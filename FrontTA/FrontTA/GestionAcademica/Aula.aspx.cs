using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class Aula : Page
    {
        private const string VS_SORT_EXPR = "AUL_SORT_EXPR";
        private const string VS_SORT_DIR = "AUL_SORT_DIR";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindGrid();
        }

        private void BindGrid(string sortExpression = null, SortDirection? sortDirection = null)
        {
            DataTable data = GetEjemploAulas();

            // Filtros
            string aulaNom = txtAulaNombre.Text.Trim();
            string gradoNom = txtGradoNombre.Text.Trim();

            string filter = "1=1";
            if (!string.IsNullOrEmpty(aulaNom)) filter += $" AND NombreAula LIKE '%{EscapeLike(aulaNom)}%'";
            if (!string.IsNullOrEmpty(gradoNom)) filter += $" AND GradoAcademico LIKE '%{EscapeLike(gradoNom)}%'";

            DataView dv = new DataView(data) { RowFilter = filter };

            // Orden
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string dir = (sortDirection ?? SortDirection.Ascending) == SortDirection.Ascending ? "ASC" : "DESC";
                dv.Sort = $"{sortExpression} {dir}";
                ViewState[VS_SORT_EXPR] = sortExpression;
                ViewState[VS_SORT_DIR] = sortDirection ?? SortDirection.Ascending;
            }
            else if (ViewState[VS_SORT_EXPR] is string se && ViewState[VS_SORT_DIR] is SortDirection sd)
            {
                dv.Sort = $"{se} {(sd == SortDirection.Ascending ? "ASC" : "DESC")}";
            }

            gvAulas.DataSource = dv;
            gvAulas.DataBind();
        }

        private static string EscapeLike(string input)
        {
            return input.Replace("[", "[[]").Replace("%", "[%]").Replace("_", "[_]").Replace("'", "''");
        }

        // === GRID EVENTS ===
        protected void gvAulas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
                e.Row.CssClass = "table-header";
                return;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string codigo = DataBinder.Eval(e.Row.DataItem, "Codigo") as string;
                e.Row.Attributes["data-id"] = codigo;
                e.Row.CssClass = (e.Row.CssClass + " data-row").Trim();
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }

        protected void gvAulas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAulas.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvAulas_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortDirection newDir = SortDirection.Ascending;
            if (ViewState[VS_SORT_EXPR] is string lastExpr && lastExpr == e.SortExpression &&
                ViewState[VS_SORT_DIR] is SortDirection lastDir)
            {
                newDir = lastDir == SortDirection.Ascending ? SortDirection.Descending : SortDirection.Ascending;
            }
            BindGrid(e.SortExpression, newDir);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            gvAulas.PageIndex = 0;
            BindGrid();
        }

        // === Mock con EJEMPLOS ===
        private DataTable GetEjemploAulas()
        {
            var dt = new DataTable();
            dt.Columns.Add("Codigo", typeof(string));
            dt.Columns.Add("NombreAula", typeof(string));
            dt.Columns.Add("Capacidad", typeof(int));
            dt.Columns.Add("Vacantes", typeof(int));
            dt.Columns.Add("GradoAcademico", typeof(string));

            dt.Rows.Add("A-101", "Aula San Marcos", 35, 5, "3° de Secundaria");
            dt.Rows.Add("B-202", "Aula Humboldt", 30, 2, "5° de Primaria");
            dt.Rows.Add("C-303", "Aula Túpac Amaru", 40, 8, "1° de Secundaria");
            return dt;
        }

        // Asegurar THEAD/TBODY
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (gvAulas.Rows.Count > 0)
                gvAulas.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}
