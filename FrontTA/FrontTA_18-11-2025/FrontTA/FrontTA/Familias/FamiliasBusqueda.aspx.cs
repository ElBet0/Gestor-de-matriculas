using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Familias
{
    public partial class FamiliasBusqueda : System.Web.UI.Page
    {
        private readonly FamiliaWSClient boFamilia = new FamiliaWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvFamilias.DataSource = boFamilia.listarFamiliasTodas();
                gvFamilias.DataBind();
            }

        }
        protected void gvFamilias_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
                e.Row.CssClass = "table-header";
                return;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string codigo = DataBinder.Eval(e.Row.DataItem, "familia_id").ToString() as string;
                e.Row.Attributes["data-id"] = codigo;
                e.Row.CssClass = (e.Row.CssClass + " data-row").Trim();
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }


        protected void gvFamilias_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvFamilias.PageIndex = e.NewPageIndex;
            // Vuelve a enlazar la fuente de datos
            gvFamilias.DataSource = boFamilia.listarFamiliasTodas();
            gvFamilias.DataBind();
        }

        protected void btnAdd_Click(object sender, GridViewRowEventArgs e)
        {
            Response.Redirect("~/Familias/CrearFamilia.aspx");
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            gvFamilias.DataSource = boFamilia.buscarFamilia(txtApePaterno.Text, txtApeMaterno.Text);
            gvFamilias.DataBind();
        }

        protected void btnDoDelete_Click(object sender, EventArgs e)
        {
            boFamilia.eliminarFamiliaPorId(int.Parse(idFamiliaDelete.Value));
            Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
        }
    }
}