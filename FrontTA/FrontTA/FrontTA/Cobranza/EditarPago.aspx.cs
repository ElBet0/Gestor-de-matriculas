using System;
using System.Globalization;
using System.Web.UI;

namespace FrontTA.Cobranza
{
    public partial class EditarPago : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Recibe parámetros (opcional): ?idPago=P-1002&idDeuda=D-00045
                string idPago = Request.QueryString["idPago"] ?? "P-1001";
                string idDeuda = Request.QueryString["idDeuda"] ?? "D-00045";

                txtIdPago.Text = idPago;     // bloqueado
                txtIdDeuda.Text = idDeuda;   // bloqueado

                // Datos demo para edición
                ddlMedio.SelectedValue = "EF"; // Efectivo
                dtpFecha.Text = DateTime.Today.ToString("yyyy-MM-dd");
                txtMonto.Text = "50.00";
                txtObs.Text = "Pago editado (demo).";
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // TODO: guardar cambios del pago (idPago en txtIdPago.Text)
            // Puedes validar y convertir monto:
            // decimal monto = decimal.Parse(txtMonto.Text, CultureInfo.InvariantCulture);

            // Vuelve a EditarDeuda (o a donde prefieras)
            Response.Redirect("EditarDeuda.aspx?idDeuda=" + Server.UrlEncode(txtIdDeuda.Text));
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Sin guardar
            Response.Redirect("EditarDeuda.aspx?idDeuda=" + Server.UrlEncode(txtIdDeuda.Text));
        }
    }
}
