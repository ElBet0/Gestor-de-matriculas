using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace FrontTA.GestionAcademica
{
    public partial class CrearCursos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarGrados();
            }
        }

        private void CargarGrados()
        {
            try
            {
                using (var ws = new GradoAcademicoWSClient()) // proxy SOAP generado
                {
                    var lista = ws.listarGradosAcademicosTodos();

                    ddlGrado.DataSource = lista;
                    ddlGrado.DataTextField = "nombre"; // o "Descripcion"
                    ddlGrado.DataValueField = "grado_academico_id"; // el campo ID real
                    ddlGrado.DataBind();

                    ddlGrado.Items.Insert(0,
                        new System.Web.UI.WebControls.ListItem("-- Seleccione --", "0"));
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar grados: " + ex.Message);
                ddlGrado.Items.Clear();
                ddlGrado.Items.Insert(0,
                    new System.Web.UI.WebControls.ListItem("(Error al cargar)", "0"));
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GestionAcademica/Cursos.aspx");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // ✅ PRIMERO: Validar según las reglas del backend Java
            string mensajesError;
            if (!ValidarCurso(out mensajesError))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionCurso",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return; // No seguimos si hay errores
            }

            try
            {
                // 1️⃣ Leer valores del formulario (igual que en tu versión original)
                string nombre = txtNombre.Text.Trim();
                string abreviatura = txtAbreviatura.Text.Trim();
                string descripcion = txtDescripcion.Text.Trim();
                int horas = int.Parse(txtHoras.Text);
                int idGrado = int.Parse(ddlGrado.SelectedValue);

                // 2️⃣ Crear objeto Curso (mismo tipo que en el WS)
                curso curso = new curso();
                curso.abreviatura = abreviatura;
                curso.nombre = nombre;
                curso.descripcion = descripcion;
                curso.horas_semanales = horas;

                gradoAcademico grado = new gradoAcademico();
                grado.grado_academico_id = idGrado;
                curso.grado = grado;

                // 3️⃣ Llamar al servicio web (sin cambios)
                using (CursoWSClient ws = new CursoWSClient())
                {
                    int resultado = ws.insertarCurso(curso);

                    if (resultado > 0)
                    {
                        var url = ResolveUrl("~/GestionAcademica/Cursos.aspx");
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "cursoCreadoOk",
                            $"alert('El curso se creó correctamente'); window.location='{url}';",
                            true
                        );
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "cursoCreadoFail",
                            "alert('El servicio devolvió 0: no se insertó ningún curso.');",
                            true
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                System.Console.WriteLine("Error: " + ex.Message);
                string msg = ("No se pudo crear el curso: " + ex.Message)
                             .Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "cursoError",
                    $"alert('{msg}');",
                    true
                );
            }
        }

        // ========= VALIDACIÓN SOLO EN C# =========
        // Replica la lógica de tu método Java validar(Curso):
        //  if(abreviatura.length > 10) -> error
        //  if(!descripcion.isEmpty() && descripcion.length > 100) -> error
        //  if(nombre.length > 45) -> error
        //  if(grado_id < 0) -> error
        //  if(horas_semanales < 0) -> error
        private bool ValidarCurso(out string mensajes)
        {
            var errores = new List<string>();

            string nombre = (txtNombre.Text ?? "").Trim();
            string abreviatura = (txtAbreviatura.Text ?? "").Trim();
            string descripcion = (txtDescripcion.Text ?? "").Trim();
            string horasTxt = (txtHoras.Text ?? "").Trim();
            string gradoSel = ddlGrado.SelectedValue;

            // Abreviatura: obligatoria + máx 10
            if (string.IsNullOrWhiteSpace(abreviatura))
            {
                errores.Add("La abreviatura es obligatoria.");
            }
            else if (abreviatura.Length > 3)
            {
                errores.Add("La longitud de la abreviatura no es válida (máx. 3 caracteres).");
            }

            // Nombre: obligatorio + máx 45
            if (string.IsNullOrWhiteSpace(nombre))
            {
                errores.Add("El nombre del curso es obligatorio.");
            }
            else if (nombre.Length > 12)
            {
                errores.Add("La longitud del nombre del curso no es válida (máx. 12 caracteres).");
            }

            // Descripción: opcional, pero si viene >100 => error
            if (!string.IsNullOrEmpty(descripcion) && descripcion.Length > 100)
            {
                errores.Add("La longitud de la descripción no es válida (máx. 100 caracteres).");
            }

            // Grado: en Java solo se valida <0, pero aquí además 0 = "no seleccionado"
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

            // Horas semanales: obligatorio, entero, >= 0
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
