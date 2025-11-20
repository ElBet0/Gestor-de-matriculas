using FrontTA.SisProgWS;
using System;
using System.Web.UI;

namespace FrontTA.Cobranza
{
    public partial class ConsultarPago : Page
    {
        private readonly PagoWSClient boPago = new PagoWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // Aseguramos todo en solo lectura
            ddlMedio.Enabled = false;
            dtpFecha.Enabled = false;
            txtMonto.Enabled = false;
            txtObs.Enabled = false;

            //btnPagoCrear.Enabled = false;
            //btnPagoEditar.Enabled = false;
            //btnPagoEliminar.Enabled = false;
            //ddlPagos.Enabled = false;
            btnGuardar.Enabled = false;

            // 🔹 id del pago viene como ?id=...
            string idPagoStr = Request.QueryString["id"];
            if (string.IsNullOrEmpty(idPagoStr) || !int.TryParse(idPagoStr, out int idPago) || idPago <= 0)
            {
                Alerta("No se recibió un identificador de pago válido.");
                Response.Redirect("~/Cobranza/Cobranza.aspx");
                return;
            }

            CargarPago(idPago);
        }

        private void CargarPago(int idPago)
        {
            try
            {

                var pago = boPago.obtenerPagoPorId(idPago);

                if (pago == null)
                {
                    Alerta("No se encontró información para el pago indicado.");
                    return;
                }

                // ID Deuda
                if (pago.deuda != null)
                    txtIdDeuda.Text = pago.deuda.deuda_id.ToString();
                else
                    txtIdDeuda.Text = string.Empty;

                // Medio de pago (enum -> string)
                string medioStr = pago.medio.ToString(); // EFECTIVO / TARJETA / ...
                var item = ddlMedio.Items.FindByValue(medioStr);
                if (item != null) {
                    ddlMedio.ClearSelection();
                    item.Selected = true;
                }

                // Fecha de pago
                if (pago.fecha != DateTime.MinValue)
                    dtpFecha.Text = pago.fecha.ToString("yyyy-MM-dd");
                else
                    dtpFecha.Text = string.Empty;

                // Monto
                txtMonto.Text = pago.monto.ToString("0.00");

                // Observaciones
                txtObs.Text = pago.observaciones ?? string.Empty;
            }
            catch (Exception ex)
            {
                Alerta("Ocurrió un error al consultar el pago: " + ex.Message);
            }
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            // volvemos a ConsultarDeuda conservando el idDeuda
            string idDeuda = Request.QueryString["idDeuda"];

            if (!string.IsNullOrEmpty(idDeuda))
            {
                Response.Redirect("~/Cobranza/ConsultarDeuda.aspx?id=" + Server.UrlEncode(idDeuda));
            }
            else
            {
                // fallback por si alguien entra directo
                Response.Redirect("~/Cobranza/Cobranza.aspx");
            }
        }

        private void Alerta(string mensaje)
        {
            if (mensaje == null) mensaje = "";
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "AlertaConsultarPago",
                "alert('" + mensaje.Replace("'", "\\'") + "');",
                true
            );
        }
    }
}
