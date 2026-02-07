using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using alumno = FrontTA.SisProgWS.alumno;
using AlumnoWSClient = FrontTA.SisProgWS.AlumnoWSClient;
using MatriculaWSClient = FrontTA.SisProgWS.MatriculaWSClient;
using periodoXAula = FrontTA.SisProgWS.periodoXAula;
using PeriodoXAulaWSClient = FrontTA.SisProgWS.PeriodoXAulaWSClient;

namespace FrontTA.Matricula
{
    public partial class CrearMatricula : Page
    {
        private readonly MatriculaWSClient boMatricula = new MatriculaWSClient();
        private readonly AlumnoWSClient boAlumno = new AlumnoWSClient();
        private readonly PeriodoXAulaWSClient boPeriodo = new PeriodoXAulaWSClient();

        private int AnioMatricula
        {
            get => (int)(ViewState["AnioMatricula"] ?? DateTime.Now.Year);
            set => ViewState["AnioMatricula"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int anio = DateTime.Now.Year;
                int.TryParse(Request.QueryString["anio"], out anio);
                AnioMatricula = anio;

                lblAnio.Text = anio.ToString();

                BindingList<alumno> alumnos = new BindingList<alumno>();

                // Lista de todos los alumnos
                var list = boAlumno.listarAlumnosTodos() ?? new alumno[0];

                // Lista de todas las matrículas
                var list3 = boMatricula.listarMatriculasTodas() ?? new matricula[0];

                // 1. Sacamos los IDs de alumnos matriculados ese año
                HashSet<int> idsMatriculados = new HashSet<int>();

                foreach (matricula mat in list3)
                {
                    if (mat.periodo_Aula.periodo.nombre == anio.ToString())
                    {
                        idsMatriculados.Add(mat.alumno.alumno_id);   // <-- importante: usar ID
                    }
                }

                // 2. Agregamos solo a los NO matriculados
                foreach (alumno al in list)
                {
                    if (!idsMatriculados.Contains(al.alumno_id))
                    {
                        alumnos.Add(al);
                    }
                }

                // 3. Mostrar en el GridView
                gvAlumnoModal.DataSource = alumnos;
                gvAlumnoModal.DataBind();
                Session["alumnosOriginales"] = alumnos;

                var list2 = boMatricula.listarPeriodoXAulasParaAsignarMatriculas() ?? new periodoXAula[0];
                BindingList<periodoXAula> aulas = new BindingList<periodoXAula>();

                foreach (periodoXAula per in list2)
                {
                    
                    periodoXAula full = boPeriodo.obtenerPeriodoXAulaPorId(per.periodo_aula_id);

                    if (full?.periodo != null && full.periodo.nombre == anio.ToString())
                        aulas.Add(full);
                }

                gvAulaModal.DataSource = aulas;
                gvAulaModal.DataBind();

                txtMonto.Text = "";
                txtPension.Text = "";
            }
        }

        protected void gvAlumnoModal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            e.Row.CssClass += " data-row";

            if (e.Row.RowIndex < gvAlumnoModal.DataKeys.Count)
            {
                var id = gvAlumnoModal.DataKeys[e.Row.RowIndex].Value.ToString();
                e.Row.Attributes["data-id"] = id;
            }
        }

        protected void gvAulaModal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            e.Row.CssClass += " data-row";

            if (e.Row.RowIndex < gvAulaModal.DataKeys.Count)
            {
                var id = gvAulaModal.DataKeys[e.Row.RowIndex].Value.ToString();
                e.Row.Attributes["data-id"] = id;
            }
        }

        protected void btnBuscarAlumno_OnClick(object sender, EventArgs e)
        {
            // 1. Recuperar la lista original (solo alumnos NO matriculados)
            var listaOriginal = Session["alumnosOriginales"] as BindingList<alumno>;
            if (listaOriginal == null)
                return;

            // 2. Obtener filtros ingresados
            string codFam = txtCodFam_Alum.Text.Trim().ToLower();
            string apePat = txtApePat_Alum.Text.Trim().ToLower();
            string apeMat = txtApeMat_Alum.Text.Trim().ToLower();
            string nombre = txtNombre_Alum.Text.Trim().ToLower();
            string dni = txtdni_Alum.Text.Trim().ToLower();

            // 3. Filtrado en memoria usando las mismas propiedades del GridView
            var filtrada = listaOriginal
                .Where(a =>
                    // CÃ³digo de familia
                    (string.IsNullOrWhiteSpace(codFam) ||
                        (a.padres?.familia_id.ToString() ?? "")
                            .Contains(codFam))

                    // Apellido paterno
                    && (string.IsNullOrWhiteSpace(apePat) ||
                        (a.padres?.apellido_paterno ?? "")
                            .ToLower()
                            .Contains(apePat))

                    // Apellido materno
                    && (string.IsNullOrWhiteSpace(apeMat) ||
                        (a.padres?.apellido_materno ?? "")
                            .ToLower()
                            .Contains(apeMat))

                    // Nombre
                    && (string.IsNullOrWhiteSpace(nombre) ||
                        (a.nombre ?? "")
                            .ToLower()
                            .Contains(nombre))

                    // DNI
                    && (string.IsNullOrWhiteSpace(dni) ||
                        (a.dni.ToString() ?? "")
                            .Contains(dni))
                )
                .ToList();

            // 4. Cargar resultado en el GridView
            gvAlumnoModal.DataSource = filtrada;
            gvAlumnoModal.DataBind();

            // 5. Mantener abierto el modal
            upAlumno.Update();
            ScriptManager.RegisterStartupScript(
                upAlumno,
                upAlumno.GetType(),
                "keepAlumnoOpen",
                "setTimeout(function(){var ov=document.getElementById('ovAlumno'); if(ov){ ov.classList.add('show'); ov.setAttribute('aria-hidden','false'); }},0);",
                true
            );
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            try
            {
                int alumnoId = 0;
                int aulaId = 0;

                double costo_matricula, costo_pension;
               
                Double.TryParse(txtMonto.Text, out costo_matricula);
                Double.TryParse(txtPension.Text, out costo_pension);

                int.TryParse(hdnAlumnoId.Value, out alumnoId);
                int.TryParse(hdnAulaId.Value, out aulaId);

                if (alumnoId <= 0 || aulaId <= 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "err",
                        "alert('Seleccione un alumno y un aula.');", true);
                    return;
                }

                if (costo_matricula <= 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "err",
                        "alert('Debe ingresar un costo de matricula valida.');", true);
                    return;
                }

                if (costo_pension <= 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "err",
                        "alert('Debe ingresar una pensión valida.');", true);
                    return;
                }

                int periodoAulaId = boMatricula.registrarMatriculaConVacantes(alumnoId, aulaId, costo_matricula, costo_pension);

                if (periodoAulaId > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ok",
                        "alert('Matrícula registrada correctamente.');", true);

                    Response.Redirect($"~/Matricula/BuscarMatricula.aspx?anio={DateTime.Now.Year}&modo=agregar", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "err",
                        "alert('No se pudo registrar la matrícula o no hay vacantes disponibles.');", true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error Crear Matricula: " + ex.Message);
                ScriptManager.RegisterStartupScript(this, GetType(), "err",
                    "alert('Ocurrió un error al registrar la matrícula.');", true);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            string modo = (AnioMatricula == DateTime.Now.Year) ? "agregar" : "consultar";
            Response.Redirect(ResolveUrl($"~/Matricula/BuscarMatricula.aspx?anio={AnioMatricula}&modo={modo}"));
        }
    }
}
