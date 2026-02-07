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
            if (txtClave.Text.Contains(" ") || txtUsuario.Text.Contains(" "))
            {
                lblMensaje.Text = "El usuario o contraseña contiene espacios";
                txtUsuario.Text = "";
                lblMensaje.Visible = true;
            }
            else
            {
                int resultado = cliente.verificarUsuario(txtUsuario.Text.Trim(), txtClave.Text.Trim());
                if (resultado != 0)
                {

                    usuario user = cliente.obtenerUsuarioPorId(resultado);
                    // --- Crear ticket de autenticación ---
                    FormsAuthenticationTicket tkt;
                    string cookiestr;
                    HttpCookie ck;

                    // Si tu objeto empleado tiene un username, úsalo:
                    string username = txtUsuario.Text + " | " + user.rol.ToString();

                    // Roles si los manejas, puedes colocar vacío o algo como "Empleado"
                    tkt = new FormsAuthenticationTicket(
                        1,                           // versión
                        username,                    // usuario
                        DateTime.Now,                // emisión
                        DateTime.Now.AddMinutes(30), // expiración
                        true,                        // persistente
                        user.rol.ToString()                  // roles o info extra
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
                    lblMensaje.Text = "Usuario o contraseña incorrecta";
                    txtUsuario.Text = "";
                    lblMensaje.Visible = true;
                    //Response.Redirect("Login.aspx");
                }
            }



        }
    }
}