using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
namespace FrontTA.Matricula
{
    public partial class BuscarMatricula : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Año y modo desde querystring
                var anioStr = Request.QueryString["anio"];
                var modo = (Request.QueryString["modo"] ?? "agregar").ToLowerInvariant();

                int anio = DateTime.Now.Year;
                int.TryParse(anioStr, out anio);

                lblAnio.Text = anio.ToString();
                lnkReporte.NavigateUrl = ResolveUrl($"~/Matricula/ReporteMatricula.aspx?anio={anio}");

                // Habilitar / deshabilitar acciones según modo
                // (son HtmlButton => Disabled + class)
                SetDisabled(btnCreate, modo == "consultar");  
                SetDisabled(btnEdit, true);                 
                SetDisabled(btnView, modo != "consultar");   

                // Datos de ejemplo
                gvAlumnos.DataSource = GetEjemplos();
                gvAlumnos.DataBind();
            }
        }

        private DataTable GetEjemplos()
        {
            var dt = new DataTable();
            dt.Columns.Add("Genero");
            dt.Columns.Add("ApePat");
            dt.Columns.Add("ApeMat");
            dt.Columns.Add("Nombre");

            dt.Rows.Add("H", "Chávez", "Hinojosa", "Joaquín");
            dt.Rows.Add("M", "Ramos", "López", "María");
            dt.Rows.Add("H", "Pérez", "Flores", "Daniel");
            return dt;
        }

        protected void gvAlumnos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //e.Row.CssClass += " data-row";
                //// toma el id del DataKey y lo pone como data-id
                //var id = gvAlumnos.DataKeys[e.Row.RowIndex]?.Value?.ToString();
                //if (!string.IsNullOrEmpty(id))
                //    e.Row.Attributes["data-id"] = id;
            }

        }

        /*  utilidades para HtmlButton  */
        private void SetDisabled(HtmlButton b, bool disabled)
        {
            b.Disabled = disabled;
            if (disabled) AddClass(b, "btn-disabled"); else RemoveClass(b, "btn-disabled");
        }
        private void AddClass(HtmlButton b, string cls)
        {
            var cur = b.Attributes["class"] ?? string.Empty;
            if (!cur.Contains(cls)) b.Attributes["class"] = (cur + " " + cls).Trim();
        }
        private void RemoveClass(HtmlButton b, string cls)
        {
            var cur = b.Attributes["class"] ?? string.Empty;
            b.Attributes["class"] = cur.Replace(cls, "").Replace("  ", " ").Trim();
        }
    }
}
