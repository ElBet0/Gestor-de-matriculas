using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Usuarios
{
    public partial class Usuarios : Page
    {
        private const string VS_SORT_EXPR = "USR_SORT_EXPR";
        private const string VS_SORT_DIR = "USR_SORT_DIR";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid(); // carga inicial
            }
        }

        // Binding central (aplica filtros, orden y pagina)
        private void BindGrid(string sortExpression = null, SortDirection? sortDirection = null)
        {
            DataTable data = GetEjemploUsuarios();

            // Filtros de búsqueda
            string nom = txtNombre.Text.Trim();
            string apep = txtApePaterno.Text.Trim();
            string apem = txtApeMaterno.Text.Trim();

            string filter = "1=1";
            if (!string.IsNullOrEmpty(nom)) filter += $" AND Nombre LIKE '%{EscapeLike(nom)}%'";
            if (!string.IsNullOrEmpty(apep)) filter += $" AND ApellidoPaterno LIKE '%{EscapeLike(apep)}%'";
            if (!string.IsNullOrEmpty(apem)) filter += $" AND ApellidoMaterno LIKE '%{EscapeLike(apem)}%'";

            // Vista + orden
            DataView dv = new DataView(data) { RowFilter = filter };

            if (!string.IsNullOrEmpty(sortExpression))
            {
                string dir = (sortDirection ?? SortDirection.Ascending) == SortDirection.Ascending ? "ASC" : "DESC";
                // sort por columna base si es compuesto
                string sortCol = sortExpression == "NombreCompleto" ? "ApellidoPaterno, ApellidoMaterno, Nombre" : sortExpression;
                dv.Sort = $"{sortCol} {dir}";
                ViewState[VS_SORT_EXPR] = sortExpression;
                ViewState[VS_SORT_DIR] = sortDirection ?? SortDirection.Ascending;
            }
            else
            {
                if (ViewState[VS_SORT_EXPR] is string se && ViewState[VS_SORT_DIR] is SortDirection sd)
                {
                    string sortCol = se == "NombreCompleto" ? "ApellidoPaterno, ApellidoMaterno, Nombre" : se;
                    dv.Sort = $"{sortCol} {(sd == SortDirection.Ascending ? "ASC" : "DESC")}";
                }
            }

            // Proyección de columna formateada de fecha (para mostrar)
            DataTable shown = dv.ToTable();
            if (!shown.Columns.Contains("UltimoAccesoStr")) shown.Columns.Add("UltimoAccesoStr", typeof(string));
            foreach (DataRow r in shown.Rows)
            {
                if (r["UltimoAcceso"] is DateTime dt)
                    r["UltimoAccesoStr"] = dt.ToString("yyyy-MM-dd HH:mm");
                else
                    r["UltimoAccesoStr"] = r["UltimoAcceso"]?.ToString();
            }

            // Columna NombreCompleto para la UI (sin romper filtros)
            if (!shown.Columns.Contains("NombreCompleto")) shown.Columns.Add("NombreCompleto", typeof(string));
            foreach (DataRow r in shown.Rows)
            {
                r["NombreCompleto"] = $"{r["Nombre"]} {r["ApellidoPaterno"]} {r["ApellidoMaterno"]}".Trim();
            }

            gvUsuarios.DataSource = shown;
            gvUsuarios.DataBind();
        }

        private static string EscapeLike(string input)
        {
            return input.Replace("[", "[[]").Replace("%", "[%]").Replace("_", "[_]").Replace("'", "''");
        }

        // ==== GRID EVENTS ====
        protected void gvUsuarios_RowDataBound(object sender, GridViewRowEventArgs e)
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

        protected void gvUsuarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsuarios.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvUsuarios_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortDirection newDir = SortDirection.Ascending;
            if (ViewState[VS_SORT_EXPR] is string lastExpr && lastExpr == e.SortExpression &&
                ViewState[VS_SORT_DIR] is SortDirection lastDir)
            {
                newDir = lastDir == SortDirection.Ascending ? SortDirection.Descending : SortDirection.Ascending;
            }
            BindGrid(e.SortExpression, newDir);
        }

        // ==== BUSCAR ====
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            gvUsuarios.PageIndex = 0;
            BindGrid();
        }

        // MOCK DATA (EJEMPLOS)
        private DataTable GetEjemploUsuarios()
        {
            var dt = new DataTable();
            dt.Columns.Add("Id", typeof(string));
            dt.Columns.Add("Nombre", typeof(string));
            dt.Columns.Add("ApellidoPaterno", typeof(string));
            dt.Columns.Add("ApellidoMaterno", typeof(string));
            dt.Columns.Add("Email", typeof(string));
            dt.Columns.Add("UltimoAcceso", typeof(DateTime));

            dt.Rows.Add("U101", "María", "López", "García", "maria.lopez@colegio.edu", new DateTime(2025, 10, 20, 8, 34, 0));
            dt.Rows.Add("U102", "Juan", "Pérez", "Santos", "juan.perez@colegio.edu", new DateTime(2025, 10, 21, 14, 12, 0));
            dt.Rows.Add("U103", "Ana", "Chávez", "Hinojosa", "ana.chavez@colegio.edu", new DateTime(2025, 10, 23, 19, 55, 0));
            dt.Rows.Add("U104", "Luis", "Torres", "Quispe", "luis.torres@colegio.edu", new DateTime(2025, 10, 25, 9, 15, 0));
            dt.Rows.Add("U105", "Sofía", "Ramos", "López", "sofia.ramos@colegio.edu", new DateTime(2025, 10, 27, 12, 40, 0));

            return dt;
        }
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (gvUsuarios.Rows.Count > 0)
                gvUsuarios.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}
