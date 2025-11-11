using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) CargarAnios();
        }

        private void CargarAnios()
        {
            int vigente = DateTime.Now.Year;

            // Calculo año:
            var lista = new List<FilaAnio>();
            for (int anio = vigente; anio >= vigente - 3; anio--)
            {
                lista.Add(new FilaAnio
                {
                    Anio = anio,
                    Cantidad = 400 - (vigente - anio) * 12, // solo para variar
                    EsVigente = (anio == vigente)
                });
            }

            rptAnios.DataSource = lista;
            rptAnios.DataBind();
        }

        protected void rptAnios_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var fila = (FilaAnio)e.Item.DataItem;

            // Reporte por año
            var lnkRep = (HyperLink)e.Item.FindControl("lnkReporte");
            lnkRep.NavigateUrl = ResolveUrl($"~/Matricula/ReporteMatricula.aspx?anio={fila.Anio}");

            // Botón acción con texto según año
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

            // Lee el HiddenField del item
            var hf = (HiddenField)e.Item.FindControl("hfEsVigente");
            if (hf != null) bool.TryParse(hf.Value, out esVigente);

            // Siempre navegamos a BuscarMatricula, pero con distinto "modo"
            string modo = esVigente ? "agregar" : "consultar";
            string url = $"~/Matricula/BuscarMatricula.aspx?anio={anio}&modo={modo}";

            Response.Redirect(ResolveUrl(url));
        }
    }
}