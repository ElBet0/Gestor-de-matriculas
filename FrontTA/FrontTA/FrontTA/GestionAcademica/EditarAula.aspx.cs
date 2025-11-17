using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class EditarAula : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            CargarGrados();

            // Por defecto
            ddlActivo.SelectedValue = "1";
            txtCodigoAula.ReadOnly = true;
            txtVacantes.ReadOnly = true;

            // Tomar id desde la URL ?id=...
            string idStr = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int idAula))
            {
                CargarAulaExistente(idAula);
            }
            else
            {
                // si quieres, puedes redirigir si no hay id
                // Response.Redirect("~/GestionAcademica/Aula.aspx");
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

        // ================== CARGA DE AULA + PERIODOxAULA ==================
        private void CargarAulaExistente(int idAula)
        {
            try
            {
                // 1) Aula base
                using (var aulaWs = new AulaWSClient())
                {
                    var a = aulaWs.obtenerAulaPorId(idAula);
                    if (a == null) return;

                    txtCodigoAula.Text = a.aula_id.ToString();
                    txtNombre.Text = a.nombre;

                    // grado
                    if (a.grado != null)
                    {
                        string idGrado = a.grado.grado_academico_id.ToString();
                        if (ddlGrado.Items.FindByValue(idGrado) != null)
                            ddlGrado.SelectedValue = idGrado;
                    }

                    // activo (si existe propiedad en proxy)
                    try
                    {
                        ddlActivo.SelectedValue = a.activo.ToString();
                    }
                    catch
                    {
                        // si no existe la propiedad, dejamos por defecto
                    }
                }

                // 2) Buscar PeriodoXAula del año actual
                int periodoActualId = ObtenerPeriodoActualId();
                if (periodoActualId == 0) return;

                using (var paWs = new PeriodoXAulaWSClient())
                {
                    var periodosAula = paWs.listarPeriodosXAulasTodos();
                    if (periodosAula == null || periodosAula.Length == 0)
                        return;

                    var pa = periodosAula.FirstOrDefault(x =>
                        x.aula != null &&
                        x.aula.aula_id == idAula &&
                        x.periodo != null &&
                        x.periodo.periodo_academico_id == periodoActualId);

                    if (pa == null) return;

                    int capacidad = pa.vacantes_disponibles + pa.vacantes_ocupadas;

                    txtCapacidad.Text = capacidad.ToString();
                    txtVacantes.Text = pa.vacantes_disponibles.ToString();

                    // Sincronizamos "activo" con PeriodoXAula si existe
                    try
                    {
                        ddlActivo.SelectedValue = pa.activo.ToString();
                    }
                    catch { }

                    // Guardamos info para el postback
                    ViewState["PeriodoAulaId"] = pa.periodo_aula_id;
                    ViewState["VacantesOcupadas"] = pa.vacantes_ocupadas;
                    ViewState["PeriodoId"] = pa.periodo.periodo_academico_id;
                    ViewState["AulaId"] = idAula;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar aula existente: " + ex.Message);
            }
        }

        // ================== BOTONES ==================
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GestionAcademica/Aula.aspx");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // 1) Validar datos (mismas reglas que CrearAula)
            string mensajesError;
            if (!ValidarAula(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionAulaEditar",
                    $"alert('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return;
            }

            try
            {
                // Datos básicos del formulario
                int idAula = int.Parse(txtCodigoAula.Text);
                string nombre = txtNombre.Text.Trim();
                int idGrado = int.Parse(ddlGrado.SelectedValue);
                int activo = int.Parse(ddlActivo.SelectedValue);
                int capacidad = int.Parse(txtCapacidad.Text.Trim());

                // Vacantes ocupadas y PeriodoAulaId desde ViewState
                int vacOcupadas = 0;
                if (ViewState["VacantesOcupadas"] != null)
                    vacOcupadas = (int)ViewState["VacantesOcupadas"];

                int periodoAulaId = 0;
                if (ViewState["PeriodoAulaId"] != null)
                    periodoAulaId = (int)ViewState["PeriodoAulaId"];

                int periodoId = 0;
                if (ViewState["PeriodoId"] != null)
                    periodoId = (int)ViewState["PeriodoId"];

                // Validación adicional: capacidad >= vacantes ocupadas
                if (capacidad < vacOcupadas)
                {
                    string msgExtra = "La nueva capacidad no puede ser menor que las vacantes ya ocupadas (" +
                                      vacOcupadas + ").";
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "capacidadInvalida",
                        $"alert('{msgExtra.Replace("'", "\\'")}');",
                        true
                    );
                    return;
                }

                int nuevasVacantesDisponibles = capacidad - vacOcupadas;

                // 2) Actualizar Aula
                var aula = new aula
                {
                    aula_id = idAula,
                    nombre = nombre
                };
                aula.grado = new gradoAcademico
                {
                    grado_academico_id = idGrado
                };
                try { aula.activo = activo; } catch { }

                using (var aulaWs = new AulaWSClient())
                {
                    int resAula = aulaWs.modificarAula(aula);
                    if (resAula <= 0)
                    {
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "aulaEditFail",
                            "alert('El servicio devolvió 0: no se modificó el aula.');",
                            true
                        );
                        return;
                    }
                }

                // 3) Actualizar PeriodoXAula (si tenemos registro asociado)
                if (periodoAulaId > 0 && periodoId > 0)
                {
                    var pa = new periodoXAula
                    {
                        periodo_aula_id = periodoAulaId,
                        vacantes_disponibles = nuevasVacantesDisponibles,
                        vacantes_ocupadas = vacOcupadas
                    };
                    try { pa.activo = activo; } catch { }

                    // periodo
                    pa.periodo = new periodoAcademico
                    {
                        periodo_academico_id = periodoId
                    };

                    // aula para PeriodoXAula → tipo aula1
                    int aulaIdPa = idAula;
                    if (ViewState["AulaId"] != null)
                        aulaIdPa = (int)ViewState["AulaId"];

                    var aulaPa = new aula1
                    {
                        aula_id = aulaIdPa
                    };
                    pa.aula = aulaPa;

                    using (var paWs = new PeriodoXAulaWSClient())
                    {
                        int resPa = paWs.modificarPeriodoXAula(pa);
                        if (resPa <= 0)
                        {
                            ScriptManager.RegisterStartupScript(
                                this,
                                GetType(),
                                "paEditWarn",
                                "alert('El aula se actualizó, pero no se pudo actualizar el PeriodoXAula del periodo actual.');",
                                true
                            );
                        }
                    }
                }

                // 4) Todo OK → volver a la lista
                string url = ResolveUrl("~/GestionAcademica/Aula.aspx");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "aulaEditOk",
                    $"alert('El aula se editó correctamente.'); window.location='{url}';",
                    true
                );
            }
            catch (Exception ex)
            {
                string msg = ("No se pudo actualizar el aula: " + ex.Message).Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "aulaEditarError",
                    $"alert('{msg}');",
                    true
                );
            }
        }

        // ================== AUXILIARES ==================
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

            // Nombre obligatorio, máx 80
            if (string.IsNullOrWhiteSpace(nombre))
            {
                errores.Add("El nombre del aula es obligatorio.");
            }
            else if (nombre.Length >12)
            {
                errores.Add("La longitud del nombre del aula no es válida (máx. 12 caracteres).");
            }

            // Grado académico obligatorio
            int idGrado;
            if (!int.TryParse(gradoSel, out idGrado) || idGrado <= 0)
            {
                errores.Add("Debe seleccionar un grado académico válido.");
            }

            // Capacidad: entero > 0
            if (string.IsNullOrWhiteSpace(capTxt))
            {
                errores.Add("La capacidad es obligatoria.");
            }
            else
            {
                int cap;
                if (!int.TryParse(capTxt, out cap))
                {
                    errores.Add("La capacidad debe ser un número entero.");
                }
                else if (cap <= 0)
                {
                    errores.Add("La capacidad debe ser mayor a cero.");
                }
            }

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }
    }
}
