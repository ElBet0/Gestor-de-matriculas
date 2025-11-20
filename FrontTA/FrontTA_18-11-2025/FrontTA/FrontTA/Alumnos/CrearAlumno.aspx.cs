using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Alumnos
{
    public partial class CrearAlumno : System.Web.UI.Page
    {
        public readonly AlumnoWSClient boAlumno = new AlumnoWSClient();
        public readonly FamiliaWSClient boFamilia = new FamiliaWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnConfirmar.Text = "<i class='fa-solid fa-check'></i>";
                btnCancelar.Text = "<i class='fa-solid fa-xmark'></i>";

                // Carga inicial de familias en el modal
                reFamilias.DataSource = boFamilia.listarFamiliasTodas();
                reFamilias.DataBind();
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }

        // ========= BOTÓN ✔ CONFIRMAR =========
        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            try
            {
                alumno al;
                string mensajesError;

                if (!ConstruirYValidarAlumno(out al, out mensajesError))
                {
                    // Mostrar todos los errores en un solo alert
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "validacionAlumno",
                       $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                        true
                    );
                    return;
                }

                int resultado = boAlumno.insertarAlumno(al);

                if (resultado > 0)
                {
                    var url = ResolveUrl("~/Alumnos/Alumnos.aspx");
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "alumnoOk",
                        $"alert('El alumno se creó correctamente.'); window.location='{url}';",
                        true
                    );
                }
                else
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "alumnoNoInsertado",
                        "alert('No se pudo registrar el alumno. Verifique los datos.');",
                        true
                    );
                }
            }
            catch (Exception ex)
            {
                string msg = ("Error al crear el alumno: " + ex.Message).Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "alumnoError",
                    $"alert('{msg}');",
                    true
                );
            }
        }

        /// <summary>
        /// Valida los campos y construye el alumno. Devuelve false si hay errores.
        /// </summary>
        private bool ConstruirYValidarAlumno(out alumno al, out string mensajes)
        {
            al = new alumno();
            var errores = new List<string>();

            // ========= FAMILIA =========
            if (string.IsNullOrWhiteSpace(txtCodigoFamilia.Text) ||
                !int.TryParse(txtCodigoFamilia.Text.Trim(), out int familiaId) ||
                familiaId <= 0)
            {
                errores.Add("Debe seleccionar una familia válida.");
            }
            else
            {
                al.padres = new familia { familia_id = familiaId };
            }

            // ========= NOMBRE =========
            string nombre = (txtNombre.Text ?? "").Trim();
            if (string.IsNullOrWhiteSpace(nombre))
                errores.Add("El nombre del alumno es obligatorio.");
            else if (nombre.Length > 12)
                errores.Add("La longitud del nombre no es válida (máx. 12 caracteres).");
            else
                al.nombre = nombre;

            // ========= DNI =========
            string dniText = (txtDNI.Text ?? "").Trim();
            if (string.IsNullOrWhiteSpace(dniText))
                errores.Add("El DNI es obligatorio.");
            else if (!dniText.All(char.IsDigit))
                errores.Add("El DNI debe contener solo dígitos.");
            else if (dniText.Length != 8)
                errores.Add("El DNI debe tener exactamente 8 dígitos.");
            else if (!int.TryParse(dniText, out int dni) || dni <= 0)
                errores.Add("El DNI no es válido.");
            else
                al.dni = dni;

            // ========= FECHAS =========
            var fmt = CultureInfo.InvariantCulture;

            // Fecha nacimiento (obligatoria)
            string fnText = (txtFechaNacimiento.Text ?? "").Trim();
            if (string.IsNullOrEmpty(fnText))
                errores.Add("La fecha de nacimiento es obligatoria.");
            else if (DateTime.TryParseExact(fnText, "yyyy-MM-dd", fmt, DateTimeStyles.None, out DateTime fn))
            {
                fn = DateTime.SpecifyKind(fn.Date, DateTimeKind.Unspecified);
                al.fecha_nacimiento = fn;
            }
            else
                errores.Add("La fecha de nacimiento no tiene un formato válido (use el selector de fecha).");

            // Fecha ingreso (obligatoria)
            string fiText = (txtFechaIngreso.Text ?? "").Trim();
            if (string.IsNullOrEmpty(fiText))
                errores.Add("La fecha de ingreso es obligatoria.");
            else if (DateTime.TryParseExact(fiText, "yyyy-MM-dd", fmt, DateTimeStyles.None, out DateTime fi))
            {
                fi = DateTime.SpecifyKind(fi.Date, DateTimeKind.Unspecified);
                al.fecha_ingreso = fi;
            }
            else
                errores.Add("La fecha de ingreso no tiene un formato válido (use el selector de fecha).");

            // ========= RELIGIÓN =========
            string religion = (txtReligion.Text ?? "").Trim();
            if (religion.Length > 50)
                errores.Add("La longitud de la religión no es válida (máx. 50 caracteres).");
            else
                al.religion = religion;

            // ========= SEXO =========
            if (string.IsNullOrEmpty(ddlGenero.SelectedValue))
                errores.Add("Debe seleccionar el sexo del alumno.");
            else
                al.sexo = ddlGenero.SelectedValue[0];

            // ========= PENSIÓN =========
            string pensionText = (txtPension.Text ?? "").Trim();
            if (string.IsNullOrEmpty(pensionText))
                errores.Add("La pensión base es obligatoria.");
            else if (double.TryParse(pensionText, NumberStyles.Any, CultureInfo.InvariantCulture, out double pensionBase))
            {
                if (pensionBase < 0)
                    errores.Add("La pensión base no puede ser negativa.");
                else
                    al.pension_base = pensionBase;
            }
            else
                errores.Add("La pensión debe ser un valor numérico válido.");

            // ========= OBSERVACIONES =========
            string obs = (txtObservaciones.Text ?? "").Trim();
            if (obs.Length > 250)
                errores.Add("Las observaciones no pueden superar los 250 caracteres.");
            else
                al.observaciones = obs;

            // Forzar serialización de fechas si el proxy lo requiere
            try
            {
                var p1 = al.GetType().GetProperty("fecha_nacimientoSpecified");
                if (p1 != null) p1.SetValue(al, true, null);
                var p2 = al.GetType().GetProperty("fecha_ingresoSpecified");
                if (p2 != null) p2.SetValue(al, true, null);
            }
            catch { }

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }

        // ========= BOTÓN BUSCAR EN EL MODAL DE FAMILIAS =========
        protected void btnBuscarModal_Click(object sender, EventArgs e)
        {
            string apePat = txtApePaternoModal.Text?.Trim();
            string apeMat = txtApeMaternoModal.Text?.Trim();

            var lista = boAlumno.buscarAlumnos(
                "",     // familia (no filtra)
                apePat, // ape. paterno
                apeMat, // ape. materno
                "",     // nombre
                ""      // dni
            );

            reFamilias.DataSource = lista;
            reFamilias.DataBind();

            // Actualizar updatepanel del modal
            upFamilia.Update();

            // Mantener modal abierto
            ScriptManager.RegisterStartupScript(
                upFamilia,
                upFamilia.GetType(),
                "keepFamiliaOpen",
                "setTimeout(function(){var ov=document.getElementById('ovFamilia'); if(ov){ ov.classList.add('show'); ov.setAttribute('aria-hidden','false'); }},0);",
                true
            );
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            // Implementación futura si la necesitas
        }
    }
}
