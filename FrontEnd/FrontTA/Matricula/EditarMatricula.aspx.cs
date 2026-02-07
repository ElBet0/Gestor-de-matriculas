using FrontTA.Alumnos;
using FrontTA.SisProgWS;
using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Matricula
{
    public partial class EditarMatricula : Page
    {
        private static int idMatricula;
        private static int anio2;
        private MatriculaWSClient boMatricula = new MatriculaWSClient();
        private AlumnoWSClient boAlumno = new AlumnoWSClient();
        private PeriodoXAulaWSClient boPeriodoAula = new PeriodoXAulaWSClient();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                
                int anio = DateTime.Now.Year;
                int.TryParse(Request.QueryString["anio"], out anio);
                lblAnio.Text = anio.ToString();
                ViewState["anio"] = anio;
                anio2 = anio;
                idMatricula = 0;
                int.TryParse(Request.QueryString["id"], out idMatricula);
                ViewState["idMatricula"] = idMatricula;

               
                CargarDatosDeEjemplo();

               
                var list = boAlumno.listarAlumnosTodos();
                BindingList<alumno> alumnos = new BindingList<alumno>(list);
                gvAlumnoModal.DataSource = alumnos;
                gvAlumnoModal.DataBind();

                var list2 = boMatricula.listarPeriodoXAulasParaAsignarMatriculas();
                BindingList<periodoXAula> aulas = new BindingList<periodoXAula>(list2);
                gvAulaModal.DataSource = aulas;
                gvAulaModal.DataBind();
            }

        }

        private void CargarDatosDeEjemplo()
        {
           

            matricula mat = boMatricula.obtenerMatriculaPorId(idMatricula);
            txtAlumno.Text = mat.alumno.padres.apellido_paterno + " " + mat.alumno.padres.apellido_materno + ", " +
                mat.alumno.nombre;
            hdnAlumnoId.Value = mat.alumno.alumno_id.ToString();
            txtMonto.Text = "S/. " + mat.costo_matricula;
            ddlActivo.SelectedValue = "1";
            txtAula.Text = mat.periodo_Aula.aula.nombre;
            int perAulaId = mat.periodo_Aula.periodo_aula_id;
            hdnAulaId.Value = perAulaId.ToString();

            var full = boPeriodoAula.obtenerPeriodoXAulaPorId(perAulaId);

            int capacidad = mat.periodo_Aula.vacantes_disponibles;
            int vacantesLibres = Math.Max(mat.periodo_Aula.vacantes_disponibles - mat.periodo_Aula.vacantes_ocupadas, 0);

            txtCapacidad.Text = capacidad.ToString();
            txtVacantes.Text = vacantesLibres.ToString();

        }




        protected void gvAlumnoModal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.CssClass += " data-row";

                if (e.Row.RowIndex < gvAlumnoModal.DataKeys.Count)
                {
                    var id = gvAlumnoModal.DataKeys[e.Row.RowIndex].Value.ToString();
                    e.Row.Attributes["data-id"] = id;
                }
            }
        }

        protected void btnBuscarAlumno_OnClick(object sender, EventArgs e)
        {

            var lista = boAlumno.buscarAlumnos(
                txtCodFam_Alum.Text,
                txtApePat_Alum.Text,
                txtApeMat_Alum.Text,
                txtNombre_Alum.Text,
                txtdni_Alum.Text
            );

            gvAlumnoModal.DataSource = lista;
            gvAlumnoModal.DataBind();

            
            upAlumno.Update();

           
            ScriptManager.RegisterStartupScript(
                upAlumno,                 
                upAlumno.GetType(),
                "keepFamiliaOpen",
                "setTimeout(function(){var ov=document.getElementById('ovAlumno'); if(ov){ ov.classList.add('show'); ov.setAttribute('aria-hidden','false'); }},0);",
                true
            );

        }





        protected void gvAulaModal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.CssClass += " data-row";

                if (e.Row.RowIndex < gvAulaModal.DataKeys.Count)
                {
                    
                    var id = gvAulaModal.DataKeys[e.Row.RowIndex].Value.ToString();
                    e.Row.Attributes["periodo_aula_id"] = id;
                }
            }

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string modo = "consultar";
            if (ddlActivo.SelectedValue == "0")
            {
                boMatricula.eliminarMatriculaPorId(idMatricula);
            }
            else
            {
                matricula mat = new matricula();
                mat.matricula_id = idMatricula;
                mat.alumno = new alumno { alumno_id = int.Parse(hdnAlumnoId.Value) };
                periodoXAula periodo = new periodoXAula();
                periodo.periodo_aula_id = int.Parse(hdnAulaId.Value);
                mat.periodo_Aula = periodo;
                //mat.periodo_Aula.periodo.nombre = anio2.ToString();
                mat.activo = int.Parse(ddlActivo.SelectedValue);
                boMatricula.modificarMatricula(mat);
                
            }


            Response.Redirect(ResolveUrl($"~/Matricula/BuscarMatricula.aspx?anio={anio2}&modo={modo}"));
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            string modo = "consultar";

            Response.Redirect(ResolveUrl($"~/Matricula/BuscarMatricula.aspx?anio={anio2}&modo={modo}"));
        }
    }
}
