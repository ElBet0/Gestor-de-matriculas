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
    public partial class CrearPersonal : System.Web.UI.Page
    {
        private CargoWSClient boCargo;
        private BindingList<cargo> listCargo;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTipoContrato();
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
            // ✅ PRIMERO: Validar según las reglas del backend Java
            string mensajesError;
            if (!ValidarPersonal(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionPersonal",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return; // No seguimos si hay errores
            }

            try
            {
                var boPersonal = new PersonalWSClient();
                var Personal = new personal();

                // --- Cargo seleccionado ---
                int cargoId = int.Parse(hfCargoId.Value);

                if (listCargo == null || listCargo.Count == 0)
                {
                    boCargo = new CargoWSClient();
                    listCargo = new BindingList<cargo>(boCargo.listarCargosTodos());
                }

                var cargoSeleccionado = listCargo.FirstOrDefault(c => c.cargo_id == cargoId);
                if (cargoSeleccionado == null)
                {
                    ClientScript.RegisterStartupScript(
                        GetType(),
                        "alert",
                        "alert('El cargo seleccionado no existe');",
                        true
                    );
                    return;
                }

                // --- Datos básicos ---
                Personal.nombre = txtNombre.Text?.Trim();
                Personal.apellido_paterno = txtApePaterno.Text?.Trim();
                Personal.apellido_materno = txtApeMaterno.Text?.Trim();
                Personal.telefono = txtTelefono.Text?.Trim();
                Personal.correo_electronico = txtEmail.Text?.Trim();

                // Salario (con cultura invariante)
                Personal.salario = double.Parse(
                    txtSueldo.Text.Trim(),
                    CultureInfo.InvariantCulture
                );
                // Personal.salarioSpecified = true; // si tu proxy lo requiere

                // DNI
                Personal.dni = int.Parse(txtDNI.Text.Trim());
                // Personal.dniSpecified = true; // si tu proxy lo requiere

                // Tipo de contrato
                Personal.tipo_contrato = (tipoContrato)Enum.Parse(
                    typeof(tipoContrato),
                    ddlTipoContrato.SelectedValue
                );
                Personal.tipo_contratoSpecified = true;

                // --- Fechas ---
                var fmt = CultureInfo.InvariantCulture;
                DateTime fiInicio, fiFin;

                // fecha_Contratacion
                if (!string.IsNullOrWhiteSpace(txtFechaInicio.Text) &&
                    DateTime.TryParseExact(
                        txtFechaInicio.Text.Trim(),
                        "yyyy-MM-dd",
                        fmt,
                        DateTimeStyles.None,
                        out fiInicio
                    ))
                {
                    fiInicio = DateTime.SpecifyKind(fiInicio.Date, DateTimeKind.Unspecified);
                }
                else
                {
                    fiInicio = DateTime.Today;
                }
                Personal.fecha_Contratacion = fiInicio;
                Personal.fecha_ContratacionSpecified = true;

                // fin_fecha_Contratacion
                if (!string.IsNullOrWhiteSpace(txtFechaFin.Text) &&
                    DateTime.TryParseExact(
                        txtFechaFin.Text.Trim(),
                        "yyyy-MM-dd",
                        fmt,
                        DateTimeStyles.None,
                        out fiFin
                    ))
                {
                    fiFin = DateTime.SpecifyKind(fiFin.Date, DateTimeKind.Unspecified);
                }
                else
                {
                    fiFin = DateTime.Today.AddYears(1);
                }
                Personal.fin_fecha_Contratacion = fiFin;
                Personal.fin_fecha_ContratacionSpecified = true;

                // Cargo completo
                Personal.cargo = cargoSeleccionado;

                // Llamada al WS
                int resultado = boPersonal.insertarPersonal(Personal);

                if (resultado > 0)
                {
                    var url = ResolveUrl("~/GestionAcademica/Personal.aspx");
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "personalCreadoOk",
                        $"alert('Personal insertado correctamente'); window.location='{url}';",
                        true
                    );
                }
                else
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "personalCreadoFail",
                        "alert('El servicio devolvió 0: no se insertó ningún registro.');",
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
                e.Row.Attributes["data-id"] = id;
                e.Row.CssClass = (e.Row.CssClass + " selectable-row").Trim();
                e.Row.Attributes["style"] = "cursor:pointer";
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

                int resultado = boCargo.insertarCargo(nuevoCargo);

                if (resultado > 0)
                {
                    txtNombreModal.Text = "";
                    listCargo = new BindingList<cargo>(boCargo.listarCargosTodos());
                    gvCargos.DataSource = listCargo;
                    gvCargos.DataBind();

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
