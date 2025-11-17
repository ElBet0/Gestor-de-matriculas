using FrontTA.SisProgWS;
using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class ConsultarAula : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // 1) Cargar combos (lista de grados)
            CargarGrados();

            // 2) Tomar id desde la URL ?id=...
            string idStr = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int idAula))
            {
                CargarAulaDesdeWS(idAula);
            }

            // asegurar solo lectura (por si acaso)
            txtCodigoAula.ReadOnly = true;
            txtNombre.ReadOnly = true;
            txtActivo.ReadOnly = true;
            txtCapacidad.ReadOnly = true;
            txtVacantes.ReadOnly = true;
            ddlGrado.Enabled = false;
        }

        // ================== CARGA DE GRADOS ==================
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
        private void CargarAulaDesdeWS(int idAula)
        {
            try
            {
                // 1) Obtener el aula base
                using (var aulaWs = new AulaWSClient())
                {
                    var a = aulaWs.obtenerAulaPorId(idAula);
                    if (a == null) return;

                    txtCodigoAula.Text = a.aula_id.ToString();
                    txtNombre.Text = a.nombre ?? string.Empty;

                    // grado
                    if (a.grado != null)
                    {
                        string idGrado = a.grado.grado_academico_id.ToString();
                        if (ddlGrado.Items.FindByValue(idGrado) != null)
                            ddlGrado.SelectedValue = idGrado;
                    }

                    // activo (01 = Vigente / No Vigente)
                    try
                    {
                        txtActivo.Text = a.activo == 1 ? "Vigente" : "No Vigente";
                    }
                    catch
                    {
                        txtActivo.Text = string.Empty;
                    }
                }

                // 2) Obtener capacidad y vacantes desde PERIODOxAULA del año actual
                int periodoActualId = ObtenerPeriodoActualId();
                if (periodoActualId == 0) return;

                using (var paWs = new PeriodoXAulaWSClient())
                {
                    var periodosAula = paWs.listarPeriodosXAulasTodos();
                    if (periodosAula == null || periodosAula.Length == 0)
                        return;

                    // tipo proxy: periodoXAula
                    var pa = periodosAula.FirstOrDefault(x =>
                        x.aula != null &&
                        x.aula.aula_id == idAula &&
                        x.periodo != null &&
                        x.periodo.periodo_academico_id == periodoActualId);

                    if (pa == null) return;

                    int capacidad = pa.vacantes_disponibles + pa.vacantes_ocupadas;

                    txtCapacidad.Text = capacidad.ToString();
                    txtVacantes.Text = pa.vacantes_disponibles.ToString();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar aula para consulta: " + ex.Message);
            }
        }

        // ================== AUXILIAR: PERIODO ACTUAL ==================
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

                    // criterio 1: fecha_inicio.Year = año actual
                    var p = periodos.FirstOrDefault(x =>
                        x.fecha_inicio != null &&
                        x.fecha_inicio.Year == anioActual);

                    // criterio 2: nombre == "2025", etc., si no tienen fecha
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

        // ================== BOTÓN SALIR ==================
        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/GestionAcademica/Aula.aspx"));
        }
    }
}
