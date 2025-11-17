<%@ Page Title="Matrícula" Language="C#" MasterPageFile="~/SoftProg.Master"
    AutoEventWireup="true" CodeBehind="Matricula.aspx.cs"
    Inherits="FrontTA.Matricula.Matricula" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Matrícula
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --blanco: #FFFFFF;
            --negro: #000;
        }

        /* FILA única por año */
        .matri-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            background: #f3f3f3;
            border: 1px solid #d7d7d7;
            border-radius: 16px;
            padding: 14px 18px;
            box-shadow: 0 4px 10px rgba(0,0,0,.15);
            margin-bottom: 16px;
        }

        /* Bloque izquierdo: año + texto + “cifra” gris */
        .matri-left {
            display: flex;
            align-items: center;
            gap: 18px;
            min-width: 0;
        }

        .year-badge {
            min-width: 120px;
            height: 70px;
            border-radius: 14px;
            background: #e9e9e9;
            border: 2px solid #bdbdbd;
            font-weight: 800;
            font-size: 2rem;
            color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: inset 0 0 0 3px #e5e5e5, 0 6px 8px rgba(0,0,0,.15);
        }

        .matri-title {
            font-weight: 800;
            font-size: 1.45rem;
            color: #333;
            white-space: nowrap;
        }

        .count-pill {
            display: inline-block;
            width: 220px;
            height: 44px;
            border-radius: 12px;
            background: #c9c9c9;
            border: 2px solid #8f8f8f;
            box-shadow: inset 0 2px 2px rgba(0,0,0,.05);
        }

        /* Bloque derecho: Reporte + Acción */
        .matri-right {
            display: flex;
            align-items: center;
            gap: .75rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: .5rem;
            padding: .6rem 1rem;
            border-radius: 12px;
            font-weight: 800;
            text-decoration: none;
            border: 2px solid transparent;
            box-shadow: 0 6px 8px rgba(0,0,0,.15);
        }
        /* Reporte */
        .btn-report {
            background: var(--blanco);
            color: var(--verdeOsc);
            border-color: var(--verdeOsc);
        }

            .btn-report:hover {
                background: var(--verde);
                color: #fff;
            }

        /* Acción */
        .btn-green {
            background: var(--verdeOsc);
            color: #fff;
            border-color: #0f571a;
        }

            .btn-green:hover {
                background: #0f571a;
                color: #fff;
            }

        .btn-gray {
            background: #e6e6e6;
            color: #222;
            border-color: #bdbdbd;
        }

            .btn-gray:hover {
                background: #dbdbdb;
                color: #111;
            }

        /* Icono */
        .btn i {
            font-size: 1.1rem;
        }

        /* Subtítulo centrado */
        .top-grid {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            align-items: center;
            gap: 1rem;
            margin-bottom: .75rem;
        }

        .top-left {
            justify-self: start;
        }

        .top-center {
            justify-self: center;
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

        /* CONTENEDOR de íconos (no botón) */
        .icon-bar {
            display: inline-flex;
            gap: .75rem;
            background: #fff; /* tarjetita blanca */
            border-radius: 12px;
            padding: .6rem .75rem;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
        }

        /* BOTONES */
        .btn-icon {
            border: 0;
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.15rem;
            background: var(--verde); /* todos VERDES */
            color: #fff;
            transition: transform .15s ease, background .15s ease, color .15s;
        }

            .btn-icon:hover {
                transform: scale(1.05);
                background: var(--verdeOsc);
                color: #fff;
            }

            .btn-icon i,
            .icon-bar .btn-icon i {
                color: #fff !important;
            }

            /* Mantén blancos también en hover / focus */
            .btn-icon:hover i,
            .btn-icon:focus i {
                color: #fff !important;
            }

        /* Si mantuviste clases alias, fuerza blanco igual */
        .btn-create i, .btn-edit i, .btn-delete i {
            color: #fff !important;
        }    

        /* por si existen clases antiguas, forzarlas a verde */
        .btn-create, .btn-edit, .btn-delete {
            background: var(--verde) !important;
            color: #fff !important;
        }

            .btn-create:hover, .btn-edit:hover, .btn-delete:hover {
                background: var(--verdeOsc) !important;
                color: #fff !important;
            }

        /* Icono inline (otros botones de tu página) */
        .btn i {
            font-size: 1.1rem;
        }

        /* ====== Modales / tablas (igual que tenías) ====== */
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
            width: min(900px,92vw);
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
            text-decoration: none !important;
            color: inherit !important;
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

        .mini-label {
            font-weight: 700;
            color: #222;
        }

        .form-control {
            border: 1px solid #D7D7D7;
            border-radius: 8px;
            height: 44px;
        }

        /* quita subrayados en iconos/botones dentro de la barra */
        .icon-bar a, .icon-bar button {
            text-decoration: none !important;
            color: inherit !important;
        }


    </style>

    <script>
        // Selección por fila y habilitar OK
        function wireSelectableGrid(gridId, okBtnId, hiddenId) {
            const gv = document.getElementById(gridId);
            if (!gv) return;

            // Toma tbody si existe, sino el grid completo
            const areaClick = gv.tBodies && gv.tBodies.length ? gv.tBodies[0] : gv;
            const ok = okBtnId ? document.getElementById(okBtnId) : null;
            const hid = hiddenId ? document.getElementById(hiddenId) : null;

            if (ok) ok.disabled = true;

            areaClick.addEventListener('click', function (e) {
                const tr = e.target.closest('tr');                // fila clickeada
                if (!tr || !tr.classList.contains('data-row')) return;

                // limpiar selección previa SOLAMENTE en filas de datos
                (gv.querySelectorAll('tr.data-row') || []).forEach(r => r.classList.remove('row-selected'));
                tr.classList.add('row-selected');

                // primer campo = Año
                const year = (tr.cells[0]?.textContent || '').trim();
                if (hid) hid.value = year;
                if (ok) ok.disabled = false;
            }, false);
        }

        // Inicializa (incluye tus grids de editar/eliminar)
        document.addEventListener('DOMContentLoaded', function () {
            wireSelectableGrid('gvPeriodosEdit', 'btnEditOk', 'hdnPeriodoSel');
            wireSelectableGrid('gvPeriodosDel', 'btnDelOk', 'hdnPeriodoDel');

            // ESC cierra modales
            document.addEventListener('keydown', e => {
                if (e.key !== 'Escape') return;
                ['ovCrear', 'ovEditar', 'ovEliminar'].forEach(id => {
                    const el = document.getElementById(id); if (el) el.classList.remove('show');
                });
            });
        });
    </script>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="top-grid">
        <div class="top-left">
            <div class="icon-bar">
                <button type="button" class="btn-icon btn-create" title="Crear Periodo Académico" onclick="document.getElementById('ovCrear').classList.add('show');">
                    <i class="fa-solid fa-calendar-plus"></i>
                </button>
                <button type="button" class="btn-icon btn-edit" title="Modificar Periodo Académico" onclick="document.getElementById('ovEditar').classList.add('show');">
                    <i class="fa-solid fa-pen"></i>
                </button>
                <button type="button" class="btn-icon btn-delete" title="Eliminar Periodo Académico" onclick="document.getElementById('ovEliminar').classList.add('show');">
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>
        </div>
        <div class="top-center">
            <span class="header-cta-btn">Gestión Periodo Académico</span>
        </div>
        <div></div>
    </div>

    <!-- ===== Modal: CREAR PERIODO ===== -->
    <div id="ovCrear" class="overlay" aria-hidden="true">
        <div class="modal-box">
            <div class="modal-inner">
                <div class="modal-title">Crear Periodo Académico</div>
                <div class="mb-3">
                    <label class="mini-label">Año</label>
                    <asp:TextBox ID="txtNuevoAnio" runat="server" CssClass="form-control" MaxLength="4"></asp:TextBox>
                    <asp:Label ID="lblErrCrear" runat="server" ForeColor="#D32F2F" CssClass="mt-2 d-block"></asp:Label>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnCrearOk" runat="server" CssClass="btn-accept" OnClick="btnCrearOk_Click" ToolTip="Crear">
                        <i class="fa-solid fa-check"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCrearCancel" runat="server" CssClass="btn-cancel"
                        OnClientClick="document.getElementById('ovCrear').classList.remove('show'); return false;" ToolTip="Cancelar">
                        <i class="fa-solid fa-xmark"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== Modal: EDITAR PERIODO ===== -->
    <div id="ovEditar" class="overlay" aria-hidden="true">
        <div class="modal-box">
            <div class="modal-inner">
                <div class="modal-title">Modificar Periodo Académico</div>

                <div class="row g-3">
                    <div class="col-lg-7">
                        <div class="tabla-box grid-selectable">
                            <asp:GridView ID="gvPeriodosEdit" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-bordered table-hover align-middle mb-0" ClientIDMode="Static"
                                ShowHeaderWhenEmpty="true" OnRowDataBound="gv_RowDataBound">
                                <HeaderStyle CssClass="table-header" />
                                <Columns>
                                    <asp:BoundField HeaderText="Año" DataField="Anio" />
                                    <asp:BoundField HeaderText="Estado" DataField="Estado" />
                                </Columns>
                                <RowStyle CssClass="data-row" />
                            </asp:GridView>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <label class="mini-label">Nuevo Año</label>
                        <asp:TextBox ID="txtEditarAnio" runat="server" CssClass="form-control" MaxLength="4"></asp:TextBox>
                        <asp:HiddenField ID="hdnPeriodoSel" runat="server" />
                        <asp:Label ID="lblErrEditar" runat="server" ForeColor="#D32F2F" CssClass="mt-2 d-block"></asp:Label>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:LinkButton ID="btnEditOk" runat="server" CssClass="btn-accept" OnClick="btnEditOk_Click" ToolTip="Guardar cambios">
                        <i class="fa-solid fa-check"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnEditCancel" runat="server" CssClass="btn-cancel"
                        OnClientClick="document.getElementById('ovEditar').classList.remove('show'); return false;" ToolTip="Cancelar">
                        <i class="fa-solid fa-xmark"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== Modal: ELIMINAR PERIODO ===== -->
    <div id="ovEliminar" class="overlay" aria-hidden="true">
        <div class="modal-box">
            <div class="modal-inner">
                <div class="modal-title">Eliminar Periodo Académico</div>

                <div class="tabla-box grid-selectable mb-3">
                    <asp:GridView ID="gvPeriodosDel" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-bordered table-hover align-middle mb-0" ClientIDMode="Static"
                        ShowHeaderWhenEmpty="true" OnRowDataBound="gv_RowDataBound">
                        <HeaderStyle CssClass="table-header" />
                        <Columns>
                            <asp:BoundField HeaderText="Año" DataField="Anio" />
                            <asp:BoundField HeaderText="Estado" DataField="Estado" />
                        </Columns>
                        <RowStyle CssClass="data-row" />
                    </asp:GridView>
                </div>

                <asp:HiddenField ID="hdnPeriodoDel" runat="server" />
                <asp:Label ID="lblErrEliminar" runat="server" ForeColor="#D32F2F" CssClass="mt-2 d-block"></asp:Label>

                <div class="modal-footer">
                    <asp:LinkButton ID="btnDelOk" runat="server" CssClass="btn-accept" OnClick="btnDelOk_Click" ToolTip="Confirmar eliminación">
                        <i class="fa-solid fa-check"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDelCancel" runat="server" CssClass="btn-cancel"
                        OnClientClick="document.getElementById('ovEliminar').classList.remove('show'); return false;" ToolTip="Cancelar">
                        <i class="fa-solid fa-xmark"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <asp:Repeater ID="rptAnios" runat="server"
        OnItemDataBound="rptAnios_ItemDataBound"
        OnItemCommand="rptAnios_ItemCommand">

        <ItemTemplate>
            <div class="matri-row">
                <!-- IZQUIERDA -->
                <div class="matri-left">
                    <div class="year-badge"><%# Eval("Anio") %></div>
                    <div class="matri-title">Alumnos Matriculados</div>
                    
                    <span class="count-pill" title="Cantidad (ejemplo)"></span>
                </div>

                <!-- DERECHA -->
                <div class="matri-right">
                    <asp:HyperLink ID="lnkReporte" runat="server" CssClass="btn btn-report" ToolTip="Reporte por año">
                        <i class="fa-solid fa-clipboard-list"></i><span>Reporte</span>
                    </asp:HyperLink>

                    <asp:LinkButton ID="btnAccion" runat="server" CssClass="btn"
                        CommandName="abrir" CommandArgument='<%# Eval("Anio") %>'>
                        <i class="fa-solid fa-user-plus"></i><span>Acción</span>
                    </asp:LinkButton>

                    <asp:HiddenField ID="hfEsVigente" runat="server" Value='<%# Eval("EsVigente") %>' />
                </div>
            </div>
        </ItemTemplate>

    </asp:Repeater>
</asp:Content>
