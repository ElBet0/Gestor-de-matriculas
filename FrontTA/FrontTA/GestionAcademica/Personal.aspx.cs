using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class Personal : Page
    {
        private const string VS_SORT_EXPR = "PER_SORT_EXPR";
        private const string VS_SORT_DIR = "PER_SORT_DIR";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid(string sortExpression = null, SortDirection? sortDirection = null)
        {
            DataTable data = GetEjemploPersonal();

            // Filtros
            string dni = txtDni.Text.Trim();
            string nom = txtNombre.Text.Trim();
            string apep = txtApePat.Text.Trim();
            string apem = txtApeMat.Text.Trim();

            string filter = "1=1";
            if (!string.IsNullOrEmpty(dni)) filter += $" AND Dni LIKE '%{EscapeLike(dni)}%'";
            if (!string.IsNullOrEmpty(nom)) filter += $" AND Nombre LIKE '%{EscapeLike(nom)}%'";
            if (!string.IsNullOrEmpty(apep)) filter += $" AND ApellidoPaterno LIKE '%{EscapeLike(apep)}%'";
            if (!string.IsNullOrEmpty(apem)) filter += $" AND ApellidoMaterno LIKE '%{EscapeLike(apem)}%'";

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

            gvPersonal.DataSource = dv;
            gvPersonal.DataBind();
        }

        private static string EscapeLike(string input)
        {
            return input.Replace("[", "[[]").Replace("%", "[%]").Replace("_", "[_]").Replace("'", "''");
        }

        // === GRID EVENTS ===
        protected void gvPersonal_RowDataBound(object sender, GridViewRowEventArgs e)
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

        protected void gvPersonal_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPersonal.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvPersonal_Sorting(object sender, GridViewSortEventArgs e)
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
            gvPersonal.PageIndex = 0;
            BindGrid();
        }

        // === Mock con TUS MISMOS EJEMPLOS ===
        private DataTable GetEjemploPersonal()
        {
            var dt = new DataTable();
            dt.Columns.Add("Id", typeof(string));
            dt.Columns.Add("Nombre", typeof(string));
            dt.Columns.Add("ApellidoPaterno", typeof(string));
            dt.Columns.Add("ApellidoMaterno", typeof(string));
            dt.Columns.Add("Dni", typeof(string));
            dt.Columns.Add("Email", typeof(string));
            dt.Columns.Add("Telefono", typeof(string));

            dt.Rows.Add("P001", "María López", "García", "Torres", "45879632", "maria.lopez@colegio.edu", "999-123-456");
            dt.Rows.Add("P002", "Carlos Ramos", "Ramos", "Quispe", "41256987", "carlos.ramos@colegio.edu", "988-111-222");
            dt.Rows.Add("P003", "Ana Chávez", "Chávez", "Hinojosa", "47651234", "ana.chavez@colegio.edu", "987-654-321");

            return dt;
        }

        // Asegurar THEAD/TBODY incluso sin filas
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (gvPersonal.Rows.Count > 0)
                gvPersonal.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}
