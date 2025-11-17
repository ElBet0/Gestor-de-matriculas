using System;
using System.Web.UI;

namespace FrontTA.Matricula
{
    public partial class ConsultarMatricula : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // Año (desde QS o vigente)
            int anio = DateTime.Now.Year;
            int.TryParse(Request.QueryString["anio"], out anio);
            if (anio <= 0) anio = DateTime.Now.Year;
            lblAnio.Text = anio.ToString();

            // Cargar datos simulados de la matrícula consultada
            CargarDatosDeEjemplo();
        }

        private void CargarDatosDeEjemplo()
        {
            // Normalmente: buscarías por IdMatricula en la BD + año
            txtAlumno.Text = "García Pérez, Mateo";
            hdnAlumnoId.Value = "ALU001";
            txtMonto.Text = "S/ 250.00";
            txtActivo.Text = "Sí";

            txtAula.Text = "1° A Primaria";
            hdnAulaId.Value = "AUL101";
            txtCapacidad.Text = "30";
            txtVacantes.Text = "5";
        }

        // Navegación
        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/Matricula/BuscarMatricula.aspx"));
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/Matricula/BuscarMatricula.aspx"));
        }
    }
}
