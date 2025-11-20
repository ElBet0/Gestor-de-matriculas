using FrontTA.SisProgWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ServiceModel.Channels;

namespace FrontTA.Cobranza
{
    public partial class Cobranza : System.Web.UI.Page
    {
        private readonly FamiliaWSClient boFamilia = new FamiliaWSClient();
        private readonly DeudaWSClient boDeuda = new DeudaWSClient();
        private readonly TipoDeudaWSClient boTipoDeuda = new TipoDeudaWSClient(); // nombre supuesto
        private readonly PagoWSClient boPago = new PagoWSClient();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTiposDeuda();
                CargarDeudas();

                var lista = boFamilia.buscarFamilia(
                    txtBuscarApePat.Text.Trim(),
                    txtBuscarApeMat.Text.Trim()
                );

                gvFamilias.DataSource = lista;
                gvFamilias.DataBind();
            }
        }

        #region TIPOS DE DEUDA (filtros)

        private void CargarTiposDeuda()
        {
            try
            {
                // nombre de método supuesto: ajusta al real (listarTodos, listarTiposDeuda, etc.)
                var tipos = boTipoDeuda.listarTiposDeudaTodos();

                if (tipos == null || tipos.Length == 0)
                {
                    repTiposDeuda.DataSource = null;
                    repTiposDeuda.DataBind();

                    gvTiposDeuda.DataSource = null;
                    gvTiposDeuda.DataBind();
                    return;
                }

                var lista = tipos.Select(t => new
                {
                    Id = t.id_tipo_deuda,
                    Descripcion = t.descripcion,
                    MontoGeneral = t.monto_general
                }).ToList();

                repTiposDeuda.DataSource = lista;
                repTiposDeuda.DataBind();

                gvTiposDeuda.DataSource = lista;
                gvTiposDeuda.DataBind();
            }
            catch (Exception ex)
            {
                repTiposDeuda.DataSource = null;
                repTiposDeuda.DataBind();

                gvTiposDeuda.DataSource = null;
                gvTiposDeuda.DataBind();

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ErrTipos",
                    "alert('Error al cargar los tipos de deuda: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
            }
        }

        #endregion

        private void CargarDeudas()
        {
            // 1) Validar familia
            if (string.IsNullOrWhiteSpace(hfFamCodigo.Value))
            {
                repDeudas.DataSource = null;
                repDeudas.DataBind();
                return;
            }

            if (!int.TryParse(hfFamCodigo.Value, out int familiaId) || familiaId <= 0)
            {
                repDeudas.DataSource = null;
                repDeudas.DataBind();
                return;
            }

            // 2) Leer tipos seleccionados del hidden (ids de RM_TIPO_DEUDA)
            string filtroTipos = hfFiltroValores.Value ?? string.Empty;

            HashSet<int> idsSeleccionados = new HashSet<int>();
            foreach (var token in filtroTipos.Split(new[] { '|' }, StringSplitOptions.RemoveEmptyEntries))
            {
                if (int.TryParse(token, out int id) && id > 0)
                    idsSeleccionados.Add(id);
            }

            try
            {
                deuda[] deudas = null;

                // 3) Obtener deudas según cantidad de tipos seleccionados
                if (idsSeleccionados.Count == 0)
                {
                    // 🔹 Sin filtros: todas las deudas de la familia
                    deudas = boDeuda.buscarDeudasAlumno(familiaId, 0);
                }
                else if (idsSeleccionados.Count == 1)
                {
                    // 🔹 Un solo tipo: usamos directamente el filtro del SP
                    int idTipo = idsSeleccionados.First();
                    deudas = boDeuda.buscarDeudasAlumno(familiaId, idTipo);
                }
                else
                {
                    // 🔹 Varios tipos: llamamos una vez por cada tipo y unimos
                    var listaDeudas = new List<deuda>();

                    foreach (int idTipo in idsSeleccionados)
                    {
                        var parciales = boDeuda.buscarDeudasAlumno(familiaId, idTipo);
                        if (parciales != null && parciales.Length > 0)
                            listaDeudas.AddRange(parciales);
                    }

                    // Evitamos duplicados por deuda_id
                    deudas = listaDeudas
                                .GroupBy(d => d.deuda_id)
                                .Select(g => g.First())
                                .ToArray();
                }

                if (deudas == null || deudas.Length == 0)
                {
                    repDeudas.DataSource = null;
                    repDeudas.DataBind();
                    return;
                }

                // 4) Proyección para el Repeater, calculando Pagado y Saldo
                var lista = deudas.Select(d =>
                {
                    double pagado = 0.0;

                    var pagos = boPago.listarPagosPorDeuda(d.deuda_id);
                    if (pagos != null && pagos.Length > 0)
                    {
                        // El SP LISTAR_PAGOS_POR_DEUDA ya tiene p.activo = 1
                        pagado = pagos.Sum(p => p.monto);
                    }

                    double saldo = d.monto - pagado;
                    if (saldo < 0) saldo = 0;

                    return new
                    {
                        Id = d.deuda_id,
                        Alumno = d.alumno != null ? d.alumno.nombre : "",
                        TipoDeuda = d.concepto_deuda != null ? d.concepto_deuda.descripcion : "",
                        MontoDeuda = d.monto,
                        Pagado = pagado,
                        Saldo = saldo,
                        FechaEmision = d.fecha_emision,
                        FechaVencimiento = d.fecha_vencimiento,
                        Descuento = d.descuento,
                        Activo = d.activo == 1 ? "Vigente" : "No Vigente"
                    };
                }).ToList();

                repDeudas.DataSource = lista;
                repDeudas.DataBind();
            }
            catch (Exception ex)
            {
                repDeudas.DataSource = null;
                repDeudas.DataBind();

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ErrDeudas",
                    "alert('Error al listar las deudas: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
            }
        }





        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            var lista = boFamilia.buscarFamilia(
                txtBuscarApePat.Text.Trim(),
                txtBuscarApeMat.Text.Trim()
            );

            gvFamilias.DataSource = lista;
            gvFamilias.DataBind();

            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "MostrarModalBuscar",
                "document.getElementById('ovBuscar').classList.add('show');" +
                "document.getElementById('ovBuscar').setAttribute('aria-hidden','false');",
                true
            );
        }

        protected void gvFamilias_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvFamilias.PageIndex = e.NewPageIndex;

            var lista = boFamilia.buscarFamilia(
                txtBuscarApePat.Text.Trim(),
                txtBuscarApeMat.Text.Trim()
            );
            gvFamilias.DataSource = lista;
            gvFamilias.DataBind();

            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "MostrarModalBuscarPagina",
                "document.getElementById('ovBuscar').classList.add('show');" +
                "document.getElementById('ovBuscar').setAttribute('aria-hidden','false');",
                true
            );
        }

        protected void gvFamilias_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
                e.Row.CssClass = "table-header";
                return;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string codigo = DataBinder.Eval(e.Row.DataItem, "familia_id").ToString();
                string apePat = DataBinder.Eval(e.Row.DataItem, "apellido_Paterno").ToString();
                string apeMat = DataBinder.Eval(e.Row.DataItem, "apellido_Materno").ToString();

                apePat = apePat.Replace("'", "\\'");
                apeMat = apeMat.Replace("'", "\\'");

                e.Row.Attributes["onclick"] =
                    $"seleccionarFamilia('{codigo}','{apePat}','{apeMat}', this);";
                e.Row.CssClass = (e.Row.CssClass + " data-row").Trim();
                e.Row.Style["cursor"] = "pointer";
            }
        }

        protected void btnConfirmarFamilia_Click(object sender, EventArgs e)
        {
            txtCodigoFamilia.Text = hfFamCodigo.Value;
            txtApePaterno.Text = hfFamApePat.Value;
            txtApeMaterno.Text = hfFamApeMat.Value;

            CargarDeudas();

            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "FamiliaElegidaModal",
                "if(window.__Cobranza__FamiliaElegida){ window.__Cobranza__FamiliaElegida(); }",
                true
            );
        }

        protected void btnLupaFamilia_Click(object sender, EventArgs e)
        {
            try
            {
                string codStr = txtCodigoFamilia.Text.Trim();
                string apePat = txtApePaterno.Text.Trim();
                string apeMat = txtApeMaterno.Text.Trim();

                SisProgWS.familia fam = null;

                if (!string.IsNullOrEmpty(codStr) && int.TryParse(codStr, out int codInt))
                {
                    hfFamCodigo.Value = codInt.ToString();

                    var listaPorApe = boFamilia.buscarFamilia(apePat, apeMat);
                    if (listaPorApe != null && listaPorApe.Length > 0)
                    {
                        fam = listaPorApe.FirstOrDefault(f => f.familia_id == codInt) ?? listaPorApe[0];

                        hfFamApePat.Value = fam.apellido_paterno;
                        hfFamApeMat.Value = fam.apellido_materno;

                        txtApePaterno.Text = fam.apellido_paterno;
                        txtApeMaterno.Text = fam.apellido_materno;
                    }

                    CargarDeudas();

                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "FamHeaderOK",
                        "if(window.__Cobranza__FamiliaElegida){ window.__Cobranza__FamiliaElegida(); }",
                        true
                    );

                    return;
                }

                var lista = boFamilia.buscarFamilia(apePat, apeMat);

                if (lista == null || lista.Length == 0)
                {
                    hfFamCodigo.Value = "";
                    hfFamApePat.Value = "";
                    hfFamApeMat.Value = "";

                    txtCodigoFamilia.Text = "";
                    txtApePaterno.Text = "";
                    txtApeMaterno.Text = "";

                    repDeudas.DataSource = null;
                    repDeudas.DataBind();

                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "NoFamHeader",
                        "alert('No se encontró ninguna familia con los datos ingresados.');",
                        true
                    );
                    return;
                }

                fam = lista[0];

                hfFamCodigo.Value = fam.familia_id.ToString();
                hfFamApePat.Value = fam.apellido_paterno;
                hfFamApeMat.Value = fam.apellido_materno;

                txtCodigoFamilia.Text = hfFamCodigo.Value;
                txtApePaterno.Text = hfFamApePat.Value;
                txtApeMaterno.Text = hfFamApeMat.Value;

                CargarDeudas();

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "FamHeaderOK2",
                    "if(window.__Cobranza__FamiliaElegida){ window.__Cobranza__FamiliaElegida(); }",
                    true
                );
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ErrHeader",
                    "alert('Error al buscar familia: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
            }
        }

        protected void btnDoDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (!int.TryParse(hfDeudaSeleccionadaId.Value, out int deudaId) || deudaId <= 0)
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "NoRow",
                        "alert('Debes seleccionar una deuda en la tabla antes de eliminar.');",
                        true
                    );
                    return;
                }

                var pagos = boPago.listarPagosPorDeuda(deudaId);

                if (pagos != null && pagos.Length > 0)
                {
                   
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "DeudaConPagos",
                        "alert('No se puede eliminar la deuda porque tiene pagos registrados. " +
                        "Primero debe eliminar los pagos asociados.');",
                        true
                    );
                    return;
                }

                var resultado = boDeuda.eliminarDeudaPorId(deudaId);

                CargarDeudas();

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "CerrarOverlayEliminar",
                    "document.getElementById('ovEliminar').classList.remove('show');" +
                    "document.getElementById('ovEliminar').setAttribute('aria-hidden','true');",
                    true
                );

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "OkDelete",
                    "alert('La deuda fue marcada como No Vigente correctamente.');",
                    true
                );

                hfDeudaSeleccionadaId.Value = string.Empty;
            }
            catch (Exception ex)
            {
                string msg = ex.Message ?? string.Empty;
                string alerta;

                if (msg.IndexOf("No se puede eliminar la deuda porque tiene pagos asociados",
                                StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    alerta = "No se puede eliminar la deuda porque tiene pagos asociados activos.";
                }
                else
                {
                    alerta = "Ocurrió un error al eliminar la deuda: " + msg.Replace("'", "\\'");
                }

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ErrDelete",
                    $"alert('{alerta}');",
                    true
                );
            }
        }


        #region Gestión TiposDeuda (modal)

        private void MostrarModalTipos()
        {
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "MostrarTiposDeuda",
                "document.getElementById('ovTiposDeuda').classList.add('show');" +
                "document.getElementById('ovTiposDeuda').setAttribute('aria-hidden','false');",
                true
            );
        }

        protected void gvTiposDeuda_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTiposDeuda.PageIndex = e.NewPageIndex;
            CargarTiposDeuda();
            MostrarModalTipos();
        }

        protected void gvTiposDeuda_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
                e.Row.CssClass = "table-header";
                return;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string id = DataBinder.Eval(e.Row.DataItem, "Id").ToString();
                string desc = DataBinder.Eval(e.Row.DataItem, "Descripcion").ToString();
                string monto = DataBinder.Eval(e.Row.DataItem, "MontoGeneral").ToString();

                desc = desc.Replace("'", "\\'");
                monto = monto.Replace(',', '.');

                e.Row.Attributes["onclick"] =
                    $"seleccionarTipoDeuda({id}, '{desc}', {monto}, this);";
                e.Row.CssClass = (e.Row.CssClass + " data-row").Trim();
                e.Row.Style["cursor"] = "pointer";
            }
        }

        protected void btnCrearTipo_Click(object sender, EventArgs e)
        {
            try
            {
                string desc = txtTipoDescripcion.Text.Trim();
                string montoStr = txtTipoMonto.Text.Trim();

                // ❗ descripción obligatoria y máx 20 caracteres
                if (string.IsNullOrEmpty(desc))
                {
                    ScriptManager.RegisterStartupScript(
                        this, GetType(), "ValDesc",
                        "alert('Debe ingresar una descripción.');", true);
                    MostrarModalTipos();
                    return;
                }

                if (desc.Length > 20)
                {
                    ScriptManager.RegisterStartupScript(
                        this, GetType(), "ValDescLen",
                        "alert('La descripción no puede superar los 20 caracteres.');", true);
                    MostrarModalTipos();
                    return;
                }

                if (!double.TryParse(montoStr, out double monto) || monto <= 0)
                {
                    ScriptManager.RegisterStartupScript(
                        this, GetType(), "ValMonto",
                        "alert('El monto general debe ser numérico y mayor a 0');", true);
                    MostrarModalTipos();
                    return;
                }

    
                var tiposExistentes = boTipoDeuda.listarTiposDeudaTodos();
                if (tiposExistentes != null && tiposExistentes.Any(t =>
                        string.Equals(t.descripcion.Trim(), desc, StringComparison.OrdinalIgnoreCase)))
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "TipoDuplicado",
                        "alert('Ya existe un tipo de deuda con esa descripción.');",
                        true
                    );
                    MostrarModalTipos();
                    return;
                }


                var tipo = new tipoDeuda
                {
                    descripcion = desc,
                    monto_general = monto
                };

                boTipoDeuda.insertarTipoDeuda(tipo);

                hfTipoDeudaSeleccionado.Value = string.Empty;
                txtTipoDescripcion.Text = string.Empty;
                txtTipoMonto.Text = string.Empty;

                CargarTiposDeuda();

                ScriptManager.RegisterStartupScript(
                    this, GetType(), "OkCrearTipo",
                    "alert('Tipo de deuda creado correctamente.');", true);

                MostrarModalTipos();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ErrCrearTipo",
                    "alert('Error al crear tipo de deuda: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
                MostrarModalTipos();
            }
        }


        protected void btnEditarTipo_Click(object sender, EventArgs e)
        {
            try
            {
                // ✅ ya tenías esta validación de selección obligatoria
                if (!int.TryParse(hfTipoDeudaSeleccionado.Value, out int idTipo) || idTipo <= 0)
                {
                    ScriptManager.RegisterStartupScript(
                        this, GetType(), "SelTipo",
                        "alert('Primero debe seleccionar un tipo de deuda en la tabla.');", true);
                    MostrarModalTipos();
                    return;
                }

                string desc = txtTipoDescripcion.Text.Trim();
                string montoStr = txtTipoMonto.Text.Trim();

                // ❗ descripción obligatoria y máx 20 caracteres
                if (string.IsNullOrEmpty(desc))
                {
                    ScriptManager.RegisterStartupScript(
                        this, GetType(), "ValDescEdit",
                        "alert('Debe ingresar una descripción.');", true);
                    MostrarModalTipos();
                    return;
                }

                if (desc.Length > 20)
                {
                    ScriptManager.RegisterStartupScript(
                        this, GetType(), "ValDescLenEdit",
                        "alert('La descripción no puede superar los 20 caracteres.');", true);
                    MostrarModalTipos();
                    return;
                }

                // ❗ monto numérico y MAYOR a 100
                if (!double.TryParse(montoStr, out double monto) || monto <= 100)
                {
                    ScriptManager.RegisterStartupScript(
                        this, GetType(), "ValMontoEdit",
                        "alert('El monto general debe ser numérico y mayor a 100.');", true);
                    MostrarModalTipos();
                    return;
                }

                var tipo = new tipoDeuda
                {
                    id_tipo_deuda = idTipo,
                    descripcion = desc,
                    monto_general = monto
                };

                boTipoDeuda.modificarTipoDeuda(tipo);

                CargarTiposDeuda();

                ScriptManager.RegisterStartupScript(
                    this, GetType(), "OkEditTipo",
                    "alert('Tipo de deuda modificado correctamente.');", true);

                MostrarModalTipos();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ErrEditTipo",
                    "alert('Error al modificar tipo de deuda: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
                MostrarModalTipos();
            }
        }


        protected void btnEliminarTipo_Click(object sender, EventArgs e)
        {
            try
            {
                if (!int.TryParse(hfTipoDeudaSeleccionado.Value, out int idTipo) || idTipo <= 0)
                {
                    ScriptManager.RegisterStartupScript(
                        this, GetType(), "SelTipoDel",
                        "alert('Debe seleccionar un tipo de deuda para eliminar.');", true);
                    MostrarModalTipos();
                    return;
                }

                var deudas = boDeuda.listarDeudasTodas();   
                if (deudas != null && deudas.Any(d =>
                        d.concepto_deuda != null &&
                        d.concepto_deuda.id_tipo_deuda == idTipo
                    // Si quisieras solo deudas vigentes: && d.activo == 1
                    ))
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "TipoConDeudas",
                        "alert('No se puede eliminar el tipo de deuda porque existen deudas asociadas con este concepto.');",
                        true
                    );
                    MostrarModalTipos();
                    return;
                }



                boTipoDeuda.eliminarTipoDeudaPorId(idTipo);

                hfTipoDeudaSeleccionado.Value = string.Empty;
                txtTipoDescripcion.Text = string.Empty;
                txtTipoMonto.Text = string.Empty;

                CargarTiposDeuda();

                ScriptManager.RegisterStartupScript(
                    this, GetType(), "OkDelTipo",
                    "alert('Tipo de deuda eliminado correctamente.');", true);

                MostrarModalTipos();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "ErrDelTipo",
                    "alert('Error al eliminar tipo de deuda: " + ex.Message.Replace("'", "\\'") + "');",
                    true
                );
                MostrarModalTipos();
            }

        }

        #endregion

        protected void btnReporte_Click(object sender, EventArgs e)
        {
            if (txtCodigoFamilia.Text!=null)
            {
                int idFamilia = int.Parse(txtCodigoFamilia.Text);
                Session["idFamReporte"] = idFamilia;
                Response.Redirect("VisualizarReporteDeudasFamilia.aspx");
            }
        }
    }
}
