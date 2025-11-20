using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Matricula
{
    public partial class Matricula : System.Web.UI.Page
    {
        private readonly PeriodoWSClient boPeriodo = new PeriodoWSClient();
        private readonly PeriodoXAulaWSClient boPeriodoXAula = new PeriodoXAulaWSClient();

        //// ====== periodos académicos (demo con viewstate) ======

        public class Capacidad
        {
            periodoAcademico periodo;
            int matriculados;
            int disponibles;
            public int Matriculados { get => matriculados; set => matriculados = value; }
            public int Disponibles { get => disponibles; set => disponibles = value; }
            public periodoAcademico Periodo { get => periodo; set => periodo = value; }
        }

        List<Capacidad> Periodos = new List<Capacidad>();

        protected void Page_Load(object sender, EventArgs e)
        {
            CargarAnios();

            if (!IsPostBack)
            {
                BindGridsPeriodo();
            }
        }

        private void CargarAnios()
        {
            int vigente = DateTime.Now.Year;

            var lista_periodos = boPeriodo.listarPeriodosTodos().OrderByDescending(x => x.fecha_inicio.Year).ToList();

            Periodos = new List<Capacidad>();

            foreach(var periodo in lista_periodos)
            {
                Periodos.Add(new Capacidad
                {
                    Periodo = periodo,
                    Disponibles = 0,
                    Matriculados = 0,
                });
            }

            var lista_cantidades = boPeriodoXAula.listarPeriodosXAulasTodos();

            foreach (var a in lista_cantidades)
            {
                var capacidad = Periodos.Find(x => x.Periodo.periodo_academico_id == a.periodo.periodo_academico_id);
                capacidad.Matriculados += a.vacantes_ocupadas;
                capacidad.Disponibles += a.vacantes_disponibles;
            }

            rptAnios.DataSource = Periodos;
            rptAnios.DataBind();

        }

        private void BindGridsPeriodo()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Anio", typeof(int));
            dt.Columns.Add("Estado", typeof(string));

            int vigente = DateTime.Now.Year;
            foreach (var a in Periodos.OrderByDescending(x => x.Periodo.fecha_inicio.Year))
                dt.Rows.Add(a.Periodo.fecha_inicio.Year, a.Periodo.fecha_inicio.Year == vigente ? "Vigente" : "Histórico");

            gvPeriodosEdit.DataSource = dt;
            gvPeriodosEdit.DataKeyNames = new string[] { "Anio" };
            gvPeriodosEdit.DataBind();

            gvPeriodosDel.DataSource = dt;
            gvPeriodosDel.DataKeyNames = new string[] { "Anio" };
            gvPeriodosDel.DataBind();
        }

        // ===== estilos de filas "seleccionables" (reutilizado) =====
        protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string anio = DataBinder.Eval(e.Row.DataItem, "Anio").ToString();
                e.Row.Attributes["onclick"] = "seleccionarFila(this, '" + anio + "');";
                e.Row.CssClass += " data-row";
            }
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
            if (Periodos.Any(x => x.Periodo.fecha_inicio.Year == nuevoAnio))
            {
                lblErrCrear.Text = "El periodo académico ya existe.";
                Reabrir("ovCrear"); return;
            }

            // TODO: insertar en BD
            var _periodo = new periodoAcademico()
            {
                nombre = nuevoAnio.ToString(),
                descripcion = "Año Academico " + nuevoAnio.ToString(),
                activo = 1
            };

            var fmt = CultureInfo.InvariantCulture;

            if (DateTime.TryParseExact(nuevoAnio.ToString() + "-03-01", "yyyy-MM-dd", fmt, DateTimeStyles.None, out DateTime fn))
            {
                fn = DateTime.SpecifyKind(fn.Date, DateTimeKind.Unspecified);
                _periodo.fecha_inicio = fn;
                _periodo.fecha_inicioSpecified = true;
            }
            else
            {
                lblErrCrear.Text = "La fecha de inicio no tiene un formato válido (use el selector de fecha).";
                Reabrir("ovCrear"); return;
            }

            if (DateTime.TryParseExact(nuevoAnio.ToString() + "-12-15", "yyyy-MM-dd", fmt, DateTimeStyles.None, out DateTime fn1))
            {
                fn1 = DateTime.SpecifyKind(fn1.Date, DateTimeKind.Unspecified);
                _periodo.fecha_fin = fn1;
                _periodo.fecha_finSpecified = true;
            }
            else
            {
                lblErrCrear.Text = "La fecha de fin no tiene un formato válido (use el selector de fecha).";
                Reabrir("ovCrear"); return;
            }

            _periodo.periodo_academico_id = boPeriodo.insertarPeriodo(_periodo);

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
            if (!int.TryParse(hfAnioSeleccionado.Value, out sel))
            {
                lblErrEditar.Text = "Seleccione un periodo a modificar.";
                Reabrir("ovEditar"); return;
            }
            if (!int.TryParse(txtEditarAnio.Text, out nuevo))
            {
                lblErrEditar.Text = "Ingrese un año válido (4 dígitos).";
                Reabrir("ovEditar"); return;
            }
            if (nuevo < 1800)
            {
                lblErrEditar.Text = "El año debe ser uno valido.";
                Reabrir("ovEditar"); return;
            }
            if (Periodos.Any(x => x.Periodo.fecha_inicio.Year == nuevo) && nuevo != sel)
            {
                lblErrEditar.Text = "Ya existe un periodo con ese año.";
                Reabrir("ovEditar"); return;
            }

            // TODO: actualizar en BD (sel -> nuevo)
            var _periodo = Periodos.Find(x => x.Periodo.fecha_inicio.Year == sel).Periodo;
            if (_periodo == null) {
                lblErrEditar.Text = "El periodo seleccionado no existe."; 
                Reabrir("ovEditar"); 
                return; 
            }

            _periodo.nombre = nuevo.ToString();
            _periodo.descripcion = "Año Academico " + nuevo.ToString();
            //_periodo.activo = 1;

            var fmt = CultureInfo.InvariantCulture;

            if (DateTime.TryParseExact(nuevo.ToString() + "-03-01", "yyyy-MM-dd", fmt, DateTimeStyles.None, out DateTime fn))
            {
                fn = DateTime.SpecifyKind(fn.Date, DateTimeKind.Unspecified);
                _periodo.fecha_inicio = fn;
                _periodo.fecha_inicioSpecified = true;
            }
            else
            {
                lblErrCrear.Text = "La fecha de inicio no tiene un formato válido (use el selector de fecha).";
                Reabrir("ovCrear"); return;
            }

            if (DateTime.TryParseExact(nuevo.ToString() + "-12-15", "yyyy-MM-dd", fmt, DateTimeStyles.None, out DateTime fn1))
            {
                fn1 = DateTime.SpecifyKind(fn1.Date, DateTimeKind.Unspecified);
                _periodo.fecha_fin = fn1;
                _periodo.fecha_finSpecified = true;
            }
            else
            {
                lblErrCrear.Text = "La fecha de fin no tiene un formato válido (use el selector de fecha).";
                Reabrir("ovCrear"); return;
            }


            boPeriodo.modificarPeriodo(_periodo);

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
            if (!int.TryParse(hfAnioSeleccionado.Value, out sel))
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
            var _periodo = Periodos.Find(x => x.Periodo.fecha_inicio.Year == sel).Periodo;
            if (_periodo == null)
            {
                lblErrEliminar.Text = "Error al encontrar el periodo seleccionado.";
                Reabrir("ovEliminar"); return;
            }

            boPeriodo.eliminarPeriodoPorId(_periodo.periodo_academico_id);

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

            var fila = (Capacidad)e.Item.DataItem;
            var lnkRep = (HyperLink)e.Item.FindControl("lnkReporte");
            lnkRep.NavigateUrl = ResolveUrl($"~/Matricula/ReporteMatricula.aspx?anio={fila.Periodo.periodo_academico_id}");

            var btn = (LinkButton)e.Item.FindControl("btnAccion");
            if (fila.Periodo.fecha_inicio.Year == DateTime.Now.Year)
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
