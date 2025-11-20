using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class EditarPersonal : System.Web.UI.Page
    {
        private CargoWSClient boCargo;
        private BindingList<cargo> listCargo;

        protected void Page_Load(object sender, EventArgs e)
        {
            boCargo = new CargoWSClient();
            listCargo = new BindingList<cargo>(boCargo.listarCargosTodos());
            gvCargos.DataSource = listCargo;
            gvCargos.DataBind();

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int personalId = int.Parse(Request.QueryString["id"]);
                    PersonalWSClient boPersonal = new PersonalWSClient();
                    personal p = boPersonal.obtenerPersonalPorId(personalId);

                    if (p != null)
                    {
                        txtId.Text = p.personal_id.ToString();
                        txtDNI.Text = p.dni.ToString();
                        txtNombre.Text = p.nombre;
                        txtApePaterno.Text = p.apellido_paterno;
                        txtApeMaterno.Text = p.apellido_materno;
                        txtEmail.Text = p.correo_electronico;
                        txtTelefono.Text = p.telefono;
                        txtSueldo.Text = p.salario.ToString(CultureInfo.InvariantCulture);
                        txtFechaInicio.Text = p.fecha_Contratacion.ToString("yyyy-MM-dd");
                        txtFechaFin.Text = p.fin_fecha_Contratacion.ToString("yyyy-MM-dd");

                        txtCargo.Text = p.cargo.nombre;   // muestra el nombre del cargo
                        hfCargoId.Value = p.cargo.cargo_id.ToString(); // guarda el ID
                        hfCargoNombre.Value = p.cargo.nombre;

                        CargarTipoContrato();
                        ddlTipoContrato.SelectedValue = p.tipo_contrato.ToString();
                    }
                }
                CargarCargos();
            }
        }

        private void CargarCargos()
        {
            boCargo = new CargoWSClient();
            listCargo = new BindingList<cargo>(boCargo.listarCargosTodos());
            gvCargos.DataSource = listCargo;
            gvCargos.DataBind();
        }

        private void CargarTipoContrato()
        {
            ddlTipoContrato.Items.Clear();
            ddlTipoContrato.Items.Add(new ListItem("Seleccionar...", ""));

            foreach (tipoContrato tipo in Enum.GetValues(typeof(tipoContrato)))
            {
                ddlTipoContrato.Items.Add(new ListItem(tipo.ToString(), tipo.ToString()));
            }
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // ✅ PRIMERO: Validar con las MISMAS reglas que CrearPersonal
            string mensajesError;
            if (!ValidarPersonal(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionPersonalEditar",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return; // No seguimos si hay errores
            }

            try
            {
                var boPersonal = new PersonalWSClient();
                var Personal = new personal();

                // --- Cargo seleccionado (SIN buscar en memoria) ---
                if (!int.TryParse(hfCargoId.Value, out int cargoId))
                {
                    ClientScript.RegisterStartupScript(
                        GetType(),
                        "alert",
                        "alert('El ID de cargo es inválido.');",
                        true
                    );
                    return;
                }

                var cargoSeleccionado = new cargo
                {
                    cargo_id = cargoId,
                    nombre = hfCargoNombre.Value // opcional, pero útil
                };

                // --- Datos básicos ---
                Personal.nombre = txtNombre.Text?.Trim();
                Personal.apellido_paterno = txtApePaterno.Text?.Trim();
                Personal.apellido_materno = txtApeMaterno.Text?.Trim();
                Personal.telefono = txtTelefono.Text?.Trim();
                Personal.correo_electronico = txtEmail.Text?.Trim();

                // Salario (ya validado antes)
                double sueldo = double.Parse(
                    txtSueldo.Text.Trim(),
                    NumberStyles.Any,
                    CultureInfo.InvariantCulture
                );
                Personal.salario = sueldo;
                // Personal.salarioSpecified = true; // si tu proxy lo requiere

                // DNI (ya validado antes)
                int dniVal = int.Parse(txtDNI.Text.Trim());
                Personal.dni = dniVal;
                // Personal.dniSpecified = true; // si tu proxy lo requiere

                // Tipo de contrato (ya validado que no esté vacío)
                Personal.tipo_contrato = (tipoContrato)Enum.Parse(
                    typeof(tipoContrato),
                    ddlTipoContrato.SelectedValue
                );
                Personal.tipo_contratoSpecified = true;

                // --- Fechas --- (ya validadas en ValidarPersonal)
                var fmt = CultureInfo.InvariantCulture;
                DateTime fiInicio, fiFin;

                DateTime.TryParseExact(
                    txtFechaInicio.Text.Trim(),
                    "yyyy-MM-dd",
                    fmt,
                    DateTimeStyles.None,
                    out fiInicio
                );
                fiInicio = DateTime.SpecifyKind(fiInicio.Date, DateTimeKind.Unspecified);

                DateTime.TryParseExact(
                    txtFechaFin.Text.Trim(),
                    "yyyy-MM-dd",
                    fmt,
                    DateTimeStyles.None,
                    out fiFin
                );
                fiFin = DateTime.SpecifyKind(fiFin.Date, DateTimeKind.Unspecified);

                Personal.fecha_Contratacion = fiInicio;
                Personal.fecha_ContratacionSpecified = true;

                Personal.fin_fecha_Contratacion = fiFin;
                Personal.fin_fecha_ContratacionSpecified = true;

                // Cargo completo y PK del personal
                Personal.cargo = cargoSeleccionado;

                if (!int.TryParse(Request.QueryString["id"], out int personalId))
                {
                    ClientScript.RegisterStartupScript(
                        GetType(),
                        "alert",
                        "alert('ID de personal inválido en la URL.');",
                        true
                    );
                    return;
                }
                Personal.personal_id = personalId;

                // Llamada al WS
                int resultado = boPersonal.modificarPersonal(Personal);

                if (resultado > 0)
                {
                    var url = ResolveUrl("~/GestionAcademica/Personal.aspx");
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "personalEditadoOk",
                        $"alert('Personal modificado correctamente'); window.location='{url}';",
                        true
                    );
                }
                else
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "personalEditadoFail",
                        "alert('El servicio devolvió 0: no se modificó ningún registro.');",
                        true
                    );
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(
                    GetType(),
                    "alert",
                    $"alert('Error: {ex.Message}');",
                    true
                );
            }
        }

        // ========= VALIDACIÓN SOLO EN C# (MISMAS REGLAS QUE CrearPersonal) =========
        private bool ValidarPersonal(out string mensajes)
        {
            var errores = new List<string>();

            // Tipo de contrato
            if (string.IsNullOrEmpty(ddlTipoContrato.SelectedValue))
            {
                errores.Add("Por favor, seleccione un tipo de contrato.");
            }

            // Cargo (hfCargoId) + regla de cargo_id < 0
            if (string.IsNullOrEmpty(hfCargoId.Value))
            {
                errores.Add("No se ha seleccionado ningún cargo.");
            }
            else
            {
                int cargoIdParsed;
                if (!int.TryParse(hfCargoId.Value, out cargoIdParsed))
                {
                    errores.Add("El cargo seleccionado no es válido.");
                }
                else if (cargoIdParsed < 0)
                {
                    errores.Add("El cargo asignado al personal no es válido.");
                }
            }

            // ===== NOMBRE Y APELLIDOS (OBLIGATORIOS + MÁX. 12) =====
            string nombre = (txtNombre.Text ?? "").Trim();
            string apePat = (txtApePaterno.Text ?? "").Trim();
            string apeMat = (txtApeMaterno.Text ?? "").Trim();

            // Nombre
            if (string.IsNullOrWhiteSpace(nombre))
            {
                errores.Add("El nombre es obligatorio.");
            }
            else if (nombre.Length > 12)
            {
                errores.Add("La longitud del nombre no es válida (máx. 12 caracteres).");
            }

            // Apellido paterno
            if (string.IsNullOrWhiteSpace(apePat))
            {
                errores.Add("El apellido paterno es obligatorio.");
            }
            else if (apePat.Length > 12)
            {
                errores.Add("La longitud del apellido paterno no es válida (máx. 12 caracteres).");
            }

            // Apellido materno
            if (string.IsNullOrWhiteSpace(apeMat))
            {
                errores.Add("El apellido materno es obligatorio.");
            }
            else if (apeMat.Length > 12)
            {
                errores.Add("La longitud del apellido materno no es válida (máx. 12 caracteres).");
            }

            // ===== DNI: requerido, numérico, rango Java =====
            string dniTxt = (txtDNI.Text ?? "").Trim();
            if (string.IsNullOrWhiteSpace(dniTxt))
            {
                errores.Add("Por favor, ingrese un DNI.");
            }
            else
            {
                int dniParsed;
                if (!int.TryParse(dniTxt, out dniParsed))
                {
                    errores.Add("El DNI debe ser un número entero.");
                }
                else if (dniParsed <= 10000000 || dniParsed >= 99999999)
                {
                    errores.Add("El DNI ingresado no es válido.");
                }
            }

            // ===== Salario: obligatorio, numérico, >= 1130 =====
            string sueldoTxt = (txtSueldo.Text ?? "").Trim();
            if (string.IsNullOrWhiteSpace(sueldoTxt))
            {
                errores.Add("Ingrese el salario.");
            }
            else
            {
                double salarioParsed;
                if (!double.TryParse(sueldoTxt, NumberStyles.Any, CultureInfo.InvariantCulture, out salarioParsed))
                {
                    errores.Add("El salario debe ser un número válido.");
                }
                else if (salarioParsed < 1130)
                {
                    errores.Add("El salario es muy bajo (mínimo 1130).");
                }
            }

            // ===== Teléfono: máx. 12 (si se llena) =====
            string telefono = (txtTelefono.Text ?? "").Trim();
            if (telefono.Length > 12)
            {
                errores.Add("La longitud del número de teléfono no es válida (máx. 12 caracteres).");
            }

            // ===== Correo: máx. 45 (si se llena) =====
            string correo = (txtEmail.Text ?? "").Trim();
            if (correo.Length > 45)
            {
                errores.Add("La longitud del correo electrónico no es válida (máx. 45 caracteres).");
            }

            // ===== FECHAS: ambas obligatorias y fin > inicio =====
            string fechaInicioTxt = (txtFechaInicio.Text ?? "").Trim();
            string fechaFinTxt = (txtFechaFin.Text ?? "").Trim();
            var fmt = CultureInfo.InvariantCulture;

            DateTime fiInicio, fiFin;

            // Ambas obligatorias
            if (string.IsNullOrWhiteSpace(fechaInicioTxt))
            {
                errores.Add("La fecha de contratación es obligatoria.");
            }
            if (string.IsNullOrWhiteSpace(fechaFinTxt))
            {
                errores.Add("La fecha de fin de contrato es obligatoria.");
            }

            // Solo si las dos tienen algo, intentamos parsear y validar orden
            if (!string.IsNullOrWhiteSpace(fechaInicioTxt) &&
                !string.IsNullOrWhiteSpace(fechaFinTxt))
            {
                bool okInicio = DateTime.TryParseExact(
                    fechaInicioTxt,
                    "yyyy-MM-dd",
                    fmt,
                    DateTimeStyles.None,
                    out fiInicio
                );

                bool okFin = DateTime.TryParseExact(
                    fechaFinTxt,
                    "yyyy-MM-dd",
                    fmt,
                    DateTimeStyles.None,
                    out fiFin
                );

                if (!okInicio)
                {
                    errores.Add("La fecha de contratación no tiene un formato válido (use yyyy-MM-dd).");
                }
                if (!okFin)
                {
                    errores.Add("La fecha de fin de contrato no tiene un formato válido (use yyyy-MM-dd).");
                }

                // Si ambas fechas son válidas, verificamos el orden
                if (okInicio && okFin)
                {
                    // Java: if (!fecha_Contratacion.before(fin_fecha_Contratacion))
                    // → error si inicio >= fin
                    if (!(fiInicio < fiFin))
                    {
                        errores.Add("El orden de las fechas no es válido: la fecha de fin de contrato debe ser posterior a la fecha de contratación.");
                    }
                }
            }

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }

        protected void gvCargos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
                e.Row.CssClass = "table-header";
                return;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string id = DataBinder.Eval(e.Row.DataItem, "cargo_id")?.ToString();
                string nombre = DataBinder.Eval(e.Row.DataItem, "nombre")?.ToString();

                e.Row.Attributes["data-id"] = id;
                e.Row.CssClass = (e.Row.CssClass + " selectable-row").Trim();
                e.Row.Attributes["style"] = "cursor:pointer";
                e.Row.Attributes["onclick"] = $"seleccionarCargo('{id}','{nombre}')";
            }
        }

        protected void btnAgregarCargo_Click(object sender, EventArgs e)
        {
            try
            {
                string nombreCargo = txtNombreModal.Text?.Trim();

                if (string.IsNullOrWhiteSpace(nombreCargo))
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "alert",
                        "alert('Ingrese un nombre de cargo.');",
                        true
                    );
                    return;
                }

                boCargo = new CargoWSClient();
                cargo nuevoCargo = new cargo { nombre = nombreCargo };

                int resultado = boCargo.insertarCargo(nuevoCargo); // WS inserta y devuelve >0 si ok

                if (resultado > 0)
                {
                    txtNombreModal.Text = ""; // limpiar input
                    listCargo = new BindingList<cargo>(boCargo.listarCargosTodos());
                    gvCargos.DataSource = listCargo;
                    gvCargos.DataBind();

                    // actualizar UpdatePanel
                    upCargos.Update();
                    CargarCargos();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "alert",
                        "alert('No se pudo agregar el cargo.');",
                        true
                    );
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "alert",
                    $"alert('Error: {ex.Message}');",
                    true
                );
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GestionAcademica/Personal.aspx");
        }
    }
}
