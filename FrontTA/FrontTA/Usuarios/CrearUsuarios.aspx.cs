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
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                // Si vienes con ?id=... puedes precargar datos:
                // txtId.Text = id; txtNombre.Text = ...; ddlRol.SelectedValue = ...;
                // txtId.ReadOnly = true; // ya está por markup
            }

        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // guardar cambios / crear usuario
            // var nombre = txtNombre.Text.Trim();
            // var clave  = txtClave.Text; // hashearla antes de persistir
            // var email  = txtEmail.Text.Trim();
            // var rol    = ddlRol.SelectedValue;
            // Redirigir al listado:
            Response.Redirect("~/Usuarios/Usuarios.aspx");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Usuarios/Usuarios.aspx");
        }
    }
}