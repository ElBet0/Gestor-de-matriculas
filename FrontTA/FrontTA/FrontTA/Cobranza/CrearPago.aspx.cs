using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Cobranza
{
    public partial class CrearPago : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Poblar medios de pago (ajusta según tu catálogo real)
                if (ddlMedioPago.Items.Count == 0)
                {
                    ddlMedioPago.Items.Add(new ListItem("Efectivo", "EFECTIVO"));
                    ddlMedioPago.Items.Add(new ListItem("Transferencia", "TRANSFERENCIA"));
                    ddlMedioPago.Items.Add(new ListItem("Tarjeta", "TARJETA"));
                    ddlMedioPago.Items.Add(new ListItem("Yape/Plin", "WALLET"));
                }

                // ID Deuda (bloqueado). Si llega por querystring, úsalo.
                var idDeuda = Request.QueryString["idDeuda"];
                txtIdDeuda.Text = string.IsNullOrWhiteSpace(idDeuda) ? "(auto)" : idDeuda;
                txtIdDeuda.ReadOnly = true;

                // Fecha de pago -> hoy
                txtFechaPago.Text = DateTime.Now.ToString("yyyy-MM-dd");

                // Monto inicial 0 (puedes precargar desde la deuda seleccionada si aplica)
                if (string.IsNullOrWhiteSpace(txtMonto.Text))
                    txtMonto.Text = "0";
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            // TODO: guardar pago en BD (usa tus DAOs / servicio)
            // - Validar campos
            // - Insertar pago
            // - Redirigir a detalle o a Cobranza
            Response.Redirect("Cobranza.aspx");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cobranza.aspx");
        }
    }
}
