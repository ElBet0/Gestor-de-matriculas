using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class EditarAula : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Cargar combos (mock); al integrar BD

                // Tomar id desde la lista


                // Cargar datos de ejemplo (simula fetch a BD)

                //// Forzar campos bloqueados
                txtCodigoAula.ReadOnly = true;
                txtVacantes.ReadOnly = true;
            }
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            //  Validaciones y update en BD.
        

            // Ejemplo: guardar cambios vía capa de aplicación/DAO
            // AulaService.Actualizar(new AulaDto { ... });

            // Al finalizar, regresar a la lista
            Response.Redirect(ResolveUrl("~/GestionAcademica/Aula.aspx"));
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Descartar cambios y volver
            Response.Redirect(ResolveUrl("~/GestionAcademica/Aula.aspx"));
        }
    }
}