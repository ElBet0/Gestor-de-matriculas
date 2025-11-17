using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Matricula
{
    public partial class EditarMatricula : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // Año de la matrícula (desde QS o vigente)
            int anio = DateTime.Now.Year;
            int.TryParse(Request.QueryString["anio"], out anio);
            if (anio <= 0) anio = DateTime.Now.Year;
            lblAnio.Text = anio.ToString();

            // Cargar "matrícula" simulada (por id en QS idealmente)
            CargarDatosDeEjemplo();

            // Poblamos las tablas de los modals (GridView, 3+ filas)
            gvAluModal.DataSource = EjemploAlumnos();
            gvAluModal.DataBind();

            gvAulaModal.DataSource = EjemploAulas();
            gvAulaModal.DataBind();
        }

        private void CargarDatosDeEjemplo()
        {
            // Aquí normalmente leerías por IdMatricula de la BD
            txtAlumno.Text = "Chávez Hinojosa, Joaquín";
            hdnAlumnoId.Value = "ALU003";
            txtMonto.Text = "S/ 250.00";
            txtActivo.Text = "Sí"; // Único editable
            txtAula.Text = "3° A Secundaria";
            hdnAulaId.Value = "AUL303";
            txtCapacidad.Text = "32";
            txtVacantes.Text = "7";
        }

        private DataTable EjemploAlumnos()
        {
            var dt = new DataTable();
            dt.Columns.Add("Codigo");
            dt.Columns.Add("ApePat");
            dt.Columns.Add("ApeMat");
            dt.Columns.Add("Nombre");
            dt.Columns.Add("Dni");
            dt.Columns.Add("CodFam");

            dt.Rows.Add("ALU001", "García", "Pérez", "Mateo", "76543210", "FAM001");
            dt.Rows.Add("ALU002", "Ramos", "López", "María", "70881234", "FAM002");
            dt.Rows.Add("ALU003", "Chávez", "Hinojosa", "Joaquín", "45678901", "FAM003");
            return dt;
        }

        private DataTable EjemploAulas()
        {
            var dt = new DataTable();
            dt.Columns.Add("Id");
            dt.Columns.Add("Aula");
            dt.Columns.Add("Grado");
            dt.Columns.Add("Vacantes");

            dt.Rows.Add("AUL101", "1° A Primaria", "1° Primaria", "5");
            dt.Rows.Add("AUL202", "2° B Secundaria", "2° Secundaria", "2");
            dt.Rows.Add("AUL303", "3° A Secundaria", "3° Secundaria", "7");
            return dt;
        }

        // Da la clase "data-row" para el resaltado/selección en JS
        protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
                e.Row.CssClass += " data-row";
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // TODO: actualizar matrícula en BD con el Id actual.
            // Datos: hdnAlumnoId.Value, hdnAulaId.Value, txtActivo.Text, etc.
            Response.Redirect(ResolveUrl("~/Matricula/BuscarMatricula.aspx"));
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/Matricula/BuscarMatricula.aspx"));
        }
    }
}
