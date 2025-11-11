using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Usuarios
{
    public partial class EditarUsuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Cargar datos por ?id=...
                // var id = Request.QueryString["id"];
                // txtId.Text = id; txtNombre.Text = ...; txtEmail.Text = ...; ddlRol.SelectedValue = ...;
            }


        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // actualizar en BD
            // var id = txtId.Text; var nombre = txtNombre.Text.Trim(); var clave = txtClave.Text;
            // var email = txtEmail.Text.Trim(); var rol = ddlRol.SelectedValue;
            Response.Redirect("~/Usuarios/Usuarios.aspx");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Usuarios/Usuarios.aspx");
        }

    }
}