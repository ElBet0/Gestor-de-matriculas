using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class EditarCursos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarGrados();

                
                string idStr = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int idCurso))
                {
                    CargarCursoExistente(idCurso); 
                }
                else
                {
                    
                }
            }
        }

       
        private void CargarGrados()
        {
            try
            {
                using (var ws = new GradoAcademicoWSClient())
                {
                    var lista = ws.listarGradosAcademicosTodos();

                    ddlGrado.DataSource = lista;
                    ddlGrado.DataTextField = "nombre";           // o "descripcion"
                    ddlGrado.DataValueField = "grado_academico_id";
                    ddlGrado.DataBind();

                    ddlGrado.Items.Insert(0, new ListItem("-- Seleccione --", "0"));
                }
            }
            catch (Exception ex)
            {
                System.Console.WriteLine(ex.Message);
            }
        }


        private void CargarCursoExistente(int idCurso)
        {
            try
            {
                using (var ws = new CursoWSClient())
                {
                    var curso = ws.obtenerCursoPorId(idCurso);

                    if (curso == null) return;

                    // mostrar datos en los campos
                    txtId.Text = curso.curso_id.ToString();
                    txtNombre.Text = curso.nombre;
                    txtAbreviatura.Text = curso.abreviatura;
                    txtDescripcion.Text = curso.descripcion;
                    txtHoras.Text = curso.horas_semanales.ToString();

                    // marcar grado correspondiente
                    if (curso.grado != null)
                    {
                        string idGrado = curso.grado.grado_academico_id.ToString();
                        if (ddlGrado.Items.FindByValue(idGrado) != null)
                            ddlGrado.SelectedValue = idGrado;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Console.WriteLine(ex.Message);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GestionAcademica/Cursos.aspx");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
           
            string mensajesError;
            if (!ValidarCurso(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionCursoEditar",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return;
            }

            try
            {
                
                int idCurso = int.Parse(txtId.Text);
                string nombre = txtNombre.Text.Trim();
                string abreviatura = txtAbreviatura.Text.Trim();
                string descripcion = txtDescripcion.Text.Trim();
                int horas = int.Parse(txtHoras.Text);
                int idGrado = int.Parse(ddlGrado.SelectedValue);

                // crear objeto curso
                var curso = new curso
                {
                    curso_id = idCurso,
                    nombre = nombre,
                    abreviatura = abreviatura,
                    descripcion = descripcion,
                    horas_semanales = horas
                };

                curso.grado = new gradoAcademico
                {
                    grado_academico_id = idGrado
                };

                // enviar al WS para modificar (sin cambios)
                using (var ws = new CursoWSClient())
                {
                    int resultado = ws.modificarCurso(curso);

                    if (resultado > 0)
                    {
                        var url = ResolveUrl("~/GestionAcademica/Cursos.aspx");
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "cursoEditadoOk",
                            $"alert('El curso se editó correctamente'); window.location='{url}';",
                            true
                        );
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "cursoEditadoFail",
                            "alert('El servicio devolvió 0: no se modificó ningún curso.');",
                            true
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                System.Console.WriteLine(ex.Message);
                string msg = ("No se pudo actualizar el curso: " + ex.Message)
                             .Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "cursoEditarError",
                    $"alert('{msg}');",
                    true
                );
            }
        }

        
        private bool ValidarCurso(out string mensajes)
        {
            var errores = new List<string>();

            string nombre = (txtNombre.Text ?? "").Trim();
            string abreviatura = (txtAbreviatura.Text ?? "").Trim();
            string descripcion = (txtDescripcion.Text ?? "").Trim();
            string horasTxt = (txtHoras.Text ?? "").Trim();
            string gradoSel = ddlGrado.SelectedValue;

            // Abreviatura: 
            if (string.IsNullOrWhiteSpace(abreviatura))
            {
                errores.Add("La abreviatura es obligatoria.");
            }
            else if (abreviatura.Length > 4)
            {
                errores.Add("La longitud de la abreviatura no es válida (máx. 4 caracteres).");
            }

            // Nombre: 
            if (string.IsNullOrWhiteSpace(nombre))
            {
                errores.Add("El nombre del curso es obligatorio.");
            }
            else if (nombre.Length > 12)
            {
                errores.Add("La longitud del nombre del curso no es válida (máx. 12 caracteres).");
            }

            // Descripción: 
            if (!string.IsNullOrEmpty(descripcion) && descripcion.Length > 100)
            {
                errores.Add("La longitud de la descripción no es válida (máx. 100 caracteres).");
            }

            // Grado:
            int gradoId;
            if (!int.TryParse(gradoSel, out gradoId))
            {
                errores.Add("Debe seleccionar un grado académico válido.");
            }
            else
            {
                if (gradoId == 0)
                {
                    errores.Add("Debe seleccionar un grado académico.");
                }
                else if (gradoId < 0)
                {
                    errores.Add("El grado asignado para el curso no es válido.");
                }
            }

            // Horas semanales:
            if (string.IsNullOrWhiteSpace(horasTxt))
            {
                errores.Add("Las horas semanales son obligatorias.");
            }
            else
            {
                int horas;
                if (!int.TryParse(horasTxt, out horas))
                {
                    errores.Add("Las horas semanales deben ser un número entero.");
                }
                else if (horas < 0)
                {
                    errores.Add("Las horas semanales asignadas al curso no son válidas (no pueden ser negativas).");
                }
            }

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }
    }
}
