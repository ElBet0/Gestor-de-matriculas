using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Alumnos
{
    public partial class EditarAlumno : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Inicializaciones si hiciera falta
                // txtCodigoFamilia.Text = ""; // ya está vacío y ReadOnly desde el .aspx
                btnConfirmar.Text = "<i class='fa-solid fa-check'></i>";
                btnCancelar.Text = "<i class='fa-solid fa-xmark'></i>";
                btnConfirmar.CausesValidation = false; // opcional
                btnCancelar.CausesValidation = false; // opcional
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Volver sin cambios
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // 1) Leer valores
            //var apePat = txtApePaterno.Text.Trim();
            //var apeMat = txtApeMaterno.Text.Trim();
            //var telefono = txtTelefono.Text.Trim();
            //var correo = txtCorreo.Text.Trim();
            //var direccion = txtDireccion.Text.Trim();

            // 2) TODO: Insertar en BD con tu capa BO/DAO y obtener el nuevo código
            // string nuevoCodigo = familiaBO.Crear(apePat, apeMat, telefono, correo, direccion);

            // 3) Volver a la búsqueda (puedes pasar el código creado para notificar/refrescar)
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }
    }
}