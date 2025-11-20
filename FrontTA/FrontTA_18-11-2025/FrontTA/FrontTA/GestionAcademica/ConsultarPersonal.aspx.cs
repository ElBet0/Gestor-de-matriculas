using FrontTA.SisProgWS;
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
                if (Request.QueryString["id"] != null)
                {
                    int personalId = int.Parse(Request.QueryString["id"]);
                    PersonalWSClient boPersonal = new PersonalWSClient();
                    personal p = boPersonal.obtenerPersonalPorId(personalId);

                    if (p != null)
                    {
                        txtId.Text = p.personal_id.ToString();
                        txtDni.Text = p.dni.ToString();
                        txtNombre.Text = p.nombre;
                        txtApePaterno.Text = p.apellido_paterno;
                        txtApeMaterno.Text = p.apellido_materno;
                        txtEmail.Text = p.correo_electronico;
                        txtTelefono.Text = p.telefono;
                        txtSueldo.Text = p.salario.ToString();
                        txtFechaInicio.Text = p.fecha_Contratacion.ToString("yyyy-MM-dd");
                        txtFechaFin.Text = p.fin_fecha_Contratacion.ToString("yyyy-MM-dd");
                        txtTipoContrato.Text = p.tipo_contrato.ToString();
                        txtCargo.Text = p.cargo.nombre;   // muestra el nombre del cargo
                        hfCargoId.Value = p.cargo.cargo_id.ToString(); // guarda el ID para editar
                    }
                }
            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GestionAcademica/Personal.aspx");
        }
    }
}