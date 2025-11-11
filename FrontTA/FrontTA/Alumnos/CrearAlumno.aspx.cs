using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FrontTA.Familias;
using FrontTA.SisProgWS;

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
                // Inicializaciones si hiciera falta
                // txtCodigoFamilia.Text = ""; // ya está vacío y ReadOnly desde el .aspx
                btnConfirmar.Text = "<i class='fa-solid fa-check'></i>";
                btnCancelar.Text = "<i class='fa-solid fa-xmark'></i>";
                btnConfirmar.CausesValidation = false; // opcional
                btnCancelar.CausesValidation = false; // opcional
            }

            reFamilias.DataSource = boFamilia.listarFamiliasTodas();
            reFamilias.DataBind();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Para todo aquel que lea esto, al parecer el modal de selección de la familia también esta enlazado a este boton
            // que alusinante es chatgpt algunas veces no?
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // Mismo caso aca, ya ustedes lo arreglan, además, le quite el solo leer del codigo de familia :)
            alumno al = new alumno();
            familia papa = new familia();

            papa.familia_id = int.Parse(txtCodigoFamilia.Text);

            al.padres = papa;

            al.nombre = txtNombre.Text;
            al.dni = int.Parse(txtDNI.Text);

            al.fecha_ingreso = new DateTime();
            al.fecha_nacimiento = new DateTime();

            //No funcionan las fechas, nidea por que, falta ver clases de paz
            al.fecha_ingreso = DateTime.Parse(txtFechaIngreso.Text);
            al.fecha_nacimiento = DateTime.Parse(txtFechaNacimiento.Text);
            al.religion = txtReligion.Text;

            al.sexo = ddlGenero.SelectedValue.ElementAt(0);
            al.pension_base = double.Parse(txtPension.Text);

            al.observaciones = txtObservaciones.Text;

            boAlumno.insertarAlumno(al);
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            //no se como implementaran esto, ya que recarga la pagina. Suerte
        }


    }
}