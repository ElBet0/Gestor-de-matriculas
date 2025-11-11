using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Familias
{
    public partial class CrearFamilia : System.Web.UI.Page
    {
        private readonly FamiliaWSClient boFamilia = new FamiliaWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Inicializaciones si hiciera falta
                // txtCodigoFamilia.Text = ""; 
                btnConfirmar.Text = "<i class='fa-solid fa-check'></i>";
                btnCancelar.Text = "<i class='fa-solid fa-xmark'></i>";
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Volver sin cambios
            Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // 1) Leer valores
            var fam = new familia();

            fam.apellido_paterno = txtApePaterno.Text.Trim();
            fam.apellido_materno = txtApeMaterno.Text.Trim();
            fam.numero_telefono = txtTelefono.Text.Trim();
            fam.correo_electronico = txtCorreo.Text.Trim();
            fam.direccion = txtDireccion.Text.Trim();

            // 2) Enviar a FamiliaWS la nueva familia
            boFamilia.insertarFamilia(fam);

            // 3) Volver a la búsqueda
            Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
        }
    }
}