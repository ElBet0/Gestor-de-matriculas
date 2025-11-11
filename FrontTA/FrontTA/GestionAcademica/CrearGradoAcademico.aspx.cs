using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class CrearGradoAcademico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
          
           

            //  Persistir en la BO/DAO.
            // Ejemplo:
            // var bo = new GradoAcademicoBO();
            // var idGenerado = bo.Crear(new GradoAcademico { Nombre = nombre, Abreviatura = abrev, Activo = true });

           
            Response.Redirect(ResolveUrl("~/GestionAcademica/GradoAcademico.aspx"));
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
           
            Response.Redirect(ResolveUrl("~/GestionAcademica/GradoAcademico.aspx"));
        }
    }
}
