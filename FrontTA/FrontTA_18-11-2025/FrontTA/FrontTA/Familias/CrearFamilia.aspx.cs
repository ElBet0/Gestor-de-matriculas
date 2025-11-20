using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace FrontTA.Familias
{
    public partial class CrearFamilia : System.Web.UI.Page
    {
        private readonly FamiliaWSClient boFamilia = new FamiliaWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Si quieres inicializar algo, aquí
                // txtCodigoFamilia.Text = "";  // por ejemplo
            }
        }

        // ========= BOTÓN ✔ CONFIRMAR =========
        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            string mensajesError;
            if (!ValidarFamilia(out mensajesError))
            {
                // Mostrar todos los errores en un solo alert
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionFamilia",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );

                return; // no seguimos
            }

            // Si todo OK, armar objeto y llamar al WS
            var fam = new familia
            {
                apellido_paterno = txtApePaterno.Text.Trim(),
                apellido_materno = txtApeMaterno.Text.Trim(),
                numero_telefono = txtTelefono.Text.Trim(),
                correo_electronico = txtCorreo.Text.Trim(),
                direccion = txtDireccion.Text.Trim()
            };

            try
            {
                boFamilia.insertarFamilia(fam);

                var url = ResolveUrl("~/Familias/FamiliasBusqueda.aspx");

                // Mensaje + redirección desde JavaScript
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "familiaOk",
                    $"alert('Se creó correctamente la Familia'); window.location='{url}';",
                    true
                );
            }
            catch (Exception ex)
            {
                string msg = ("No se pudo crear la familia: " + ex.Message)
                             .Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "familiaError",
                    $"alert('{msg}');",
                    true
                );
            }

        }

        // ========= BOTÓN ✖ CANCELAR =========
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Solo volver al listado
            Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
        }

        // ========= VALIDACIÓN SOLO EN C# =========
        private bool ValidarFamilia(out string mensajes)
        {
            var errores = new List<string>();

            // Requeridos
            if (string.IsNullOrWhiteSpace(txtApePaterno.Text))
                errores.Add("El apellido paterno es obligatorio.");

            if (string.IsNullOrWhiteSpace(txtApeMaterno.Text))
                errores.Add("El apellido materno es obligatorio.");

            if (string.IsNullOrWhiteSpace(txtTelefono.Text))
                errores.Add("El número de teléfono es obligatorio.");

            if (string.IsNullOrWhiteSpace(txtCorreo.Text))
                errores.Add("El correo electrónico es obligatorio.");

            if (string.IsNullOrWhiteSpace(txtDireccion.Text))
                errores.Add("La dirección es obligatoria.");

            // Longitudes (las mismas que en Java)
            if ((txtApePaterno.Text ?? "").Trim().Length > 15)
                errores.Add("La longitud del apellido paterno no es válida (máx. 15 caracteres).");

            if ((txtApeMaterno.Text ?? "").Trim().Length > 15)
                errores.Add("La longitud del apellido materno no es válida (máx. 15 caracteres).");

            if ((txtTelefono.Text ?? "").Trim().Length > 12)
                errores.Add("La longitud del número de teléfono no es válida (máx. 12 dígitos).");

            if ((txtCorreo.Text ?? "").Trim().Length > 35)
                errores.Add("La longitud del correo electrónico no es válida (máx. 35 caracteres).");

            if ((txtDireccion.Text ?? "").Trim().Length > 100)
                errores.Add("La longitud de la dirección no es válida (máx. 100 caracteres).");

            // Tipos de dato
            if (!string.IsNullOrWhiteSpace(txtTelefono.Text) &&
                !txtTelefono.Text.All(char.IsDigit))
            {
                errores.Add("El número de teléfono solo debe contener dígitos.");
            }

            if (!string.IsNullOrWhiteSpace(txtCorreo.Text) &&
                (!txtCorreo.Text.Contains("@") || !txtCorreo.Text.Contains(".")))
            {
                errores.Add("El correo electrónico no tiene un formato válido.");
            }

            // Unimos todo para el alert
            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }
    }
}
