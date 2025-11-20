using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Matricula
{
    public partial class CrearMatricula : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // Año desde QS; por defecto vigente
            int anio = DateTime.Now.Year;
            int.TryParse(Request.QueryString["anio"], out anio);
            if (anio <= 0) anio = DateTime.Now.Year;
            lblAnio.Text = anio.ToString();

            // Datos de ejemplo para modales
            gvAlumnosModal.DataSource = EjemploAlumnos();
            gvAlumnosModal.DataBind();

            gvAulasModal.DataSource = EjemploAulas();
            gvAulasModal.DataBind();

            // Valores de solo lectura por defecto
            txtMonto.Text = "S/ 0.00";
            txtActivo.Text = "Sí";
        }

        private DataTable EjemploAlumnos()
        {
            var dt = new DataTable();
            dt.Columns.Add("Codigo");   // código alumno
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
            dt.Columns.Add("Aula");     // Nombre de aula
            dt.Columns.Add("Grado");    // Nombre de grado académico
            dt.Columns.Add("Vacantes");

            dt.Rows.Add("AUL101", "1° A Primaria", "1° Primaria", "5");
            dt.Rows.Add("AUL202", "2° B Secundaria", "2° Secundaria", "2");
            dt.Rows.Add("AUL303", "3° A Secundaria", "3° Secundaria", "7");
            return dt;
        }

        // Marca cada fila como "data-row" para la selección por JS
        protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
                e.Row.CssClass += " data-row";
        }

        // Navegación (sin persistencia aún)
        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // Aquí iría el guardado real de matrícula.
            Response.Redirect(ResolveUrl("~/Matricula/BuscarMatricula.aspx"));
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/Matricula/BuscarMatricula.aspx"));
        }
    }
}
