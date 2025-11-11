using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class GestionAcademico : Page
    {
        private const string VS_SORT_EXPR = "GA_SORT_EXPR";
        private const string VS_SORT_DIR = "GA_SORT_DIR";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid(string sortExpression = null, SortDirection? sortDirection = null)
        {
            DataTable data = GetEjemploGrados();

            // Filtros
            string nom = txtNombre.Text.Trim();
            string abr = txtAbreviatura.Text.Trim();

            string filter = "1=1";
            if (!string.IsNullOrEmpty(nom)) filter += $" AND Nombre LIKE '%{EscapeLike(nom)}%'";
            if (!string.IsNullOrEmpty(abr)) filter += $" AND Abreviatura LIKE '%{EscapeLike(abr)}%'";

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

            gvGrados.DataSource = dv;
            gvGrados.DataBind();
        }

        private static string EscapeLike(string input)
        {
            return input.Replace("[", "[[]").Replace("%", "[%]").Replace("_", "[_]").Replace("'", "''");
        }

        // === Eventos Grid ===
        protected void gvGrados_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
                e.Row.CssClass = "table-header";
                return;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string id = DataBinder.Eval(e.Row.DataItem, "Id") as string;
                e.Row.Attributes["data-id"] = id;
                e.Row.CssClass = (e.Row.CssClass + " data-row").Trim();
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }

        protected void gvGrados_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvGrados.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvGrados_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortDirection newDir = SortDirection.Ascending;
            if (ViewState[VS_SORT_EXPR] is string lastExpr && lastExpr == e.SortExpression &&
                ViewState[VS_SORT_DIR] is SortDirection lastDir)
            {
                newDir = lastDir == SortDirection.Ascending ? SortDirection.Descending : SortDirection.Ascending;
            }
            BindGrid(e.SortExpression, newDir);
        }

        // === Buscar ===
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            gvGrados.PageIndex = 0;
            BindGrid();
        }

        // === Mock data (reemplazar por DAO) ===
        private DataTable GetEjemploGrados()
        {
            var dt = new DataTable();
            dt.Columns.Add("Id", typeof(string));
            dt.Columns.Add("Nombre", typeof(string));
            dt.Columns.Add("Abreviatura", typeof(string));

            dt.Rows.Add("GA001", "Inicial", "INI");
            dt.Rows.Add("GA002", "Primaria", "PRI");
            dt.Rows.Add("GA003", "Secundaria", "SEC");
            return dt;
        }

        // Asegurar THEAD/TBODY
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (gvGrados.Rows.Count > 0)
                gvGrados.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}
