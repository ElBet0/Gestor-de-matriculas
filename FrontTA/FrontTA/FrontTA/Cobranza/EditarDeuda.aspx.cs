using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Cobranza
{
    public partial class EditarDeuda : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Simular datos de la deuda
                txtCodigoDeuda.Text = Request.QueryString["idDeuda"] ?? "D-00045";

                // Ejemplos simples de pagos (usa tu datasource real)
                if (ddlPagos.Items.Count == 0)
                {
                    ddlPagos.Items.Add(new ListItem("(seleccione un pago)", ""));
                    ddlPagos.Items.Add(new ListItem("P-1001 | 50.00 | 10/05/2025", "P-1001"));
                    ddlPagos.Items.Add(new ListItem("P-1002 | 80.00 | 20/05/2025", "P-1002"));
                    ddlPagos.Items.Add(new ListItem("P-1003 | 40.00 | 01/06/2025", "P-1003"));
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // TODO: guardar cambios de la deuda
            Response.Redirect("Cobranza.aspx");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cobranza.aspx");
        }

        // Si decides eliminar en servidor (en vez de solo JS), usa este handler:
        protected void btnEliminarPago_Server(object sender, EventArgs e)
        {
            // string idPago = ddlPagos.SelectedValue;
            // TODO: eliminar en BD si corresponde
            // Volver a cargar la lista:
            // cargarPagos();
        }
    }
}
