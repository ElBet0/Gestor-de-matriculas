using FrontTA.SisProgWS;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Alumnos
{
    public partial class ConsultarAlumno : System.Web.UI.Page
    {
        private readonly AlumnoWSClient boAlumno = new AlumnoWSClient();
        class AcademicoInfo {
           
            public string Anho { get; set; }
            public string GradoAcademico { get; set; }
            public string Aula { get; set; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var id = Request.QueryString["id"];

            if (string.IsNullOrWhiteSpace(id))
            {
                
                Response.Redirect("~/Alumnos/Alumnos.aspx");
                return;
            }

            if (!IsPostBack)
            {
               
                btnCancelar.CausesValidation = false; 
            }
    

            var al = boAlumno.obtenerAlumnoPorId(int.Parse(id));

            txtCodigoFamilia.Text = al.padres.familia_id.ToString()
                + ", " + al.padres.apellido_paterno + " " + al.padres.apellido_materno;
            txtNombre.Text = al.nombre;
            txtDNI.Text = al.dni.ToString();
            txtFechaIngreso.Text = al.fecha_ingreso.ToString();
            txtFechaNacimiento.Text = al.fecha_nacimiento.ToString();
            if (al.religion != null)
            {
                txtReligion.Text = al.religion.ToString();
            }
            
            txtGenero.Text = char.ConvertFromUtf32(al.sexo);
            txtPension.Text = al.pension_base.ToString();
            txtNombreModal.Text = al.nombre + ", " + al.padres.apellido_paterno + " " + al.padres.apellido_materno;

            var mat = boAlumno.consultarMatriculas(int.Parse(id));

            List<AcademicoInfo> infos = new List<AcademicoInfo>();

            if (mat != null) {
                foreach (var m in mat) {
                    infos.Add(new AcademicoInfo { 
                        Anho = m.periodo_Aula.periodo.nombre, 
                        Aula = m.periodo_Aula.aula.nombre, 
                        GradoAcademico = m.periodo_Aula.aula.grado.nombre 
                    }
                    );
                }
            }

            repGrados.DataSource = infos;
            repGrados.DataBind();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Volver sin cambios
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }
    }
}