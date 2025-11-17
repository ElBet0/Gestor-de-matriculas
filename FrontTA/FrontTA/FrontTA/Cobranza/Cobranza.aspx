<%@ Page Title="Cobranza" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true"
    CodeBehind="Cobranza.aspx.cs" Inherits="FrontTA.Cobranza.Cobranza" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Cobranza
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --blanco: #FFF;
            --negro: #000;
            --borde: #D7D7D7;
        }

        /* Contenedor principal */
        .cobranza-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
        }

        /* Barra de íconos */
        .icon-bar-wrap {
            display: block;
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
            position: relative;
            overflow: visible;
        }

            .btn-icon:hover {
                background: var(--verdeOsc);
                transform: scale(1.05);
            }

            .btn-icon.btn-disabled,
            .btn-icon[disabled] {
                background: #E1E1E1 !important;
                color: #777 !important;
                cursor: not-allowed;
                transform: none !important;
                box-shadow: none !important;
            }

        /* Badge + (para crear deuda/pago) */
        .btn-plus::after {
            content: "+";
            position: absolute;
            right: -4px;
            top: -4px;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            background: var(--verdeOsc);
            color: #fff;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: .85rem;
            line-height: 1;
            box-shadow: 0 1px 3px rgba(0,0,0,.25);
        }

        .btn-disabled.btn-plus::after {
            background: #9aa0a6;
        }

        /* Caja blanca de búsqueda (Division 1) */
        .busqueda-box {
            background: var(--blanco);
            border-radius: 10px;
            padding: 1rem;
            box-shadow: 0 2px 5px rgba(0,0,0,.08);
        }

        .form-label {
            font-weight: 700;
            color: var(--negro);
        }

        .form-control, .filtro-select {
            border: 1px solid var(--borde);
            border-radius: 8px;
            height: 40px;
        }

        .btn-search, .btn-buscar {
            background: var(--verde);
            color: #fff;
            border: 0;
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

            .btn-search:hover, .btn-buscar:hover {
                background: var(--verdeOsc);
            }

        /* Caja blanca de tabla (Division 2) */
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

        /* Selección de filas */
        .tabla-box table.table tbody tr.data-row {
            cursor: pointer;
        }

            .tabla-box table.table tbody tr.data-row.row-selected > td {
                background-color: #E6F4FF !important;
                transition: background-color .15s ease-in-out;
            }

            .tabla-box table.table tbody tr.data-row:hover:not(.row-selected) > td {
                background-color: #F3FAFF !important;
            }

        /* Multi-select (filtro deuda) */
        .multi-wrap {
            position: relative;
        }

        .multi-display {
            width: 100%;
            height: 40px;
            border: 1px solid var(--borde);
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: .5rem;
            padding: 0 .75rem;
            background: #fff;
            color: #111;
            text-align: left;
        }

        .multi-panel {
            position: absolute;
            right: 0;
            top: calc(100% + 6px);
            background: #fff;
            border: 1px solid var(--borde);
            border-radius: 10px;
            padding: .5rem .75rem;
            box-shadow: 0 8px 20px rgba(0,0,0,.15);
            min-width: 260px;
            z-index: 1500;
            display: none;
        }

            .multi-panel.show {
                display: block;
            }

        /* Overlays y modales (confirmación y buscar familia) */
        .overlay, .confirm-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.35);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 2000;
        }

            .overlay.show, .confirm-overlay.show {
                display: flex;
            }

        .modal-box, .confirm-box {
            background: #fff;
            border-radius: 14px;
            padding: 1.25rem 1.5rem;
            box-shadow: 0 12px 32px rgba(0,0,0,.25);
            min-width: 420px;
            max-width: 90%;
            text-align: center;
        }

        .modal-title, .confirm-title {
            background: #bdbdbd;
            color: #1f1f1f;
            font-weight: 800;
            border-radius: 10px;
            padding: .6rem 1rem;
            margin-bottom: 1rem;
        }

        .modal-footer, .confirm-actions {
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

        .toolbar {
            display: grid;
            grid-template-columns: 1fr auto 1fr; /* izquierda | centro | derecha */
            align-items: center;
            margin-bottom: 1rem;
        }

            /* la barra de iconos va alineada a la izquierda dentro de la toolbar */
            .toolbar .icon-bar {
                justify-self: start;
            }

        /* rectángulo gris del subtítulo */
        .header-cta {
            background: #F3F4F6;
            color: #000000;
            border: 1px solid #E5E7EB;
            padding: .5rem 1rem;
            border-radius: 4px;
            font-weight: 700;
            justify-self: center; /* centra en la columna del medio */
        }

    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // ----- Barra -----
            const btnCrearDeuda = document.getElementById('btnCrearDeuda');
            const btnCrearPago = document.getElementById('btnCrearPago');
            const btnConsultar = document.getElementById('btnConsultar');
            const btnEditar = document.getElementById('btnEditar');
            const btnEliminar = document.getElementById('btnEliminar');
            const btnReporte = document.getElementById('btnReporte');

            function setToolbarState(level) {
                [btnCrearDeuda, btnCrearPago, btnConsultar, btnEditar, btnEliminar, btnReporte]
                    .forEach(b => { b.classList.add('btn-disabled'); b.disabled = true; });
                if (level >= 1) { [btnCrearDeuda, btnReporte].forEach(b => { b.classList.remove('btn-disabled'); b.disabled = false; }); }
                if (level >= 2) { [btnCrearPago, btnConsultar, btnEditar, btnEliminar].forEach(b => { b.classList.remove('btn-disabled'); b.disabled = false; }); }
            }
            setToolbarState(0);

            // Navegación por botones (usa tu routing actual)
            if (btnCrearDeuda) {
                btnCrearDeuda.addEventListener('click', function () {
                    const sel = document.querySelector('#tbodyDeudas tr.row-selected'); if (!sel) return;
                    const id = sel.getAttribute('Id');
                    window.location.href = '<%= ResolveUrl("~/Cobranza/CrearDeuda.aspx") %>?id=' + encodeURIComponent(id);
                });
            }

            if (btnCrearPago) btnCrearPago.addEventListener('click', function () {
                const sel = document.querySelector('#tbodyDeudas tr.row-selected'); if (!sel) return;
                const id = sel.getAttribute('Id');
                window.location.href = '<%= ResolveUrl("~/Cobranza/CrearPago.aspx") %>?id=' + encodeURIComponent(id);
            });


            if (btnConsultar) {
                btnConsultar.addEventListener('click', function () {
                    const sel = document.querySelector('#tbodyDeudas tr.row-selected'); if (!sel) return;
                    const id = sel.getAttribute('Id');
                    window.location.href = '<%= ResolveUrl("~/Cobranza/ConsultarDeuda.aspx") %>?id=' + encodeURIComponent(id);
                });
            }
            if (btnEditar) {
                btnEditar.addEventListener('click', function () {
                    const sel = document.querySelector('#tbodyDeudas tr.row-selected'); if (!sel) return;
                    const id = sel.getAttribute('Id');
                    window.location.href = '<%= ResolveUrl("~/Cobranza/EditarDeuda.aspx") %>?id=' + encodeURIComponent(id);
                });
            }

            // ----- Selección de fila -----
            const tbody = document.getElementById('tbodyDeudas');
            if (tbody) {
                tbody.addEventListener('click', (e) => {
                    const tr = e.target.closest('tr.data-row'); if (!tr || !tbody.contains(tr)) return;
                    tbody.querySelectorAll('tr.row-selected').forEach(r => r.classList.remove('row-selected'));
                    tr.classList.add('row-selected');
                    setToolbarState(2);
                    e.stopPropagation();
                });
            }
            document.addEventListener('click', (e) => {
                const grid = document.querySelector('.tabla-box');
                if (grid && !grid.contains(e.target)) {
                    if (tbody) tbody.querySelectorAll('tr.row-selected').forEach(r => r.classList.remove('row-selected'));
                    const hasFam = document.getElementById('<%= hfFamCodigo.ClientID %>').value;
                    setToolbarState(hasFam ? 1 : 0);
                }
            });

            // ----- Buscar familia (overlay) -----
            const ovBuscar = document.getElementById('ovBuscar');
            const btnAbrirBuscar = document.getElementById('btnBuscarFamilia');
            const btnCerrarBuscar = document.getElementById('btnCerrarBuscar');

            if (btnAbrirBuscar) {
                btnAbrirBuscar.addEventListener('click', () => {
                    ovBuscar.classList.add('show'); ovBuscar.setAttribute('aria-hidden', 'false');
                });
            }
            if (btnCerrarBuscar) {
                btnCerrarBuscar.addEventListener('click', () => {
                    ovBuscar.classList.remove('show'); ovBuscar.setAttribute('aria-hidden', 'true');
                });
            }

            // Expuesto para el botón Confirmar selección (server): setea estado=1
            window.__Cobranza__FamiliaElegida = function () {
                setToolbarState(1);
                ovBuscar.classList.remove('show'); ovBuscar.setAttribute('aria-hidden', 'true');
            };

            // ----- Filtro de deuda (multi) -----
            const btnFiltro = document.getElementById('btnFiltroDeuda');
            const panelFiltro = document.getElementById('panelFiltroDeuda');
            const lblFiltro = document.getElementById('lblFiltroDeuda');
            const hfFiltro = document.getElementById('<%= hfFiltroValores.ClientID %>');

            function actualizarTextoFiltro() {
                if (!panelFiltro) return;
                const chks = panelFiltro.querySelectorAll('.chkFiltro');
                const sel = Array.from(chks).filter(c => c.checked).map(c => c.value);
                if (lblFiltro) lblFiltro.textContent = (sel.length ? sel.join(', ') : '0 seleccionados');
                if (hfFiltro) hfFiltro.value = sel.join('|');
            }

            if (btnFiltro && panelFiltro) {
                btnFiltro.addEventListener('click', (e) => {
                    e.preventDefault(); e.stopPropagation();
                    panelFiltro.classList.toggle('show');
                });
                panelFiltro.querySelectorAll('.chkFiltro').forEach(c => c.addEventListener('change', actualizarTextoFiltro));
                document.addEventListener('click', (e) => {
                    if (panelFiltro.classList.contains('show') && !panelFiltro.contains(e.target) && !e.target.closest('#btnFiltroDeuda')) {
                        panelFiltro.classList.remove('show');
                    }
                });
                // Estado inicial
                if (hfFiltro && hfFiltro.value) {
                    const valores = hfFiltro.value.split('|');
                    panelFiltro.querySelectorAll('.chkFiltro').forEach(c => { c.checked = valores.includes(c.value); });
                }
                actualizarTextoFiltro();
            }

            // ----- Overlay eliminar -----
            const ovEliminar = document.getElementById('ovEliminar');
            const btnCancelDelete = document.getElementById('<%= btnCancelDelete.ClientID %>');
            if (btnEliminar) {
                btnEliminar.addEventListener('click', function () {
                    if (btnEliminar.classList.contains('btn-disabled')) return;
                    ovEliminar.classList.add('show'); ovEliminar.setAttribute('aria-hidden', 'false');
                });
            }
            function cerrarOverlayEliminar() {
                ovEliminar.classList.remove('show'); ovEliminar.setAttribute('aria-hidden', 'true');
            }
            if (btnCancelDelete) { btnCancelDelete.addEventListener('click', function (e) { e.preventDefault(); cerrarOverlayEliminar(); }); }
            if (ovEliminar) { ovEliminar.addEventListener('click', function (e) { if (e.target === ovEliminar) cerrarOverlayEliminar(); }); }
            document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && ovEliminar && ovEliminar.classList.contains('show')) cerrarOverlayEliminar(); });
        });

        // Función global para cuando el usuario elija una familia en la grilla del modal
        function seleccionarFamilia(codigo, apePat, apeMat, tr) {
            document.getElementById('<%= hfFamCodigo.ClientID %>').value = codigo;
            document.getElementById('<%= hfFamApePat.ClientID %>').value = apePat;
            document.getElementById('<%= hfFamApeMat.ClientID %>').value = apeMat;

            const tbody = document.getElementById('tbodyFamilias');
            if (tbody) {
                tbody.querySelectorAll('tr.row-selected').forEach(r => r.classList.remove('row-selected'));
                if (tr) tr.classList.add('row-selected');
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid cobranza-container">
        <asp:ScriptManager />

        <!-- barra superior: iconos + título "Gestión Cobranza" -->
        <div class="toolbar mb-3">
            <div class="icon-bar">
                <button type="button" id="btnCrearDeuda" class="btn-icon btn-disabled btn-plus" title="Crear deuda" disabled>
                    <i class="fa-solid fa-hand-holding-dollar"></i>
                </button>
                <button type="button" id="btnCrearPago" class="btn-icon btn-disabled btn-plus" title="Crear pago" disabled>
                    <i class="fa-solid fa-money-bill-transfer"></i>
                </button>
                <button type="button" id="btnConsultar" class="btn-icon btn-disabled" title="Consultar deuda" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>
                <button type="button" id="btnEditar" class="btn-icon btn-disabled" title="Editar deuda" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>
                <button type="button" id="btnEliminar" class="btn-icon btn-disabled" title="Eliminar deuda" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>

            <span class="header-cta">Gestión Cobranza</span>
        </div>

        <!-- DIVISIÓN 1: BÚSQUEDA / DATOS -->
        <div class="busqueda-box mb-4">
            <div class="row g-3 align-items-center">
                <div class="col-md-2 text-end">
                    <label class="form-label">Código Familia:</label>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtCodigoFamilia" runat="server" CssClass="form-control input-disabled"></asp:TextBox>
                </div>
                <div class="col-md-1">
                    <button type="button" id="btnBuscarFamilia" class="btn-buscar" title="Buscar familia">
                        <i class="fa-solid fa-users-viewfinder"></i>
                    </button>
                </div>

                <div class="col-md-2 text-end">
                    <label class="form-label">Filtro deuda:</label>
                </div>
                <div class="col-md-3">
                    <div class="multi-wrap">
                        <button type="button" id="btnFiltroDeuda" class="multi-display filtro-select">
                            <span id="lblFiltroDeuda">0 seleccionados</span>
                            <i class="fa-solid fa-caret-down ms-auto"></i>
                        </button>
                        <div id="panelFiltroDeuda" class="multi-panel">
                            <div class="form-check">
                                <input class="form-check-input chkFiltro" type="checkbox" value="Matrícula" id="fil_mat">
                                <label class="form-check-label" for="fil_mat">Matrícula</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input chkFiltro" type="checkbox" value="Pensión" id="fil_pen">
                                <label class="form-check-label" for="fil_pen">Pensión</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input chkFiltro" type="checkbox" value="Mora" id="fil_mor">
                                <label class="form-check-label" for="fil_mor">Mora</label>
                            </div>
                        </div>
                        <asp:HiddenField ID="hfFiltroValores" runat="server" />
                    </div>
                </div>
            </div>

            <div class="row g-3 align-items-center mt-1">
                <div class="col-md-2 text-end">
                    <label class="form-label">Apellido Paterno:</label>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtApePaterno" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-2 text-end">
                    <label class="form-label">Apellido Materno:</label>
                </div>
                <div class="col-md-3">
                    <asp:TextBox ID="txtApeMaterno" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-1 text-start">
                    <asp:LinkButton ID="btnLupaFamilia" runat="server" CssClass="btn-buscar" ToolTip="Buscar familia">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>

        <!-- DIVISIÓN 2: TABLA -->
        <div class="tabla-box">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-header">
                    <tr>
                        <th>Id</th>
                        <th>Alumno</th>
                        <th>Tipo Deuda</th>
                        <th>Monto Deuda</th>
                        <th>Pagado</th>
                        <th>Saldo</th>
                        <th>Fecha Emisión</th>
                        <th>Fecha Vencimiento</th>
                        <th>Descuento</th>
                        <th>Activo</th>
                    </tr>
                </thead>
                <tbody id="tbodyDeudas">
                    <asp:Repeater ID="repDeudas" runat="server">
                        <ItemTemplate>
                            <tr class="data-row" id='<%# Eval("Id") %>'>
                                <td><%# Eval("Id") %></td>
                                <td><%# Eval("Alumno") %></td>
                                <td><%# Eval("TipoDeuda") %></td>
                                <td><%# Eval("MontoDeuda") %></td>
                                <td><%# Eval("Pagado") %></td>
                                <td><%# Eval("Saldo") %></td>
                                <td><%# Eval("FechaEmision","{0:dd/MM/yyyy}") %></td>
                                <td><%# Eval("FechaVencimiento","{0:dd/MM/yyyy}") %></td>
                                <td><%# Eval("Descuento") %></td>
                                <td><%# Eval("Activo") %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>

        <div class="mt-2 d-flex justify-content-end">
            <button type="button" id="btnReporte" class="btn-icon btn-disabled" title="Reporte" disabled>
                <i class="fa-solid fa-clipboard-list"></i>
            </button>
        </div>

        <!-- Hidden para familia seleccionada -->
        <asp:HiddenField ID="hfFamCodigo" runat="server" />
        <asp:HiddenField ID="hfFamApePat" runat="server" />
        <asp:HiddenField ID="hfFamApeMat" runat="server" />

        <!-- Overlay: Buscar Familia -->
        <div id="ovBuscar" class="overlay" aria-hidden="true">
            <div class="modal-box">
                <div class="modal-title">Buscar Familia</div>
                <div class="row g-3 align-items-center mb-3">
                    <div class="col-4 text-end">
                        <label class="form-label">Apellido Paterno:</label>
                    </div>
                    <div class="col-3">
                        <asp:TextBox ID="txtBuscarApePat" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-2 text-end">
                        <label class="form-label">Apellido Materno:</label>
                    </div>
                    <div class="col-3 d-flex align-items-center gap-2">
                        <asp:TextBox ID="txtBuscarApeMat" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn-buscar" OnClick="btnBuscar_Click" ToolTip="Buscar">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnConfirmarFamilia" runat="server" CssClass="btn-accept" OnClick="btnConfirmarFamilia_Click" ToolTip="Confirmar selección">
                        <i class="fa-solid fa-check"></i>
                    </asp:LinkButton>
                    <button type="button" id="btnCerrarBuscar" class="btn-cancel"><i class="fa-solid fa-xmark"></i></button>
                </div>
            </div>
        </div>

        <!-- Overlay: Confirmar eliminación -->
        <div id="ovEliminar" class="confirm-overlay" aria-hidden="true">
            <div class="confirm-box">
                <div class="confirm-title">¿Estás seguro que deseas eliminar esta deuda?</div>
                <div class="confirm-actions">
                    <asp:LinkButton ID="btnDoDelete" runat="server" CssClass="btn-accept" ToolTip="Sí, eliminar" OnClick="btnDoDelete_Click">
                        <i class="fa-solid fa-check"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancelDelete" runat="server" CssClass="btn-cancel" ToolTip="No, cancelar" OnClientClick="return false;">
                        <i class="fa-solid fa-xmark"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
