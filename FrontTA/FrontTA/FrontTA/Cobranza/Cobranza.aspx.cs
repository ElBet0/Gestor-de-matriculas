using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.Cobranza
{
    public partial class Cobranza : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDeudas();
            }
        }



        private void CargarDeudas()
        {
            var lista = new List<dynamic>
            {
                new { Id=1, Alumno="Joaquin", TipoDeuda="Matrícula", MontoDeuda=100, Pagado=0, Saldo=100,
                      FechaEmision=DateTime.Parse("2025-03-03"), FechaVencimiento=DateTime.Parse("2025-04-03"),
                      Descuento=0, Activo="Vigente"}
            };

            repDeudas.DataSource = lista;
            repDeudas.DataBind();
        }



        protected void btnBuscar_Click(object sender, EventArgs e)
        {

        }

        protected void btnConfirmarFamilia_Click(object sender, EventArgs e)
        {

            txtCodigoFamilia.Text = "105502";
            txtApePaterno.Text = "Hinojosa";
            txtApeMaterno.Text = "Chavez";
        }

        protected void btnDoDelete_Click(object sender, EventArgs e)
        {
            // TODO: aquí borras la deuda seleccionada en BD.
            // Si todavía no pasas el Id al servidor, por ahora simplemente recarga.

            // Opción 1: recargar la misma página (cierra el overlay por ser nueva petición)
            Response.Redirect(Request.RawUrl, false);
            Context.ApplicationInstance.CompleteRequest();

            // Opción 2: si prefieres sólo rebind sin redirigir (POST completo), descomenta:
            // CargarDeudas();
            // ClientScript.RegisterStartupScript(GetType(), "cerrarOv",
            //     "var ov=document.getElementById('ovEliminar'); if(ov){ov.classList.remove('show');ov.setAttribute('aria-hidden','true');}",
            //     true);
        }


    }
}