using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class EditarCursos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            //SE HACE LA MODIFICACION USANDO EL BO
            Response.Redirect(ResolveUrl("~/GestionAcademica/Cursos.aspx"));
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            //NO PASA NAAA
            Response.Redirect(ResolveUrl("~/GestionAcademica/Cursos.aspx"));
        }
    }
}
