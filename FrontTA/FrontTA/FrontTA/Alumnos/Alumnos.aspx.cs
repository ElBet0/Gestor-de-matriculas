using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Alumnos
{
    public partial class Alumnos : System.Web.UI.Page
    {
        private readonly AlumnoWSClient boAlumno = new AlumnoWSClient();
        private readonly FamiliaWSClient boFamilia = new FamiliaWSClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                btnConfirmar.CausesValidation = false; // opcional

            }
            
            if (!IsPostBack)
            {

                gvAlumnos.DataSource = boAlumno.listarAlumnosTodos();
                gvAlumnos.DataBind();

                string apePat = txtApePaternoModal.Text;
                string apeMat = txtApeMaternoModal.Text;

                string familiaId = txtCodigoFamilia.Text;
                string dni = txtDNI.Text;

                var lista = boAlumno.buscarAlumnos(
                familiaId,
                apePat,
                apeMat,
                null,   // nombre en modal (si no lo usas aquí)
                   dni
                );

                reFamilias.DataSource = lista;
                reFamilias.DataBind();

            }

            var evtTarget = Request["__EVENTTARGET"];
            if (!string.IsNullOrEmpty(evtTarget) && evtTarget == btnBuscarModal.UniqueID)
            {
                // Abrir el modal en la carga de la página (postback completo)
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "reOpenFamilia",
                    "var ov=document.getElementById('ovFamilia'); if(ov){ ov.classList.add('show'); ov.setAttribute('aria-hidden','false'); }",
                    true
                );
            }


        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Alumnos/Alumnos.aspx");
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {




            gvAlumnos.DataSource = boAlumno.buscarAlumnos(
                txtCodigoFamilia.Text,
                txtApellidoPaterno.Text,
                txtApellidoMaterno.Text,
                txtNombre.Text,
                txtDNI.Text
                );
            gvAlumnos.DataBind();
        }
        protected void btnBuscar_Click2(object sender, EventArgs e)
        {

            string apePat = txtApePaternoModal.Text?.Trim();
            string apeMat = txtApeMaternoModal.Text?.Trim();

            var lista = boAlumno.buscarAlumnos(
                "",     // familia (no filtra)
                apePat, // ape. paterno
                apeMat, // ape. materno
                "",     // nombre (no filtra)
                ""      // dni (no filtra)
            );

            reFamilias.DataSource = lista;
            reFamilias.DataBind();

            // Forzar que el UpdatePanel pinte el DOM nuevo
            upFamilia.Update();

            // Mantener el modal abierto DESDE el UpdatePanel (clave)
            ScriptManager.RegisterStartupScript(
                upFamilia,                 // <<— destino: el panel actualizado
                upFamilia.GetType(),
                "keepFamiliaOpen",
                "setTimeout(function(){var ov=document.getElementById('ovFamilia'); if(ov){ ov.classList.add('show'); ov.setAttribute('aria-hidden','false'); }},0);",
                true
            );

        }

        protected void btnDoDelete_Click(object sender, EventArgs e)
        {
            if (int.TryParse(idAlumnoDelete.Value, out int id))
            {
                boAlumno.eliminarAlumnoPorId(id);
            }
            Response.Redirect("~/Alumnos/Alumnos.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }


        protected void gvAlumnos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
                e.Row.CssClass = "table-header";
                return;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string codigo = DataBinder.Eval(e.Row.DataItem, "alumno_id").ToString() as string;
                e.Row.Attributes["data-id"] = codigo;
                e.Row.CssClass = (e.Row.CssClass + " data-row").Trim();
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }


        protected void gvAlumnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAlumnos.PageIndex = e.NewPageIndex;
            gvAlumnos.DataSource = boAlumno.listarAlumnosTodos();
            gvAlumnos.DataBind();
        }

    }
}