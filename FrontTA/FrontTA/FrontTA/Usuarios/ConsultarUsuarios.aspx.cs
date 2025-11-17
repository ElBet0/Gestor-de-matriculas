using FrontTA.SisProgWS;
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
                var id = Request.QueryString["id"];
                UsuarioWSClient boUsuario = new UsuarioWSClient();
                if (string.IsNullOrWhiteSpace(id))
                {
                    // si no llega id, volvemos a la búsqueda
                    Response.Redirect("~/Usuarios/Usuarios.aspx");
                    return;
                }
                var usr = boUsuario.obtenerUsuarioPorId(int.Parse(id));
                txtId.Text = usr.usuario_id.ToString();
                txtNombre.Text = usr.nombre;
                ddlRol.Text = usr.rol.ToString();

            }

        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Usuarios/Usuarios.aspx");
        }


    }

}