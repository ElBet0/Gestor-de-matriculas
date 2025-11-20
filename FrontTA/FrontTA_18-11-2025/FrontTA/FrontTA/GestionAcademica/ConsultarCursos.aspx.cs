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
                // 1️⃣ Obtenemos el id desde la URL (redirigido desde la grilla)
                string idStr = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int idCurso))
                {
                    CargarCursoDesdeWS(idCurso);
                }

            }
        }

        // 🔹 Carga de información del curso desde el WS
        private void CargarCursoDesdeWS(int idCurso)
        {
            try
            {
                using (var wsCurso = new CursoWSClient())
                {
                    curso curso = wsCurso.obtenerCursoPorId(idCurso);



                    // Asignamos los valores a los controles
                    txtId.Text = curso.curso_id.ToString();
                    txtNombre.Text = curso.nombre;
                    txtAbreviatura.Text = curso.abreviatura;
                    txtHoras.Text = curso.horas_semanales.ToString();
                    txtDescripcion.Text = curso.descripcion;

                    // Cargar el grado correspondiente
                    txtGrado.Text = curso.grado.nombre;
                }
            }
            catch (Exception ex)
            {
                System.Console.WriteLine(ex.Message);
            }
        }

        // 🔹 Carga de grados académicos desde el WS y selecciona el grado actual


        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GestionAcademica/Cursos.aspx");
        }
    }
}
