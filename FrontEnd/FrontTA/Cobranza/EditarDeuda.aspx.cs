using FrontTA.SisProgWS;     // FamiliaWS (ObtenerHijos)
using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Cobranza
{
    public partial class EditarDeuda : Page
    {
        private readonly FamiliaWSClient boFamilia = new FamiliaWSClient();
        private readonly DeudaWSClient boDeuda = new DeudaWSClient();
        private readonly TipoDeudaWSClient boTipoDeuda = new TipoDeudaWSClient();
        private readonly PagoWSClient boPago = new PagoWSClient();

        private int DeudaId
        {
            get => ViewState["DeudaId"] != null ? (int)ViewState["DeudaId"] : 0;
            set => ViewState["DeudaId"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // id de la deuda
            string idStr = Request.QueryString["id"] ?? Request.QueryString["idDeuda"];
            if (string.IsNullOrEmpty(idStr) || !int.TryParse(idStr, out int deudaId) || deudaId <= 0)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "noId",
                    "alert('No se recibió un identificador de deuda válido.');",
                    true
                );
                Response.Redirect("~/Cobranza/Cobranza.aspx");
                return;
            }
            DeudaId = deudaId;

            // familia (para listar alumnos)
            string famStr = Request.QueryString["familia"];
            if (!string.IsNullOrEmpty(famStr) && int.TryParse(famStr, out int familiaId) && familiaId > 0)
                hfFamiliaId.Value = familiaId.ToString();

            CargarTiposDeuda();
            CargarAlumnos();
            CargarDeuda();
            CargarPagos();
        }

        

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
                        ddlTipoDeuda.Items.Add(
                            new ListItem(t.descripcion, t.id_tipo_deuda.ToString())
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "errTipos",
                    "alert('Error al cargar tipos de deuda: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
            }
        }

        private void CargarAlumnos()
        {
            ddlAlumno.Items.Clear();
            ddlAlumno.Items.Add(new ListItem("Seleccione alumno", ""));

            if (!int.TryParse(hfFamiliaId.Value, out int familiaId) || familiaId <= 0)
                return;

            try
            {
                var hijos = boFamilia.ObtenerHijos(familiaId);
                if (hijos != null)
                {
                    foreach (var h in hijos)
                    {
                        ddlAlumno.Items.Add(
                            new ListItem(h.nombre, h.alumno_id.ToString())
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "errAlumnos",
                    "alert('Error al cargar alumnos de la familia: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
            }
        }

        private void CargarDeuda()
        {
            try
            {
                var d = boDeuda.consultarDeudaPorId(DeudaId);
                if (d == null)
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "errDeudaNotFound",
                        "alert('No se encontró la deuda indicada.');",
                        true
                    );
                    return;
                }

                txtCodigoDeuda.Text = d.deuda_id.ToString();

                // Monto base = monto (neto) + descuento
                double montoNeto = d.monto;
                double descuento = d.descuento;
                double montoBase = montoNeto + descuento;

                hfMontoBase.Value = montoBase.ToString(CultureInfo.InvariantCulture);
                txtMonto.Text = montoBase.ToString("0.00");
                txtDescuento.Text = descuento.ToString("0.00");
                txtTotal.Text = montoNeto.ToString("0.00");

                if (d.fecha_emision != DateTime.MinValue)
                    txtFechaEmision.Text = d.fecha_emision.ToString("yyyy-MM-dd");
                if (d.fecha_vencimiento != DateTime.MinValue)
                    txtFechaVencimiento.Text = d.fecha_vencimiento.ToString("yyyy-MM-dd");

                txtDescripcion.Text = d.descripcion ?? string.Empty;

                // seleccionar tipo de deuda por descripción (más seguro que por id)
                if (d.concepto_deuda != null && !string.IsNullOrEmpty(d.concepto_deuda.descripcion))
                {
                    var itemTipo = ddlTipoDeuda.Items.Cast<ListItem>()
                        .FirstOrDefault(it => it.Text.Equals(d.concepto_deuda.descripcion, StringComparison.OrdinalIgnoreCase));
                    if (itemTipo != null)
                    {
                        ddlTipoDeuda.ClearSelection();
                        itemTipo.Selected = true;
                    }
                }

                // seleccionar alumno por nombre
                if (d.alumno != null && !string.IsNullOrEmpty(d.alumno.nombre))
                {
                    var itemAlu = ddlAlumno.Items.Cast<ListItem>()
                        .FirstOrDefault(it => it.Text.Equals(d.alumno.nombre, StringComparison.OrdinalIgnoreCase));
                    if (itemAlu != null)
                    {
                        ddlAlumno.ClearSelection();
                        itemAlu.Selected = true;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "errConsultarDeuda",
                    "alert('Error al consultar la deuda: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
            }
        }

        private void CargarPagos()
        {
            ddlPagos.Items.Clear();

            try
            {
                var pagos = boPago.listarPagosPorDeuda(DeudaId);
                if (pagos == null || pagos.Length == 0)
                {
                    ddlPagos.Items.Add(new ListItem("(sin pagos)", ""));
                    return;
                }

                ddlPagos.Items.Add(new ListItem("(seleccione un pago)", ""));
                foreach (var p in pagos)
                {
                    string fecha = p.fecha.ToString("dd/MM/yyyy");
                    string texto = $"PAG-{p.pago_id} · {fecha} · S/. {p.monto:0.00}";
                    ddlPagos.Items.Add(new ListItem(texto, p.pago_id.ToString()));
                }

            }
            catch (Exception ex)
            {
                ddlPagos.Items.Clear();
                ddlPagos.Items.Add(new ListItem("(sin pagos)", ""));
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "errListPagos",
                    "alert('Error al listar los pagos de la deuda: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
            }
        }

        /* ================== RE-CÁLCULO DE TOTAL ================== */

        protected void ddlTipoDeuda_SelectedIndexChanged(object sender, EventArgs e)
        {
            // si no se selecciona nada, no hacemos nada
            if (!int.TryParse(ddlTipoDeuda.SelectedValue, out int idTipo) || idTipo <= 0)
                return;

            try
            {
                var tipo = boTipoDeuda.obtenerTipoDeudaPorId(idTipo);
                if (tipo != null)
                {
                    double montoBase = tipo.monto_general;
                    hfMontoBase.Value = montoBase.ToString(CultureInfo.InvariantCulture);
                    txtMonto.Text = montoBase.ToString("0.00");
                    RecalcularTotal();
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "errTipoMonto",
                    "alert('Error al obtener el monto del tipo de deuda: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
            }
        }

        protected void txtDescuento_TextChanged(object sender, EventArgs e)
        {
            RecalcularTotal();
        }

        private void RecalcularTotal()
        {
            if (!double.TryParse(hfMontoBase.Value, NumberStyles.Any, CultureInfo.InvariantCulture, out double montoBase) || montoBase <= 0)
            {
                txtMonto.Text = "0.00";
                txtTotal.Text = "0.00";
                return;
            }

            double desc = 0;
            if (!string.IsNullOrWhiteSpace(txtDescuento.Text))
            {
                if (!double.TryParse(txtDescuento.Text, NumberStyles.Any, CultureInfo.InvariantCulture, out desc))
                    desc = 0;
            }

            if (desc < 0) desc = 0;
            if (desc > montoBase) desc = montoBase;

            double total = montoBase - desc;

            txtMonto.Text = montoBase.ToString("0.00");
            txtDescuento.Text = desc.ToString("0.00");
            txtTotal.Text = total.ToString("0.00");
        }

        /* ====================== GUARDAR DEUDA ====================== */

        // Validación separada (bool + mensaje) — mantiene EXACTO orden original
        private bool Validar(out string mensajes)
        {
            var errores = new System.Collections.Generic.List<string>();
            var fmt = CultureInfo.InvariantCulture;

            // Tipo de deuda obligatorio
            if (!int.TryParse(ddlTipoDeuda.SelectedValue, out int idTipo) || idTipo <= 0)
                errores.Add("Debe seleccionar un tipo de deuda.");

            // Alumno obligatorio
            if (!int.TryParse(ddlAlumno.SelectedValue, out int idAlumno) || idAlumno <= 0)
                errores.Add("Debe seleccionar un alumno.");

            // Fechas obligatorias
            string feText = (txtFechaEmision.Text ?? "").Trim();
            string fvText = (txtFechaVencimiento.Text ?? "").Trim();

            if (!DateTime.TryParseExact(feText, "yyyy-MM-dd", fmt, DateTimeStyles.None, out DateTime fechaEmision))
                errores.Add("Debe ingresar una fecha de emisión válida.");

            if (!DateTime.TryParseExact(fvText, "yyyy-MM-dd", fmt, DateTimeStyles.None, out DateTime fechaVenc))
                errores.Add("Debe ingresar una fecha de vencimiento válida.");

            if (DateTime.TryParseExact(feText, "yyyy-MM-dd", fmt, DateTimeStyles.None, out fechaEmision) &&
                DateTime.TryParseExact(fvText, "yyyy-MM-dd", fmt, DateTimeStyles.None, out fechaVenc))
            {
                if (fechaEmision >= fechaVenc)
                    errores.Add("La fecha de emisión debe ser anterior a la fecha de vencimiento.");
            }

            // Monto base y descuento
            if (!double.TryParse(hfMontoBase.Value, NumberStyles.Any, fmt, out double montoBase) || montoBase <= 0)
                errores.Add("El monto de la deuda debe ser mayor a 0.");

            double descuento = 0;
            if (!string.IsNullOrWhiteSpace(txtDescuento.Text))
            {
                if (!double.TryParse(txtDescuento.Text, NumberStyles.Any, fmt, out descuento))
                    errores.Add("El descuento debe ser un número válido.");
            }

            if (descuento < 0 || descuento > montoBase)
                errores.Add("El descuento debe estar entre 0 y el monto base de la deuda.");

            double total = montoBase - descuento;
            if (total <= 0)
                errores.Add("El monto total de la deuda debe ser mayor a 0.");

            // Validar que el nuevo total no sea menor a lo ya pagado
            double pagado = 0;
            try
            {
                var pagos = boPago.listarPagosPorDeuda(DeudaId);
                if (pagos != null && pagos.Length > 0)
                    pagado = pagos.Sum(p => p.monto);
            }
            catch (Exception exPagos)
            {
                errores.Add("Error al verificar los pagos de la deuda: " + exPagos.Message);
            }

            if (total < pagado)
                errores.Add($"El monto total de la deuda (S/. {total:0.00}) no puede ser menor al total ya pagado (S/. {pagado:0.00}).");

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                // Validar primero
                if (!Validar(out string mensajesError))
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "validacionEditarDeuda",
                        "mostrarModal('" + mensajesError.Replace("'", "\\'") + "');",
                        true
                    );
                    return;
                }

                var fmt = CultureInfo.InvariantCulture;

                // Obtener valores ya validados
                int idTipo = int.Parse(ddlTipoDeuda.SelectedValue);
                int idAlumno = int.Parse(ddlAlumno.SelectedValue);

                DateTime fechaEmision = DateTime.ParseExact(txtFechaEmision.Text, "yyyy-MM-dd", fmt);
                fechaEmision = DateTime.SpecifyKind(fechaEmision.Date, DateTimeKind.Unspecified);

                DateTime fechaVenc = DateTime.ParseExact(txtFechaVencimiento.Text, "yyyy-MM-dd", fmt);
                fechaVenc = DateTime.SpecifyKind(fechaVenc.Date, DateTimeKind.Unspecified);

                double montoBase = double.Parse(hfMontoBase.Value, fmt);

                double descuento = 0;
                if (!string.IsNullOrWhiteSpace(txtDescuento.Text))
                    double.TryParse(txtDescuento.Text, NumberStyles.Any, fmt, out descuento);

                double total = montoBase - descuento;

                var deu = new deuda
                {
                    deuda_id = DeudaId,
                    monto = total,                    // monto neto
                    fecha_emision = fechaEmision,
                    fecha_vencimiento = fechaVenc,
                    descripcion = txtDescripcion.Text?.Trim(),
                    descuento = descuento,
                    alumno = new alumno { alumno_id = idAlumno },
                    concepto_deuda = new tipoDeuda { id_tipo_deuda = idTipo }
                };

                deu.fecha_emisionSpecified = true;
                deu.fecha_vencimientoSpecified = true;


                int resultado = boDeuda.modificarDeuda(deu);
                if (resultado <= 0)
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "errGuardar2",
                        "alert('No se pudo actualizar la deuda.');",
                        true
                    );
                    return;
                }

                // volver a Cobranza manteniendo familia si existe
                string url = "~/Cobranza/Cobranza.aspx";
                if (!string.IsNullOrEmpty(hfFamiliaId.Value))
                    url += "?familia=" + Server.UrlEncode(hfFamiliaId.Value);

                ScriptManager.RegisterStartupScript(
                    this, GetType(), "OkEditDeuda",
                    "alert('La deuda se actualizó correctamente.'); window.location='" + ResolveUrl(url) + "';",
                    true
                );
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "errExGuardar",
                    "alert('Ocurrió un error al actualizar la deuda: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            string url = "~/Cobranza/Cobranza.aspx";
            if (!string.IsNullOrEmpty(hfFamiliaId.Value))
                url += "?familia=" + Server.UrlEncode(hfFamiliaId.Value);

            Response.Redirect(url);
        }

        /* ==================== GESTIÓN DE PAGOS ==================== */

        protected void btnPagoConsultar_Click(object sender, EventArgs e)
        {
            //if (!int.TryParse(ddlPagos.SelectedValue, out int pagoId) || pagoId <= 0)
            //{
            //    ScriptManager.RegisterStartupScript(this, GetType(), "errPagoCons", "alert('Debe seleccionar un pago para consultar.');", true);
            //    return;
            //}

            //string url = "~/Cobranza/ConsultarPago.aspx?id=" + pagoId + "&idDeuda=" + DeudaId;
            //Response.Redirect(url);
        }

        protected void btnPagoEditar_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(ddlPagos.SelectedValue, out int pagoId) || pagoId <= 0)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "errPagoEdit",
                    "alert('Debe seleccionar un pago para editar.');",
                    true
                );
                return;
            }

            // futura pantalla de edición
            string url = "~/Cobranza/EditarPago.aspx?id=" + pagoId + "&idDeuda=" + DeudaId;
            Response.Redirect(url);
        }

        protected void btnConfirmarEliminarPago_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(ddlPagos.SelectedValue, out int pagoId) || pagoId <= 0)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "errPagoDelete",
                    "alert('Debe seleccionar un pago para colocarlo en No Vigente.');",
                    true
                );
                CerrarModalEliminarPago();
                return;
            }

            try
            {
                int res = boPago.eliminarPagoPorId(pagoId);
                if (res <= 0)
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "errPagoDelete2",
                        "alert('No se pudo colocar como No Vigente el pago.');",
                        true
                    );
                }
                else
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "okPagoElim",
                        "alert('Pago puesto en No Vigente correctamente');",
                        true
                    );
                }

                // recargar lista de pagos después de borrar
                CargarPagos();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "errPagoDeleteEx",
                    "alert('Ocurrió un error al colocar en No Vigente el pago: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
            }

            CerrarModalEliminarPago();
        }

        private void CerrarModalEliminarPago()
        {
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "CerrarEliminarPago",
                "document.getElementById('ovEliminarPago').classList.remove('show');" +
                "document.getElementById('ovEliminarPago').setAttribute('aria-hidden','true');",
                true
            );
        }

        protected void ddlPagos_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool tienePago = int.TryParse(ddlPagos.SelectedValue, out int pagoId) && pagoId > 0;

            btnPagoConsultar.Enabled = false;
            btnPagoConsultar.CssClass = "btn-icon btn-disabled";

            // Solo habilitamos editar / eliminar si hay pago seleccionado
            btnPagoEditar.Enabled = tienePago;
            btnPagoEliminar.Enabled = tienePago;

            btnPagoEditar.CssClass = "btn-icon" + (tienePago ? "" : " btn-disabled");
            btnPagoEliminar.CssClass = "btn-icon" + (tienePago ? "" : " btn-disabled");
        }
    }
}
