using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace FrontTA.Cobranza
{
    public partial class ConsultarDeuda : System.Web.UI.Page
    {
        // DTO simple para poblar el DropDownList
        private class PagoDemo
        {
            public string Id { get; set; }
            public string Descripcion { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPagosDemo();            // carga ejemplos en ddlPagos
                SetBtnConsultarState(false); // ojo deshabilitado al inicio
            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cobranza.aspx");
        }

        /* ==================== Binding de pagos de ejemplo ==================== */
        private void BindPagosDemo()
        {
            var lista = new List<PagoDemo>
            {
                new PagoDemo { Id = "PAG-1001", Descripcion = "PAG-1001 · 15/10/2025 · S/. 120.00" },
                new PagoDemo { Id = "PAG-1002", Descripcion = "PAG-1002 · 30/10/2025 · S/. 95.50"  },
                new PagoDemo { Id = "PAG-1003", Descripcion = "PAG-1003 · 05/11/2025 · S/. 80.00"  }
            };

            ddlPagos.DataSource = lista;
            ddlPagos.DataTextField = "Descripcion";
            ddlPagos.DataValueField = "Id";
            ddlPagos.DataBind();

            // Placeholder al inicio
            ddlPagos.Items.Insert(0, new ListItem("(seleccione un pago)", ""));
            ddlPagos.SelectedIndex = 0;
        }

        /* =============== Habilitar/Deshabilitar botón Consultar ============== */
        private void SetBtnConsultarState(bool enabled)
        {
            btnPagoConsultar.Enabled = enabled;
            btnPagoConsultar.CssClass = enabled ? "btn-icon btn-active" : "btn-icon btn-disabled";
        }

        protected void ddlPagos_SelectedIndexChanged(object sender, EventArgs e)
        {
            // habilita solo si hay un valor válido
            bool tieneSeleccion = !string.IsNullOrEmpty(ddlPagos.SelectedValue);
            SetBtnConsultarState(tieneSeleccion);
        }

        /* ===================== Navegación a ConsultarPago ===================== */
        protected void btnPagoConsultar_Click(object sender, EventArgs e)
        {
            // Seguridad básica: si no hay selección válida, no navega
            if (string.IsNullOrEmpty(ddlPagos.SelectedValue))
            {
                SetBtnConsultarState(false);
                return;
            }

            string idPago = ddlPagos.SelectedValue;
            Response.Redirect("~/Cobranza/ConsultarPago.aspx?id=" + Server.UrlEncode(idPago));
        }
    }
}
