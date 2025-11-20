using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using FrontTA.SisProgWS;   // <-- referencia a tus WS

namespace FrontTA.GestionAcademica
{
    public partial class ConsultarGradoAcademico : Page
    {
        private const string VS_AUL_SORT_EXPR = "CONS_AUL_SE";
        private const string VS_AUL_SORT_DIR = "CONS_AUL_SD";
        private const string VS_CUR_SORT_EXPR = "CONS_CUR_SE";
        private const string VS_CUR_SORT_DIR = "CONS_CUR_SD";

        private readonly GradoAcademicoWSClient boGrado = new GradoAcademicoWSClient();
        private readonly CursoWSClient boCurso = new CursoWSClient();
        //private readonly AulaWSClient boAula = new AulaWSClient();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // 1) Validar y obtener ID
            var idStr = Request.QueryString["id"];
            if (!int.TryParse(idStr, out var gradoId) || gradoId <= 0)
            {
                NotificarYVolver("Identificador de grado académico inválido.");
                return;
            }

            try
            {
                // 2) Consultar grado académico
                var grado = boGrado.obtenerGradoAcademicoPorId(gradoId);
                if (grado == null)
                {
                    NotificarYVolver("No se encontró el grado académico solicitado.");
                    return;
                }


                txtId.Text = grado.grado_academico_id.ToString();
                txtNombre.Text = grado.nombre;
                txtAbreviatura.Text = grado.abreviatura;

                // ddlActivo solo tiene "Vigente", así que si quieres reflejar inactivo
                // podrías agregar el ítem "No vigente" en el .aspx.
                if (grado.activo == 1)
                    ddlActivo.SelectedValue = "1";
                else if (ddlActivo.Items.FindByValue("0") != null)
                    ddlActivo.SelectedValue = "0";

                // Guardamos para reusar en paginación/ordenamiento
                ViewState["GradoId"] = grado.grado_academico_id;
                ViewState["GradoNombre"] = grado.nombre;

                // 3) Cargar Aulas y Cursos reales
                BindAulas();
                BindCursos();
            }
            catch (Exception ex)
            {
                NotificarYVolver("Ocurrió un error al consultar el grado académico: " + ex.Message);
            }
        }

        private void NotificarYVolver(string mensaje)
        {
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "msgGradoAcad",
                $"alert('{mensaje.Replace("'", "\\'")}'); window.location='{ResolveUrl("~/GestionAcademica/GradoAcademico.aspx")}';",
                true
            );
        }

        private int GetGradoIdFromViewState()
        {
            return (ViewState["GradoId"] is int id) ? id : int.Parse(txtId.Text);
        }

        private string GetGradoNombreFromViewState()
        {
            return (ViewState["GradoNombre"] as string) ?? txtNombre.Text;
        }

        // ================== AULAS ==================
        private void BindAulas(string sortExpression = null, SortDirection? sortDirection = null)
        {
            // Usamos el ID real del grado, no el nombre
            int gradoId = GetGradoIdFromViewState();

            // 1) Llamamos al WS de GRADO que internamente usa LISTAR_AULAS_POR_GRADO_ACADEMICO
            var aulasWS = boGrado.listarAulasPorGradoAcademico(gradoId);

            // 2) Preparamos el DataTable que espera el GridView
            var dt = new DataTable();
            dt.Columns.Add("Codigo", typeof(int));
            dt.Columns.Add("Nombre", typeof(string));

            if (aulasWS != null)
            {
                foreach (var a in aulasWS)
                {
                    // OJO: ajusta estos nombres a los de tu proxy .NET
                    // según lo que pusiste, son: a.aula_id y a.nombre
                    dt.Rows.Add(a.aula_id, a.nombre);
                }
            }

            DataView dv = dt.DefaultView;

            // 3) Ordenamiento igual que antes
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
                string codigo = DataBinder.Eval(e.Row.DataItem, "Codigo").ToString();
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
                newDir = lastDir == SortDirection.Ascending
                    ? SortDirection.Descending
                    : SortDirection.Ascending;
            }

            BindAulas(e.SortExpression, newDir);
        }

        // ================== CURSOS ==================
        private void BindCursos(string sortExpression = null, SortDirection? sortDirection = null)
        {
            string nombreGrado = GetGradoNombreFromViewState();

            // 1) Obtenemos cursos del WS filtrando por nombre de grado
            var cursosWS = boCurso.listarCursosPorNombreAbreviaturaOGradoAcademico(
                "",      // nombre (no filtramos)
                "",      // abreviatura (no filtramos)
                nombreGrado // nombre del grado
            );

            // 2) Construimos DataTable que espera el GridView
            DataTable dt = new DataTable();
            dt.Columns.Add("Codigo", typeof(int));
            dt.Columns.Add("Nombre", typeof(string));
            dt.Columns.Add("Abreviatura", typeof(string));
            dt.Columns.Add("Horas", typeof(int));

            if (cursosWS != null)
            {
                foreach (var c in cursosWS)
                {
                    // Ajusta nombres de propiedades según proxy:
                    // supuestos: c.cursoId, c.nombre, c.abreviatura, c.horasSemanales
                    dt.Rows.Add(c.curso_id, c.nombre, c.abreviatura, c.horas_semanales);
                }
            }

            DataView dv = dt.DefaultView;

            // Ordenamiento
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
                string codigo = DataBinder.Eval(e.Row.DataItem, "Codigo").ToString();
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
                newDir = lastDir == SortDirection.Ascending
                    ? SortDirection.Descending
                    : SortDirection.Ascending;
            }

            BindCursos(e.SortExpression, newDir);
        }

        // ================== OTROS ==================
        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/GestionAcademica/GradoAcademico.aspx"));
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (gvAulas.Rows.Count > 0) gvAulas.HeaderRow.TableSection = TableRowSection.TableHeader;
            if (gvCursos.Rows.Count > 0) gvCursos.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}
