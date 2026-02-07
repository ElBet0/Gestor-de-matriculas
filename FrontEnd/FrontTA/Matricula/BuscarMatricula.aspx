<%@ Page Title="Búsqueda de Matrículas" Language="C#" MasterPageFile="~/SoftProg.Master"
    AutoEventWireup="true" CodeBehind="BuscarMatricula.aspx.cs" Inherits="FrontTA.Matricula.BuscarMatricula" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Búsqueda de Matrículas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
    :root {
        --verde: #74D569;
        --verdeOsc: #016A13;
        --gris: #E1E1E1;
        --blanco: #FFF;
        --negro: #000;
        --celeste: #E6F4FF;
    }

    .matricula-container {
        background: var(--gris);
        padding: 1.5rem;
        border-radius: 1rem;
        box-shadow: 0 3px 8px rgba(0,0,0,.1);
    }

    .tabla-box .table tbody tr.data-row.row-selected > td,
    .table tbody tr.data-row.row-selected > td,
    .table.table-hover tbody tr.data-row.row-selected:hover > td {
        background-color: #E6F4FF !important;
        transition: background-color .15s ease-in-out;
    }

    
    .table.table-striped > tbody > tr.data-row.row-selected:nth-of-type(odd) > td {
        --bs-table-accent-bg: transparent; /* BS5 */
        background-color: #E6F4FF !important;
    }

    
    .table tbody tr.data-row:hover:not(.row-selected) > td {
        background-color: #F3FAFF !important;
    }



    
    .top-row {
        display: grid;
        grid-template-columns: auto 1fr auto; 
        align-items: center;
        gap: 1rem;
        margin-bottom: 1rem;
    }

    .year-box {
        background: #c9c9c9;
        border: 3px solid #111;
        border-radius: 16px;
        padding: .65rem 1.25rem;
        min-width: 360px;
        font-weight: 800;
        font-size: 2rem;
        color: #111;
        box-shadow: inset 0 3px 6px rgba(0,0,0,.12);
    }

        .year-box small {
            font-size: 1.25rem;
            font-weight: 800;
            margin-right: .5rem;
        }

    .icon-bar { /* igual que Familias */
        display: inline-flex;
        gap: .75rem;
        background: var(--blanco);
        border-radius: 12px;
        padding: .6rem .75rem;
        box-shadow: 0 2px 6px rgba(0,0,0,.1);
    }

    .btn-icon { /* igual que Familias */
        background: var(--verde);
        color: var(--blanco);
        border: 0;
        width: 44px;
        height: 44px;
        border-radius: 12px;
        font-size: 1.15rem;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: transform .15s ease, background .15s ease;
    }

        .btn-icon:hover {
            background: var(--verdeOsc);
            transform: scale(1.05);
        }

        .btn-icon.btn-disabled, .btn-icon[disabled] {
            background: var(--gris) !important;
            color: #777 !important;
            cursor: not-allowed;
            transform: none !important;
            box-shadow: none !important;
        }

    .btn-search {
        background: var(--verde);
        color: #fff;
        border: 0;
        width: 44px;
        height: 44px;
        border-radius: 12px;
    }

        .btn-search:hover {
            background: var(--verdeOsc);
        }


    /*  BÚSQUEDA  */
    .busqueda-box {
        background: var(--blanco);
        border-radius: 12px;
        padding: 1rem 1.25rem;
        box-shadow: 0 2px 5px rgba(0,0,0,.08);
        margin-bottom: 1.25rem;
    }

        .busqueda-box label {
            font-weight: 700;
            color: #111;
        }

    .form-control {
        border: 1px solid var(--gris);
        border-radius: 10px;
    }

    .readonly-gray {
        background: #eee !important;
        color: #333 !important;
    }

    .mini-btn {
        width: 44px;
        height: 44px;
        border-radius: 12px;
        border: 2px solid #111;
        background: var(--blanco);
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }

    
    .tabla-box {
        background: var(--blanco);
        border-radius: 10px;
        box-shadow: 0 2px 6px rgba(0,0,0,.1);
        overflow-x: auto;
    }

    .table-header {
        background: var(--verde);
        color: #fff;
        text-align: center;
    }

    th, td {
        text-align: center;
        vertical-align: middle;
    }

    .empty-state {
        color: #6c757d;
        font-style: italic;
    }


    #gvAlumnos {
        width: 100%;
    }

        #gvAlumnos th, #gvAlumnos td {
            text-align: center;
            vertical-align: middle;
        }

        #gvAlumnos tr.data-row {
            cursor: pointer;
        }

            #gvAlumnos tr.data-row:hover td {
                background: var(--celeste);
            }

        #gvAlumnos tr.row-selected td {
            background: var(--celeste) !important;
            transition: background-color .12s ease-in-out;
        }

  
    .confirm-overlay {
        position: fixed;
        inset: 0;
        background: rgba(0,0,0,.35);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 1050;
    }

        .confirm-overlay.show {
            display: flex;
        }

    .confirm-box {
        background: #fff;
        border-radius: 14px;
        padding: 1.25rem 1.5rem;
        box-shadow: 0 12px 32px rgba(0,0,0,.25);
        min-width: 420px;
        max-width: 90%;
        text-align: center;
    }

    .confirm-title {
        background: #bdbdbd;
        color: #1f1f1f;
        font-weight: 800;
        border-radius: 10px;
        padding: .6rem 1rem;
        margin-bottom: 1rem;
    }

    .confirm-actions {
        display: flex;
        gap: 1.25rem;
        justify-content: center;
    }

  
    .btn-accept, .btn-cancel {
        text-decoration: none !important;
        width: 64px;
        height: 64px;
        border-radius: 12px;
        border: 2px solid #00000030;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 2rem;
        background: #fff;
        cursor: pointer;
        transition: transform .15s ease, box-shadow .15s ease;
    }

    .btn-accept {
        box-shadow: 0 3px 8px rgba(0,128,0,.15);
    }

    .btn-cancel {
        box-shadow: 0 3px 8px rgba(255,0,0,.15);
    }

        .btn-accept:hover, .btn-cancel:hover {
            transform: translateY(-2px);
        }

    .btn-accept i {
        color: #2E7D32;
    }

    .btn-cancel i {
        color: #D32F2F;
    }

    .btn-exit {
        background: #fff;
        border: 1px solid #cbd5e1;
        color: #1f2937;
        font-weight: 700;
        padding: .65rem 1.25rem;
        border-radius: 12px;
        min-width: 140px;
        box-shadow: 0 2px 6px rgba(0,0,0,.08);
    }

        .btn-exit:hover {
            background: #f8fafc;
        }

 
    .overlay {
        position: fixed;
        inset: 0;
        background: rgba(0,0,0,.35);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 1050;
    }

        .overlay.show {
            display: flex;
        }

    .modal-box {
        position: relative;
        background: #e9ecef;
        border-radius: 14px;
        padding: 1.5rem;
        width: min(1000px, 92vw);
        box-shadow: 0 16px 40px rgba(0,0,0,.35);
        border: 6px solid #000; 
    }

    .modal-inner {
        background: #f3f5f7;
        border: 3px solid #222;
        border-radius: 12px;
        padding: 1rem 1rem 0 1rem;
    }

    .modal-title {
        font-weight: 800;
        color: #0b3650;
        margin-bottom: .5rem;
    }

    .tabla-box {
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 2px 6px rgba(0,0,0,.1);
        overflow-x: auto;
    }

    .table-header {
        background: var(--verde);
        color: #fff;
        text-align: center;
    }

    th, td {
        text-align: center;
        vertical-align: middle;
    }

    .modal-footer {
        display: flex;
        justify-content: flex-end;
        padding: 1rem 0;
    }

   
    .modal-flex {
        display: flex;
        gap: 1rem;
        align-items: flex-start;
    }

    .side-img-modal {
        background: #ffffffcc;
        border: 2px solid #d7eefc;
        border-radius: 12px;
        padding: .75rem;
        text-align: center;
        width: 180px;
        min-width: 180px;
        align-self: flex-start;
    }

        .side-img-modal img {
            max-width: 140px;
            height: auto;
            display: block;
            margin: auto;
        }

    .form-label {
        font-weight: 700;
        font-size: 1.15rem;
        color: #1f2937;
    }

    .gv-pager {
        text-align: right;
        padding: .5rem .75rem;
    }

        .gv-pager a, .gv-pager span {
            display: inline-block;
            min-width: 36px;
            padding: .35rem .6rem;
            margin-left: .25rem;
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            background: #fff;
            color: #111;
            font-weight: 700;
        }

        .gv-pager span {
            background: #f3f4f6;
            border-color: #d1d5db;
        }

    .toolbar {
        display: grid;
        grid-template-columns: 1fr auto 1fr; 
        align-items: center;
        margin-bottom: 1rem;
    }

       
        .toolbar .icon-bar {
            justify-self: start;
        }

    
    .btn-exit {
        background: var(--verde);
        color: #fff;
        border: none;
        border-radius: 12px;
        padding: .6rem 1.25rem;
        font-weight: 700;
        float: right;
    }

    .header-cta {
        background: #F3F4F6;
        color: #000000;
        border: 1px solid #E5E7EB;
        padding: .5rem 1rem;
        border-radius: 4px;
        font-weight: 700;
        justify-self: center; /* centra dentro de la columna 2 */
    }


</style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {

           
            function eventPath(e) {
                if (e.composedPath) return e.composedPath();
                var path = [];
                var node = e.target;
                while (node) { path.push(node); node = node.parentNode; }
                path.push(window);
                return path;
            }

           
            window.confirmarFamilia = function () {
                var ov = document.getElementById('ovFamilias');
                if (!ov) return false;

                var sel = ov.querySelector('tr.fam-row.row-selected, tr.data-row.row-selected');
                if (!sel) return false;

                var cod = sel.getAttribute('data-familia');
                var apPat = sel.getAttribute('data-ape-pat');
                var apMat = sel.getAttribute('data-ape-mat');

                if (cod == null || apPat == null || apMat == null) {
                    var tds = sel.querySelectorAll('td');
                    cod = cod ?? (tds[0]?.innerText.trim() || '');
                    apPat = apPat ?? (tds[1]?.innerText.trim() || '');
                    apMat = apMat ?? (tds[2]?.innerText.trim() || '');
                }

                var txtCod = document.getElementById('<%= txtCodFam.ClientID %>');

                var txtApPat = document.getElementById('<%= txtApePat.ClientID %>');
                var txtApMat = document.getElementById('<%= txtApeMat.ClientID %>');

                if (txtCod) txtCod.value = cod || '';

                var hfCod = document.getElementById('hfCodFam');
                if (hfCod) hfCod.value = cod || '';

                if (txtApPat) txtApPat.value = apPat || '';
                if (txtApMat) txtApMat.value = apMat || '';

                var hf = document.getElementById('<%= hfCodFam.ClientID %>');
                if (hf) hf.value = cod || '';

                ov.classList.remove('show');
                ov.setAttribute('aria-hidden', 'true');

                return false; // evita postback
            };


            
            const gv = document.getElementById('gvAlumnos');
            const btnDelete = document.getElementById('<%= btnDelete.ClientID %>');
            const btnView = document.getElementById('<%= btnView.ClientID %>');
            const btnCreate = document.getElementById('<%= btnCreate.ClientID %>');

            function setEnabled(el, enabled) {
                if (!el) return;
                el.disabled = !enabled;
                el.classList.toggle('btn-disabled', !enabled);
            }
            // inicial
            setEnabled(btnDelete, false);
            setEnabled(btnView, false);

            if (gv) {
                gv.addEventListener('click', function (e) {
                    const tr = e.target.closest('tr.data-row');
                    if (!tr) return;
                    gv.querySelectorAll('tr').forEach(r => r.classList.remove('row-selected'));
                    tr.classList.add('row-selected');
                    setEnabled(btnDelete, true);
                    setEnabled(btnView, true);
                });
            }

            
            function getOvFamilia() { return document.getElementById('ovFamilias'); }

           
            function bindDelegatedModalHandlers() {
                var ov = getOvFamilia();
                if (!ov || ov.__delegatedBound) return;
                ov.__delegatedBound = true;

                ov.addEventListener('click', function (e) {
                    
                    if (e.target.closest('#btnCloseFamilia')) {
                        ov.classList.remove('show');
                        ov.setAttribute('aria-hidden', 'true');
                        e.preventDefault();
                        e.stopPropagation();
                        return;
                    }

                   
                    var tr = e.target.closest('tr.fam-row, tr.data-row');
                    if (tr && ov.contains(tr)) {
                        var table = ov.querySelector('.tabla-box table');
                        if (table) {
                            table.querySelectorAll('tr.row-selected')
                                .forEach(r => r.classList.remove('row-selected'));
                        }
                        tr.classList.add('row-selected');

                        var btnConfirm = document.getElementById('btnConfirmar');
                        if (btnConfirm) btnConfirm.classList.remove('btn-disabled');
                        return;
                    }
                });

                
                ov.addEventListener('click', function (e) {
                    if (e.target === ov) {
                        ov.classList.remove('show');
                        ov.setAttribute('aria-hidden', 'true');
                    }
                });
            }

            function openOvFamilia() {
                var ov = getOvFamilia();
                if (!ov) return;
                ov.classList.add('show');
                ov.setAttribute('aria-hidden', 'false');
                var btnConfirm = document.getElementById('btnConfirmar');
                if (btnConfirm) btnConfirm.classList.add('btn-disabled');
            }
            function closeOvFamilia() {
                var ov = getOvFamilia();
                if (!ov) return;
                ov.classList.remove('show');
                ov.setAttribute('aria-hidden', 'true');
            }

           
            document.addEventListener('click', function (e) {
                if (!gv) return;

                var path = eventPath(e);

                
                if (path.some(n => n && n.id === gv.id)) return;

               
                if (path.some(n => n && n.id === 'ovFamilias')) return;

                
                var btnClientIds = [
        '<%= btnCreate.ClientID %>',
        '<%= btnView.ClientID %>',
        '<%= btnDelete.ClientID %>'
    ];
    if (path.some(n => n && btnClientIds.indexOf(n.id) !== -1)) return;

    
    if (path.some(n => n && n.getAttribute && n.getAttribute('data-action') === 'no-deselect')) return;

    
    gv.querySelectorAll('tr.row-selected').forEach(r => r.classList.remove('row-selected'));
    setEnabled(btnDelete, false);
    setEnabled(btnView, false);
}, true);

       
        const btnAddFamilia = document.getElementById('btnOpenFam');
        if (btnAddFamilia) {
            btnAddFamilia.type = 'button';
            btnAddFamilia.addEventListener('click', function (e) {
                e.preventDefault();
                openOvFamilia();
            });
        }
        const btnCloseFamilia = document.getElementById('btnCloseFamilia');
        if (btnCloseFamilia) {
            btnCloseFamilia.addEventListener('click', function (e) {
                e.preventDefault();
                closeOvFamilia();
            });
        }

        
        function attachNavHandlers() {
            
            if (btnCreate) {
                btnCreate.type = 'button';
                btnCreate.removeEventListener && btnCreate.removeEventListener('click', null);
                btnCreate.addEventListener('click', function (ev) {
                    ev.preventDefault();
                    const anio = (document.getElementById('<%= lblAnio.ClientID %>').textContent || '').trim();
            window.location.href = '<%= ResolveUrl("~/Matricula/CrearMatricula.aspx") %>?anio=' + encodeURIComponent(anio);
        });
    }

    // btnView
    if (btnView) {
        btnView.type = 'button';
        btnView.removeEventListener && btnView.removeEventListener('click', null);
        btnView.addEventListener('click', function (ev) {
            ev.preventDefault();
            const sel = gv ? gv.querySelector('tr.row-selected') : null;
            if (!sel) { alert('Seleccione una fila.'); return; }
            const id = sel.getAttribute('data-id') || sel.dataset?.id || '';
            const anio = (document.getElementById('<%= lblAnio.ClientID %>').textContent || '').trim();
            window.location.href = '<%= ResolveUrl("~/Matricula/ConsultarMatricula.aspx") %>?anio=' + encodeURIComponent(anio) + '&id=' + encodeURIComponent(id);
        });
    }

    // btnDelete
    if (btnDelete) {
        btnDelete.type = 'button';
        btnDelete.removeEventListener && btnDelete.removeEventListener('click', null);
        btnDelete.addEventListener('click', function (ev) {
            ev.preventDefault();
            const sel = gv ? gv.querySelector('tr.row-selected') : null;
            if (!sel) { alert('Seleccione una fila.'); return; }
            const id = sel.getAttribute('data-id') || sel.dataset?.id || '';
            const anio = (document.getElementById('<%= lblAnio.ClientID %>').textContent || '').trim();
            window.location.href = '<%= ResolveUrl("~/Matricula/EditarMatricula.aspx") %>?anio=' + encodeURIComponent(anio) + '&id=' + encodeURIComponent(id);
        });
                }
            }
            attachNavHandlers();

           
            bindDelegatedModalHandlers();

            
            if (window.Sys && Sys.WebForms && Sys.WebForms.PageRequestManager) {
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                prm.add_endRequest(function () {
                   
                    bindDelegatedModalHandlers();
                    attachNavHandlers();
                });
            }



        });
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
   <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <div class="container-fluid matricula-container">

        <!--  Fila superior  -->
        <div class="top-row">
            <div class="year-box">
                <small>Año</small>
                <asp:Label ID="lblAnio" runat="server" Text=""></asp:Label>
            </div>

            <span class="header-cta">Gestión Matrícula</span>

            <div class="icon-bar">
                <button id="btnCreate" runat="server" type="button" class="btn-icon" title="Crear matrícula">
                    <i class="fa-solid fa-user-plus"></i>
                </button>
                <button id="btnView" runat="server" type="button" class="btn-icon btn-disabled" title="Consultar matrícula" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>

                <button id="btnDelete" runat="server" type="button" class="btn-icon btn-disabled" title="Eliminar matrícula" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>
        </div>

        <!--  Búsqueda  -->
        <div class="busqueda-box">
            <div class="row g-3 align-items-end">
                <div class="col-lg-4">
                    <label class="form-label">Código Familia:</label>
                    <div class="input-group">
                        <asp:TextBox ID="txtCodFam" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>
                        <asp:HiddenField ID="hfCodFam" runat="server" ClientIDMode="Static" />

                        <button id="btnOpenFam" type="button" class="btn-icon" title="Buscar familia">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
                </div>

                <div class="col-lg-2">
                    <label class="form-label">Apellido Paterno:</label>
                    <asp:TextBox ID="txtApePat" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-lg-2">
                    <label class="form-label">Apellido Materno:</label>
                    <asp:TextBox ID="txtApeMat" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-lg-2">
                    <label class="form-label">Nombre:</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-lg-2">
                </div>
            </div>

            <div class="d-flex justify-content-end mt-3">
                <div class="icon-bar">
                    <asp:HyperLink ID="lnkReporte" runat="server" CssClass="btn-icon" ToolTip="Reporte por año">
                        <i class="fa-solid fa-clipboard-list"></i>
                    </asp:HyperLink>

                    <asp:LinkButton ID="btnBuscar2" runat="server" CssClass="btn btn-search" ToolTip="Buscar"
                        OnClick="btnBuscar_Click" CausesValidation="false" UseSubmitBehavior="false">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>

        <!--  Tabla / GridView  -->
        <div class="tabla-box">
            <asp:GridView ID="gvAlumnos" runat="server" AutoGenerateColumns="False"
                CssClass="table table-bordered table-hover align-middle mb-0"
                ClientIDMode="Static"
                OnRowDataBound="gvAlumnos_RowDataBound"
                DataKeyNames="matricula_id"
                OnPageIndexChanging="gvAlumnos_PageIndexChanging"
                ShowHeaderWhenEmpty="true">
                <HeaderStyle CssClass="table-header" />
                <Columns>

                    <asp:TemplateField HeaderText="Género">
                        <ItemTemplate>
                            <%# GetGenero(Eval("alumno.sexo")) %>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Apellido Paterno">
                        <ItemTemplate>
                            <%# Eval("alumno.padres.apellido_paterno") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Apellido Materno">
                        <ItemTemplate>
                            <%# Eval("alumno.padres.apellido_materno") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Nombre">
                        <ItemTemplate>
                            <%# Eval("alumno.nombre") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

                <EmptyDataTemplate>
                    <tr>
                        <td colspan="4" class="text-muted">Sin resultados</td>
                    </tr>
                </EmptyDataTemplate>

                <RowStyle CssClass="data-row" />
            </asp:GridView>
        </div>

        <asp:HiddenField ID="hfFamiliaOpen" runat="server" ClientIDMode="Static" Value="0" />
<!-- Seleccionar Familia -->
<asp:UpdatePanel ID="upFamilia" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
    <ContentTemplate>
        <div id="ovFamilias" class="overlay" aria-hidden="true">
            <div class="modal-box">
                <div class="modal-inner">

                    <!-- fila: tabla + logo (adentro del rectángulo gris) -->
                    <div class="modal-flex">
                        <div class="col-9">
                            <div class="mb-2 row">
                                <div class="col-md-10">
                                    <div class="mb-2 row">
                                        <div class="col-md-4">
                                            <label class="form-label align-content-center">Apellido Paterno:</label>
                                        </div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtApePaternoModal" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="mb-2 row">
                                        <div class="col-md-4">
                                            <label class="form-label align-content-center text-nowrap">Apellido Materno:</label>
                                        </div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtApeMaternoModal" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-2 d-flex justify-content-center align-items-center">
                                    <asp:LinkButton ID="btnBuscarModal"
                                        runat="server"
                                        CssClass="btn btn-search"
                                        ToolTip="Buscar"
                                        OnClick="btnBuscar_Click2"
                                        CausesValidation="false"
                                        UseSubmitBehavior="false">
                            <i class="fa-solid fa-magnifying-glass" aria-hidden="true"></i>
                            <span class="sr-only">Buscar</span>
                                    </asp:LinkButton>
                                </div>
                            </div>

                            <div class="tabla-box mb-3 flex-grow-1">
                                <table class="table table-bordered table-hover align-middle mb-0">
                                    <thead class="table-header">
                                        <tr>
                                            <th>Código Familia</th>
                                            <th>Apellido Paterno</th>
                                            <th>Apellido Materno</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="reFamilias" runat="server">
                                            <ItemTemplate>
                                                <tr class="data-row fam-row"
                                                    data-familia="<%# Eval("familia_id") %>"
                                                    data-ape-pat="<%# Eval("apellido_paterno") %>"
                                                    data-ape-mat="<%# Eval("apellido_materno") %>">
                                                    <td><%# Eval("familia_id") %></td>
                                                    <td><%# Eval("apellido_paterno") %></td>
                                                    <td><%# Eval("apellido_materno") %></td>
                                                </tr>
                                            </ItemTemplate>                                        
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="col-3 align-content-center">
                            <div class="side-img-modal">
                                <asp:Image ID="imgCursosEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <div class="action-buttons mt-3">

                        <asp:LinkButton ID="btnConfirmar" runat="server" ClientIDMode="Static"
                            CssClass="btn-accept btn-disabled"
                            ToolTip="Seleccionar y cerrar"
                            OnClientClick="return confirmarFamilia();">
                            <i class="fa-solid fa-check"></i>
                        </asp:LinkButton>

                        <button type="button" id="btnCloseFamilia" class="btn-cancel">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </ContentTemplate>


    <Triggers>

        <asp:PostBackTrigger ControlID="btnBuscarModal" />
    </Triggers>

</asp:UpdatePanel>

    </div>
</asp:Content>
