using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class ConsultarPersonal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Si vienes con ?id=..., carga los datos
                // var id = Request.QueryString["id"];
                // Consulta a BD
                // txtId.Text = id;
                // txtNombre.Text = ...; txtApePaterno.Text = ...; txtApeMaterno.Text = ...;
                // txtTelefono.Text = ...; txtEmail.Text = ...; txtSueldo.Text = ...;
                // txtFechaInicio.Text = fechaInicio?.ToString("yyyy-MM-dd");
                // txtFechaFin.Text = fechaFin?.ToString("yyyy-MM-dd");
                // ddlTipoContrato.SelectedValue = ...;
            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GestionAcademica/Personal.aspx");
        }
    }
}