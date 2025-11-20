using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace FrontTA.GestionAcademica
{
    public partial class EditarGradoAcademico : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1️⃣ Obtener ID del grado desde la URL
                string idStr = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int idGrado))
                {
                    CargarGradoExistente(idGrado);
                }
                else
                {
                    // Si no hay id válido, podemos redirigir a la lista
                    Response.Redirect("~/GestionAcademica/GradoAcademico.aspx");
                }
            }
        }

        // 🔹 Cargar datos del grado a editar
        private void CargarGradoExistente(int idGrado)
        {
            try
            {
                using (var ws = new GradoAcademicoWSClient())
                {
                    var grado = ws.obtenerGradoAcademicoPorId(idGrado);

                    if (grado == null)
                    {
                        string msg = "No se encontró el grado académico especificado.";
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "gradoNoEncontrado",
                            $"mostrarModal('{msg.Replace("'", "\\'")}');",
                            true
                        );
                        return;
                    }

                    txtId.Text = grado.grado_academico_id.ToString();
                    txtNombre.Text = grado.nombre;
                    txtAbrev.Text = grado.abreviatura;

                    // El backend solo expone grados activos,
                    // así que por defecto marcamos "Vigente".
                    if (ddlActivo.Items.FindByValue("1") != null)
                        ddlActivo.SelectedValue = "1";
                }
            }
            catch (Exception ex)
            {
                string msg = ("Error al cargar el grado académico: " + ex.Message)
                             .Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "errorCargarGrado",
                    $"alert('{msg}');",
                    true
                );
            }
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // ✅ 1) Validar primero
            string mensajesError;
            if (!ValidarGradoAcademico(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionGradoEditar",
                    $"alert('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return;
            }

            try
            {
                // ✅ 2) Leer valores del formulario
                int idGrado = int.Parse(txtId.Text);
                string nombre = txtNombre.Text.Trim();
                string abreviatura = txtAbrev.Text.Trim();
                // ddlActivo por ahora es solo informativo, el SP de modificar
                // no recibe el campo ACTIVO.

                // ✅ 3) Crear objeto gradoAcademico para el WS
                var grado = new gradoAcademico
                {
                    grado_academico_id = idGrado,
                    nombre = nombre,
                    abreviatura = abreviatura
                };

                // ✅ 4) Llamar al WS para modificar
                using (var ws = new GradoAcademicoWSClient())
                {
                    int resultado = ws.modificarGradoAcademico(grado);

                    if (resultado > 0)
                    {
                        var url = ResolveUrl("~/GestionAcademica/GradoAcademico.aspx");
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "gradoEditadoOk",
                            $"alert('El grado académico se actualizó correctamente.'); window.location='{url}';",
                            true
                        );
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "gradoEditadoFail",
                            "alert('El servicio devolvió 0: no se modificó ningún grado académico.');",
                            true
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                string msg = ("No se pudo actualizar el grado académico: " + ex.Message)
                             .Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "gradoEditarError",
                    $"alert('{msg}');",
                    true
                );
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/GestionAcademica/GradoAcademico.aspx"));
        }

        // ========= VALIDACIÓN SOLO EN C# (mismas reglas que CrearGrado) =========
        private bool ValidarGradoAcademico(out string mensajes)
        {
            var errores = new List<string>();

            string nombre = (txtNombre.Text ?? "").Trim();
            string abreviatura = (txtAbrev.Text ?? "").Trim();

            // Nombre: obligatorio + máx 12
            if (string.IsNullOrWhiteSpace(nombre))
            {
                errores.Add("El nombre del grado académico es obligatorio.");
            }
            else if (nombre.Length > 12)
            {
                errores.Add("La longitud del nombre no es válida (máx. 12 caracteres).");
            }

            // Abreviatura: obligatoria + máx 3
            if (string.IsNullOrWhiteSpace(abreviatura))
            {
                errores.Add("La abreviatura es obligatoria.");
            }
            else if (abreviatura.Length > 3)
            {
                errores.Add("La longitud de la abreviatura no es válida (máx. 3 caracteres).");
            }

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }
    }
}
