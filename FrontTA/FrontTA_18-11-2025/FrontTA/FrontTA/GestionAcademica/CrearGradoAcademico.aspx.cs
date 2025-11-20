using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace FrontTA.GestionAcademica
{
    public partial class CrearGradoAcademico : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // ID vacío y activo siempre "Vigente"
                txtId.Text = string.Empty;
                ddlActivo.SelectedValue = "1";
            }
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // 1️⃣ Validar primero
            string mensajesError;
            if (!ValidarGradoAcademico(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionGrado",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return;
            }

            try
            {
                // 2️⃣ Leer valores del formulario
                string nombre = txtNombre.Text.Trim();
                string abreviatura = txtAbreviatura.Text.Trim();

                // 3️⃣ Crear objeto gradoAcademico (tipo generado por el WS)
                gradoAcademico grado = new gradoAcademico();
                grado.nombre = nombre;
                grado.abreviatura = abreviatura;
                // El ID y el campo activo los maneja el backend (SP INSERTAR_GRADO_ACADEMICO)

                // 4️⃣ Llamar al servicio web
                using (var ws = new GradoAcademicoWSClient())
                {
                    int resultado = ws.insertarGradoAcademico(grado);

                    if (resultado > 0)
                    {
                        string url = ResolveUrl("~/GestionAcademica/GradoAcademico.aspx");
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "gradoCreadoOk",
                            $"alert('El grado académico se creó correctamente.'); window.location='{url}';",
                            true
                        );
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "gradoCreadoFail",
                            "alert('El servicio no insertó el grado académico.');",
                            true
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                string msg = ("No se pudo crear el grado académico: " + ex.Message)
                             .Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "gradoError",
                    $"alert('{msg}');",
                    true
                );
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/GestionAcademica/GradoAcademico.aspx"));
        }

        // ========= VALIDACIÓN SOLO EN C# =========
        // Adaptado al mismo estilo que ValidarCurso:
        //  - Nombre obligatorio, máx. 12 caracteres (como tus ejemplos: Inicial, Primaria, Secundaria)
        //  - Abreviatura obligatoria, máx. 3 caracteres (INI, PRI, SEC)
        private bool ValidarGradoAcademico(out string mensajes)
        {
            var errores = new List<string>();

            string nombre = (txtNombre.Text ?? "").Trim();
            string abreviatura = (txtAbreviatura.Text ?? "").Trim();

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
