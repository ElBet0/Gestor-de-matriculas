using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA
{
    public partial class SoftProg : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Evitar que Login se bloquee
            if (Request.Url.AbsolutePath.EndsWith("login.aspx", StringComparison.OrdinalIgnoreCase))
                return;

            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                FormsIdentity id = (FormsIdentity)HttpContext.Current.User.Identity;
                FormsAuthenticationTicket ticket = id.Ticket;
                string nombre = ticket.Name;
                nombre = nombre.Replace("_", " ");
                lblNombreCompleto.Text = nombre;
                string rol = (ticket.UserData ?? "").Trim();

                AplicarRestriccionesPorRol(rol);
                ValidarAccesoPorUrl(rol);
            }
        }

        private void AplicarRestriccionesPorRol(string rol)
        {
            rol = rol.ToUpper();

            // DIRECTOR → ve todo
            if (rol == "DIRECTOR")
                return;

            // PERSONAL_ADMINISTRATIVO → ocultar opciones restringidas
            if (rol == "PERSONAL_ADMINISTRATIVO")
            {
                liUsuarios.Visible = false;
                liGestionAcademica.Visible = false;
                return;
            }

            liUsuarios.Visible = false;
            liGestionAcademica.Visible = false;
        }

        private void ValidarAccesoPorUrl(string rol)
        {
            rol = rol.ToUpper();
            string url = Request.Url.AbsolutePath.ToLower();

            // Gestión Académica → solo DIRECTOR
            if (url.Contains("/gestionacademica/") && rol != "DIRECTOR")
            {
                Response.Redirect("~/Home.aspx");
            }

            // Usuarios → solo DIRECTOR
            if (url.Contains("/usuarios/") && rol != "DIRECTOR")
            {
                Response.Redirect("~/Home.aspx");
            }
        }





    }
}