using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Usuarios
{
    public partial class EditarUsuarios : System.Web.UI.Page
    {
        UsuarioWSClient boUsuario = new UsuarioWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var id = Request.QueryString["id"];
            if (string.IsNullOrWhiteSpace(id))
            {
                // Si no llega id, volvemos al listado de usuarios
                Response.Redirect("~/Usuarios/Usuarios.aspx");
                return;
            }

            var us = boUsuario.obtenerUsuarioPorId(int.Parse(id));
            if (us == null)
            {
                Response.Redirect("~/Usuarios/Usuarios.aspx");
                return;
            }

            txtId.Text = us.usuario_id.ToString();
            txtNombre.Text = us.nombre;
            ddlRol.SelectedValue = us.rol.ToString();
            // txtClave lo dejas vacío para que el usuario ingrese una nueva si desea
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // ✅ Primero: validar igual que en CrearUsuarios
            string mensajesError;
            if (!ValidarUsuario(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionUsuarioEditar",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return; // No seguimos si hay errores
            }

            try
            {
                int id = int.Parse(txtId.Text);
                string nombre = txtNombre.Text.Trim();
                string clave = txtClave.Text.Trim();
                rol r = (rol)Enum.Parse(typeof(rol), ddlRol.SelectedValue);

                // Actualizar en BD
                boUsuario.modificarUsuario(id, nombre, clave, r);

                // Mensaje + redirección por JavaScript
                var url = ResolveUrl("~/Usuarios/Usuarios.aspx");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "usuarioEditadoOk",
                    $"alert('Usuario editado correctamente'); window.location='{url}';",
                    true
                );
            }
            catch (Exception ex)
            {
                string msg = ("No se pudo editar el usuario: " + ex.Message)
                             .Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "usuarioEditarError",
                    $"alert('{msg}');",
                    true
                );
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Usuarios/Usuarios.aspx");
        }

        // ========= VALIDACIÓN SOLO EN C# =========
        //  - nombre obligatorio y longitud <= 12 (según tu ajuste)
        //  - clave obligatoria
        //  - rol obligatorio
        private bool ValidarUsuario(out string mensajes)
        {
            var errores = new List<string>();

            string nombre = (txtNombre.Text ?? "").Trim();
            string clave = (txtClave.Text ?? "").Trim();
            string rolSel = ddlRol.SelectedValue;

            // Nombre: obligatorio + máx 12
            if (string.IsNullOrWhiteSpace(nombre))
            {
                errores.Add("El nombre de usuario es obligatorio.");
            }
            else if (nombre.Length > 12)
            {
                errores.Add("La longitud del nombre no es válida (máx. 12 caracteres).");
            }

            // Clave: obligatoria
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
