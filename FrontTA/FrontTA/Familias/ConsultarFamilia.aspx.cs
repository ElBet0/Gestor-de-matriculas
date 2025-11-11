using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Familias
{
    public partial class ConsultarFamilia : System.Web.UI.Page
    {
        private readonly FamiliaWSClient familiaBO = new FamiliaWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            var id = Request.QueryString["id"];
            if (string.IsNullOrWhiteSpace(id))
            {
                // si no llega id, volvemos a la búsqueda
                Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
                return;
            }

            //AÑADIR CON LA BD:
            var fam = familiaBO.obtenerFamiliaPorId(int.Parse(id));
            var hijos = familiaBO.ObtenerHijos(int.Parse(id));

            txtCodigoFamilia.Text = fam.familia_id.ToString();
            txtApePaterno.Text = fam.apellido_paterno;
            txtApeMaterno.Text = fam.apellido_materno;
            txtTelefono.Text = fam.numero_telefono;
            txtCorreo.Text = fam.correo_electronico;
            txtDireccion.Text = fam.direccion;

            if (hijos != null)
            {
                repHijos.DataSource = hijos.Select(h => h.nombre);
                repHijos.DataBind();
            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Familias/FamiliasBusqueda.aspx");
        }
    }
}