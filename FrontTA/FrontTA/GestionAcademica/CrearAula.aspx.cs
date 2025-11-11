using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class CrearAula : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // Validar y guardar en BD.
            // Ejemplo de lectura de valores:
            // Aquí iría la llamada a la capa de aplicación/DAO.
            // Al terminar, redirige a la lista:
            Response.Redirect(ResolveUrl("~/GestionAcademica/Aula.aspx"));
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Volver sin guardar
            Response.Redirect(ResolveUrl("~/GestionAcademica/Aula.aspx"));
        }




    }
}