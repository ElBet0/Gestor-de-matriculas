using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FrontTA.SisProgWS;

namespace FrontTA.Matricula
{
    public partial class VisualizarReporteMatriculasPeriodo : System.Web.UI.Page
    {
        private ReportesWSClient boReporte;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                MostrarReporte();
        }

        private void MostrarReporte()
        {
            boReporte = new ReportesWSClient();
            byte[] reporte = null;
            int idPeriodo = (int)(Session["idPeriodoReporte"] ?? 0);
            string nombrePeriodo=null;
            nombrePeriodo = (string)(Session["nombrePeriodoReporte"]);

            reporte = boReporte.generarReporteMatriculasPeriodo(idPeriodo,nombrePeriodo);

            if (reporte == null || reporte.Length == 0)
            {
                Response.Write("Reporte vacío.");
                return;
            }

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "inline; filename=ReporteMatriculasPeriodo.pdf");
            Response.OutputStream.Write(reporte, 0, reporte.Length);
            Response.Flush();
          
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
    }
}