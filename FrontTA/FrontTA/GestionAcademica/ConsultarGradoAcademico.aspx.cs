using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace FrontTA.GestionAcademica
{
    public partial class ConsultarGradoAcademico : Page
    {
        private const string VS_AUL_SORT_EXPR = "CONS_AUL_SE";
        private const string VS_AUL_SORT_DIR = "CONS_AUL_SD";
        private const string VS_CUR_SORT_EXPR = "CONS_CUR_SE";
        private const string VS_CUR_SORT_DIR = "CONS_CUR_SD";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // 1) Cargar datos del grado (mock)
            string id = Request.QueryString["id"] ?? "GA001";
            txtId.Text = id;
            txtNombre.Text = (id == "GA001") ? "Inicial" : "Primaria";
            txtAbreviatura.Text = (id == "GA001") ? "INI" : "PRI";
            ddlActivo.SelectedValue = "1";

            // 2) Cargar Aulas y Cursos (mock con tus ejemplos)
            BindAulas();
            BindCursos();
        }

        // ====== AULAS ======
        private void BindAulas(string sortExpression = null, SortDirection? sortDirection = null)
        {
            DataTable dt = GetEjemploAulas(txtId.Text);
            DataView dv = new DataView(dt);

            if (!string.IsNullOrEmpty(sortExpression))
            {
                string dir = (sortDirection ?? SortDirection.Ascending) == SortDirection.Ascending ? "ASC" : "DESC";
                dv.Sort = $"{sortExpression} {dir}";
                ViewState[VS_AUL_SORT_EXPR] = sortExpression;
                ViewState[VS_AUL_SORT_DIR] = sortDirection ?? SortDirection.Ascending;
            }
            else if (ViewState[VS_AUL_SORT_EXPR] is string se && ViewState[VS_AUL_SORT_DIR] is SortDirection sd)
            {
                dv.Sort = $"{se} {(sd == SortDirection.Ascending ? "ASC" : "DESC")}";
            }

            gvAulas.DataSource = dv;
            gvAulas.DataBind();
        }

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
            BindAulas();
        }

        protected void gvAulas_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortDirection newDir = SortDirection.Ascending;
            if (ViewState[VS_AUL_SORT_EXPR] is string lastExpr && lastExpr == e.SortExpression &&
                ViewState[VS_AUL_SORT_DIR] is SortDirection lastDir)
            {
                newDir = lastDir == SortDirection.Ascending ? SortDirection.Descending : SortDirection.Ascending;
            }
            BindAulas(e.SortExpression, newDir);
        }

        private DataTable GetEjemploAulas(string gradoId)
        {
            var dt = new DataTable();
            dt.Columns.Add("Codigo", typeof(string));
            dt.Columns.Add("Nombre", typeof(string));

            // Igual que tu lógica anterior (A01..A03)
            dt.Rows.Add(gradoId + "-A01", "Aula 1");
            dt.Rows.Add(gradoId + "-A02", "Aula 2");
            dt.Rows.Add(gradoId + "-A03", "Aula 3");
            return dt;
        }

        // ====== CURSOS ======
        private void BindCursos(string sortExpression = null, SortDirection? sortDirection = null)
        {
            DataTable dt = GetEjemploCursos(txtId.Text);
            DataView dv = new DataView(dt);

            if (!string.IsNullOrEmpty(sortExpression))
            {
                string dir = (sortDirection ?? SortDirection.Ascending) == SortDirection.Ascending ? "ASC" : "DESC";
                dv.Sort = $"{sortExpression} {dir}";
                ViewState[VS_CUR_SORT_EXPR] = sortExpression;
                ViewState[VS_CUR_SORT_DIR] = sortDirection ?? SortDirection.Ascending;
            }
            else if (ViewState[VS_CUR_SORT_EXPR] is string se && ViewState[VS_CUR_SORT_DIR] is SortDirection sd)
            {
                dv.Sort = $"{se} {(sd == SortDirection.Ascending ? "ASC" : "DESC")}";
            }

            gvCursos.DataSource = dv;
            gvCursos.DataBind();
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
                string codigo = DataBinder.Eval(e.Row.DataItem, "Codigo") as string;
                e.Row.Attributes["data-id"] = codigo;
                e.Row.CssClass = (e.Row.CssClass + " data-row").Trim();
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }

        protected void gvCursos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCursos.PageIndex = e.NewPageIndex;
            BindCursos();
        }

        protected void gvCursos_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortDirection newDir = SortDirection.Ascending;
            if (ViewState[VS_CUR_SORT_EXPR] is string lastExpr && lastExpr == e.SortExpression &&
                ViewState[VS_CUR_SORT_DIR] is SortDirection lastDir)
            {
                newDir = lastDir == SortDirection.Ascending ? SortDirection.Descending : SortDirection.Ascending;
            }
            BindCursos(e.SortExpression, newDir);
        }

        private DataTable GetEjemploCursos(string gradoId)
        {
            var dt = new DataTable();
            dt.Columns.Add("Codigo", typeof(string));
            dt.Columns.Add("Nombre", typeof(string));
            dt.Columns.Add("Abreviatura", typeof(string));
            dt.Columns.Add("Horas", typeof(int));

            dt.Rows.Add(gradoId + "-C01", "Comunicación", "COM", 5);
            dt.Rows.Add(gradoId + "-C02", "Matemática", "MAT", 6);
            dt.Rows.Add(gradoId + "-C03", "Historia", "HIS", 3);
            return dt;
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/GestionAcademica/GradoAcademico.aspx"));
        }

        // Asegurar THEAD en ambos grids
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (gvAulas.Rows.Count > 0) gvAulas.HeaderRow.TableSection = TableRowSection.TableHeader;
            if (gvCursos.Rows.Count > 0) gvCursos.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}
