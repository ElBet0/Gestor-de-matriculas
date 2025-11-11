using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Alumnos
{
    public partial class CrearAlumno : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Inicializaciones si hiciera falta
                // txtCodigoFamilia.Text = ""; // ya está vacío y ReadOnly desde el .aspx
                btnConfirmar.Text = "<i class='fa-solid fa-check'></i>";
                btnCancelar.Text = "<i class='fa-solid fa-xmark'></i>";
                btnConfirmar.CausesValidation = false; // opcional
                btnCancelar.CausesValidation = false; // opcional
            }

            // 2) Aulas del grado (Ejemplo)
            var grados = new List<object>
            {
                new { Codigo = "001", apePaterno = "Gallardo" , apeMaterno = "Morales"},
                new { Codigo = "002", apePaterno = "García" , apeMaterno = "López" },
                new { Codigo = "003", apePaterno = "Ramos" , apeMaterno = "Pérez" },
            };
            reFamilias.DataSource = grados;
            reFamilias.DataBind();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Volver sin cambios
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
           
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {

        }


    }
}