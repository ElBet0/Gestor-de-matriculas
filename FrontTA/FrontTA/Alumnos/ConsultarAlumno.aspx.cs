using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Alumnos
{
    public partial class ConsultarAlumno : System.Web.UI.Page
    {
        private readonly AlumnoWSClient boAlumno = new AlumnoWSClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var id = Request.QueryString["id"];
            
            if (string.IsNullOrWhiteSpace(id))
            {
                // si no llega id, volvemos a la búsqueda
                Response.Redirect("~/Alumnos/Alumnos.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Inicializaciones si hiciera falta
                // txtCodigoFamilia.Text = ""; // ya está vacío y ReadOnly desde el .aspx
                //btnConfirmar.Text = "<i class='fa-solid fa-check'></i>";
                //btnCancelar.Text = "<i class='fa-solid fa-xmark'></i>";
                //btnConfirmar.CausesValidation = false; // opcional
                btnCancelar.CausesValidation = false; // opcional
            }
            // 2) Aulas del grado (Ejemplo)
            //var grados = new List<object>
            //{
            //    new { Anho = "2023", GradoAcademico = "Primero de secundaria" , PeriodoAcademico = "2023", Activo="Si"},
            //    new { Anho = "2024", GradoAcademico = "Segundo de secundaria" , PeriodoAcademico = "2024", Activo="Si" },
            //    new { Anho = "2025", GradoAcademico = "Tercero de secundaria" , PeriodoAcademico = "2025", Activo="Si" },
            //};
            //repGrados.DataSource = grados;
            //repGrados.DataBind();

            var al = boAlumno.obtenerAlumnoPorId(int.Parse(id));

            txtCodigoFamilia.Text = al.padres.familia_id.ToString()
                + ", " + al.padres.apellido_paterno + " " + al.padres.apellido_materno;
            txtNombre.Text = al.nombre;
            txtDNI.Text = al.dni.ToString();
            txtFechaIngreso.Text = al.fecha_ingreso.ToString();
            txtFechaNacimiento.Text = al.fecha_nacimiento.ToString();
            txtReligion.Text = al.religion.ToString();
            txtGenero.Text = char.ConvertFromUtf32(al.sexo);
            txtPension.Text = al.pension_base.ToString();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Volver sin cambios
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }
    }
}