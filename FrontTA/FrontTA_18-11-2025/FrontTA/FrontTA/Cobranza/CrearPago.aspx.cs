using FrontTA.SisProgWS;
using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Cobranza
{
    public partial class CrearPago : Page
    {
        private readonly PagoWSClient boPago = new PagoWSClient();
        private readonly DeudaWSClient boDeuda = new DeudaWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // Medio de pago (coincide con enum MedioPago)
            if (ddlMedioPago.Items.Count == 0)
            {
                ddlMedioPago.Items.Add(new ListItem("Efectivo", "EFECTIVO"));
                ddlMedioPago.Items.Add(new ListItem("Tarjeta", "TARJETA"));
                ddlMedioPago.Items.Add(new ListItem("Transferencia", "TRANSFERENCIA"));
                ddlMedioPago.Items.Add(new ListItem("Depósito", "DEPOSITO"));
            }

            // Guardar familia (por si viene en la URL para volver a Cobranza)
            hfFamiliaId.Value = Request.QueryString["familia"] ?? "";

            // Tomar id de la deuda: ?id=XX o ?idDeuda=XX
            string idStr = Request.QueryString["idDeuda"] ?? Request.QueryString["id"];
            if (string.IsNullOrEmpty(idStr) || !int.TryParse(idStr, out int deudaId) || deudaId <= 0)
            {
                Alerta("No se recibió un identificador de deuda válido.");
                Response.Redirect("Cobranza.aspx");
                return;
            }

            hfDeudaId.Value = deudaId.ToString();
            txtIdDeuda.Text = deudaId.ToString();
            txtIdDeuda.ReadOnly = true;

            // Fecha de pago = hoy
            txtFechaPago.Text = DateTime.Now.ToString("yyyy-MM-dd");

            // Inicializar monto
            txtMonto.Text = "0";

            // Cargar montos de deuda y saldo
            CargarMontosDeudaYSaldo(deudaId);
        }

        private void CargarMontosDeudaYSaldo(int deudaId)
        {
            try
            {
                // 1) Obtener deuda
                var deu = boDeuda.obtenerDeudaPorId(deudaId); // ajusta nombre si tu proxy difiere
                if (deu == null)
                {
                    Alerta("No se encontró la deuda indicada.");
                    return;
                }

                decimal montoDeuda = (decimal)deu.monto;

                // 2) Obtener pagos de esa deuda y sumar
                decimal totalPagado = 0m;
                try
                {

                    var pagos = boPago.listarPagosPorDeuda(deudaId); // ajusta nombre si difiere
                    if (pagos != null)
                    {
                        totalPagado = (decimal)pagos.Sum(p => p.monto);
                    }
                }
                catch
                {
                    // Si aún no existe el método en el WS, simplemente totalPagado=0
                    totalPagado = 0m;
                }

                decimal saldo = montoDeuda - totalPagado;
                if (saldo < 0m) saldo = 0m;

                hfMontoDeuda.Value = montoDeuda.ToString(CultureInfo.InvariantCulture);
                hfSaldoActual.Value = saldo.ToString(CultureInfo.InvariantCulture);

                txtMontoDeuda.Text = montoDeuda.ToString("0.00");
                txtSaldoActual.Text = saldo.ToString("0.00");
            }
            catch (Exception ex)
            {
                Alerta("Error al cargar datos de la deuda: " + ex.Message);
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            // 1️⃣ VALIDACIÓN PREVIA
            string mensajesError;
            if (!ValidarPago(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionCrearPago",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return; // No continuar si hay errores
            }

            try
            {
                var fmt = CultureInfo.InvariantCulture;

                // Los datos ya están validados aquí
                int deudaId = int.Parse(hfDeudaId.Value);

                medioPago medio = (medioPago)Enum.Parse(
                    typeof(medioPago),
                    ddlMedioPago.SelectedValue
                );

                DateTime fechaPago = DateTime.ParseExact(
                    txtFechaPago.Text,
                    "yyyy-MM-dd",
                    fmt
                );
                fechaPago = DateTime.SpecifyKind(fechaPago, DateTimeKind.Unspecified);

                decimal monto = decimal.Parse(txtMonto.Text, fmt);

                // Construcción del objeto
                var nuevoPago = new pago
                {
                    monto = (double)monto,
                    fecha = fechaPago,
                    medio = medio,
                    observaciones = (txtObservaciones.Text ?? "").Trim(),
                    deuda = new deuda { deuda_id = deudaId },

                    fechaSpecified = true,
                    medioSpecified = true
                };

                // Insertar
                int idGenerado = boPago.insertarPago(nuevoPago);

                if (idGenerado <= 0)
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "PagoError",
                        "mostrarModal('No se pudo registrar el pago.');",
                        true
                    );
                    return;
                }

                // Redirección
                string url = "Cobranza.aspx";
                if (!string.IsNullOrEmpty(hfFamiliaId.Value))
                    url += "?familia=" + hfFamiliaId.Value;

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "OkPago",
                    $"alert('El pago fue registrado correctamente.'); window.location='{url}';",
                    true
                );
            }
            catch (Exception ex)
            {
                string msg = ("Ocurrió un error al registrar el pago: " + ex.Message)
                                .Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ExPago",
                    $"mostrarModal('{msg}');",
                    true
                );
            }
        }


        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            string url = "Cobranza.aspx";
            if (!string.IsNullOrEmpty(hfFamiliaId.Value))
                url += "?familia=" + hfFamiliaId.Value;

            Response.Redirect(url);
        }

        private void Alerta(string mensaje)
        {
            if (mensaje == null) mensaje = "";
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "AlertaCrearPago",
                "alert('" + mensaje.Replace("'", "\\'") + "');",
                true
            );
        }


        private bool ValidarPago(out string mensajes)
        {
            var errores = new System.Collections.Generic.List<string>();
            var fmt = CultureInfo.InvariantCulture;

            // 1) Validar deuda ID
            if (!int.TryParse(hfDeudaId.Value, out int deudaId) || deudaId <= 0)
                errores.Add("No se encontró la deuda asociada al pago.");

            // 2) Medio de pago
            if (!Enum.TryParse(ddlMedioPago.SelectedValue, out medioPago medio))
                errores.Add("Debe seleccionar un medio de pago válido.");

            // 3) Fecha de pago
            string fpText = (txtFechaPago.Text ?? "").Trim();
            if (string.IsNullOrEmpty(fpText) ||
                !DateTime.TryParseExact(fpText, "yyyy-MM-dd", fmt,
                        DateTimeStyles.None, out DateTime fechaPago))
            {
                errores.Add("Debe ingresar una fecha de pago válida.");
            }

            // 4) Monto
            if (!decimal.TryParse(txtMonto.Text, NumberStyles.Any, fmt, out decimal monto))
                errores.Add("El monto debe ser un número válido.");
            else if (monto <= 0m)
                errores.Add("El monto del pago debe ser mayor a 0.");

            // 5) Validar saldo
            if (decimal.TryParse(hfSaldoActual.Value, NumberStyles.Any, fmt, out decimal saldoActual))
            {
                if (saldoActual <= 0m)
                    errores.Add("La deuda ya está cancelada, no se pueden registrar más pagos.");
                else if (decimal.TryParse(txtMonto.Text, NumberStyles.Any, fmt, out decimal montoPago)
                         && montoPago > saldoActual)
                    errores.Add($"El monto máximo permitido para esta deuda es S/. {saldoActual:0.00}.");
            }
            else
            {
                errores.Add("No se pudo determinar el saldo actual.");
            }

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }

    }
}
