using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                // Si no llega id, volvemos a la búsqueda
                Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
                return;
            }

            //AÑADIR CON LA BD:
            var fam = familiaBO.obtenerFamiliaPorId(int.Parse(id));

            txtCodigoFamilia.Text = fam.familia_id.ToString();
            txtApePaterno.Text = fam.apellido_paterno;
            txtApeMaterno.Text = fam.apellido_materno;
            txtTelefono.Text = fam.numero_telefono;
            txtCorreo.Text = fam.correo_electronico;
            txtDireccion.Text = fam.direccion;
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            familia fam = new familia();

            fam.familia_id = int.Parse(txtCodigoFamilia.Text);
            fam.apellido_paterno = txtApePaterno.Text;
            fam.apellido_materno = txtApeMaterno.Text;
            fam.numero_telefono = txtTelefono.Text;
            fam.correo_electronico = txtCorreo.Text;
            fam.direccion = txtDireccion.Text;

            familiaBO.modificarFamilia(fam);

            Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
        }
    }
}