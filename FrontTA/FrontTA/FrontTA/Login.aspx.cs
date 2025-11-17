using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            UsuarioWSClient cliente = new UsuarioWSClient();
            int resultado = cliente.verificarUsuario(txtUsuario.Text, txtClave.Text);
            if (resultado == 1)
            {


                // --- Crear ticket de autenticación ---
                FormsAuthenticationTicket tkt;
                string cookiestr;
                HttpCookie ck;

                // Si tu objeto empleado tiene un username, úsalo:
                string username = txtUsuario.Text;

                // Roles si los manejas, puedes colocar vacío o algo como "Empleado"
                tkt = new FormsAuthenticationTicket(
                    1,                           // versión
                    username,                    // usuario
                    DateTime.Now,                // emisión
                    DateTime.Now.AddMinutes(30), // expiración
                    true,                        // persistente
                    "naaa"                   // roles o info extra
                );

                cookiestr = FormsAuthentication.Encrypt(tkt);
                ck = new HttpCookie(FormsAuthentication.FormsCookieName, cookiestr);
                ck.Expires = tkt.Expiration;
                ck.Path = FormsAuthentication.FormsCookiePath;
                Response.Cookies.Add(ck);

                // --- Redirección ---
                string strRedirect = Request["ReturnUrl"];
                if (strRedirect == null)
                    strRedirect = "~/Home.aspx";

                Response.Redirect(strRedirect, true);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }


        }
    }
}
