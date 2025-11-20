using FrontTA.GestionAcademica;
using FrontTA.SisProgWS;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Usuarios
{
    public partial class Usuarios : Page
    {
        private UsuarioWSClient boUsuario = new UsuarioWSClient();
        private const string VS_SORT_EXPR = "USR_SORT_EXPR";
        private const string VS_SORT_DIR = "USR_SORT_DIR";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindGrid(); // ✅ usar el método central para cargar la grilla
        }

        private static string EscapeLike(string input)
        {
            return input.Replace("[", "[[]").Replace("%", "[%]").Replace("_", "[_]").Replace("'", "''");
        }

        // === GRID ===
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
                string id = DataBinder.Eval(e.Row.DataItem, "usuario_id")?.ToString();
                e.Row.Attributes["data-id"] = id;
                e.Row.CssClass = (e.Row.CssClass + " data-row").Trim();
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }

        protected void gvUsuarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsuarios.PageIndex = e.NewPageIndex;
            BindGrid(); // ✅ volver a aplicar filtros y datos
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

        // === BUSCAR ===
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            gvUsuarios.PageIndex = 0; // reiniciar paginación
            BindGrid(); // ✅ volver a cargar con el filtro aplicado
        }

        // === CARGA CENTRAL ===
        private void BindGrid(string sortExpression = null, SortDirection? sortDirection = null)
        {
            DataTable data = GetUsuarios();

            // Filtro por nombre
            string nom = txtNombre.Text.Trim();
            string filter = "1=1";
            if (!string.IsNullOrEmpty(nom))
                filter += $" AND Nombre LIKE '%{EscapeLike(nom)}%'";

            DataView dv = new DataView(data)
            {
                RowFilter = filter
            };

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

            gvUsuarios.DataSource = dv;
            gvUsuarios.DataBind();
        }

        private DataTable GetUsuarios()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("usuario_id", typeof(int));
            dt.Columns.Add("Nombre", typeof(string));
            dt.Columns.Add("ultimo_acceso", typeof(string));

            try
            {
                var lista = boUsuario.listarUsuariosTodos();
                if (lista != null)
                {
                    foreach (var c in lista)
                    {
                        dt.Rows.Add(c.usuario_id, c.nombre, c.ultimo_acceso);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "err", $"alert('Error: {ex.Message}');", true);
            }

            return dt;
        }

        private void eliminar(int id)
        {
            try
            {
                using (var ws = new UsuarioWSClient())
                {
                    int res = ws.eliminarUsuarioPorId(id);
                    Response.Redirect("~/Usuarios/Usuarios.aspx");
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "err", $"alert('Error: {ex.Message}');", true);
            }
        }

        protected void btnDoDelete_Click(object sender, EventArgs e)
        {
            string idStr = hfUsuarioIdSeleccionado.Value;
            if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int idUsuario))
                eliminar(idUsuario);
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (gvUsuarios.Rows.Count > 0)
                gvUsuarios.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}