using FrontTA.SisProgWS;
using System;
using System.Web.UI;
using periodoXAula = FrontTA.SisProgWS.periodoXAula;
using PeriodoXAulaWSClient = FrontTA.SisProgWS.PeriodoXAulaWSClient;

namespace FrontTA.Matricula
{
    public partial class ConsultarMatricula : Page
    {
        private int idMatricula;
        private static int anio2;

        private MatriculaWSClient boMatricula = new MatriculaWSClient();
        private PeriodoXAulaWSClient boPeriodo = new PeriodoXAulaWSClient();   
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            
            int anio = DateTime.Now.Year;
            int.TryParse(Request.QueryString["anio"], out anio);
            lblAnio.Text = anio.ToString();
            anio2 = anio;

            idMatricula = 0;
            int.TryParse(Request.QueryString["id"], out idMatricula);

            CargarDatos();
        }

        private void CargarDatos()
        {

            matricula mat = boMatricula.obtenerMatriculaPorId(idMatricula);

            txtAlumno.Text = mat.alumno.padres.apellido_paterno + " " +
                             mat.alumno.padres.apellido_materno + ", " +
                             mat.alumno.nombre;
            hdnAlumnoId.Value = mat.alumno.alumno_id.ToString();
            txtMonto.Text = "S/. " + mat.costo_matricula;
            txtPension.Text = "S/. " + mat.costo_pension;

            txtAula.Text = mat.periodo_Aula.aula.nombre;

           
            int perAulaId = mat.periodo_Aula.periodo_aula_id;
            hdnAulaId.Value = perAulaId.ToString();

            var full = boPeriodo.obtenerPeriodoXAulaPorId(perAulaId);

            int capacidad = mat.periodo_Aula.vacantes_disponibles;
            int vacantesLibres = Math.Max(mat.periodo_Aula.vacantes_disponibles - mat.periodo_Aula.vacantes_ocupadas, 0);

            txtCapacidad.Text = capacidad.ToString();
            txtVacantes.Text = vacantesLibres.ToString();
        }

        // Navegación
        protected void btnVolver_Click(object sender, EventArgs e)
        {
            string modo = "consultar";
            Response.Redirect(ResolveUrl($"~/Matricula/BuscarMatricula.aspx?anio={anio2}&modo={modo}"));
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            string modo = "consultar";
            Response.Redirect(ResolveUrl($"~/Matricula/BuscarMatricula.aspx?anio={anio2}&modo={modo}"));
        }
    }
}
