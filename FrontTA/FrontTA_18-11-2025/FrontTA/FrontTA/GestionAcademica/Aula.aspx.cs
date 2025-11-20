using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using FrontTA.SisProgWS;

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
            DataTable data = GetAulasDesdeWS();

            // Filtros
            string aulaNom = txtAulaNombre.Text.Trim();
            string gradoNom = txtGradoNombre.Text.Trim();

            string filter = "1=1";
            if (!string.IsNullOrEmpty(aulaNom))
                filter += $" AND NombreAula LIKE '%{EscapeLike(aulaNom)}%'";
            if (!string.IsNullOrEmpty(gradoNom))
                filter += $" AND GradoAcademico LIKE '%{EscapeLike(gradoNom)}%'";

            DataView dv = new DataView(data) { RowFilter = filter };

            // Orden
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string dir = (sortDirection ?? SortDirection.Ascending) == SortDirection.Ascending
                    ? "ASC"
                    : "DESC";

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
            return input
                .Replace("[", "[[]")
                .Replace("%", "[%]")
                .Replace("_", "[_]")
                .Replace("'", "''");
        }

        // ================== GRID EVENTS ==================
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
                string codigo = DataBinder.Eval(e.Row.DataItem, "Codigo")?.ToString();
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
                newDir = lastDir == SortDirection.Ascending
                    ? SortDirection.Descending
                    : SortDirection.Ascending;
            }
            BindGrid(e.SortExpression, newDir);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            gvAulas.PageIndex = 0;
            BindGrid();
        }

        // ================== DATOS DESDE WS ==================
        private DataTable GetAulasDesdeWS()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Codigo", typeof(int));
            dt.Columns.Add("NombreAula", typeof(string));
            dt.Columns.Add("GradoAcademico", typeof(string));

            try
            {
                using (var aulaWs = new AulaWSClient())
                {
                    var aulas = aulaWs.listarAulasTodas();
                    Session["listaAulas"] = aulas;

                    if (aulas != null)
                    {
                        foreach (var a in aulas)
                        {
                            string nombreGrado = string.Empty;

                            // Ajusta estas propiedades según tu proxy:
                            // a.grado, a.grado.nombre, etc.
                            if (a.grado != null)
                                nombreGrado = a.grado.nombre;

                            dt.Rows.Add(
                                a.aula_id,
                                a.nombre,
                                nombreGrado
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Console.WriteLine("Error al listar aulas: " + ex.Message);
            }

            return dt;
        }

        // Asegurar THEAD/TBODY
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (gvAulas.Rows.Count > 0)
                gvAulas.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        // ================== ELIMINAR AULA ==================
        private void Eliminar(int id)
        {
            try
            {
                using (var ws = new AulaWSClient())
                {

                    int resultado = ws.eliminarAulaPorId(id);

                    if (resultado <= 0)
                    {
                        ClientScript.RegisterStartupScript(
                            GetType(),
                            "dep",
                            "alert('No se pudo eliminar el aula (puede tener dependencias).');",
                            true
                        );
                        return;
                    }
                }

                // Recargar la página / grilla
                Response.Redirect("~/GestionAcademica/Aula.aspx");
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(
                    GetType(),
                    "err",
                    $"alert('Error al eliminar el aula: {ex.Message}');",
                    true
                );
            }
        }


        protected void btnDoDelete_Click(object sender, EventArgs e)
        {
            string idStr = hfAulaIdSeleccionada.Value;
            if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int idAula))
            {
                Eliminar(idAula);
            }
        }
    }
}
