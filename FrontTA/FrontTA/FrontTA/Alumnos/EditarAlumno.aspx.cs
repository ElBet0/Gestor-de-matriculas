using FrontTA.SisProgWS;
using System;
using System.Globalization;
using System.Web;
using System.Web.UI;

namespace FrontTA.Alumnos
{
    public partial class EditarAlumno : System.Web.UI.Page
    {
        private readonly AlumnoWSClient boAlumno = new AlumnoWSClient();

        protected void Page_Init(object sender, EventArgs e)
        {
            // Desactiva el modo unobtrusive para que NO requiera jQuery
            Page.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var idStr = Request.QueryString["id"];
            if (!int.TryParse(idStr, out var alumnoId) || alumnoId <= 0)
            {
                NotificarYVolver("Identificador inválido.");
                return;
            }

            try
            {
                var al = boAlumno.obtenerAlumnoPorId(alumnoId);
                if (al == null)
                {
                    NotificarYVolver("No se encontró el alumno.");
                    return;
                }

                hfAlumnoId.Value = alumnoId.ToString();

                txtCodigoFamilia.Text = al.padres != null ? al.padres.familia_id.ToString() : string.Empty;
                txtNombre.Text = al.nombre ?? string.Empty;
                txtDNI.Text = al.dni.ToString();

                txtFechaNacimiento.Text = al.fecha_nacimiento == DateTime.MinValue
                    ? string.Empty
                    : al.fecha_nacimiento.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);

                txtFechaIngreso.Text = al.fecha_ingreso == DateTime.MinValue
                    ? string.Empty
                    : al.fecha_ingreso.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);

                txtReligion.Text = al.religion ?? string.Empty;

                var sexo = (al.sexo == '\0') ? "" : al.sexo.ToString().ToUpperInvariant();
                if (sexo == "M" || sexo == "F") ddlGenero.SelectedValue = sexo; else ddlGenero.SelectedIndex = 0;

                txtPension.Text = al.pension_base.ToString(CultureInfo.InvariantCulture);
                txtObservaciones.Text = al.observaciones ?? string.Empty;
            }
            catch
            {
                NotificarYVolver("Ocurrió un problema al cargar la información del alumno.");
            }
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // Validación 100% server-side
            if (!int.TryParse(hfAlumnoId.Value, out var alumnoId) || alumnoId <= 0)
            {
                MostrarAlerta("Identificador de alumno inválido.");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtCodigoFamilia.Text) || !int.TryParse(txtCodigoFamilia.Text.Trim(), out var familiaId))
            {
                MostrarAlerta("Código de familia inválido.");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtNombre.Text))
            {
                MostrarAlerta("El nombre es obligatorio.");
                return;
            }

            if (txtNombre.Text.Trim().Length > 12)
            {
                MostrarAlerta("La longitud del nombre no es válida (máx. 12 caracteres).");
                return;
            }

            if (!int.TryParse((txtDNI.Text ?? "").Trim(), out var dni) || dni <= 0)
            {
                MostrarAlerta("DNI inválido.");
                return;
            }

            if (!TryParseDate(txtFechaNacimiento.Text, out var fn))
            {
                MostrarAlerta("La fecha de nacimiento es inválida (use el selector de fecha).");
                return;
            }
            if (!TryParseDate(txtFechaIngreso.Text, out var fi))
            {
                MostrarAlerta("La fecha de ingreso es inválida (use el selector de fecha).");
                return;
            }

            // ==== PENSIÓN BASE ====
            double pensionBase = 0;
            var penTxt = (txtPension.Text ?? string.Empty).Trim().Replace(',', '.');

            if (!string.IsNullOrWhiteSpace(penTxt))
            {
                if (!double.TryParse(penTxt, NumberStyles.Any, CultureInfo.InvariantCulture, out pensionBase))
                {
                    MostrarAlerta("Pensión base inválida (use números, máx. 2 decimales).");
                    return;
                }

                // Nueva regla: si ingresa pensión, debe ser >= 100
                if (pensionBase < 100)
                {
                    MostrarAlerta("La pensión base debe ser mayor o igual que 100.");
                    return;
                }
            }
            else
            {
                // Si quieres obligatoria en edición, descomenta esto:
                // MostrarAlerta("La pensión base es obligatoria.");
                // return;
                pensionBase = 0;
            }

            var genero = ddlGenero.SelectedValue; // "M" | "F" | ""
            if (string.IsNullOrEmpty(genero))
            {
                MostrarAlerta("Selecciona el género.");
                return;
            }

            var alumno = new alumno
            {
                alumno_id = alumnoId, // asumiendo propiedad en proxy
                padres = new familia { familia_id = familiaId },
                nombre = (txtNombre.Text ?? string.Empty).Trim(),
                dni = dni,
                fecha_nacimiento = fn,
                fecha_ingreso = fi,
                religion = (txtReligion.Text ?? string.Empty).Trim(),
                sexo = genero[0],
                pension_base = pensionBase,
                observaciones = (txtObservaciones.Text ?? string.Empty).Trim()
            };

            // Forzar flags ...Specified si el proxy los generó
            TryMarkSpecifiedFlag(alumno, "fecha_nacimientoSpecified");
            TryMarkSpecifiedFlag(alumno, "fecha_ingresoSpecified");

            try
            {
                boAlumno.modificarAlumno(alumno);

                var url = ResolveUrl("~/Alumnos/Alumnos.aspx");

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "alumnoEditOk",
                    $"alert('El alumno se editó correctamente.'); window.location='{url}';",
                    true
                );
            }
            catch
            {
                MostrarAlerta("No se pudo guardar los cambios del alumno. Intenta nuevamente.");
            }
        }


        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Alumnos/Alumnos.aspx", endResponse: false);
        }

        // ===== Helpers =====

        private static bool TryParseDate(string text, out DateTime dt)
        {
            dt = DateTime.MinValue;
            if (string.IsNullOrWhiteSpace(text)) return false;

            // type="date" emite yyyy-MM-dd
            if (!DateTime.TryParseExact(text.Trim(), "yyyy-MM-dd", CultureInfo.InvariantCulture,
                                        DateTimeStyles.None, out var parsed))
                return false;

            dt = DateTime.SpecifyKind(parsed.Date, DateTimeKind.Unspecified);
            return true;
        }

        private static void TryMarkSpecifiedFlag(object obj, string propertyName)
        {
            try
            {
                var p = obj.GetType().GetProperty(propertyName);
                if (p != null) p.SetValue(obj, true, null);
            }
            catch { /* ignorar */ }
        }

        private void NotificarYVolver(string mensaje)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "redir",
                $"alert('{HttpUtility.JavaScriptStringEncode(mensaje)}'); window.location='~/Alumnos/Alumnos.aspx';", true);
        }

        private void MostrarAlerta(string mensaje)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                $"alert('{HttpUtility.JavaScriptStringEncode(mensaje)}');", true);
        }

        protected override void OnUnload(EventArgs e)
        {
            base.OnUnload(e);
            try
            {
                if (boAlumno.State == System.ServiceModel.CommunicationState.Faulted)
                    boAlumno.Abort();
                else
                    boAlumno.Close();
            }
            catch { }
        }
    }
}
