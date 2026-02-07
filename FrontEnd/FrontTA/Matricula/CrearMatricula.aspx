<%@ Page Title="Crear Matrícula" Language="C#" MasterPageFile="~/SoftProg.Master"
    AutoEventWireup="true" CodeBehind="CrearMatricula.aspx.cs"
    Inherits="FrontTA.Matricula.CrearMatricula" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Crear Matrícula
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --grisTexto: #777;
            --blanco: #FFF;
            --negro: #000;
            --celeste: #BFE7FF;
            --celesteBtn: #8FD2FF;
            --borde: #D7D7D7;
        }

        .matricula-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
        }

        
        .top-grid {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            align-items: center;
            gap: 1rem;
            margin-bottom: .75rem;
        }

        .top-right {
            justify-self: end;
        }

        .top-center {
            justify-self: center;
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

        .icon-bar {
            display: inline-flex;
            gap: .75rem;
            background: var(--blanco);
            border-radius: 12px;
            padding: .6rem .75rem;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
        }

        .btn-icon {
            border: 0;
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.15rem;
            transition: transform .15s ease, background .15s ease, color .15s;
        }

        .btn-active {
            background: var(--celesteBtn);
            color: #00324D;
        }

        .btn-muted {
            background: #F1F1F1;
            color: var(--grisTexto);
        }

            .btn-muted[disabled] {
                opacity: .9;
                cursor: not-allowed;
            }

        .header-cta-btn {
            background: #F3F4F6;
            color: #000;
            border: 1px solid #E5E7EB;
            padding: .55rem 1.15rem;
            border-radius: 6px;
            font-weight: 800;
            box-shadow: 0 2px 6px rgba(0,0,0,.06);
        }

     
        .card-form {
            background: var(--blanco);
            border-radius: 16px;
            padding: 1.25rem;
            box-shadow: 0 2px 6px rgba(0,0,0,.12);
        }

        .fieldset {
            border: 2px solid #E0E0E0;
            border-radius: 16px;
            padding: 1.25rem;
            background: #F8F8F8;
        }

        .legend-title {
            font-weight: 800;
            color: #444;
            padding: .25rem .6rem;
            border: 2px solid #D0D0D0;
            border-radius: 10px;
            background: #F2F2F2;
        }

        .form-label {
            font-weight: 700;
            font-size: 1.05rem;
            color: #1f2937;
        }

        .form-control {
            border: 1px solid var(--borde);
            border-radius: 8px;
            height: 44px;
        }

        .readonly-gray {
            background: #BDBDBD !important;
            color: #444 !important;
            border: 1px solid #AFAFAF !important;
        }

        .side-panel {
            max-width: 300px;
            min-width: 200px;
            padding: 1rem 2rem;
            border-radius: 16px;
            background: var(--celeste);
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #a7d7f3;
        }

        .side-img {
            background: #ffffffaa;
            border: 2px solid #d7eefc;
            border-radius: 16px;
            padding: 1rem;
        }

        .btn-icon-2 {
            background: var(--verde);
            color: #fff;
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

            .btn-icon-2:hover {
                background: var(--verdeOsc);
                transform: scale(1.05);
            }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }

        .btn-accept, .btn-cancel {
            width: 56px;
            height: 56px;
            border-radius: 12px;
            border: 2px solid #00000030;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            background: #fff;
            transition: transform .15s ease;
        }

            .btn-accept i {
                color: #2E7D32 !important;
            }

            .btn-cancel i {
                color: #D32F2F !important;
            }

            .btn-accept:hover, .btn-cancel:hover {
                transform: translateY(-2px);
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

        .grid-selectable tr.data-row {
            cursor: pointer;
        }

            .grid-selectable tr.data-row:hover td {
                background: #F3FAFF !important;
            }

        .grid-selectable tr.row-selected td {
            background: #E6F4FF !important;
            transition: background-color .15s ease-in-out;
        }

        .overlay .tabla-box {
            max-height: 300px;
            overflow-y: auto;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

       
        .overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.35);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 2000;
        }

            .overlay.show {
                display: flex;
            }

        .modal-box {
            position: relative;
            background: #e9ecef;
            border-radius: 14px;
            padding: 1.5rem;
            width: min(1000px,92vw);
            box-shadow: 0 16px 40px rgba(0,0,0,.35);
            border: 6px solid #000;
        }

        .modal-inner {
            background: #f3f5f7;
            border: 3px solid #222;
            border-radius: 12px;
            padding: 1rem;
        }

        .modal-title {
            font-weight: 800;
            color: #0b3650;
            margin-bottom: .75rem;
            font-size: 1.25rem;
        }

        .modal-footer {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            padding-top: .75rem;
        }

        .busqueda-box {
            background: #fff;
            border-radius: 12px;
            padding: .9rem 1rem;
            border: 1px solid #ddd;
            margin-bottom: .7rem;
        }

        .mini-label {
            font-weight: 700;
            color: #222;
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

        
        a.btn-accept, a.btn-cancel, .btn-accept, .btn-cancel,
        .icon-bar a, .icon-bar button, .btn-icon, .btn-icon-2 {
            text-decoration: none !important;
            color: inherit !important;
        }

            .btn-accept:focus, .btn-cancel:focus, .btn-icon:focus, .btn-icon-2:focus {
                outline: none !important;
                box-shadow: none !important;
            }

            
            .btn-icon-2, .btn-search, .btn-icon-2 i, .btn-search i {
                color: #fff !important;
            }

        
        #montoCol, #gvAlumnoModal td:nth-child(5), #gvAlumnoModal th:nth-child(5) {
            display: none;
        }

      
        #gvAulaModal td:nth-child(4),
        #gvAulaModal th:nth-child(4),
        #gvAulaModal td:nth-child(5),
        #gvAulaModal th:nth-child(5) {
            display: none;
        }
    </style>


    <script>
        (function () {

            
            function get(id) {
                var el = document.getElementById(id);
                if (!el) console.warn("Element not found:", id);
                return el;
            }

           
            function wireSelectableGrid(gridId, okBtnClientId) {
                const gv = get(gridId);
                const ok = get(okBtnClientId);

                if (!gv || !ok) return;

                
                try { ok.disabled = true; }
                catch (e) { ok.classList.add("disabled-link"); ok.setAttribute("aria-disabled", "true"); }

                const tbody = gv.querySelector("tbody") || gv;

                tbody.onclick = function (e) {
                    const tr = e.target.closest("tr.data-row");
                    if (!tr || !gv.contains(tr)) return;

                    gv.querySelectorAll("tr.data-row").forEach(r => r.classList.remove("row-selected"));
                    tr.classList.add("row-selected");

                  
                    try {
                        ok.disabled = false;
                        ok.classList.remove("disabled-link");
                        ok.setAttribute("aria-disabled", "false");
                    } catch (ex) {
                        ok.classList.remove("disabled-link");
                        ok.setAttribute("aria-disabled", "false");
                    }

                    try { ok.focus(); } catch (_) { }
                };
            }

            
            function initSelectors() {
                const gvAlumnoId = "gvAlumnoModal";
                const gvAulaId = "gvAulaModal";

                const btnAluOkClientId = "<%= btnAluOk.ClientID %>";
        const btnAulaOkClientId = "<%= btnAulaOk.ClientID %>";

        wireSelectableGrid(gvAlumnoId, btnAluOkClientId);
        wireSelectableGrid(gvAulaId, btnAulaOkClientId);
    }

    document.addEventListener("DOMContentLoaded", initSelectors);

    
    if (window.Sys && Sys.WebForms) {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            initSelectors();
        });
    }

   
    window.ConfirmAlumno = function () {
        const row = document.querySelector("#gvAlumnoModal tr.row-selected");
        if (!row) return false;

        const id = row.cells[0].innerText.trim();
        const apePat = row.cells[1].innerText.trim();
        const apeMat = row.cells[2].innerText.trim();
        const nombre = row.cells[3].innerText.trim();

       
        const montoSpan = row.querySelector("span.monto");
        const monto = montoSpan ? montoSpan.dataset.monto : "0";

        
        get("<%= txtAlumno.ClientID %>").value = `${apePat} ${apeMat}, ${nombre}`;

       
        get("<%= hdnAlumnoId.ClientID %>").value = id;
        const hfAl = get("hfAlumnoId"); // ClientIDMode="Static"
        if (hfAl) hfAl.value = id;

        // cerrar modal
        get("ovAlumno").classList.remove("show");
        return false;
    };

    
    window.ConfirmAula = function () {
        const row = document.querySelector("#gvAulaModal tr.row-selected");
        if (!row) return false;

        const nombreAula = row.cells[0].innerText.trim();
        const nombreGrado = row.cells[1].innerText.trim(); // (no lo usamos pero lo dejamos)

        
        const dispSpan = row.querySelector("span.disp");
        const vacTotal = dispSpan ? parseInt(dispSpan.dataset.disp, 10)
                                  : parseInt(row.cells[2].innerText.trim(), 10);

        
        const ocupSpan = row.querySelector("span.ocup");
        const vacOcup = ocupSpan ? parseInt(ocupSpan.dataset.ocup, 10) : 0;

       
        const idSpan = row.querySelector("span.id");
        const aulaId = idSpan ? idSpan.dataset.id : "0";

        
        const capacidad = vacTotal;                 
        const vacantes = Math.max(vacTotal - vacOcup, 0); 

        
        get("<%= txtAula.ClientID %>").value = nombreAula;
        get("<%= txtCapacidad.ClientID %>").value = capacidad;
        get("<%= txtVacantes.ClientID %>").value = vacantes;

       
        get("<%= hdnAulaId.ClientID %>").value = aulaId;
                const hfAu = get("hfAulaId"); 
                if (hfAu) hfAu.value = aulaId;

                
                get("ovAula").classList.remove("show");
                return false;
            };

           
            document.addEventListener("DOMContentLoaded", function () {

                const txtNomAula = get("f_nomAula");
                const txtNomGrado = get("f_nomGrado");
                const btnBuscarAula = get("btnBuscarAula");
                const grid = get("gvAulaModal");

                if (!txtNomAula || !txtNomGrado || !btnBuscarAula || !grid) return;

                function getHeaderCells(table) {
                    let ths = table.querySelectorAll("thead th");
                    if (ths.length) return Array.from(ths);

                    const firstHeaderRow = table.querySelector("tr");
                    if (!firstHeaderRow) return [];
                    const possibleThs = firstHeaderRow.querySelectorAll("th");
                    if (possibleThs.length) return Array.from(possibleThs);

                    const firstRowTds = firstHeaderRow.querySelectorAll("td");
                    return firstRowTds.length ? Array.from(firstRowTds) : [];
                }

                function findColIndexByHeader(table, headerText) {
                    const headers = getHeaderCells(table);
                    headerText = headerText.toLowerCase().trim();

                    for (let i = 0; i < headers.length; i++) {
                        const txt = (headers[i].innerText || headers[i].textContent || "")
                            .toLowerCase().trim();
                        if (!txt) continue;
                        if (txt === headerText || txt.includes(headerText)) return i;
                    }
                    return -1;
                }

                btnBuscarAula.addEventListener("click", function () {
                    const filtroAula = txtNomAula.value.toLowerCase().trim();
                    const filtroGrado = txtNomGrado.value.toLowerCase().trim();

                    const idxAula = findColIndexByHeader(grid, "Nombre de Aula");
                    const idxGrado = findColIndexByHeader(grid, "Nombre de Grado");

                    const rows = grid.querySelectorAll("tr.data-row");
                    rows.forEach(row => {
                        const cells = row.querySelectorAll("td");

                        const textoAula = (idxAula >= 0 && cells[idxAula])
                            ? (cells[idxAula].innerText || "").toLowerCase()
                            : "";

                        const textoGrado = (idxGrado >= 0 && cells[idxGrado])
                            ? (cells[idxGrado].innerText || "").toLowerCase()
                            : "";

                        const coincideAula = filtroAula === "" || textoAula.includes(filtroAula);
                        const coincideGrado = filtroGrado === "" || textoGrado.includes(filtroGrado);

                        row.style.display = (coincideAula && coincideGrado) ? "" : "none";
                    });
                });

            });

        })();
    </script>


   
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />

    <div class="container-fluid matricula-container">

        <div class="top-grid">
            <div class="year-box">
                <small>Año</small><asp:Label ID="lblAnio" runat="server" Text=""></asp:Label>
            </div>

            <div class="top-center">
                <span class="header-cta-btn">Crear Matrícula</span>
            </div>

            <div class="icon-bar top-right">
                <button type="button" class="btn-icon btn-active" title="Crear Matrícula"><i class="fa-solid fa-user-plus"></i></button>
                <button type="button" class="btn-icon btn-muted" title="Consultar" disabled><i class="fa-solid fa-eye"></i></button>
                <button type="button" class="btn-icon btn-muted" title="Editar" disabled><i class="fa-solid fa-pen"></i></button>
            </div>
        </div>

        <!-- FORM -->
        <div class="card-form">
            <div class="fieldset">
                <div class="mb-2 row g-4 align-items-start">
                    <!-- izquierda -->
                    <div class="col-lg-7">
                        <div class="mb-3 row">
                            <div class="col-md-4">
                                <label class="form-label">Alumno:</label>
                            </div>
                            <div class="col-md-7">
                                <asp:TextBox ID="txtAlumno" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>

          
                                <asp:HiddenField ID="hdnAlumnoId" runat="server" ClientIDMode="Static" />
                            </div>
                            <div class="col-md-1">
                                <button type="button" id="btnOpenAlumno" class="btn-icon-2" title="Buscar Alumno"
                                    onclick="document.getElementById('ovAlumno').classList.add('show');">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-md-4">
                                <label class="form-label">Matricula:</label>
                            </div>
                            <div class="col-md-7">
                                <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control" ReadOnly="false"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-md-4">
                                <label class="form-label">Pensión:</label>
                            </div>
                            <div class="col-md-7">
                                <asp:TextBox ID="txtPension" runat="server" CssClass="form-control" ReadOnly="false"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <!-- derecha -->
                    <div class="col-lg-5 d-flex">
                        <div class="side-panel flex-fill flex-column justify-content-center">
                            <div class="text-center">
                                <div class="side-img">
                                    <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" AlternateText="Colegio" Style="max-width: 150px; max-height: 120px;" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- AULA -->
                <fieldset class="p-3" style="border: 2px solid #d0d0d0; border-radius: 12px; background: #f6f6f6;">
                    <legend class="legend-title">Aula</legend>

                    <div class="row g-3 align-items-end">
                        <div class="col-lg-6">
                            <label class="form-label">Aula</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtAula" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>

                               
                                <asp:HiddenField ID="hdnAulaId" runat="server" ClientIDMode="Static" />

                                <button type="button" id="btnOpenAula" class="btn-icon-2" title="Buscar Aula"
                                    onclick="document.getElementById('ovAula').classList.add('show');">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <label class="form-label">Capacidad</label>
                            <asp:TextBox ID="txtCapacidad" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-lg-3">
                            <label class="form-label">Vacantes</label>
                            <asp:TextBox ID="txtVacantes" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>
                </fieldset>
            </div>

           
            <div class="action-buttons mt-3">
                <asp:LinkButton ID="btnConfirmar" runat="server" CssClass="btn-accept" OnClick="btnConfirmar_Click" ToolTip="Crear y volver">
                    <i class="fa-solid fa-check"></i>
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel" OnClick="btnCancelar_Click" ToolTip="Cancelar y volver">
                    <i class="fa-solid fa-xmark"></i>
                </asp:LinkButton>
            </div>
        </div>

        <!--  MODAL ALUMNO  -->
        <asp:UpdatePanel ID="upAlumno" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
            <ContentTemplate>

                <div id="ovAlumno" class="overlay" aria-hidden="true">
                    <div class="modal-box">
                        <div class="modal-inner">
                            <div class="modal-title">Buscar Alumno</div>

                            <div class="busqueda-box">
                                <div class="row g-3 align-items-end">
                                    <div class="col-md-2">
                                        <label class="mini-label">Código Familia</label><asp:TextBox ID="txtCodFam_Alum" runat="server" CssClass="form-control"></asp:TextBox></div>
                                    <div class="col-md-2">
                                        <label class="mini-label">Apellido Paterno</label><asp:TextBox ID="txtApePat_Alum" runat="server" CssClass="form-control"></asp:TextBox></div>
                                    <div class="col-md-2">
                                        <label class="mini-label">Apellido Materno</label><asp:TextBox ID="txtApeMat_Alum" runat="server" CssClass="form-control"></asp:TextBox></div>
                                    <div class="col-md-2">
                                        <label class="mini-label">DNI</label><asp:TextBox ID="txtdni_Alum" runat="server" CssClass="form-control"></asp:TextBox></div>
                                    <div class="col-md-2">
                                        <label class="mini-label">Nombre</label><asp:TextBox ID="txtNombre_Alum" runat="server" CssClass="form-control"></asp:TextBox></div>
                                    <div class="col-md-2 d-flex justify-content-center">
                                        <asp:LinkButton ID="btnBuscarAlumno"
                                            runat="server"
                                            CssClass="btn btn-search"
                                            ToolTip="Buscar"
                                            OnClick="btnBuscarAlumno_OnClick"
                                            CausesValidation="false"
                                            UseSubmitBehavior="false">
                                            <i class="fa-solid fa-magnifying-glass" aria-hidden="true"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>

                            <div class="tabla-box grid-selectable">
                                <asp:GridView ID="gvAlumnoModal" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-bordered table-hover align-middle mb-0"
                                    ClientIDMode="Static" ShowHeaderWhenEmpty="true"
                                    DataKeyNames="alumno_id"
                                    OnRowDataBound="gvAlumnoModal_RowDataBound">

                                    <HeaderStyle CssClass="table-header" />

                                    <Columns>

                                        <asp:BoundField HeaderText="Código" DataField="alumno_id" />

                                        <asp:TemplateField HeaderText="Apellido Paterno">
                                            <ItemTemplate><%# Eval("padres.apellido_paterno") %></ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Apellido Materno">
                                            <ItemTemplate><%# Eval("padres.apellido_materno") %></ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Nombre">
                                            <ItemTemplate><%# Eval("nombre") %></ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField HeaderText="DNI" DataField="dni" />

                                        <asp:TemplateField HeaderText="Código Familia">
                                            <ItemTemplate><%# Eval("padres.familia_id") %></ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>

                                    <RowStyle CssClass="data-row" />
                                </asp:GridView>
                            </div>

                            <div class="modal-footer">
                                <asp:LinkButton ID="btnAluOk" runat="server" CssClass="btn-accept"
                                    OnClientClick="return ConfirmAlumno();" UseSubmitBehavior="false" ToolTip="Seleccionar">
                                    <i class="fa-solid fa-check"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAluClose" runat="server" CssClass="btn-cancel"
                                    OnClientClick="document.getElementById('ovAlumno').classList.remove('show'); return false;"
                                    UseSubmitBehavior="false" ToolTip="Cerrar">
                                    <i class="fa-solid fa-xmark"></i>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>

            </ContentTemplate>

            <Triggers>
                <asp:PostBackTrigger ControlID="btnBuscarAlumno" />
            </Triggers>
        </asp:UpdatePanel>

        <!--  MODAL AULA  -->
        <asp:UpdatePanel ID="upAula" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
            <ContentTemplate>

                <div id="ovAula" class="overlay" aria-hidden="true">
                    <div class="modal-box">
                        <div class="modal-inner">
                            <div class="modal-title">Buscar Aula</div>

                            <div class="busqueda-box">
                                <div class="row g-3 align-items-end">
                                    <div class="col-md-5">
                                        <label class="mini-label">Nombre de Aula</label><input id="f_nomAula" type="text" class="form-control" /></div>
                                    <div class="col-md-5">
                                        <label class="mini-label">Nombre de Grado Académico</label><input id="f_nomGrado" type="text" class="form-control" /></div>
                                    <div class="col-md-2 d-flex justify-content-center">
                                        <button type="button" id="btnBuscarAula" class="btn-search" title="Buscar">
                                            <i class="fa-solid fa-magnifying-glass"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="tabla-box grid-selectable">
                                <asp:GridView ID="gvAulaModal" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-bordered table-hover align-middle mb-0"
                                    ClientIDMode="Static" ShowHeaderWhenEmpty="true"
                                    DataKeyNames="periodo_aula_id"
                                    OnRowDataBound="gvAulaModal_RowDataBound">

                                    <HeaderStyle CssClass="table-header" />

                                    <Columns>
                                        <asp:TemplateField HeaderText="Nombre de Aula">
                                            <ItemTemplate>
                                                <%# Eval("aula.nombre") %>
                                                <span class="id" data-id='<%# Eval("aula.aula_id") %>'></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Nombre de Grado">
                                            <ItemTemplate><%# Eval("aula.grado.nombre") %></ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Capacidad">
                                            <ItemTemplate>
                                                <%# Eval("vacantes_disponibles") %>
                                                <span class="disp" data-disp='<%# Eval("vacantes_disponibles") %>'></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>



                                        <asp:TemplateField HeaderText="ID Aula">
                                            <ItemTemplate>
                                                <span class="id" data-id='<%# Eval("aula.aula_id") %>'></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Vac Ocupadas">
                                            <ItemTemplate>
                                                <span class="ocup" data-ocup='<%# Eval("vacantes_ocupadas") %>'></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>

                                    <RowStyle CssClass="data-row" />
                                </asp:GridView>
                            </div>

                            <div class="modal-footer">
                                <asp:LinkButton ID="btnAulaOk" runat="server" CssClass="btn-accept"
                                    OnClientClick="return ConfirmAula();" UseSubmitBehavior="false" ToolTip="Seleccionar">
                                    <i class="fa-solid fa-check"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAulaClose" runat="server" CssClass="btn-cancel"
                                    OnClientClick="document.getElementById('ovAula').classList.remove('show'); return false;"
                                    UseSubmitBehavior="false" ToolTip="Cerrar">
                                    <i class="fa-solid fa-xmark"></i>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</asp:Content>
