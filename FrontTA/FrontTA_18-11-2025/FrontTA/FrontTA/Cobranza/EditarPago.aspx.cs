using FrontTA.SisProgWS;
using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Cobranza
{
    public partial class EditarPago : Page
    {
        private readonly PagoWSClient boPago = new PagoWSClient();
        private readonly DeudaWSClient boDeuda = new DeudaWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // Combo medio de pago
            if (ddlMedioPago.Items.Count == 0)
            {
                ddlMedioPago.Items.Add(new ListItem("Efectivo", "EFECTIVO"));
                ddlMedioPago.Items.Add(new ListItem("Tarjeta", "TARJETA"));
                ddlMedioPago.Items.Add(new ListItem("Transferencia", "TRANSFERENCIA"));
                ddlMedioPago.Items.Add(new ListItem("Depósito", "DEPOSITO"));
            }

            hfFamiliaId.Value = Request.QueryString["familia"] ?? string.Empty;

            // Obtener parámetros
            string pagoStr = Request.QueryString["id"] ?? Request.QueryString["idPago"];
            string deudaStr = Request.QueryString["idDeuda"];

            // Validar id de pago
            if (string.IsNullOrEmpty(pagoStr) || !int.TryParse(pagoStr, out int pagoId) || pagoId <= 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "modalEditarPago1",
                    "mostrarModal('No se recibió un identificador de pago válido.');", true);
                VolverAEditarDeuda();
                return;
            }

            // Validar id de deuda
            if (string.IsNullOrEmpty(deudaStr) || !int.TryParse(deudaStr, out int deudaId) || deudaId <= 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "modalEditarPago2",
                    "mostrarModal('No se recibió un identificador de deuda válido.');", true);
                Response.Redirect("~/Cobranza/Cobranza.aspx");
                return;
            }

            hfPagoId.Value = pagoId.ToString();
            hfDeudaId.Value = deudaId.ToString();

            txtIdPago.Text = $"PAG-{pagoId}";
            txtIdDeuda.Text = deudaId.ToString();

            try
            {
                var pago = boPago.obtenerPagoPorId(pagoId);
                if (pago == null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "modalEditarPago3",
                        "mostrarModal('No se encontró el pago indicado.');", true);
                    VolverAEditarDeuda();
                    return;
                }

                // Seteo del medio de pago
                if (pago.medioSpecified)
                {
                    string medioStr = pago.medio.ToString();
                    var item = ddlMedioPago.Items.FindByValue(medioStr);
                    if (item != null)
                    {
                        ddlMedioPago.ClearSelection();
                        item.Selected = true;
                    }
                }

                if (pago.fecha != DateTime.MinValue)
                    txtFechaPago.Text = pago.fecha.ToString("yyyy-MM-dd");

                txtMonto.Text = ((decimal)pago.monto).ToString("0.00");
                txtObservaciones.Text = pago.observaciones ?? string.Empty;

                // Cargar saldos
                CargarMontosDeudaYSaldo(deudaId, pagoId);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "modalEditarPago4",
                    $"mostrarModal('Error al cargar los datos del pago: {ex.Message.Replace("'", "\\'")}');",
                    true);

                VolverAEditarDeuda();
            }
        }

        private void CargarMontosDeudaYSaldo(int deudaId, int pagoIdActual)
        {
            try
            {
                var deu = boDeuda.obtenerDeudaPorId(deudaId);
                if (deu == null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "modalEditarPago5",
                        "mostrarModal('No se encontró la deuda indicada.');", true);
                    return;
                }

                decimal montoDeuda = (decimal)deu.monto;

                decimal totalPagadoOtros = 0m;
                var pagos = boPago.listarPagosPorDeuda(deudaId);

                if (pagos != null)
                {
                    totalPagadoOtros = (decimal)pagos
                        .Where(p => p.pago_id != pagoIdActual)
                        .Sum(p => p.monto);
                }

                decimal saldo = montoDeuda - totalPagadoOtros;
                if (saldo < 0m) saldo = 0m;

                hfMontoDeuda.Value = montoDeuda.ToString(CultureInfo.InvariantCulture);
                hfSaldoActual.Value = saldo.ToString(CultureInfo.InvariantCulture);

                txtMontoDeuda.Text = montoDeuda.ToString("0.00");
                txtSaldoActual.Text = saldo.ToString("0.00");
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "modalEditarPago6",
                    $"mostrarModal('Error al calcular el saldo de la deuda: {ex.Message.Replace("'", "\\'")}');",
                    true);
            }
        }

        // =========================================================
        // VALIDACIÓN COMPLETA EN FUNCIÓN APARTE
        // =========================================================
        private bool Validar(out string errores)
        {
            errores = "";
            var fmt = CultureInfo.InvariantCulture;

            // 1) Validación de deuda
            if (!int.TryParse(hfDeudaId.Value, out int deudaId) || deudaId <= 0)
                errores += "- No se encontró la deuda asociada al pago.<br/>";

            // 2) Validación de pago
            if (!int.TryParse(hfPagoId.Value, out int pagoId) || pagoId <= 0)
                errores += "- No se encontró el identificador del pago.<br/>";

            // 3) Medio de pago
            if (!Enum.TryParse(ddlMedioPago.SelectedValue, out medioPago _))
                errores += "- Debe seleccionar un medio de pago válido.<br/>";

            // 4) Fecha
            string fpText = (txtFechaPago.Text ?? "").Trim();
            if (string.IsNullOrEmpty(fpText) ||
                !DateTime.TryParseExact(fpText, "yyyy-MM-dd", fmt, DateTimeStyles.None, out _))
                errores += "- Debe ingresar una fecha de pago válida.<br/>";

            // 5) Monto
            if (!decimal.TryParse(txtMonto.Text, NumberStyles.Any, fmt, out decimal monto))
                errores += "- El monto debe ser un número válido.<br/>";
            else if (monto <= 0)
                errores += "- El monto del pago debe ser mayor a 0.<br/>";

            // 6) Saldo
            if (!decimal.TryParse(hfSaldoActual.Value, NumberStyles.Any, fmt, out decimal saldo))
                saldo = 0;

            if (saldo <= 0)
                errores += "- La deuda ya se encuentra cancelada.<br/>";
            else if (monto > saldo)
                errores += $"- El monto máximo permitido es S/. {saldo:0.00}.<br/>";

            return errores == "";
        }

        // =========================================================
        // BOTÓN GUARDAR — SOLO EVALÚA LOS ERRORES Y MUESTRA MODAL
        // =========================================================
        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            string mensajesError;

            if (!Validar(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionEditarPagoFinal",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return;
            }

            try
            {
                var fmt = CultureInfo.InvariantCulture;
                int deudaId = int.Parse(hfDeudaId.Value);
                int pagoId = int.Parse(hfPagoId.Value);

                Enum.TryParse(ddlMedioPago.SelectedValue, out medioPago medio);

                DateTime fechaPago = DateTime.ParseExact(txtFechaPago.Text, "yyyy-MM-dd", fmt);
                fechaPago = DateTime.SpecifyKind(fechaPago.Date, DateTimeKind.Unspecified);

                decimal monto = decimal.Parse(txtMonto.Text, fmt);

                var pago = new pago
                {
                    pago_id = pagoId,
                    monto = (double)monto,
                    fecha = fechaPago,
                    medio = medio,
                    observaciones = (txtObservaciones.Text ?? "").Trim(),
                    deuda = new deuda { deuda_id = deudaId },
                    fechaSpecified = true,
                    medioSpecified = true
                };

                int resultado = boPago.modificarPago(pago);
                if (resultado <= 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "modalEditarPago7",
                        "mostrarModal('No se pudo actualizar el pago.');", true);
                    return;
                }

                string url = "~/Cobranza/EditarDeuda.aspx?id=" + deudaId;
                if (!string.IsNullOrEmpty(hfFamiliaId.Value))
                    url += "&familia=" + Server.UrlEncode(hfFamiliaId.Value);

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "OkEditPago",
                    "alert('El pago fue actualizado correctamente.'); window.location='" + ResolveUrl(url) + "';",
                    true
                );
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "modalEditarPago8",
                    $"mostrarModal('Ocurrió un error al actualizar el pago: {ex.Message.Replace("'", "\\'")}');",
                    true);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            VolverAEditarDeuda();
        }

        private void VolverAEditarDeuda()
        {
            if (!int.TryParse(hfDeudaId.Value, out int deudaId) || deudaId <= 0)
            {
                Response.Redirect("~/Cobranza/Cobranza.aspx");
                return;
            }

            string url = "~/Cobranza/EditarDeuda.aspx?id=" + deudaId;
            if (!string.IsNullOrEmpty(hfFamiliaId.Value))
                url += "&familia=" + Server.UrlEncode(hfFamiliaId.Value);

            Response.Redirect(url);
        }
    }
}
