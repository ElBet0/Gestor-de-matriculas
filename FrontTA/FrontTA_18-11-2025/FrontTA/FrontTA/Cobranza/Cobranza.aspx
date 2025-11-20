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

        .cobranza-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
        }

        .icon-bar-wrap { display: block; }

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

        .form-control,
        .filtro-select {
            border: 1px solid var(--borde);
            border-radius: 8px;
            height: 40px;
        }

        .btn-search,
        .btn-buscar {
            background: var(--verde);
            color: #fff;
            border: 0;
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none !important;
        }

        .btn-search:hover,
        .btn-buscar:hover {
            background: var(--verdeOsc);
            text-decoration: none !important;
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

        .tabla-box table.table tbody tr.data-row { cursor: pointer; }

        .tabla-box table.table tbody tr.data-row.row-selected > td {
            background-color: #E6F4FF !important;
            transition: background-color .15s ease-in-out;
        }

        .tabla-box table.table tbody tr.data-row:hover:not(.row-selected) > td {
            background-color: #F3FAFF !important;
        }

        .multi-wrap { position: relative; }

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

        .multi-panel.show { display: block; }

        .overlay,
        .confirm-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.35);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 2000;
        }

        .overlay.show,
        .confirm-overlay.show { display: flex; }

        .modal-box,
        .confirm-box {
            background: #fff;
            border-radius: 14px;
            padding: 1.25rem 1.5rem;
            box-shadow: 0 12px 32px rgba(0,0,0,.25);
            min-width: 420px;
            max-width: 90%;
            text-align: center;
        }

        .modal-box.modal-wide {
            min-width: 700px;
        }

        .modal-title,
        .confirm-title {
            background: #bdbdbd;
            color: #1f1f1f;
            font-weight: 800;
            border-radius: 10px;
            padding: .6rem 1rem;
            margin-bottom: 1rem;
        }

        .modal-footer,
        .confirm-actions {
            display: flex;
            gap: 1.25rem;
            justify-content: center;
        }

        .btn-accept,
        .btn-cancel {
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

        .btn-accept { box-shadow: 0 3px 8px rgba(0,128,0,.15); }

        .btn-cancel { box-shadow: 0 3px 8px rgba(255,0,0,.15); }

        .btn-accept:hover,
        .btn-cancel:hover { transform: translateY(-2px); }

        .btn-accept i { color: #2E7D32; }

        .btn-cancel i { color: #D32F2F; }

        .toolbar {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            align-items: center;
            margin-bottom: 1rem;
        }

        .toolbar .icon-bar { justify-self: start; }

        .header-cta {
            background: #F3F4F6;
            color: #000000;
            border: 1px solid #E5E7EB;
            padding: .5rem 1rem;
            border-radius: 4px;
            font-weight: 700;
            justify-self: center;
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {

            const btnCrearDeuda = document.getElementById('btnCrearDeuda');
            const btnCrearPago = document.getElementById('btnCrearPago');
            const btnConsultar = document.getElementById('btnConsultar');
            const btnEditar = document.getElementById('btnEditar');
            const btnEliminar = document.getElementById('btnEliminar');
            const btnReporte = document.getElementById('btnReporte');

            const txtCodigoFamilia = document.getElementById('<%= txtCodigoFamilia.ClientID %>');
            const hfFamCodigo = document.getElementById('<%= hfFamCodigo.ClientID %>');
            const hfDeudaSel = document.getElementById('<%= hfDeudaSeleccionadaId.ClientID %>');

            const tbody = document.getElementById('tbodyDeudas');
            const grid = document.querySelector('.tabla-box');

            const ovBuscar = document.getElementById('ovBuscar');
            const btnAbrirBuscar = document.getElementById('btnBuscarFamilia');
            const btnCerrarBuscar = document.getElementById('btnCerrarBuscar');

            const ovEliminar = document.getElementById('ovEliminar');
            const btnCancelDelete = document.getElementById('<%= btnCancelDelete.ClientID %>');

            const btnFiltro = document.getElementById('btnFiltroDeuda');
            const panelFiltro = document.getElementById('panelFiltroDeuda');
            const lblFiltro = document.getElementById('lblFiltroDeuda');
            const hfFiltro = document.getElementById('<%= hfFiltroValores.ClientID %>');

            // ---- gestión tipos de deuda ----
            const btnGestionTipos = document.getElementById('btnGestionTipos');
            const ovTipos = document.getElementById('ovTiposDeuda');
            const btnCerrarTipos = document.getElementById('btnCerrarTipos');

            function setToolbarState(level) {
                const hasCodigo = txtCodigoFamilia && txtCodigoFamilia.value.trim().length > 0;

                [btnCrearDeuda, btnCrearPago, btnConsultar, btnEditar, btnEliminar, btnReporte]
                    .forEach(b => {
                        if (!b) return;
                        b.classList.add('btn-disabled');
                        b.disabled = true;
                    });

                if (level >= 1 && hasCodigo) {
                    [btnCrearDeuda, btnReporte].forEach(b => {
                        if (!b) return;
                        b.classList.remove('btn-disabled');
                        b.disabled = false;
                    });
                }

                if (level >= 2 && hasCodigo) {
                    [btnCrearPago, btnConsultar, btnEditar, btnEliminar].forEach(b => {
                        if (!b) return;
                        b.classList.remove('btn-disabled');
                        b.disabled = false;
                    });
                }
            }

            const famCodigoInit = hfFamCodigo ? hfFamCodigo.value : '';
            setToolbarState(famCodigoInit ? 1 : 0);

            if (btnCrearDeuda) {
                btnCrearDeuda.addEventListener('click', function (e) {
                    e.stopPropagation();
                    if (btnCrearDeuda.classList.contains('btn-disabled')) return;
                    const cod = txtCodigoFamilia.value.trim();
                    if (!cod) return;

                    window.location.href =
                        '<%= ResolveUrl("~/Cobranza/CrearDeuda.aspx") %>?familia=' + encodeURIComponent(cod);
                });
            }

            if (btnCrearPago) {
                btnCrearPago.addEventListener('click', function (e) {
                    e.stopPropagation();
                    if (btnCrearPago.classList.contains('btn-disabled')) return;
                    if (!hfDeudaSel || !hfDeudaSel.value) return;

                    window.location.href =
                        '<%= ResolveUrl("~/Cobranza/CrearPago.aspx") %>?id=' + encodeURIComponent(hfDeudaSel.value);
                });
            }

            if (btnConsultar) {
                btnConsultar.addEventListener('click', function (e) {
                    e.stopPropagation();
                    if (btnConsultar.classList.contains('btn-disabled')) return;
                    if (!hfDeudaSel || !hfDeudaSel.value) return;

                    window.location.href =
                        '<%= ResolveUrl("~/Cobranza/ConsultarDeuda.aspx") %>?id=' + encodeURIComponent(hfDeudaSel.value);
                });
            }

            if (btnEditar) {
                btnEditar.addEventListener('click', function (e) {
                    e.stopPropagation();
                    if (btnEditar.classList.contains('btn-disabled')) return;
                    if (!hfDeudaSel || !hfDeudaSel.value) return;

                    // Tomamos el id de la familia desde el hidden (es el valor “real”)
                    const famId = hfFamCodigo ? hfFamCodigo.value.trim() : "";
                    if (!famId) {
                        alert('Primero debes seleccionar una familia.');
                        return;
                    }

                    // Enviamos deuda + familia
                    window.location.href =
                        '<%= ResolveUrl("~/Cobranza/EditarDeuda.aspx") %>?id='
                        + encodeURIComponent(hfDeudaSel.value)
                        + '&familia=' + encodeURIComponent(famId);
                });
            }


            if (tbody) {
                tbody.addEventListener('click', function (e) {
                    const tr = e.target.closest('tr.data-row');
                    if (!tr || !tbody.contains(tr)) return;

                    tbody.querySelectorAll('tr.row-selected')
                        .forEach(r => r.classList.remove('row-selected'));

                    tr.classList.add('row-selected');

                    if (hfDeudaSel) {
                        hfDeudaSel.value = tr.getAttribute('id') || '';
                    }

                    setToolbarState(2);
                    e.stopPropagation();
                });
            }

            document.addEventListener('click', function (e) {
                if (grid && grid.contains(e.target)) return;
                if (ovBuscar && ovBuscar.contains(e.target)) return;
                if (ovEliminar && ovEliminar.contains(e.target)) return;
                if (ovTipos && ovTipos.contains(e.target)) return;

                if (tbody) {
                    tbody.querySelectorAll('tr.row-selected')
                        .forEach(r => r.classList.remove('row-selected'));
                }
                if (hfDeudaSel) hfDeudaSel.value = '';

                const hasFam = hfFamCodigo && hfFamCodigo.value.trim().length > 0;
                setToolbarState(hasFam ? 1 : 0);
            });

            if (btnAbrirBuscar && ovBuscar) {
                btnAbrirBuscar.addEventListener('click', function (e) {
                    e.stopPropagation();
                    ovBuscar.classList.add('show');
                    ovBuscar.setAttribute('aria-hidden', 'false');
                });
            }

            if (btnCerrarBuscar && ovBuscar) {
                btnCerrarBuscar.addEventListener('click', function (e) {
                    e.stopPropagation();
                    ovBuscar.classList.remove('show');
                    ovBuscar.setAttribute('aria-hidden', 'true');
                });
            }

            window.__Cobranza__FamiliaElegida = function () {
                setToolbarState(1);
                if (ovBuscar) {
                    ovBuscar.classList.remove('show');
                    ovBuscar.setAttribute('aria-hidden', 'true');
                }
            };

            function actualizarTextoFiltro() {
                if (!panelFiltro) return;
                const chks = panelFiltro.querySelectorAll('.chkFiltro');
                const sel = Array.from(chks).filter(c => c.checked).map(c => c.value);
                if (lblFiltro) lblFiltro.textContent = (sel.length ? sel.length + ' seleccionados' : '0 seleccionados');
                if (hfFiltro) hfFiltro.value = sel.join('|');
            }

            if (btnFiltro && panelFiltro) {
                btnFiltro.addEventListener('click', function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    panelFiltro.classList.toggle('show');
                });

                panelFiltro.querySelectorAll('.chkFiltro')
                    .forEach(c => c.addEventListener('change', function () {
                        actualizarTextoFiltro();
                        // si quisieras, aquí podrías hacer __doPostBack para recargar deudas
                    }));

                document.addEventListener('click', function (e) {
                    if (panelFiltro.classList.contains('show') &&
                        !panelFiltro.contains(e.target) &&
                        !e.target.closest('#btnFiltroDeuda')) {
                        panelFiltro.classList.remove('show');
                    }
                });

                if (hfFiltro && hfFiltro.value) {
                    const valores = hfFiltro.value.split('|');
                    panelFiltro.querySelectorAll('.chkFiltro')
                        .forEach(c => { c.checked = valores.includes(c.value); });
                }
                actualizarTextoFiltro();
            }

            if (btnEliminar && ovEliminar) {
                btnEliminar.addEventListener('click', function (e) {
                    e.stopPropagation();
                    if (btnEliminar.classList.contains('btn-disabled')) return;

                    if (!hfDeudaSel || !hfDeudaSel.value) {
                        alert('Primero debes seleccionar una deuda en la tabla.');
                        return;
                    }

                    ovEliminar.classList.add('show');
                    ovEliminar.setAttribute('aria-hidden', 'false');
                });
            }

            if (btnCancelDelete && ovEliminar) {
                btnCancelDelete.addEventListener('click', function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    ovEliminar.classList.remove('show');
                    ovEliminar.setAttribute('aria-hidden', 'true');
                });
            }

            if (ovEliminar) {
                ovEliminar.addEventListener('click', function (e) {
                    if (e.target === ovEliminar) {
                        ovEliminar.classList.remove('show');
                        ovEliminar.setAttribute('aria-hidden', 'true');
                    }
                });
            }

            // ---- abrir/cerrar modal Tipos Deuda ----
            if (btnGestionTipos && ovTipos) {
                btnGestionTipos.addEventListener('click', function (e) {
                    e.stopPropagation();
                    ovTipos.classList.add('show');
                    ovTipos.setAttribute('aria-hidden', 'false');
                });
            }

            if (btnCerrarTipos && ovTipos) {
                btnCerrarTipos.addEventListener('click', function (e) {
                    e.stopPropagation();
                    ovTipos.classList.remove('show');
                    ovTipos.setAttribute('aria-hidden', 'true');
                });
            }

            if (ovTipos) {
                ovTipos.addEventListener('click', function (e) {
                    if (e.target === ovTipos) {
                        ovTipos.classList.remove('show');
                        ovTipos.setAttribute('aria-hidden', 'true');
                    }
                });
            }

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    if (ovEliminar && ovEliminar.classList.contains('show')) {
                        ovEliminar.classList.remove('show');
                        ovEliminar.setAttribute('aria-hidden', 'true');
                    }
                    if (ovBuscar && ovBuscar.classList.contains('show')) {
                        ovBuscar.classList.remove('show');
                        ovBuscar.setAttribute('aria-hidden', 'true');
                    }
                    if (ovTipos && ovTipos.classList.contains('show')) {
                        ovTipos.classList.remove('show');
                        ovTipos.setAttribute('aria-hidden', 'true');
                    }
                }
            });

        });

        // seleccion familia (GridView modal)
        function seleccionarFamilia(codigo, apePat, apeMat, tr) {
            document.getElementById('<%= hfFamCodigo.ClientID %>').value = codigo;
            document.getElementById('<%= hfFamApePat.ClientID %>').value = apePat;
            document.getElementById('<%= hfFamApeMat.ClientID %>').value = apeMat;

            const gv = document.getElementById('<%= gvFamilias.ClientID %>');
            if (gv) {
                const tbody = gv.querySelector('tbody');
                if (tbody) {
                    tbody.querySelectorAll('tr.row-selected')
                        .forEach(r => r.classList.remove('row-selected'));
                    if (tr) tr.classList.add('row-selected');
                }
            }
        }

        // seleccion tipo deuda (GridView modal tipos)
        function seleccionarTipoDeuda(id, desc, monto, tr) {
            document.getElementById('<%= hfTipoDeudaSeleccionado.ClientID %>').value = id;
            document.getElementById('<%= txtTipoDescripcion.ClientID %>').value = desc;
            document.getElementById('<%= txtTipoMonto.ClientID %>').value = monto;

            const gv = document.getElementById('<%= gvTiposDeuda.ClientID %>');
            if (gv) {
                const tbody = gv.querySelector('tbody');
                if (tbody) {
                    tbody.querySelectorAll('tr.row-selected')
                        .forEach(r => r.classList.remove('row-selected'));
                    if (tr) tr.classList.add('row-selected');
                }
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid cobranza-container">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

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
                <div class="col-md-2">
                    <div class="multi-wrap">
                        <button type="button" id="btnFiltroDeuda" class="multi-display filtro-select">
                            <span id="lblFiltroDeuda">0 seleccionados</span>
                            <i class="fa-solid fa-caret-down ms-auto"></i>
                        </button>
                        <div id="panelFiltroDeuda" class="multi-panel">
                            <asp:Repeater ID="repTiposDeuda" runat="server">
                                <ItemTemplate>
                                    <div class="form-check">
                                        <input class="form-check-input chkFiltro" type="checkbox"
                                            value='<%# Eval("Id") %>'
                                            id='fil_tipo_<%# Eval("Id") %>' />
                                        <label class="form-check-label" for='fil_tipo_<%# Eval("Id") %>'>
                                            <%# Eval("Descripcion") %>
                                        </label>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <asp:HiddenField ID="hfFiltroValores" runat="server" />
                    </div>
                </div>
                <!-- botón para gestionar filtros (tipos de deuda) -->
                <div class="col-md-1">
                    <button type="button" id="btnGestionTipos" class="btn-icon btn-plus"
                        title="Gestionar tipos de deuda">
                        <i class="fa-solid fa-filter"></i>
                    </button>
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

                <div class="col-md-1 text-start d-flex gap-2">
                    <asp:LinkButton ID="btnLupaFamilia" runat="server"
                        CssClass="btn-buscar"
                        ToolTip="Buscar familia"
                        OnClick="btnLupaFamilia_Click">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </asp:LinkButton>

                    <asp:LinkButton type="button" runat="server" ID="btnReporte" class="btn-icon" title="Reporte" OnClick="btnReporte_Click">
                        <i class="fa-solid fa-clipboard-list"></i>
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

        <!-- Hidden para familia, deuda y tipo seleccionados -->
        <asp:HiddenField ID="hfFamCodigo" runat="server" />
        <asp:HiddenField ID="hfFamApePat" runat="server" />
        <asp:HiddenField ID="hfFamApeMat" runat="server" />
        <asp:HiddenField ID="hfDeudaSeleccionadaId" runat="server" />
        <asp:HiddenField ID="hfTipoDeudaSeleccionado" runat="server" />

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
                        <asp:LinkButton ID="LinkButton1" runat="server"
                            CssClass="btn-buscar"
                            ToolTip="Buscar"
                            OnClick="btnBuscar_Click"
                            CausesValidation="false"
                            UseSubmitBehavior="false">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </asp:LinkButton>
                    </div>
                </div>

                <div class="tabla-box mb-3">
                    <asp:GridView ID="gvFamilias" runat="server"
                        CssClass="table table-bordered table-hover align-middle mb-0"
                        AutoGenerateColumns="False"
                        AllowPaging="True"
                        PageSize="12"
                        OnRowDataBound="gvFamilias_RowDataBound"
                        OnPageIndexChanging="gvFamilias_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="familia_id" HeaderText="Código Familia" />
                            <asp:BoundField DataField="apellido_Paterno" HeaderText="Apellido Paterno" />
                            <asp:BoundField DataField="apellido_Materno" HeaderText="Apellido Materno" />
                        </Columns>
                    </asp:GridView>
                </div>

                <div class="modal-footer">
                    <asp:LinkButton ID="btnConfirmarFamilia" runat="server"
                        CssClass="btn-accept"
                        ToolTip="Confirmar selección"
                        OnClick="btnConfirmarFamilia_Click"
                        CausesValidation="false"
                        UseSubmitBehavior="false">
                        <i class="fa-solid fa-check"></i>
                    </asp:LinkButton>
                    <button type="button" id="btnCerrarBuscar" class="btn-cancel">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Overlay: Confirmar eliminación deuda -->
        <div id="ovEliminar" class="confirm-overlay" aria-hidden="true">
            <div class="confirm-box">
                <div class="confirm-title">¿Estás seguro que deseas eliminar esta deuda?</div>
                <div class="confirm-actions">
                    <asp:LinkButton ID="btnDoDelete" runat="server" CssClass="btn-accept"
                        ToolTip="Sí, eliminar" OnClick="btnDoDelete_Click"
                        CausesValidation="false" UseSubmitBehavior="false">
                        <i class="fa-solid fa-check"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancelDelete" runat="server" CssClass="btn-cancel"
                        ToolTip="No, cancelar" OnClientClick="return false;"
                        CausesValidation="false" UseSubmitBehavior="false">
                        <i class="fa-solid fa-xmark"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>

        <!-- Overlay: Gestión Tipos de Deuda -->
        <div id="ovTiposDeuda" class="overlay" aria-hidden="true">
            <div class="modal-box modal-wide">
                <div class="modal-title">Gestionar Tipos de Deuda</div>

                <div class="row g-3 mb-3">
                    <div class="col-md-7">
                        <div class="tabla-box">
                            <asp:GridView ID="gvTiposDeuda" runat="server"
                                CssClass="table table-bordered table-hover align-middle mb-0"
                                AutoGenerateColumns="False"
                                AllowPaging="True"
                                PageSize="10"
                                OnRowDataBound="gvTiposDeuda_RowDataBound"
                                OnPageIndexChanging="gvTiposDeuda_PageIndexChanging">
                                <Columns>
                                    <asp:BoundField DataField="Id" HeaderText="Id" />
                                    <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                                    <asp:BoundField DataField="MontoGeneral" HeaderText="Monto General"
                                        DataFormatString="{0:N2}" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    <div class="col-md-5 text-start">
                        <div class="mb-3">
                            <label class="form-label">Descripción:</label>
                            <%--MAXIMO 20 CARACTERES--%>
                            <asp:TextBox ID="txtTipoDescripcion" runat="server"
                                CssClass="form-control" MaxLength="20"></asp:TextBox>

                        </div>
                        <div class="mb-3">
                            <label class="form-label">Monto general (S/):</label>
                            <asp:TextBox ID="txtTipoMonto" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <small class="text-muted">
                            Selecciona un tipo en la tabla para editar o eliminar.  
                            Deja la selección vacía para crear uno nuevo.
                        </small>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:LinkButton ID="btnCrearTipo" runat="server"
                        CssClass="btn-accept" ToolTip="Crear nuevo tipo"
                        OnClick="btnCrearTipo_Click" CausesValidation="false"
                        UseSubmitBehavior="false">
                        <i class="fa-solid fa-plus"></i>
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnEditarTipo" runat="server"
                        CssClass="btn-accept" ToolTip="Guardar cambios"
                        OnClick="btnEditarTipo_Click" CausesValidation="false"
                        UseSubmitBehavior="false">
                        <i class="fa-solid fa-pen"></i>
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnEliminarTipo" runat="server"
                        CssClass="btn-cancel" ToolTip="Eliminar tipo"
                        OnClick="btnEliminarTipo_Click" CausesValidation="false"
                        UseSubmitBehavior="false">
                        <i class="fa-solid fa-trash"></i>
                    </asp:LinkButton>

                    <button type="button" id="btnCerrarTipos" class="btn-cancel">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
