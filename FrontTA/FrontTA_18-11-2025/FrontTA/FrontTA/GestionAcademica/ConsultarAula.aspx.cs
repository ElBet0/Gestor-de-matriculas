using FrontTA.SisProgWS;
using System;
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

            // Asegurar solo lectura
            txtCodigoAula.ReadOnly = true;
            txtNombre.ReadOnly = true;
            txtActivo.ReadOnly = true;
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

        // ================== CARGA DE AULA ==================
        private void CargarAulaDesdeWS(int idAula)
        {
            try
            {
                using (var aulaWs = new AulaWSClient())
                {
                    var a = aulaWs.obtenerAulaPorId(idAula);
                    if (a == null) return;

                    txtCodigoAula.Text = a.aula_id.ToString();
                    txtNombre.Text = a.nombre ?? string.Empty;

                    // Grado académico
                    if (a.grado != null)
                    {
                        string idGrado = a.grado.grado_academico_id.ToString();
                        if (ddlGrado.Items.FindByValue(idGrado) != null)
                            ddlGrado.SelectedValue = idGrado;
                    }

                    // Activo: 1 = Vigente, 0 = No Vigente
                    try
                    {
                        txtActivo.Text = a.activo == 1 ? "Vigente" : "No Vigente";
                    }
                    catch
                    {
                        txtActivo.Text = string.Empty;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar aula para consulta: " + ex.Message);
            }
        }

        // ================== BOTÓN SALIR ==================
        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/GestionAcademica/Aula.aspx"));
        }
    }
}
