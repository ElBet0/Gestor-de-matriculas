using System;
using System.Data;
using System.Linq;              // <-- IMPORTANTE para usar LINQ
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
            dt.Columns.Add("Capacidad", typeof(int));
            dt.Columns.Add("Vacantes", typeof(int));
            dt.Columns.Add("GradoAcademico", typeof(string));

            try
            {
                using (var aulaWs = new AulaWSClient())
                using (var periodoWs = new PeriodoWSClient())
                using (var periodoAulaWs = new PeriodoXAulaWSClient())
                {
                    // 1) Año actual
                    int anioActual = DateTime.Now.Year;

                    // 2) Buscar periodo del año actual
                    var periodos = periodoWs.listarPeriodosTodos();
                    int periodoActualId = 0;

                    if (periodos != null && periodos.Length > 0)
                    {
                        // primero por fecha_inicio.Year
                        var p = periodos.FirstOrDefault(x =>
                            x.fecha_inicio != null &&
                            x.fecha_inicio.Year == anioActual);

                        // si no hay, probar por nombre = "2025", etc.
                        if (p == null)
                            p = periodos.FirstOrDefault(x => x.nombre == anioActual.ToString());

                        if (p != null)
                            periodoActualId = p.periodo_academico_id;
                    }

                    // 3) Construir mapa AulaId -> (Capacidad, Vacantes) SOLO del periodo actual
                    var mapaCapacidad = new System.Collections.Generic.Dictionary<int, (int Cap, int Vac)>();

                    if (periodoActualId != 0)
                    {
                        var periodosXAula = periodoAulaWs.listarPeriodosXAulasTodos();
                        if (periodosXAula != null)
                        {
                            foreach (var pa in periodosXAula)
                            {
                                // Ajusta nombres según tu proxy:
                                // pa.periodo_academico.periodo_academico_id
                                // pa.aula.aula_id
                                // pa.vacantes_disponibles, pa.vacantes_ocupadas

                                if (pa.periodo == null ||
                                    pa.periodo.periodo_academico_id != periodoActualId)
                                    continue;

                                if (pa.aula == null)
                                    continue;

                                int aulaId = pa.aula.aula_id;

                                int disp = pa.vacantes_disponibles;
                                int ocup = pa.vacantes_ocupadas;

                                int capacidad = disp;                 // capacidad total
                                int vacantesLibres = disp - ocup;     // cupos libres
                                if (vacantesLibres < 0) vacantesLibres = 0;

                                mapaCapacidad[aulaId] = (capacidad, vacantesLibres);
                            }
                        }
                    }

                    // 4) Aulas + info de periodo actual
                    var aulas = aulaWs.listarAulasTodas();
                    Session["listaAulas"] = aulas;

                    if (aulas != null)
                    {
                        foreach (var a in aulas)
                        {
                            string nombreGrado = a.grado != null ? a.grado.nombre : string.Empty;

                            int capacidad = 0;
                            int vacantes = 0;

                            if (mapaCapacidad.TryGetValue(a.aula_id, out var info))
                            {
                                capacidad = info.Cap;
                                vacantes = info.Vac;
                            }

                            dt.Rows.Add(
                                a.aula_id,
                                a.nombre,
                                capacidad,
                                vacantes,
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
                    int res = ws.eliminarAulaPorId(id);

                    if (res <= 0)
                    {
                        ClientScript.RegisterStartupScript(
                            GetType(),
                            "dep",
                            "alert('No se puede eliminar el aula porque tiene dependencias (períodos, matrículas, etc.).');",
                            true
                        );
                        return;
                    }
                }

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
