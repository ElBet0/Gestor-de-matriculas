using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Usuarios
{
    public partial class CrearUsuarios : System.Web.UI.Page
    {
        UsuarioWSClient boUsuario = new UsuarioWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Si quisieras inicializar ddlRol con "Seleccionar...", etc., sería aquí.
            }
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {

            string mensajesError;
            if (!ValidarUsuario(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionUsuario",
                    $"alert('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return; // No seguimos si hay errores
            }

            try
            {
                string nombre = txtNombre.Text.Trim();
                string clave = txtClave.Text.Trim();
                rol r = (rol)Enum.Parse(typeof(rol), ddlRol.SelectedValue);

                // Llamar al WS (misma lógica que antes)
                boUsuario.insertarUsuario(nombre, clave, r);

                // Mensaje + redirección por JavaScript
                var url = ResolveUrl("~/Usuarios/Usuarios.aspx");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "usuarioCreadoOk",
                    $"alert('Usuario creado correctamente'); window.location='{url}';",
                    true
                );
            }
            catch (Exception ex)
            {
                string msg = ("No se pudo crear el usuario: " + ex.Message)
                             .Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "usuarioError",
                    $"mostrarModal('{msg}');",
                    true
                );
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Usuarios/Usuarios.aspx");
        }

        // ========= VALIDACIÓN SOLO EN C# =========
        // Basado en tu validar(Usuario):
        //  - nombre obligatorio y longitud <= 50
        //  - clave obligatoria
        //  - rol obligatorio
        private bool ValidarUsuario(out string mensajes)
        {
            var errores = new List<string>();

            string nombre = (txtNombre.Text ?? "").Trim();
            string clave = (txtClave.Text ?? "").Trim();
            string rolSel = ddlRol.SelectedValue;

            // Nombre: obligatorio + máx 50
            if (string.IsNullOrWhiteSpace(nombre))
            {
                errores.Add("El nombre de usuario es obligatorio.");
            }
            else if (nombre.Length > 12)
            {
                errores.Add("La longitud del nombre no es válida (máx. 12 caracteres).");
            }

            // Clave: obligatoria (no validamos hash/salt aquí)
            if (string.IsNullOrWhiteSpace(clave))
            {
                errores.Add("La clave es obligatoria.");
            }

            // Rol: obligatorio
            if (string.IsNullOrEmpty(rolSel) || rolSel == "0")
            {
                errores.Add("Debe seleccionar un rol para el usuario.");
            }

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }
    }
}
