using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Usuarios
{
    public partial class ConsultarUsuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Cargar por ?id=...
                // var id = Request.QueryString["id"];
                //  traer usuario y setear controles:
                // txtId.Text = id; txtNombre.Text = ...; txtEmail.Text = ...; ddlRol.SelectedValue = ...;
                // txtClave.Text = "********"; // o la cantidad de * que quieras mostrar
            }

        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Usuarios/Usuarios.aspx");
        }


    }
    
}