using FrontTA.SisProgWS;
using System;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class Personal : Page
    {
        private const string VS_SORT_EXPR = "PER_SORT_EXPR";
        private const string VS_SORT_DIR = "PER_SORT_DIR";

        private PersonalWSClient boPersonal;
        private BindingList<personal> listPersonal;

        protected void Page_Load(object sender, EventArgs e)
        {
            boPersonal = new PersonalWSClient();

            if (!IsPostBack)
            {
                CargarPersonal();
            }
        }

        private void CargarPersonal()
        {
            try
            {
                listPersonal = new BindingList<personal>(boPersonal.listarPersonalTodos());
                gvPersonal.DataSource = listPersonal;
                gvPersonal.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al cargar el personal: " + ex.Message);
            }
        }

        // === GRID EVENTS ===
        protected void gvPersonal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
                e.Row.CssClass = "table-header";
                return;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string id = DataBinder.Eval(e.Row.DataItem, "personal_id")?.ToString();
                e.Row.Attributes["data-id"] = id;
                e.Row.CssClass = (e.Row.CssClass + " data-row").Trim();
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }

        protected void gvPersonal_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPersonal.PageIndex = e.NewPageIndex;
            gvPersonal.DataSource = Session["personal"] as BindingList<personal>;
            gvPersonal.DataBind();
        }



        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                gvPersonal.PageIndex = 0;

                int dni = 0;
                if (!string.IsNullOrWhiteSpace(txtDni.Text))
                    int.TryParse(txtDni.Text, out dni);

                // Junta nombre + apellidos como un solo texto (sin errores de null)
                string nombreApellidos = $"{txtNombre.Text} {txtApePat.Text} {txtApeMat.Text}".Trim();

                // Llamada al servicio SOAP
                var resultado = boPersonal.listarPersonalPorDniONombreApellidos(dni, nombreApellidos);

                if (resultado != null && resultado.Length > 0)
                {
                    listPersonal = new BindingList<personal>(resultado);
                    Session["personal"] = listPersonal;
                    gvPersonal.DataSource = listPersonal;
                    gvPersonal.DataBind();
                }
                else
                {
                    gvPersonal.DataSource = null;
                    gvPersonal.DataBind();
                    Session["personal"] = null;
                    // lblMensaje.Text = "No se encontraron resultados.";
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al buscar personal: " + ex.Message);
            }
        }

        protected void btnDoDelete_Click(object sender, EventArgs e)
        {
            if (int.TryParse(hfPersonalDelete.Value, out int id))
            {
                boPersonal.eliminarPersonalPorId(id);
            }
            Response.Redirect("~/GestionAcademica/Personal.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        // Asegurar THEAD/TBODY incluso sin filas
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (gvPersonal.Rows.Count > 0)
                gvPersonal.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}
