using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;

namespace FrontTA.Alumnos
{
    public partial class EditarAlumno : System.Web.UI.Page
    {
        private readonly AlumnoWSClient boAlumno = new AlumnoWSClient();
        private readonly FamiliaWSClient boFamilia = new FamiliaWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDatosAlumno();
            }
        }

        // ======================================================
        //  🔹 BOTÓN ✔ CONFIRMAR
        // ======================================================
        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            string errores;

            if (!ValidarAlumno(out errores))
            {
                // Mostrar modal con errores
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "alumnoError",
                    $"mostrarModal('{errores.Replace("'", "\\'")}');",
                    true
                );
                return;
            }

            // ============ SI TODO OK: ARMAR OBJETO ==================
            int alumnoId = int.Parse(hfAlumnoId.Value);
            int familiaId = int.Parse(txtCodigoFamilia.Text);

            // Pensiones
            double pensionBase = 0;
            double.TryParse(
                txtPension.Text.Replace(",", "."),
                NumberStyles.Any,
                CultureInfo.InvariantCulture,
                out pensionBase
            );

            // Construir objeto alumno
            var alumno = new alumno
            {
                alumno_id = alumnoId,
                padres = new familia { familia_id = familiaId },

                nombre = txtNombre.Text.Trim(),
                dni = int.Parse(txtDNI.Text.Trim()),

                fecha_nacimiento = DateTime.Parse(txtFechaNacimiento.Text),
                fecha_ingreso = DateTime.Parse(txtFechaIngreso.Text),

                religion = txtReligion.Text.Trim(),
                sexo = ddlGenero.SelectedValue[0],
                pension_base = pensionBase,
                observaciones = txtObservaciones.Text.Trim()
            };

            // Marcar campos "Specified"
            alumno.fecha_nacimientoSpecified = true;
            alumno.fecha_ingresoSpecified = true;

            try
            {
                boAlumno.modificarAlumno(alumno);

                var url = ResolveUrl("~/Alumnos/Alumnos.aspx");

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "editarOk",
                    $"alert('El alumno se editó correctamente'); window.location='{url}';",
                    true
                );
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "editarError",
                    $"mostrarModal('No se pudo guardar los cambios: {ex.Message.Replace("'", "\\'")}');",
                    true
                );
            }
        }

        // ======================================================
        //  🔹 BOTÓN ✖ CANCELAR
        // ======================================================
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }

        // ======================================================
        // 🔎 FUNCIÓN CENTRAL DE VALIDACIÓN
        // ======================================================
        private bool ValidarAlumno(out string mensajes)
        {
            var errores = new List<string>();

            // ==== ID del alumno ====
            if (!int.TryParse(hfAlumnoId.Value, out int alumnoId) || alumnoId <= 0)
                errores.Add("Identificador de alumno inválido.");

            // ==== Familia ====
            if (!int.TryParse(txtCodigoFamilia.Text, out int familiaId) || familiaId <= 0)
                errores.Add("Código de familia inválido.");

            // ==== Nombre ====
            if (string.IsNullOrWhiteSpace(txtNombre.Text))
                errores.Add("El nombre es obligatorio.");
            else if (txtNombre.Text.Trim().Length > 12)
                errores.Add("La longitud del nombre no es válida (máx. 12 caracteres).");

            // ==== DNI ====
            if (!int.TryParse(txtDNI.Text.Trim(), out int dni))
                errores.Add("El DNI debe ser un número válido.");

            // ==== Fechas ====
            if (!DateTime.TryParse(txtFechaNacimiento.Text, out _))
                errores.Add("La fecha de nacimiento es inválida.");

            if (!DateTime.TryParse(txtFechaIngreso.Text, out _))
                errores.Add("La fecha de ingreso es inválida.");

            // ==== Género ====
            if (string.IsNullOrWhiteSpace(ddlGenero.SelectedValue))
                errores.Add("Debes seleccionar un género.");

            // ==== Pensión ====
            string pens = txtPension.Text.Replace(",", ".");
            if (!string.IsNullOrWhiteSpace(pens))
            {
                if (!double.TryParse(pens, NumberStyles.Any, CultureInfo.InvariantCulture, out double pension))
                    errores.Add("La pensión base debe ser un número válido.");
                else if (pension < 100)
                    errores.Add("La pensión base debe ser mayor o igual que 100.");
            }

            // ==== Dirección, Religión, Observaciones (opcionales) ====  
            // Puedes agregar validaciones si deseas

            mensajes = string.Join("<br>", errores);
            return errores.Count == 0;
        }

        // ======================================================
        // 🔹 CARGAR DATOS INICIALES DEL ALUMNO
        // ======================================================
        private void CargarDatosAlumno()
        {
            if (!int.TryParse(Request.QueryString["id"], out int alumnoId))
                return;

            hfAlumnoId.Value = alumnoId.ToString();

            var alumno = boAlumno.obtenerAlumnoPorId(alumnoId);

            if (alumno == null)
                return;

            txtCodigoFamilia.Text = alumno.padres.familia_id.ToString();
            txtNombre.Text = alumno.nombre;
            txtDNI.Text = alumno.dni.ToString();
            txtFechaNacimiento.Text = alumno.fecha_nacimiento.ToString("yyyy-MM-dd");
            txtFechaIngreso.Text = alumno.fecha_ingreso.ToString("yyyy-MM-dd");
            txtReligion.Text = alumno.religion;
            ddlGenero.SelectedValue = alumno.sexo.ToString();
            txtPension.Text = alumno.pension_base.ToString(CultureInfo.InvariantCulture);
            txtObservaciones.Text = alumno.observaciones;
        }
    }
}
