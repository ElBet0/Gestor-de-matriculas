<%@ Page Title="Editar Matrícula" Language="C#" MasterPageFile="~/SoftProg.Master"
    AutoEventWireup="true" CodeBehind="EditarMatricula.aspx.cs"
    Inherits="FrontTA.Matricula.EditarMatricula" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Editar Matrícula
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root{
            --verde:#74D569; --verdeOsc:#016A13; --gris:#E1E1E1;
            --grisTexto:#777; --blanco:#FFF; --negro:#000;
            --celeste:#BFE7FF; --celesteBtn:#8FD2FF; --borde:#D7D7D7;
        }

        .matricula-container{ background:var(--gris); padding:1.5rem; border-radius:1rem; box-shadow:0 3px 8px rgba(0,0,0,.1); }

        /* ===== top layout (Año | Editar Matrícula | iconos) ===== */
        .top-grid{ display:grid; grid-template-columns:1fr auto 1fr; align-items:center; gap:1rem; margin-bottom:.75rem; }
        .top-right{ justify-self:end; }
        .top-center{ justify-self:center; }

        .year-box{ background:#c9c9c9; border:3px solid #111; border-radius:16px; padding:.65rem 1.25rem; min-width:360px; font-weight:800; font-size:2rem; color:#111; box-shadow:inset 0 3px 6px rgba(0,0,0,.12); }
        .year-box small{ font-size:1.25rem; font-weight:800; margin-right:.5rem; }

        .icon-bar{ display:inline-flex; gap:.75rem; background:var(--blanco); border-radius:12px; padding:.6rem .75rem; box-shadow:0 2px 6px rgba(0,0,0,.1); }
        .btn-icon{ border:0; width:44px; height:44px; border-radius:12px; display:inline-flex; align-items:center; justify-content:center; font-size:1.15rem; transition:transform .15s ease, background .15s ease, color .15s; }
        .btn-active{ background:var(--celesteBtn); color:#00324D; }
        .btn-muted{ background:#F1F1F1; color:var(--grisTexto); }
        .btn-muted[disabled]{ opacity:.9; cursor:not-allowed; }

        .header-cta-btn{
            background:#F3F4F6; color:#000; border:1px solid #E5E7EB;
            padding:.55rem 1.15rem; border-radius:6px; font-weight:800;
            box-shadow:0 2px 6px rgba(0,0,0,.06);
        }

        /* ===== formulario ===== */
        .card-form{ background:var(--blanco); border-radius:16px; padding:1.25rem; box-shadow:0 2px 6px rgba(0,0,0,.12); }
        .fieldset{ border:2px solid #E0E0E0; border-radius:16px; padding:1.25rem; background:#F8F8F8; }
        .legend-title{
            font-weight:800; color:#444; padding:.25rem .6rem; border:2px solid #D0D0D0;
            border-radius:10px; background:#F2F2F2;
        }
        .form-label{ font-weight:700; font-size:1.05rem; color:#1f2937; }
        .form-control{ border:1px solid var(--borde); border-radius:8px; height:44px; }
        .readonly-gray{ background:#BDBDBD !important; color:#444 !important; border:1px solid #AFAFAF !important; }

        .side-panel{ max-width:300px; min-width:200px; padding:1rem 2rem; border-radius:16px; background:var(--celeste); display:flex; align-items:center; justify-content:center; border:1px solid #a7d7f3; }
        .side-img{ background:#ffffffaa; border:2px solid #d7eefc; border-radius:16px; padding:1rem; }

        .btn-icon-2{ background:var(--verde); color:#fff; border:0; width:44px; height:44px; border-radius:12px; font-size:1.15rem; display:inline-flex; align-items:center; justify-content:center; transition:transform .15s ease, background .15s ease; }
        .btn-icon-2:hover{ background:var(--verdeOsc); transform:scale(1.05); }

        .action-buttons{ display:flex; gap:1rem; justify-content:flex-end; }
        .btn-accept,.btn-cancel{ width:56px; height:56px; border-radius:12px; border:2px solid #00000030; display:inline-flex; align-items:center; justify-content:center; font-size:1.6rem; background:#fff; transition:transform .15s ease; }
        .btn-accept i{ color:#2E7D32 !important; }
        .btn-cancel i{ color:#D32F2F !important; }
        .btn-accept:hover,.btn-cancel:hover{ transform:translateY(-2px); }

        /* ===== tablas ===== */
        .tabla-box{ background:var(--blanco); border-radius:10px; box-shadow:0 2px 6px rgba(0,0,0,.1); overflow-x:auto; }
        .table-header{ background:var(--verde); color:#fff; text-align:center; }
        .grid-selectable tr.data-row{ cursor:pointer; }
        .grid-selectable tr.data-row:hover td{ background:#F3FAFF !important; }
        .grid-selectable tr.row-selected td{ background:#E6F4FF !important; transition:background-color .15s ease-in-out; }

        /* ===== modal ===== */
        .overlay{ position:fixed; inset:0; background:rgba(0,0,0,.35); display:none; align-items:center; justify-content:center; z-index:2000; }
        .overlay.show{ display:flex; }
        .modal-box{ position:relative; background:#e9ecef; border-radius:14px; padding:1.5rem; width:min(1000px,92vw); box-shadow:0 16px 40px rgba(0,0,0,.35); border:6px solid #000; }
        .modal-inner{ background:#f3f5f7; border:3px solid #222; border-radius:12px; padding:1rem; }
        .modal-title{ font-weight:800; color:#0b3650; margin-bottom:.75rem; font-size:1.25rem; }
        .modal-footer{ display:flex; gap:1rem; justify-content:flex-end; padding-top:.75rem; }
        .busqueda-box{ background:#fff; border-radius:12px; padding:.9rem 1rem; border:1px solid #ddd; margin-bottom:.7rem; }
        .mini-label{ font-weight:700; color:#222; }
        .btn-search{ background:var(--verde); color:#fff; border:0; width:44px; height:44px; border-radius:12px; }
        .btn-search:hover{ background:var(--verdeOsc); }

        /* Fix: no subrayado/azul en botones (incluye LinkButton) */
        a.btn-accept, a.btn-cancel, .btn-accept, .btn-cancel,
        .icon-bar a, .icon-bar button, .btn-icon, .btn-icon-2 {
            text-decoration:none !important; color:inherit !important;
        }
        .btn-accept:focus, .btn-cancel:focus, .btn-icon:focus, .btn-icon-2:focus {
            outline:none !important; box-shadow:none !important;
        }
        /* Íconos blancos en botones verdes */
        .btn-icon-2, .btn-search, .btn-icon-2 i, .btn-search i { color:#fff !important; }
    </style>

    <script>
        function wireSelectableGrid(gridId, okBtnId){
            const gv = document.getElementById(gridId);
            const ok = document.getElementById(okBtnId);
            if(!gv || !ok) return;
            ok.disabled = true;
            gv.addEventListener('click', e=>{
                const tr = e.target.closest('tr.data-row'); if(!tr) return;
                gv.querySelectorAll('tr').forEach(r=>r.classList.remove('row-selected'));
                tr.classList.add('row-selected');
                ok.disabled = false;
            });
        }

        function filterTable(gridId, preds){
            const tbody = document.querySelector('#'+gridId+' tbody'); if(!tbody) return;
            [...tbody.rows].forEach(r=>{
                let show = true;
                preds.forEach(p=>{
                    const val = (r.cells[p.col].textContent||'').trim().toLowerCase();
                    const q = (p.q()||'').trim().toLowerCase();
                    if(q && !val.includes(q)) show = false;
                });
                r.style.display = show ? '' : 'none';
            });
        }

        function ConfirmAlumno(){
            const tr = document.querySelector('#gvAluModal tr.row-selected'); if(!tr) return false;
            const c = tr.children;
            document.getElementById('<%= txtAlumno.ClientID %>').value = c[1].textContent.trim() + ' ' + c[2].textContent.trim() + ', ' + c[3].textContent.trim();
            document.getElementById('<%= hdnAlumnoId.ClientID %>').value = c[0].textContent.trim();
            document.getElementById('ovAlumno').classList.remove('show');
            return false;
        }

        function ConfirmAula(){
            const tr = document.querySelector('#gvAulaModal tr.row-selected'); if(!tr) return false;
            const c = tr.children;
            document.getElementById('<%= txtAula.ClientID %>').value      = c[1].textContent.trim();
            document.getElementById('<%= txtCapacidad.ClientID %>').value = c[2].textContent.trim();
            document.getElementById('<%= txtVacantes.ClientID %>').value  = c[3].textContent.trim();
            document.getElementById('<%= hdnAulaId.ClientID %>').value    = c[0].textContent.trim();
            document.getElementById('ovAula').classList.remove('show');
            return false;
        }

        document.addEventListener('DOMContentLoaded', function(){
            wireSelectableGrid('gvAluModal','btnAluOk');
            wireSelectableGrid('gvAulaModal','btnAulaOk');

            document.getElementById('btnBuscarAlumno').addEventListener('click', ()=>{
                filterTable('gvAluModal',[
                    {col:0, q:()=>document.getElementById('f_codAlu').value},
                    {col:1, q:()=>document.getElementById('f_apePat').value},
                    {col:2, q:()=>document.getElementById('f_apeMat').value},
                    {col:3, q:()=>document.getElementById('f_nombre').value},
                    {col:4, q:()=>document.getElementById('f_dni').value},
                    {col:5, q:()=>document.getElementById('f_codFam').value}
                ]);
            });

            document.getElementById('btnBuscarAula').addEventListener('click', ()=>{
                filterTable('gvAulaModal',[
                    {col:1, q:()=>document.getElementById('f_nomAula').value},
                    {col:2, q:()=>document.getElementById('f_nomGrado').value}
                ]);
            });

            // ESC cierra
            document.addEventListener('keydown', e=>{
                if(e.key!=='Escape') return;
                ['ovAlumno','ovAula'].forEach(id=>document.getElementById(id).classList.remove('show'));
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid matricula-container">

        <!-- Año | Editar | Iconos -->
        <div class="top-grid">
            <div class="year-box">
                <small>Año</small><asp:Label ID="lblAnio" runat="server" Text=""></asp:Label>
            </div>

            <div class="top-center">
                <span class="header-cta-btn">Editar Matrícula</span>
            </div>

            <div class="icon-bar top-right">
                <!-- Crear (bloqueado) -->
                <button type="button" class="btn-icon btn-muted" title="Crear" disabled><i class="fa-solid fa-user-plus"></i></button>
                <!-- Ver (bloqueado) -->
                <button type="button" class="btn-icon btn-muted" title="Consultar" disabled><i class="fa-solid fa-eye"></i></button>
                <!-- Editar (activo) -->
                <button type="button" class="btn-icon btn-active" title="Editar Matrícula"><i class="fa-solid fa-pen"></i></button>
            </div>
        </div>

        <!-- FORM -->
        <div class="card-form">
            <div class="fieldset">
                <div class="mb-2 row g-4 align-items-start">
                    <!-- izquierda -->
                    <div class="col-lg-7">
                        <div class="mb-3 row">
                            <div class="col-md-4"><label class="form-label">Alumno:</label></div>
                            <div class="col-md-7">
                                <asp:TextBox ID="txtAlumno" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>
                                <asp:HiddenField ID="hdnAlumnoId" runat="server" />
                            </div>
                            <div class="col-md-1">
                                <button type="button" class="btn-icon-2" title="Buscar Alumno"
                                        onclick="document.getElementById('ovAlumno').classList.add('show');">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-md-4"><label class="form-label">Monto:</label></div>
                            <div class="col-md-7"><asp:TextBox ID="txtMonto" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox></div>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-md-4"><label class="form-label">Activo:</label></div>
                            <div class="col-md-7">
                                <!-- Único editable -->
                                <asp:TextBox ID="txtActivo" runat="server" CssClass="form-control" MaxLength="2"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <!-- derecha -->
                    <div class="col-lg-5 d-flex">
                        <div class="side-panel flex-fill flex-column justify-content-center">
                            <div class="text-center">
                                <div class="side-img">
                                    <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" AlternateText="Colegio" Style="max-width:150px; max-height:120px;" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- AULA -->
                <fieldset class="p-3" style="border:2px solid #d0d0d0;border-radius:12px;background:#f6f6f6;">
                    <legend class="legend-title">Aula</legend>

                    <div class="row g-3 align-items-end">
                        <div class="col-lg-6">
                            <label class="form-label">Aula</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtAula" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>
                                <asp:HiddenField ID="hdnAulaId" runat="server" />
                                <button type="button" class="btn-icon-2" title="Buscar Aula"
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

            <!-- ✔ / ✖ -->
            <div class="action-buttons mt-3">
                <asp:LinkButton ID="btnGuardar" runat="server" CssClass="btn-accept" OnClick="btnGuardar_Click" ToolTip="Guardar cambios y volver">
                    <i class="fa-solid fa-check"></i>
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel" OnClick="btnCancelar_Click" ToolTip="Cancelar y volver">
                    <i class="fa-solid fa-xmark"></i>
                </asp:LinkButton>
            </div>
        </div>

        <!-- ===== Modal: Buscar Alumno ===== -->
        <div id="ovAlumno" class="overlay" aria-hidden="true">
            <div class="modal-box">
                <div class="modal-inner">
                    <div class="modal-title">Buscar Alumno</div>

                    <div class="busqueda-box">
                        <div class="row g-3 align-items-end">
                            <div class="col-md-2"><label class="mini-label">Código Familia</label><input id="f_codFam" type="text" class="form-control" /></div>
                            <div class="col-md-2"><label class="mini-label">Código Alumno</label><input id="f_codAlu" type="text" class="form-control" /></div>
                            <div class="col-md-2"><label class="mini-label">Apellido Paterno</label><input id="f_apePat" type="text" class="form-control" /></div>
                            <div class="col-md-2"><label class="mini-label">DNI</label><input id="f_dni" type="text" class="form-control" /></div>
                            <div class="col-md-2"><label class="mini-label">Nombre</label><input id="f_nombre" type="text" class="form-control" /></div>
                            <div class="col-md-2 d-flex justify-content-center">
                                <button type="button" id="btnBuscarAlumno" class="btn-search" title="Buscar"><i class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                        </div>
                    </div>

                    <div class="tabla-box grid-selectable">
                        <asp:GridView ID="gvAluModal" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-bordered table-hover align-middle mb-0"
                            ClientIDMode="Static" ShowHeaderWhenEmpty="true"
                            OnRowDataBound="gv_RowDataBound">
                            <HeaderStyle CssClass="table-header" />
                            <Columns>
                                <asp:BoundField HeaderText="Código Alumno" DataField="Codigo" />
                                <asp:BoundField HeaderText="Apellido Paterno" DataField="ApePat" />
                                <asp:BoundField HeaderText="Apellido Materno" DataField="ApeMat" />
                                <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                                <asp:BoundField HeaderText="DNI" DataField="Dni" />
                                <asp:BoundField HeaderText="Código Familia" DataField="CodFam" />
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

        <!-- ===== Modal: Buscar Aula ===== -->
        <div id="ovAula" class="overlay" aria-hidden="true">
            <div class="modal-box">
                <div class="modal-inner">
                    <div class="modal-title">Buscar Aula</div>

                    <div class="busqueda-box">
                        <div class="row g-3 align-items-end">
                            <div class="col-md-5"><label class="mini-label">Nombre de Aula</label><input id="f_nomAula" type="text" class="form-control" /></div>
                            <div class="col-md-5"><label class="mini-label">Nombre de Grado Académico</label><input id="f_nomGrado" type="text" class="form-control" /></div>
                            <div class="col-md-2 d-flex justify-content-center">
                                <button type="button" id="btnBuscarAula" class="btn-search" title="Buscar"><i class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                        </div>
                    </div>

                    <div class="tabla-box grid-selectable">
                        <asp:GridView ID="gvAulaModal" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-bordered table-hover align-middle mb-0"
                            ClientIDMode="Static" ShowHeaderWhenEmpty="true"
                            OnRowDataBound="gv_RowDataBound">
                            <HeaderStyle CssClass="table-header" />
                            <Columns>
                                <asp:BoundField HeaderText="Id" DataField="Id" />
                                <asp:BoundField HeaderText="Nombre de Aula" DataField="Aula" />
                                <asp:BoundField HeaderText="Nombre de Grado" DataField="Grado" />
                                <asp:BoundField HeaderText="Vacantes disponibles" DataField="Vacantes" />
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

    </div>
</asp:Content>
