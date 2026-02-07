using FrontTA.SisProgWS;
using System;
using System.ComponentModel;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace FrontTA.Matricula
{
    public partial class BuscarMatricula : System.Web.UI.Page
    {
        private readonly FamiliaWSClient boFamilia = new FamiliaWSClient();
        private readonly MatriculaWSClient boMatricula = new MatriculaWSClient();

       
        private int AnioMatricula
        {
            get => (int)(ViewState["AnioMatricula"] ?? DateTime.Now.Year);
            set => ViewState["AnioMatricula"] = value;
        }

        private string Modo
        {
            get => (string)(ViewState["Modo"] ?? "agregar");
            set => ViewState["Modo"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
            var anioStr = Request.QueryString["anio"];
            var modoStr = (Request.QueryString["modo"] ?? "agregar").ToLowerInvariant();

            int anio = DateTime.Now.Year;
            int.TryParse(anioStr, out anio);

            
            if (anio == DateTime.Now.Year)
                modoStr = "agregar";

            AnioMatricula = anio;
            Modo = modoStr;

            
            if (IsPostBack)
            {
                if (string.IsNullOrWhiteSpace(txtCodFam.Text) &&
                    !string.IsNullOrWhiteSpace(hfCodFam.Value))
                {
                    txtCodFam.Text = hfCodFam.Value;
                }
            }

            
            lblAnio.Text = AnioMatricula.ToString();
            lnkReporte.NavigateUrl = ResolveUrl($"~/Matricula/ReporteMatricula.aspx?anio={AnioMatricula}");

            
            if (!IsPostBack)
            {
                // Habilitar/deshabilitar según modo
                SetDisabled(btnCreate, modoStr == "consultar");
                SetDisabled(btnDelete, modoStr != "consultar");
                SetDisabled(btnView, modoStr != "consultar");

                CargarGridInicial(AnioMatricula);
                CargarFamilias();
            }
        }

        private void CargarGridInicial(int anio)
        {
            var list = boMatricula.listarMatriculasTodas() ?? new matricula[0];

            BindingList<matricula> matriculas = new BindingList<matricula>();

            foreach (matricula mat in list)
            {
                // null-safe
                var nombrePeriodo = mat?.periodo_Aula?.periodo?.nombre;

                if (!string.IsNullOrEmpty(nombrePeriodo) && nombrePeriodo == anio.ToString())
                    matriculas.Add(mat);
            }

            Session["matricula"] = matriculas;

            gvAlumnos.DataSource = matriculas;
            gvAlumnos.DataBind();
        }

        private void CargarFamilias()
        {
            var lista2 = boFamilia.listarFamiliasTodas();
            reFamilias.DataSource = lista2;
            reFamilias.DataBind();
        }

        protected void gvAlumnos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.CssClass += " data-row";

                if (e.Row.RowIndex < gvAlumnos.DataKeys.Count)
                {
                    var id = gvAlumnos.DataKeys[e.Row.RowIndex].Value.ToString();
                    e.Row.Attributes["data-id"] = id;
                }
                else
                {
                    var matriculaItem = e.Row.DataItem as matricula;
                    if (matriculaItem != null)
                        e.Row.Attributes["data-id"] = matriculaItem.matricula_id.ToString();
                }
            }
        }

        protected void gvAlumnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAlumnos.PageIndex = e.NewPageIndex;
            gvAlumnos.DataSource = Session["matricula"] as BindingList<matricula>;
            gvAlumnos.DataBind();
        }

        
        protected void btnBuscar_Click2(object sender, EventArgs e)
        {
            string apePat = txtApePaternoModal.Text?.Trim();
            string apeMat = txtApeMaternoModal.Text?.Trim();

            var lista = boFamilia.buscarFamilia(apePat, apeMat);

            reFamilias.DataSource = lista;
            reFamilias.DataBind();

            upFamilia.Update();

            ScriptManager.RegisterStartupScript(
                upFamilia,
                upFamilia.GetType(),
                "keepFamiliaOpen",
                "setTimeout(function(){var ov=document.getElementById('ovFamilias'); if(ov){ ov.classList.add('show'); ov.setAttribute('aria-hidden','false'); }},0);",
                true
            );
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                // Recuperar la lista original del Session
                var listaOriginal = Session["matricula"] as BindingList<matricula>;
                if (listaOriginal == null)
                {
                    gvAlumnos.DataSource = null;
                    gvAlumnos.DataBind();
                    return;
                }

                // Obtener criterios de búsqueda
                string apePat = txtApePat.Text.Trim().ToLower();
                string apeMat = txtApeMat.Text.Trim().ToLower();
                string nombre = txtNombre.Text.Trim().ToLower();

                // Filtrar en memoria
                var filtrada = listaOriginal
                    .Where(m =>
                        (string.IsNullOrWhiteSpace(apePat) ||
                         (m.alumno?.padres?.apellido_paterno ?? "").ToLower().Contains(apePat))
                    && (string.IsNullOrWhiteSpace(apeMat) ||
                         (m.alumno?.padres?.apellido_materno ?? "").ToLower().Contains(apeMat))
                    && (string.IsNullOrWhiteSpace(nombre) ||
                         (m.alumno?.nombre ?? "").ToLower().Contains(nombre))
                    )
                    .ToList();

                // Cargar al GV
                gvAlumnos.DataSource = filtrada;
                gvAlumnos.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error en filtro buscar: " + ex.Message);
            }
        }

        //protected void btnBuscar_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        gvAlumnos.PageIndex = 0;

        //        int famParam = 0;
        //        int dniParam = 0;


        //        string famTxt = string.IsNullOrWhiteSpace(txtCodFam.Text)
        //            ? hfCodFam.Value
        //            : txtCodFam.Text;

        //        int.TryParse(famTxt?.Trim(), out famParam);
        //        int.TryParse(txtDni.Text?.Trim(), out dniParam);


        //        string apePat = string.IsNullOrWhiteSpace(txtApePat.Text) ? null : txtApePat.Text.Trim();
        //        string apeMat = string.IsNullOrWhiteSpace(txtApeMat.Text) ? null : txtApeMat.Text.Trim();
        //        string nombre = string.IsNullOrWhiteSpace(txtNombre.Text) ? null : txtNombre.Text.Trim();

        //        var lista = boMatricula.listarMatriculasPorFamiliaIdPaternoMaternoNombre(
        //            famParam,
        //            apePat,
        //            apeMat,
        //            nombre,
        //            dniParam,
        //            AnioMatricula
        //        );

        //        if (lista != null && lista.Length > 0)
        //        {
        //            var listMatricula = new BindingList<matricula>(lista);
        //            Session["matricula"] = listMatricula;

        //            gvAlumnos.DataSource = listMatricula;
        //            gvAlumnos.DataBind();
        //        }
        //        else
        //        {
        //            gvAlumnos.DataSource = null;
        //            gvAlumnos.DataBind();
        //            Session["matricula"] = null;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        System.Diagnostics.Debug.WriteLine("Error Buscar Matricula: " + ex.Message);
        //    }
        //}


        public string GetGenero(object sexoObj)
        {
            if (sexoObj == null) return "";

            if (sexoObj is string s)
                return s.Length > 0 ? s.Substring(0, 1).ToUpper() : "";

            if (sexoObj is char c)
                return c.ToString().ToUpper();

            if (int.TryParse(sexoObj.ToString(), out int code))
            {
                char ch = (char)code;
                if (ch == 'M' || ch == 'F') return ch.ToString();
            }

            return sexoObj.ToString();
        }

        
        private void SetDisabled(HtmlButton b, bool disabled)
        {
            b.Disabled = disabled;
            if (disabled) AddClass(b, "btn-disabled");
            else RemoveClass(b, "btn-disabled");
        }

        private void AddClass(HtmlButton b, string cls)
        {
            var cur = b.Attributes["class"] ?? string.Empty;
            if (!cur.Contains(cls)) b.Attributes["class"] = (cur + " " + cls).Trim();
        }

        private void RemoveClass(HtmlButton b, string cls)
        {
            var cur = b.Attributes["class"] ?? string.Empty;
            b.Attributes["class"] = cur.Replace(cls, "").Replace("  ", " ").Trim();
        }
    }
}
