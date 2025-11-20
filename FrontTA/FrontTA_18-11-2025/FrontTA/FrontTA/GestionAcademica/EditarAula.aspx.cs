using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontTA.GestionAcademica
{
    public partial class EditarAula : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            CargarGrados();

            // Por defecto
            ddlActivo.SelectedValue = "1";
            txtCodigoAula.ReadOnly = true;
            // ddlActivo se maneja como solo lectura desde el .aspx (Enabled="false")

            // Tomar id desde la URL ?id=...
            string idStr = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int idAula))
            {
                CargarAulaExistente(idAula);
            }
            else
            {
                // Podrías redirigir si no hay id, si lo necesitas
                // Response.Redirect("~/GestionAcademica/Aula.aspx");
            }
        }

        // ================== CARGA DE COMBOS ==================
        private void CargarGrados()
        {
            try
            {
                using (var ws = new GradoAcademicoWSClient())
                {
                    var lista = ws.listarGradosAcademicosTodos();

                    ddlGrado.DataSource = lista;
                    ddlGrado.DataTextField = "nombre";
                    ddlGrado.DataValueField = "grado_academico_id";
                    ddlGrado.DataBind();

                    ddlGrado.Items.Insert(0, new ListItem("-- Seleccione --", "0"));
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar grados: " + ex.Message);
                ddlGrado.Items.Clear();
                ddlGrado.Items.Insert(0, new ListItem("(Error al cargar grados)", "0"));
            }
        }

        // ================== CARGA DE AULA ==================
        private void CargarAulaExistente(int idAula)
        {
            try
            {
                using (var aulaWs = new AulaWSClient())
                {
                    var a = aulaWs.obtenerAulaPorId(idAula);
                    if (a == null) return;

                    txtCodigoAula.Text = a.aula_id.ToString();
                    txtNombre.Text = a.nombre;

                    // grado
                    if (a.grado != null)
                    {
                        string idGrado = a.grado.grado_academico_id.ToString();
                        if (ddlGrado.Items.FindByValue(idGrado) != null)
                            ddlGrado.SelectedValue = idGrado;
                    }

                    // activo (si existe propiedad en proxy)
                    try
                    {
                        ddlActivo.SelectedValue = a.activo.ToString();
                    }
                    catch
                    {
                        // si no existe la propiedad, dejamos por defecto
                    }
                }

                // Todo lo relacionado a PeriodoXAula queda descartado
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar aula existente: " + ex.Message);
            }
        }

        // ================== BOTONES ==================
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GestionAcademica/Aula.aspx");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // 1) Validar datos
            string mensajesError;
            if (!ValidarAula(out mensajesError))
            {
                // Mostrar errores en el modal
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "validacionAulaEditar",
                    $"mostrarModal('{mensajesError.Replace("'", "\\'")}');",
                    true
                );
                return;
            }

            try
            {
                // Datos básicos del formulario
                int idAula = int.Parse(txtCodigoAula.Text);
                string nombre = txtNombre.Text.Trim();
                int idGrado = int.Parse(ddlGrado.SelectedValue);

                // Activo (aunque esté deshabilitado en UI, lo tomamos igual)
                int activo;
                if (!int.TryParse(ddlActivo.SelectedValue, out activo))
                    activo = 1;

                // 2) Actualizar Aula
                var aula = new aula
                {
                    aula_id = idAula,
                    nombre = nombre
                };
                aula.grado = new gradoAcademico
                {
                    grado_academico_id = idGrado
                };
                try { aula.activo = activo; } catch { }

                using (var aulaWs = new AulaWSClient())
                {
                    int resAula = aulaWs.modificarAula(aula);
                    if (resAula <= 0)
                    {
                        ScriptManager.RegisterStartupScript(
                            this,
                            GetType(),
                            "aulaEditFail",
                            "alert('El servicio devolvió 0: no se modificó el aula.');",
                            true
                        );
                        return;
                    }
                }

                // 3) Todo OK → volver a la lista
                string url = ResolveUrl("~/GestionAcademica/Aula.aspx");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "aulaEditOk",
                    $"alert('El aula se editó correctamente.'); window.location='{url}';",
                    true
                );
            }
            catch (Exception ex)
            {
                string msg = ("No se pudo actualizar el aula: " + ex.Message).Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "aulaEditarError",
                    $"alert('{msg}');",
                    true
                );
            }
        }

        // ================== VALIDACIÓN ==================
        private bool ValidarAula(out string mensajes)
        {
            var errores = new List<string>();

            string nombre = (txtNombre.Text ?? "").Trim();
            string gradoSel = ddlGrado.SelectedValue;

            // Nombre obligatorio, máx 12
            if (string.IsNullOrWhiteSpace(nombre))
            {
                errores.Add("El nombre del aula es obligatorio.");
            }
            else if (nombre.Length > 12)
            {
                errores.Add("La longitud del nombre del aula no es válida (máx. 12 caracteres).");
            }

            // Grado académico obligatorio
            int idGrado;
            if (!int.TryParse(gradoSel, out idGrado) || idGrado <= 0)
            {
                errores.Add("Debe seleccionar un grado académico válido.");
            }

            mensajes = string.Join("\\n", errores);
            return errores.Count == 0;
        }
    }
}
