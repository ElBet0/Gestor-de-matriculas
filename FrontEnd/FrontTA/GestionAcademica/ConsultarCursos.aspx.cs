using FrontTA.SisProgWS;   // proxy del WS de grados (para mostrar el nombre del grado)
using System;
using System.Web.UI;

namespace FrontTA.GestionAcademica
{
    public partial class ConsultarCursos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
                string idStr = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int idCurso))
                {
                    CargarCursoDesdeWS(idCurso);
                }

            }
        }

        
        private void CargarCursoDesdeWS(int idCurso)
        {
            try
            {
                using (var wsCurso = new CursoWSClient())
                {
                    curso curso = wsCurso.obtenerCursoPorId(idCurso);



                    
                    txtId.Text = curso.curso_id.ToString();
                    txtNombre.Text = curso.nombre;
                    txtAbreviatura.Text = curso.abreviatura;
                    txtHoras.Text = curso.horas_semanales.ToString();
                    txtDescripcion.Text = curso.descripcion;

                    
                    txtGrado.Text = curso.grado.nombre;
                }
            }
            catch (Exception ex)
            {
                System.Console.WriteLine(ex.Message);
            }
        }

        

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GestionAcademica/Cursos.aspx");
        }
    }
}
