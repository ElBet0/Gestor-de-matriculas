using FrontTA.SisProgWS;   // FamiliaWS y alumnos de familia
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Cobranza
{
    public partial class CrearDeuda : Page
    {
        private readonly DeudaWSClient boDeuda = new DeudaWSClient();
        private readonly TipoDeudaWSClient boTipoDeuda = new TipoDeudaWSClient();
        private readonly FamiliaWSClient boFamilia = new FamiliaWSClient();  // Para ObtenerHijos

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // Pagos bloqueados
            btnPagoCrear.Enabled = false;
            btnPagoEditar.Enabled = false;
            btnPagoEliminar.Enabled = false;
            ddlPagos.Enabled = false;

            // Tomar familia de la URL ?familia=xxxx
            string famStr = Request.QueryString["familia"];
            if (string.IsNullOrEmpty(famStr) || !int.TryParse(famStr, out int familiaId) || familiaId <= 0)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "NoFam",
                    "alert('No se recibió un identificador de familia válido.');" +
                    "window.location='Cobranza.aspx';",
                    true
                );
                return;
            }

            hfFamiliaId.Value = familiaId.ToString();

            CargarTiposDeuda();
            CargarAlumnos(familiaId);

            txtMonto.Text = "0.00";
            txtTotal.Text = "0.00";
        }

        // Cargar combo de tipos de deuda desde LISTAR_TIPOS_DEUDA
        private void CargarTiposDeuda()
        {
            ddlTipoDeuda.Items.Clear();
            ddlTipoDeuda.Items.Add(new ListItem("Seleccione tipo de deuda", ""));

            try
            {
                var tipos = boTipoDeuda.listarTiposDeudaTodos();

                if (tipos != null)
                {
                    foreach (var t in tipos)
                    {
                        string texto = t.descripcion;
                        ddlTipoDeuda.Items.Add(
                            new ListItem(texto, t.id_tipo_deuda.ToString())
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                Alerta("Error al cargar tipos de deuda: " + ex.Message);
            }
        }

        // Cargar hijos de la familia usando OBTENER_HIJOS_FAMILIA (FamiliaWS)
        private void CargarAlumnos(int familiaId)
        {
            ddlAlumno.Items.Clear();
            ddlAlumno.Items.Add(new ListItem("Seleccione alumno", ""));

            try
            {
                var hijos = boFamilia.ObtenerHijos(familiaId);

                if (hijos != null)
                {
                    foreach (var al in hijos)
                    {
                        string texto = al.nombre;        // nombre del alumno
                        ddlAlumno.Items.Add(
                            new ListItem(texto, al.alumno_id.ToString())
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                Alerta("Error al cargar alumnos de la familia: " + ex.Message);
            }
        }

        // Cuando cambia el tipo de deuda → traer monto_general y recalcular total
        protected void ddlTipoDeuda_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfMontoBase.Value = "";
            txtMonto.Text = "0.00";
            txtTotal.Text = "0.00";

            if (!int.TryParse(ddlTipoDeuda.SelectedValue, out int idTipo) || idTipo <= 0)
                return;

            try
            {
                var tipo = boTipoDeuda.obtenerTipoDeudaPorId(idTipo);
                if (tipo != null)
                {
                    // Guardamos monto base en hidden para reutilizarlo
                    hfMontoBase.Value = tipo.monto_general.ToString(CultureInfo.InvariantCulture);
                    RecalcularTotal();
                }
            }
            catch (Exception ex)
            {
                Alerta("Error al obtener el monto del tipo de deuda: " + ex.Message);
            }
        }

        // Cuando cambia el descuento → recalcular usando el monto base
        protected void txtDescuento_TextChanged(object sender, EventArgs e)
        {
            RecalcularTotal();
        }

        // Recalcula txtMonto y txtTotal usando hfMontoBase y txtDescuento
        // ➤ Aquí el DESCUENTO es MONTO (S/.), NO PORCENTAJE
        private void RecalcularTotal()
        {
            if (!decimal.TryParse(hfMontoBase.Value, NumberStyles.Any, CultureInfo.InvariantCulture, out decimal montoBase))
            {
                txtMonto.Text = "0.00";
                txtTotal.Text = "0.00";
                return;
            }

            decimal descuentoMonto = 0m;
            if (!string.IsNullOrWhiteSpace(txtDescuento.Text))
            {
                if (!decimal.TryParse(txtDescuento.Text, NumberStyles.Any, CultureInfo.InvariantCulture, out descuentoMonto))
                    descuentoMonto = 0m;
            }

            // No permitir descuentos negativos ni mayores al monto base
            if (descuentoMonto < 0m) descuentoMonto = 0m;
            if (descuentoMonto > montoBase) descuentoMonto = montoBase;

            decimal total = montoBase - descuentoMonto;

            txtMonto.Text = montoBase.ToString("0.00");
            txtTotal.Text = total.ToString("0.00");

            /*
             * 🔎 NOTA: Si el descuento fuera PORCENTAJE en lugar de monto,
             * el cálculo se vería así:
             *
             *   decimal descuentoPorc = 0m;
             *   if (!string.IsNullOrWhiteSpace(txtDescuento.Text))
             *       decimal.TryParse(txtDescuento.Text, out descuentoPorc);
             *
             *   if (descuentoPorc < 0m) descuentoPorc = 0m;
             *   if (descuentoPorc > 100m) descuentoPorc = 100m;
             *
             *   decimal totalPorc = montoBase * (1m - (descuentoPorc / 100m));
             *
             *   txtMonto.Text = montoBase.ToString("0.00");
             *   txtTotal.Text = totalPorc.ToString("0.00");
             */
        }

        // Guardar deuda usando INSERTAR_DEUDA
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // 1️⃣ Validación previa (igual que EditarUsuario)
            string mensajesError;
            if (!ValidarDeuda(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionCrearDeuda",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return; // No continuar si hay errores
            }

            try
            {
                // 🔥 Ya está todo VALIDADO aquí, así que solo procesamos
                int idTipo = int.Parse(ddlTipoDeuda.SelectedValue);
                int idAlumno = int.Parse(ddlAlumno.SelectedValue);

                var fmt = CultureInfo.InvariantCulture;

                DateTime fechaEmision = DateTime.ParseExact(txtFechaEmision.Text, "yyyy-MM-dd", fmt);
                fechaEmision = DateTime.SpecifyKind(fechaEmision, DateTimeKind.Unspecified);

                DateTime fechaVenc = DateTime.ParseExact(txtFechaVencimiento.Text, "yyyy-MM-dd", fmt);
                fechaVenc = DateTime.SpecifyKind(fechaVenc, DateTimeKind.Unspecified);

                decimal montoBase = decimal.Parse(hfMontoBase.Value, fmt);
                decimal descuentoMonto = 0m;
                decimal.TryParse(txtDescuento.Text, NumberStyles.Any, fmt, out descuentoMonto);

                decimal total = montoBase - descuentoMonto;

                // Construcción del objeto
                var nueva = new deuda
                {
                    monto = (double)total,
                    fecha_emision = fechaEmision,
                    fecha_vencimiento = fechaVenc,
                    descripcion = txtDescripcion.Text?.Trim(),
                    descuento = (double)descuentoMonto,
                    alumno = new alumno { alumno_id = idAlumno },
                    concepto_deuda = new tipoDeuda { id_tipo_deuda = idTipo },
                    fecha_emisionSpecified = true,
                    fecha_vencimientoSpecified = true
                };

                int idGenerado = boDeuda.insertarDeuda(nueva);

                if (idGenerado <= 0)
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "crearDeudaError",
                        "mostrarModal('No se pudo registrar la deuda.');",
                        true
                    );
                    return;
                }

                // OK → redirigir
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "OkCrearDeuda",
                    $"alert('La deuda fue registrada correctamente.');" +
                    $"window.location='Cobranza.aspx?familia={hfFamiliaId.Value}';",
                    true
                );
            }
            catch (Exception ex)
            {
                string msg = ("Ocurrió un error al registrar la deuda: " + ex.Message)
                             .Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "crearDeudaEx",
                    $"mostrarModal('{msg}');",
                    true
                );
            }
        }
        private bool ValidarDeuda(out string mensajes)
        {
            var errores = new List<string>();
            var fmt = CultureInfo.InvariantCulture;

            // Tipo de deuda
            if (!int.TryParse(ddlTipoDeuda.SelectedValue, out int idTipo) || idTipo <= 0)
                errores.Add("Debe seleccionar un tipo de deuda.");

            // Alumno
            if (!int.TryParse(ddlAlumno.SelectedValue, out int idAlumno) || idAlumno <= 0)
                errores.Add("Debe seleccionar un alumno.");

            // Fecha emisión
            string feText = (txtFechaEmision.Text ?? "").Trim();
            if (string.IsNullOrEmpty(feText) ||
                !DateTime.TryParseExact(feText, "yyyy-MM-dd", fmt, DateTimeStyles.None, out DateTime fechaEmision))
                errores.Add("Debe ingresar una fecha de emisión válida.");

            // Fecha vencimiento
            string fvText = (txtFechaVencimiento.Text ?? "").Trim();
            if (string.IsNullOrEmpty(fvText) ||
                !DateTime.TryParseExact(fvText, "yyyy-MM-dd", fmt, DateTimeStyles.None, out DateTime fechaVenc))
                errores.Add("Debe ingresar una fecha de vencimiento válida.");

            // Comparación fechas solo si ambas son válidas
            if (DateTime.TryParseExact(feText, "yyyy-MM-dd", fmt, DateTimeStyles.None, out fechaEmision) &&
                DateTime.TryParseExact(fvText, "yyyy-MM-dd", fmt, DateTimeStyles.None, out fechaVenc))
            {
                if (fechaEmision >= fechaVenc)
                    errores.Add("La fecha de emisión debe ser anterior a la fecha de vencimiento.");
            }

            // Monto base
            if (!decimal.TryParse(hfMontoBase.Value, NumberStyles.Any, fmt, out decimal montoBase))
                errores.Add("No se pudo determinar el monto base del tipo de deuda.");

            // Descuento
            if (!string.IsNullOrWhiteSpace(txtDescuento.Text) &&
                !decimal.TryParse(txtDescuento.Text, NumberStyles.Any, fmt, out decimal descuentoMonto))
                errores.Add("El descuento debe ser un número válido.");

            if (decimal.TryParse(txtDescuento.Text, NumberStyles.Any, fmt, out decimal dMonto))
            {
                if (dMonto < 0 || (decimal.TryParse(hfMontoBase.Value, out montoBase) && dMonto > montoBase))
                    errores.Add("El descuento debe estar entre 0 y el monto de la deuda.");
            }

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }


        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            string url = "Cobranza.aspx";
            if (!string.IsNullOrEmpty(hfFamiliaId.Value))
                url += "?familia=" + hfFamiliaId.Value;

            Response.Redirect(url);
        }

        // Helpers para pagos (bloqueados por ahora)
        protected void btnPagoCrear_Click(object sender, EventArgs e) { }
        protected void btnPagoEditar_Click(object sender, EventArgs e) { }
        protected void btnPagoEliminar_Click(object sender, EventArgs e) { }

        // Helper para mostrar alertas JS
        private void Alerta(string mensaje)
        {
            if (mensaje == null) mensaje = "";
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "AlertaCrearDeuda",
                "alert('" + mensaje.Replace("'", "\\'") + "');",
                true
            );
        }
    }
}
