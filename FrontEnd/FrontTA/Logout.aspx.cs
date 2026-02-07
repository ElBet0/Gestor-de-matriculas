using System;
using System.Web;
using System.Web.Security;

namespace FrontTA
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();

            // Borrar cookie manualmente
            HttpCookie ck = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            ck.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(ck);

            Response.Redirect("~/Login.aspx");
        }
    }
}
