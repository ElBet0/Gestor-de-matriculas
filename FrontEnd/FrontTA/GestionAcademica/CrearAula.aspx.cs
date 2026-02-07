using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
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

                // Siempre por defecto Vigente
                ddlActivo.SelectedValue = "1";
                // ddlActivo.Enabled = false; // ya está deshabilitado en el .aspx
            }
        }

       
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

        
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/GestionAcademica/Aula.aspx"));
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            
            string mensajesError;
            if (!ValidarAula(out mensajesError))
            {
                
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionAula",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return;
            }

            try
            {
               
                string nombre = txtNombre.Text.Trim();
                int idGrado = int.Parse(ddlGrado.SelectedValue);

                
                int activo = 1;

                
                var aula = new aula();
                aula.nombre = nombre;

                var grado = new gradoAcademico();
                grado.grado_academico_id = idGrado;
                aula.grado = grado;

                
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

      
        private bool ValidarAula(out string mensajes)
        {
            var errores = new List<string>();

            string nombre = (txtNombre.Text ?? "").Trim();
            string gradoSel = ddlGrado.SelectedValue;

            if (string.IsNullOrWhiteSpace(nombre))
                errores.Add("El nombre del aula es obligatorio.");
            else if (nombre.Length > 12)
                errores.Add("La longitud del nombre del aula no es válida (máx. 12 caracteres).");

            int idGrado;
            if (!int.TryParse(gradoSel, out idGrado) || idGrado <= 0)
                errores.Add("Debe seleccionar un grado académico válido.");

            
            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }
    }
}
