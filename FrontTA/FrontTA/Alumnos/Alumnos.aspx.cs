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

        }

        protected void btnDoDelete_Click(object sender, EventArgs e)
        {
            // Asegúrate de exponer un método equivalente en tu WS
            boAlumno.eliminarAlumnoPorId(int.Parse(idAlumnoDelete.Value));
            Response.Redirect("~/Alumnos/Alumnos.aspx");
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
    }
}