using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class CrearAula : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarGrados();
                ddlActivo.SelectedValue = "1"; // por defecto Vigente
                txtVacantes.Text = "";        // informativo
            }
        }

        // ================== CARGA DE COMBOS ==================
        private void CargarGrados()
        {
            try
            {
                using (var ws = new GradoAcademicoWSClient())
                {
                    var lista = ws.listarGradosAcademicosTodos();

                    ddlGrado.DataSource = lista;
                    ddlGrado.DataTextField = "nombre";
                    ddlGrado.DataValueField = "grado_academico_id";
                    ddlGrado.DataBind();

                    ddlGrado.Items.Insert(0, new ListItem("-- Seleccione --", "0"));
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar grados: " + ex.Message);
                ddlGrado.Items.Clear();
                ddlGrado.Items.Insert(0, new ListItem("(Error al cargar grados)", "0"));
            }
        }

        // ================== BOTONES ==================
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/GestionAcademica/Aula.aspx"));
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // 1) Validar datos
            string mensajesError;
            if (!ValidarAula(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionAula",
                    $"alert('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return;
            }

            try
            {
                // 2) Obtener periodo académico vigente (año actual)
                int periodoActualId = ObtenerPeriodoActualId();
                if (periodoActualId == 0)
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "sinPeriodo",
                        "alert('No se encontró un periodo académico vigente para el año actual. Verifique RM_PERIODO_ACADEMICO.');",
                        true
                    );
                    return;
                }

                // 3) Leer valores del formulario
                string nombre = txtNombre.Text.Trim();
                int idGrado = int.Parse(ddlGrado.SelectedValue);
                int activo = int.Parse(ddlActivo.SelectedValue);
                int capacidad = int.Parse(txtCapacidad.Text.Trim());

                // 4) Crear AULA
                var aula = new aula();
                aula.nombre = nombre;

                var grado = new gradoAcademico();
                grado.grado_academico_id = idGrado;
                aula.grado = grado;

                // si tu proxy tiene la propiedad activo
                try { aula.activo = activo; } catch { }

                int idAula;
                using (var aulaWs = new AulaWSClient())
                {
                    idAula = aulaWs.insertarAula(aula);
                }

                if (idAula <= 0)
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "aulaFail",
                        "alert('El servicio devolvió 0: no se insertó ningún aula.');",
                        true
                    );
                    return;
                }

                // 5) Crear PERIODOxAULA para el año actual
                // 5) Crear PERIODOxAULA para el año actual
                int vacantesDisponibles = capacidad;   // asientos libres al inicio
                int vacantesOcupadas = 0;          // nadie matriculado aún

                var pa = new periodoXAula();

                // ----- periodo -----
                var periodo = new periodoAcademico();
                periodo.periodo_academico_id = periodoActualId;
                pa.periodo = periodo;

                // ----- aula (OJO: aquí es aula1, no aula) -----
                var aulaPa = new aula1();   // usa el tipo que te muestra IntelliSense
                aulaPa.aula_id = idAula;    // mismo id del aula recién creada
                pa.aula = aulaPa;

                // ----- vacantes y activo -----
                pa.vacantes_disponibles = vacantesDisponibles;
                pa.vacantes_ocupadas = vacantesOcupadas;
                pa.activo = 1;    // si la propiedad se llama distinto, usa el nombre exacto que te muestre IntelliSense

                using (var paWs = new PeriodoXAulaWSClient())
                {
                    int resPa = paWs.insertarPeriodoXAula(pa);
                    if (resPa <= 0)
                    {
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "paFail",
                            "alert('El aula se creó, pero no se pudo crear el PeriodoXAula para el periodo actual.');",
                            true
                        );
                    }
                }


                // 6) Todo OK → volver a la lista
                string url = ResolveUrl("~/GestionAcademica/Aula.aspx");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "aulaOk",
                    $"alert('El aula se creó correctamente.'); window.location='{url}';",
                    true
                );
            }
            catch (Exception ex)
            {
                string msg = ("No se pudo crear el aula: " + ex.Message).Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "aulaError",
                    $"alert('{msg}');",
                    true
                );
            }
        }

        // ================== LÓGICA AUXILIAR ==================
        private int ObtenerPeriodoActualId()
        {
            int anioActual = DateTime.Now.Year;

            try
            {
                using (var ws = new PeriodoWSClient())
                {
                    var periodos = ws.listarPeriodosTodos();
                    if (periodos == null || periodos.Length == 0)
                        return 0;

                    var p = periodos.FirstOrDefault(x =>
                        x.fecha_inicio != null &&
                        x.fecha_inicio.Year == anioActual);

                    if (p == null)
                        p = periodos.FirstOrDefault(x => x.nombre == anioActual.ToString());

                    return p != null ? p.periodo_academico_id : 0;
                }
            }
            catch
            {
                return 0;
            }
        }

        private bool ValidarAula(out string mensajes)
        {
            var errores = new List<string>();

            string nombre = (txtNombre.Text ?? "").Trim();
            string capTxt = (txtCapacidad.Text ?? "").Trim();
            string gradoSel = ddlGrado.SelectedValue;

            if (string.IsNullOrWhiteSpace(nombre))
                errores.Add("El nombre del aula es obligatorio.");
            else if (nombre.Length > 12)
                errores.Add("La longitud del nombre del aula no es válida (máx. 12 caracteres).");

            int idGrado;
            if (!int.TryParse(gradoSel, out idGrado) || idGrado <= 0)
                errores.Add("Debe seleccionar un grado académico válido.");

            if (string.IsNullOrWhiteSpace(capTxt))
                errores.Add("La capacidad es obligatoria.");
            else
            {
                int cap;
                if (!int.TryParse(capTxt, out cap))
                    errores.Add("La capacidad debe ser un número entero.");
                else if (cap <= 0)
                    errores.Add("La capacidad debe ser mayor a cero.");
            }

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }
    }
}
