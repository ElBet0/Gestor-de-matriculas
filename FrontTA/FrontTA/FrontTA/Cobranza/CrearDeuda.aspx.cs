using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Cobranza
{
    public partial class CrearDeuda : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // En CrearDeuda: todo bloqueado
                btnPagoCrear.Enabled = false;
                btnPagoEditar.Enabled = false;
                btnPagoEliminar.Enabled = false;
                ddlPagos.Enabled = false;

                // Si quieres dejar un item por defecto explícito:
                if (ddlPagos.Items.Count == 0)
                    ddlPagos.Items.Add(new ListItem("(sin pagos)", ""));
            }
        }

        // Preparados para cuando implementes EditarPago / CrearPago
        protected void btnPagoCrear_Click(object sender, EventArgs e) { }
        protected void btnPagoEditar_Click(object sender, EventArgs e) { }
        protected void btnPagoEliminar_Click(object sender, EventArgs e) { }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cobranza.aspx");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cobranza.aspx");
        }
    }
}
