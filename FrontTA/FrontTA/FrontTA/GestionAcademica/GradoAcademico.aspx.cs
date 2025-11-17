using FrontTA.SisProgWS;
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
            // 🔹 AHORA: datos desde el WS, no mock
            DataTable data = GetGradosDesdeWS();

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
            return input.Replace("[", "[[]")
                        .Replace("%", "[%]")
                        .Replace("_", "[_]")
                        .Replace("'", "''");
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
                // Id es INT en el DataTable → lo convertimos a string
                string id = DataBinder.Eval(e.Row.DataItem, "Id")?.ToString();
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

        // === 🔹 NUEVO: obtener grados desde WS ===
        private DataTable GetGradosDesdeWS()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("Nombre", typeof(string));
            dt.Columns.Add("Abreviatura", typeof(string));

            try
            {
                using (var ws = new GradoAcademicoWSClient())
                {
                    var lista = ws.listarGradosAcademicosTodos();
                    Session["listaGrados"] = lista;

                    if (lista != null)
                    {
                        foreach (var g in lista)
                        {
                            // Propiedades según tu modelo Java/WS:
                            // g.grado_academico_id, g.nombre, g.abreviatura
                            dt.Rows.Add(g.grado_academico_id, g.nombre, g.abreviatura);
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

        // Asegurar THEAD/TBODY
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (gvGrados.Rows.Count > 0)
                gvGrados.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        // === 🔹 Eliminar (igual estilo que Cursos) ===
        private void Eliminar(int id)
        {
            try
            {
                using (var ws = new GradoAcademicoWSClient())
                {
                    int res = ws.eliminarGradoAcademicoPorId(id);

                    // Según tu SP ELIMINAR_GRADO_ACADEMICO, si hay dependencias
                    // (aulas o cursos) no elimina y el WS devuelve 0 (o < 0).
                    if (res <= 0)
                    {
                        ClientScript.RegisterStartupScript(
                            GetType(),
                            "dep",
                            "alert('No se puede eliminar el grado académico porque tiene aulas o cursos asociados.');",
                            true
                        );
                        return;
                    }
                }

                // 🔹 AQUÍ ESTABA EL ERROR: nombre correcto del archivo
                Response.Redirect("~/GestionAcademica/GradoAcademico.aspx");
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(
                    GetType(),
                    "err",
                    $"alert('Error al eliminar el grado académico: {ex.Message}');",
                    true
                );
            }
        }


        protected void btnDoDelete_Click(object sender, EventArgs e)
        {
            // Asegúrate que en el .aspx exista:
            // <asp:HiddenField ID="hfGradoIdSeleccionado" runat="server" />
            string idStr = hfGradoIdSeleccionado.Value;
            if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int idGrado))
            {
                Eliminar(idGrado);
            }
        }
    }
}
