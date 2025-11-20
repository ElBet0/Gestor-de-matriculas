using FrontTA.SisProgWS;
using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Cobranza
{
    public partial class ConsultarDeuda : System.Web.UI.Page
    {
        private readonly DeudaWSClient boDeuda = new DeudaWSClient();
        private readonly PagoWSClient boPago = new PagoWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // id de deuda desde la URL: ConsultarDeuda.aspx?id=XX
            string idStr = Request.QueryString["id"];
            if (string.IsNullOrEmpty(idStr) || !int.TryParse(idStr, out int deudaId) || deudaId <= 0)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "NoId",
                    "alert('No se recibió un identificador de deuda válido.'); window.location='Cobranza.aspx';",
                    true
                );
                return;
            }

            ViewState["DeudaId"] = deudaId;

            CargarDeuda(deudaId);
            CargarPagos(deudaId);
            SetBtnConsultarState(false);
        }

        private void CargarDeuda(int deudaId)
        {
            try
            {
                // nombre del método según tu WS Java
                var d = boDeuda.consultarDeudaPorId(deudaId);
                if (d == null)
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "NoDeuda",
                        "alert('No se encontró la deuda especificada.'); window.location='Cobranza.aspx';",
                        true
                    );
                    return;
                }

                // Código
                txtCodigoDeuda.Text = d.deuda_id.ToString();

                // Tipo de deuda (DropDownList de solo lectura con un ítem)
                ddlTipoDeuda.Items.Clear();
                string tipoDesc = d.concepto_deuda != null ? d.concepto_deuda.descripcion : "";
                string tipoId = (d.concepto_deuda != null && d.concepto_deuda.id_tipo_deuda > 0)
                                  ? d.concepto_deuda.id_tipo_deuda.ToString()
                                  : "";
                ddlTipoDeuda.Items.Add(new ListItem(tipoDesc, tipoId));
                ddlTipoDeuda.SelectedIndex = 0;
                ddlTipoDeuda.Enabled = false;

                // Alumno (idem)
                ddlAlumno.Items.Clear();
                string alumnoNombre = d.alumno != null ? d.alumno.nombre : "";
                string alumnoId = (d.alumno != null && d.alumno.alumno_id > 0)
                                      ? d.alumno.alumno_id.ToString()
                                      : "";
                ddlAlumno.Items.Add(new ListItem(alumnoNombre, alumnoId));
                ddlAlumno.SelectedIndex = 0;
                ddlAlumno.Enabled = false;

                // Monto, descuento, fechas, total
                txtMonto.Text = d.monto.ToString("0.00");

                if (d.fecha_emision != DateTime.MinValue)
                    txtFechaEmision.Text = d.fecha_emision.ToString("yyyy-MM-dd");

                if (d.fecha_vencimiento != DateTime.MinValue)
                    txtFechaVencimiento.Text = d.fecha_vencimiento.ToString("yyyy-MM-dd");

                txtDescuento.Text = d.descuento.ToString("0.00");

                double total = d.monto - d.descuento;
                if (total < 0) total = 0;
                txtTotal.Text = total.ToString("0.00");

                txtDescripcion.Text = d.descripcion ?? string.Empty;
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ErrDeuda",
                    "alert('Error al consultar la deuda: " + ex.Message.Replace("'", "\\'") + "'); window.location='Cobranza.aspx';",
                    true
                );
            }
        }

        private void CargarPagos(int deudaId)
        {
            ddlPagos.Items.Clear();
            ddlPagos.Items.Add(new ListItem("(seleccione un pago)", ""));

            try
            {
                var pagos = boPago.listarPagosPorDeuda(deudaId);
                if (pagos == null || pagos.Length == 0) return;

                var items = pagos.Select(p => new
                {
                    Id = p.pago_id,
                    Texto = string.Format("PAG-{0} · {1:dd/MM/yyyy} · S/. {2:0.00}",
                                          p.pago_id,
                                          p.fecha,
                                          p.monto)
                }).ToList();

                foreach (var it in items)
                {
                    ddlPagos.Items.Add(new ListItem(it.Texto, it.Id.ToString()));
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ErrPagos",
                    "alert('Error al cargar los pagos de la deuda: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
            }
        }

        private void SetBtnConsultarState(bool enabled)
        {
            btnPagoConsultar.Enabled = enabled;
            btnPagoConsultar.CssClass = enabled ? "btn-icon btn-active" : "btn-icon btn-disabled";
        }

        protected void ddlPagos_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool tieneSeleccion = !string.IsNullOrEmpty(ddlPagos.SelectedValue);
            SetBtnConsultarState(tieneSeleccion);
        }

        protected void btnPagoConsultar_Click(object sender, EventArgs e)
        {
            // Si no hay pago seleccionado, no hacemos nada
            if (string.IsNullOrEmpty(ddlPagos.SelectedValue))
                return;

            string idPago = ddlPagos.SelectedValue;

            // idDeuda viene en la propia URL de ConsultarDeuda.aspx?id=...
            string idDeuda = Request.QueryString["id"] ?? "";

            string url = "~/Cobranza/ConsultarPago.aspx?id=" + Server.UrlEncode(idPago);
            if (!string.IsNullOrEmpty(idDeuda))
                url += "&idDeuda=" + Server.UrlEncode(idDeuda);

            Response.Redirect(url);
        }


        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cobranza.aspx");
        }
    }
}
