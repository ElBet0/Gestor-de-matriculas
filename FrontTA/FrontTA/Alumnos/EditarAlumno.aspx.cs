using FrontTA.SisProgWS;
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
        private readonly AlumnoWSClient boAlumno = new AlumnoWSClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var id = Request.QueryString["id"];

            if (string.IsNullOrWhiteSpace(id))
            {
                // si no llega id, volvemos a la búsqueda
                Response.Redirect("~/Alumnos/Alumnos.aspx");
                return;
            }

            var al = boAlumno.obtenerAlumnoPorId(int.Parse(id));

            txtCodigoFamilia.Text = al.padres.familia_id.ToString();
            txtNombre.Text = al.nombre;
            txtDNI.Text = al.dni.ToString();
            txtFechaIngreso.Text = al.fecha_ingreso.ToString();
            txtFechaNacimiento.Text = al.fecha_nacimiento.ToString();
            txtReligion.Text = al.religion.ToString();
            ddlGenero.Text = char.ConvertFromUtf32(al.sexo) == "M" ? "Masculino" : "Femenino";
            txtPension.Text = al.pension_base.ToString();


            btnConfirmar.Text = "<i class='fa-solid fa-check'></i>";
            btnCancelar.Text = "<i class='fa-solid fa-xmark'></i>";
            btnConfirmar.CausesValidation = false; // opcional
            btnCancelar.CausesValidation = false; // opcional
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Volver sin cambios
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            alumno al = new alumno();

            al.padres = new familia();
            al.padres.familia_id = int.Parse(txtCodigoFamilia.Text.Split(',').ElementAt(0));
            al.nombre = txtNombre.Text;
            al.dni = int.Parse(txtDNI.Text);
            al.fecha_ingreso = DateTime.Parse(txtFechaIngreso.Text);
            al.fecha_nacimiento = DateTime.Parse(txtFechaNacimiento.Text);
            al.religion = txtReligion.Text;
            al.sexo = ddlGenero.Text.ElementAt(0);
            al.pension_base = double.Parse(txtPension.Text);
            al.observaciones = txtObservaciones.Text;

            boAlumno.insertarAlumno(al);

            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }
    }
}