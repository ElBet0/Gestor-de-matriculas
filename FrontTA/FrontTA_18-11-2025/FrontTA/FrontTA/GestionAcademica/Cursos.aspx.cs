using FrontTA.SisProgWS;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class Cursos : Page
    {
        private const string VS_SORT_EXPR = "CUR_SORT_EXPR";
        private const string VS_SORT_DIR = "CUR_SORT_DIR";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindGrid();
        }

        private void BindGrid(string sortExpression = null, SortDirection? sortDirection = null)
        {
            DataTable data = GetCursosDesdeWS();

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

            gvCursos.DataSource = dv;
            gvCursos.DataBind();
        }

        private static string EscapeLike(string input)
        {
            return input.Replace("[", "[[]").Replace("%", "[%]").Replace("_", "[_]").Replace("'", "''");
        }

        protected void gvCursos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
                e.Row.CssClass = "table-header";
                return;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string id = DataBinder.Eval(e.Row.DataItem, "Id")?.ToString();
                e.Row.Attributes["data-id"] = id;
                e.Row.CssClass = (e.Row.CssClass + " data-row").Trim();
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }

        protected void gvCursos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCursos.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvCursos_Sorting(object sender, GridViewSortEventArgs e)
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
            gvCursos.PageIndex = 0;
            BindGrid();
        }

        // === 🔹 NUEVO: obtener cursos desde WS ===
        private DataTable GetCursosDesdeWS()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("Nombre", typeof(string));
            dt.Columns.Add("Abreviatura", typeof(string));
            dt.Columns.Add("HorasSemanales", typeof(int));

            try
            {
                using (var ws = new CursoWSClient())
                {
                    var lista = ws.listarCursosTodos();
                    Session["listaCursos"] = lista;

                    if (lista != null)
                    {
                        foreach (var c in lista)
                        {
                            dt.Rows.Add(c.curso_id, c.nombre, c.abreviatura, c.horas_semanales);

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Console.WriteLine(ex.Message);
            }

            return dt;
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (gvCursos.Rows.Count > 0)
                gvCursos.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        private void eliminar(int id)
        {
            try
            {
                using (var ws = new CursoWSClient())
                {
                    int res = ws.eliminarCursoPorId(id); // método WS


                    Response.Redirect("~/GestionAcademica/Cursos.aspx");
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "err", $"alert('Error: {ex.Message}');", true);
            }
        }

        protected void btnDoDelete_Click(object sender, EventArgs e)
        {

            string idStr = hfCursoIdSeleccionado.Value;
            if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int idCurso))
                eliminar(idCurso);

        }


    }
}
