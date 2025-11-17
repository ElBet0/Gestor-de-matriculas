using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Matricula
{
    public partial class Matricula : System.Web.UI.Page
    {
        private class FilaAnio
        {
            public int Anio { get; set; }
            public int Cantidad { get; set; }
            public bool EsVigente { get; set; }
        }

        // ====== Periodos académicos (demo con ViewState) ======
        private List<int> Periodos
        {
            get
            {
                if (ViewState["Periodos"] == null)
                {
                    // Semilla: años recientes (puedes reemplazar por consulta a BD)
                    int vigente = DateTime.Now.Year;
                    ViewState["Periodos"] = Enumerable.Range(vigente - 3, 4).ToList(); // [vigente-3 .. vigente]
                }
                return (List<int>)ViewState["Periodos"];
            }
            set { ViewState["Periodos"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarAnios();
                BindGridsPeriodo();
            }
        }

        private void CargarAnios()
        {
            int vigente = DateTime.Now.Year;

            var lista = new List<FilaAnio>();
            foreach (var anio in Periodos.OrderByDescending(x => x))
            {
                lista.Add(new FilaAnio
                {
                    Anio = anio,
                    Cantidad = 400 - (vigente - anio) * 12,
                    EsVigente = (anio == vigente)
                });
            }

            rptAnios.DataSource = lista;
            rptAnios.DataBind();
        }

        private void BindGridsPeriodo()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Anio", typeof(int));
            dt.Columns.Add("Estado", typeof(string));

            int vigente = DateTime.Now.Year;
            foreach (var a in Periodos.OrderByDescending(x => x))
                dt.Rows.Add(a, a == vigente ? "Vigente" : "Histórico");

            gvPeriodosEdit.DataSource = dt;
            gvPeriodosEdit.DataBind();

            gvPeriodosDel.DataSource = dt;
            gvPeriodosDel.DataBind();
        }

        // ===== estilos de filas "seleccionables" (reutilizado) =====
        protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
                e.Row.CssClass += " data-row";
        }

        // ======== CREAR ========
        protected void btnCrearOk_Click(object sender, EventArgs e)
        {
            lblErrCrear.Text = string.Empty;
            int nuevoAnio;

            if (!int.TryParse(txtNuevoAnio.Text, out nuevoAnio))
            {
                lblErrCrear.Text = "Ingrese un año válido (4 dígitos).";
                Reabrir("ovCrear"); return;
            }
            if (nuevoAnio < DateTime.Now.Year)
            {
                lblErrCrear.Text = "El año debe ser mayor o igual al año actual.";
                Reabrir("ovCrear"); return;
            }
            if (Periodos.Contains(nuevoAnio))
            {
                lblErrCrear.Text = "El periodo académico ya existe.";
                Reabrir("ovCrear"); return;
            }

            // TODO: insertar en BD
            var ps = Periodos; ps.Add(nuevoAnio); Periodos = ps;

            // Refresca UI
            txtNuevoAnio.Text = string.Empty;
            CargarAnios();
            BindGridsPeriodo();
        }

        // ======== EDITAR (modificar año seleccionado) ========
        protected void btnEditOk_Click(object sender, EventArgs e)
        {
            lblErrEditar.Text = string.Empty;

            int sel, nuevo;
            if (!int.TryParse(hdnPeriodoSel.Value, out sel))
            {
                lblErrEditar.Text = "Seleccione un periodo a modificar.";
                Reabrir("ovEditar"); return;
            }
            if (!int.TryParse(txtEditarAnio.Text, out nuevo))
            {
                lblErrEditar.Text = "Ingrese un año válido (4 dígitos).";
                Reabrir("ovEditar"); return;
            }
            if (nuevo < DateTime.Now.Year)
            {
                lblErrEditar.Text = "El año debe ser mayor o igual al año actual.";
                Reabrir("ovEditar"); return;
            }
            if (Periodos.Contains(nuevo) && nuevo != sel)
            {
                lblErrEditar.Text = "Ya existe un periodo con ese año.";
                Reabrir("ovEditar"); return;
            }

            // TODO: actualizar en BD (sel -> nuevo)
            var ps = Periodos;
            if (!ps.Contains(sel)) { lblErrEditar.Text = "El periodo seleccionado no existe."; Reabrir("ovEditar"); return; }
            ps.Remove(sel);
            ps.Add(nuevo);
            Periodos = ps;

            // Refresca UI
            hdnPeriodoSel.Value = string.Empty;
            txtEditarAnio.Text = string.Empty;
            CargarAnios();
            BindGridsPeriodo();
        }

        // ======== ELIMINAR ========
        protected void btnDelOk_Click(object sender, EventArgs e)
        {
            lblErrEliminar.Text = string.Empty;

            int sel;
            if (!int.TryParse(hdnPeriodoDel.Value, out sel))
            {
                lblErrEliminar.Text = "Seleccione un periodo a eliminar.";
                Reabrir("ovEliminar"); return;
            }
            // (opcional) impedir borrar el vigente
            if (sel == DateTime.Now.Year)
            {
                lblErrEliminar.Text = "No se puede eliminar el periodo vigente.";
                Reabrir("ovEliminar"); return;
            }

            // TODO: eliminar en BD
            var ps = Periodos;
            ps.Remove(sel);
            Periodos = ps;

            hdnPeriodoDel.Value = string.Empty;
            CargarAnios();
            BindGridsPeriodo();
        }

        // Reabre modal tras postback si hubo error
        private void Reabrir(string overlayId)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "reopen_" + overlayId,
                $"document.getElementById('{overlayId}').classList.add('show');", true);
        }

        // ======== (tu lógica existente de Repeater) ========
        protected void rptAnios_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var fila = (FilaAnio)e.Item.DataItem;
            var lnkRep = (HyperLink)e.Item.FindControl("lnkReporte");
            lnkRep.NavigateUrl = ResolveUrl($"~/Matricula/ReporteMatricula.aspx?anio={fila.Anio}");

            var btn = (LinkButton)e.Item.FindControl("btnAccion");
            if (fila.EsVigente)
            {
                btn.Text = "Agregar Alumno";
                btn.CssClass += " btn-green";
                btn.ToolTip = "Ir a búsqueda para agregar alumnos del año vigente";
            }
            else
            {
                btn.Text = "Consultar Alumnos";
                btn.CssClass += " btn-gray";
                btn.ToolTip = "Ir a búsqueda para consultar alumnos de este año";
            }
        }

        protected void rptAnios_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "abrir") return;

            int anio = int.Parse((string)e.CommandArgument);
            bool esVigente = false;

            var hf = (HiddenField)e.Item.FindControl("hfEsVigente");
            if (hf != null) bool.TryParse(hf.Value, out esVigente);

            string modo = esVigente ? "agregar" : "consultar";
            string url = $"~/Matricula/BuscarMatricula.aspx?anio={anio}&modo={modo}";
            Response.Redirect(ResolveUrl(url));
        }
    }
}
