using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace FrontTA.Familias
{
    public partial class EditarFamilia : System.Web.UI.Page
    {
        private readonly FamiliaWSClient familiaBO = new FamiliaWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var id = Request.QueryString["id"];
            if (string.IsNullOrWhiteSpace(id))
            {
              
                Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
                return;
            }

            var fam = familiaBO.obtenerFamiliaPorId(int.Parse(id));
            if (fam == null)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "familiaNoEncontrada",
                    "alert('No se encontró la familia indicada.');",
                    true
                );
                Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
                return;
            }

            txtCodigoFamilia.Text = fam.familia_id.ToString();
            txtApePaterno.Text = fam.apellido_paterno;
            txtApeMaterno.Text = fam.apellido_materno;
            txtTelefono.Text = fam.numero_telefono;
            txtCorreo.Text = fam.correo_electronico;
            txtDireccion.Text = fam.direccion;
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            string mensajesError;
            if (!ValidarFamilia(out mensajesError))
            {
              
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionFamiliaEdit",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return;
            }

            var fam = new familia
            {
                familia_id = int.Parse(txtCodigoFamilia.Text),
                apellido_paterno = txtApePaterno.Text.Trim(),
                apellido_materno = txtApeMaterno.Text.Trim(),
                numero_telefono = txtTelefono.Text.Trim(),
                correo_electronico = txtCorreo.Text.Trim(),
                direccion = txtDireccion.Text.Trim()
            };


            try
            {
                familiaBO.modificarFamilia(fam);

                var url = ResolveUrl("~/Familias/FamiliasBusqueda.aspx");

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "familiaEditOk",
                    $"alert('La familia se editó correctamente.'); window.location='{url}';",
                    true
                );


            }
            catch (Exception ex)
            {
                string msg = ("No se pudo actualizar la familia: " + ex.Message)
                             .Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "familiaEditError",
                    $"alert('{msg}');",
                    true
                );
            }

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
        }


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

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }
    }
}
