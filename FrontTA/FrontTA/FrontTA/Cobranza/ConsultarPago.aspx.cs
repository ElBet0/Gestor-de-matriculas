using System;
using System.Web.UI;

namespace FrontTA.Cobranza
{
    public partial class ConsultarPago : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Carga de demo / desde querystring (opcional)
                txtIdDeuda.Text = Request.QueryString["idDeuda"] ?? "D-00045";
                ddlMedio.SelectedValue = (Request.QueryString["medio"] ?? "EF");
                dtpFecha.Text = (Request.QueryString["fecha"] ?? DateTime.Today.ToString("yyyy-MM-dd"));
                txtMonto.Text = Request.QueryString["monto"] ?? "50.00";
                txtObs.Text = Request.QueryString["obs"] ?? "Pago registrado (solo lectura).";

                // Asegura todo deshabilitado (por si en el .aspx se cambia algo luego)
                ddlMedio.Enabled = false;
                dtpFecha.Enabled = false;
                txtMonto.Enabled = false;
                txtObs.Enabled = false;

                btnPagoCrear.Enabled = false;
                btnPagoEditar.Enabled = false;
                btnPagoEliminar.Enabled = false;
                ddlPagos.Enabled = false;
            }
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            // Regresar a donde prefieras (Cobranza o EditarDeuda)
            Response.Redirect("ConsultarDeuda.aspx");
        }
    }
}
