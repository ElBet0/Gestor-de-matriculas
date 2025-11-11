<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="FamiliasBusqueda.aspx.cs" Inherits="FrontTA.Familias.FamiliasBusqueda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Búsqueda de Familias
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --blanco: #FFF;
            --negro: #000;
        }

        .familias-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
        }

        /* Estado deshabilitado: gris, sin hover */
        .btn-icon.btn-disabled,
        .btn-icon[disabled] {
            background: var(--gris) !important; /* #E1E1E1 */
            color: #777 !important;
            cursor: not-allowed;
            transform: none !important;
            box-shadow: none !important;
        }

        /* Selección de fila */
        /* Fila seleccionada: pinta celdas */
        .tabla-box table.table tbody tr.data-row.row-selected > td {
            background-color: #E6F4FF !important; /* celeste claro */
            transition: background-color .15s ease-in-out;
        }

        /* Hover solo si NO está seleccionada */
        .tabla-box table.table tbody tr.data-row:hover:not(.row-selected) > td {
            background-color: #F3FAFF !important;
        }

        .icon-bar-wrap {
            display: block;
        }

        .icon-bar {
            display: inline-flex; /* clave: caja se ajusta al contenido */
            gap: .75rem;
            background: var(--blanco);
            border-radius: 12px;
            padding: .6rem .75rem;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
        }

        tr.data-row.row-selected {
            background-color: #E6F4FF; /* celeste claro */
            transition: background-color .15s ease-in-out;
        }


        tr.data-row {
            cursor: pointer;
        }

            tr.data-row:hover {
                background-color: #F3FAFF;
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
        }

            .btn-icon:hover {
                background: var(--verdeOsc);
                transform: scale(1.05);
            }

        /* Icono “Añadir familia”: grupo + badge de + */
        .btn-add-family {
            position: relative;
        }

            .btn-add-family .fa-people-group {
                font-size: 1.1rem;
            }

            .btn-add-family::after {
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

        /* === Bloque búsqueda === */
        .busqueda-box {
            background: var(--blanco);
            border-radius: 10px;
            padding: 1rem;
            box-shadow: 0 2px 5px rgba(0,0,0,.08);
        }

            .busqueda-box label {
                font-weight: 600;
                color: var(--negro);
            }

        .form-control {
            border: 1px solid var(--gris);
            border-radius: 8px;
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

        /* === Tabla === */
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

        /*BORRADO ESTILOS: */
        /* ====== SUBTÍTULO (como en otras pantallas) ====== */
        .header-cta {
            background: #CFEFFF;
            color: #0d3a52;
            border: 1px solid #a9daf7;
            padding: .6rem 1rem;
            border-radius: 12px;
            font-weight: 700;
        }

        /* ====== MODAL DE CONFIRMACIÓN ====== */
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

        /* Botones de la ventanita (reutiliza estilos de otras pantallas) */
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
    </style>

    <script>
        (function () {
            // Helpers para obtener el GridView y la fila seleccionada
            function getTable() {
                return document.getElementById('<%= gvFamilias.ClientID %>');
            }
            function getSelected() {
                return getTable()?.querySelector('tr.data-row.row-selected');
            }

            function wireUp() {
                const table = getTable();
                const btnAdd = document.getElementById('btnAdd');
                const btnView = document.getElementById('btnView');
                const btnEdit = document.getElementById('btnEdit');
                const btnDel = document.getElementById('btnDelete');

                if (!table) return;

                function setEnabled(enabled) {
                    [btnView, btnEdit, btnDel].forEach(b => {
                        if (!b) return;
                        b.disabled = !enabled;
                        b.classList.toggle('btn-disabled', !enabled);
                    });
                }
                setEnabled(false);

                // --- Selección de filas en el GridView ---
                table.addEventListener('click', function (e) {
                    const tr = e.target.closest('tr');
                    if (!tr || !table.contains(tr)) return;
                    // Evitar header
                    if (tr.parentElement && tr.parentElement.tagName === 'THEAD') return;
                    // Solo filas de datos (marcadas en RowDataBound con "data-row")
                    if (!tr.classList.contains('data-row')) return;

                    table.querySelectorAll('tr.row-selected, tr.selected')
                        .forEach(r => r.classList.remove('row-selected', 'selected'));

                    tr.classList.add('row-selected');
                    setEnabled(true);
                    e.stopPropagation();
                });

                // Click fuera => deseleccionar
                document.addEventListener('click', function (ev) {
                    if (!table.contains(ev.target)) {
                        const sel = getSelected();
                        if (sel) sel.classList.remove('row-selected');
                        setEnabled(false);
                    }
                });

                // --- Navegación de botones ---
                if (btnAdd) {
                    // si es <button>, evita submit
                    btnAdd.type = 'button';
                    btnAdd.addEventListener('click', function (e) {
                        e.preventDefault();
                        window.location.href = "<%= ResolveUrl("~/Familias/CrearFamilia.aspx") %>";
                    });
                }

                if (btnView) {
                    btnView.addEventListener('click', function () {
                        const sel = getSelected();
                        if (!sel) return;
                        const id = sel.getAttribute('data-id');
                        window.location.href = '<%= ResolveUrl("~/Familias/ConsultarFamilia.aspx") %>?id=' + encodeURIComponent(id);
      });
                }

                if (btnEdit) {
                    btnEdit.addEventListener('click', function () {
                        const sel = getSelected();
                        if (!sel) return;
                        const id = sel.getAttribute('data-id');
                        window.location.href = '<%= ResolveUrl("~/Familias/EditarFamilia.aspx") %>?id=' + encodeURIComponent(id);
      });
                }

                // --- Lógica de borrado (usa getSelected, NO tbody) ---
                const overlay = document.getElementById('confirmDelete');
                const btnDoDelete = document.getElementById('btnDoDelete');
                const btnCancelDelete = document.getElementById('btnCancelDelete');
                const subTitle = document.getElementById('subTitle');
                // use rendered client id for the HiddenField control
                const hiddenID = document.getElementById('<%= idFamiliaDelete.ClientID %>');

                function closeDeleteUI() {
                    if (overlay) {
                        overlay.classList.remove('show');
                        overlay.setAttribute('aria-hidden', 'true');
                    }
                    if (subTitle) subTitle.style.display = 'none';
                    if (btnDel) btnDel.classList.remove('btn-active');
                    if (btnAdd) btnAdd.classList.remove('btn-disabled');
                    if (btnView) btnView.classList.remove('btn-disabled');
                    if (btnEdit) btnEdit.classList.remove('btn-disabled');
                    if (btnDel) btnDel.classList.remove('btn-disabled');
                  setEnabled(true);
                  // Restore previous selection state
                  const sel = getSelected();
                  if (sel) {
                    setEnabled(true);
                          } else {
                            setEnabled(false);
                  }
                }

                if (btnDel && overlay) {
                    btnDel.addEventListener('click', function () {
                        const sel = getSelected();
                        if (!sel) return;

                        const id = sel.getAttribute('data-id');
                        if (hiddenID) hiddenID.value = id ? id.trim() : '';
                        if (subTitle) subTitle.style.display = 'block';
                        if (btnAdd) btnAdd.classList.add('btn-disabled');
                        if (btnView) btnView.classList.add('btn-disabled');
                        if (btnEdit) btnEdit.classList.add('btn-disabled');

                        btnDel.classList.remove('btn-disabled');
                        btnDel.classList.add('btn-active');
                        btnDel.disabled = false;

                        overlay.classList.add('show');
                        overlay.setAttribute('aria-hidden', 'false');
                    });
                }

                // Do NOT attach a client-side click handler to btnDoDelete —
                // the LinkButton should perform a postback and run the server handler
                // btnDoDelete_Click. Removing the client-side handler ensures the
                // server receives the HiddenField value.

                if (btnCancelDelete && overlay) {
                    btnCancelDelete.addEventListener('click', closeDeleteUI);
                    overlay.addEventListener('click', function (e) {
                        if (e.target === overlay) closeDeleteUI();
                    });
                    document.addEventListener('keydown', function (e) {
                        if (e.key === 'Escape' && overlay.classList.contains('show')) closeDeleteUI();
                    });
                }
            }

            // DOM listo
            document.addEventListener('DOMContentLoaded', wireUp);

            // Si usas UpdatePanel/MS AJAX, re-enlaza tras postback parcial
            if (window.Sys && Sys.Application) {
                Sys.Application.add_load(wireUp);
            }
        })();
    </script>



</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">

    <div class="container-fluid familias-container">

        <!-- ICONOS (izquierda) -->
        <div class="icon-bar-wrap mb-3">
            <div class="icon-bar">
                <button type="button" id="btnAdd" class="btn btn-icon btn-add-family" title="Añadir familia">
                    <i class="fa-solid fa-people-group"></i>
                </button>

                <button type="button" id="btnView" class="btn btn-icon btn-disabled" title="Consultar familia" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>

                <button type="button" id="btnEdit" class="btn btn-icon btn-disabled" title="Editar familia" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>

                <button type="button" id="btnDelete" class="btn btn-icon btn-disabled" title="Eliminar familia" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-2">
            <div></div>
<%--            <span id="subTitle" class="header-cta" style="display: none;">Eliminar Familia</span>--%>
        </div>


        <!-- BÚSQUEDA -->
        <div class="busqueda-box mb-4">
            <div class="row align-items-center g-3">
                <div class="col-md-5">
                    <label for="txtApePaterno" class="form-label">Apellido Paterno:</label>
                    <asp:TextBox ID="txtApePaterno" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-5">
                    <label for="txtApeMaterno" class="form-label">Apellido Materno:</label>
                    <asp:TextBox ID="txtApeMaterno" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-2 text-center">
                    <asp:LinkButton ID="btnBuscar"
                        runat="server"
                        CssClass="btn btn-search"
                        ToolTip="Buscar"
                        OnClick="btnBuscar_Click"
                        CausesValidation="false"
                        UseSubmitBehavior="false">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>

        <!-- TABLA (sin filas de ejemplo PARA RELLENAR DATOS CON LA BD) -->
        <div class="tabla-box">

            <%--<table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-header">
                    <tr>
                        <th style="width:180px;">Código Familia</th>
                        <th>Apellido Paterno</th>
                        <th>Apellido Materno</th>
                    </tr>
                </thead>
                <tbody id="tbodyFamilias">
                    <tr class="data-row" data-id="001">
                        <td>001</td>
                        <td>García</td>
                        <td>Pérez</td>
                    </tr>
                    <tr class="data-row" data-id="002">
                        <td>002</td>
                        <td>Ramos</td>
                        <td>López</td>
                    </tr>
                    <tr class="data-row" data-id="003">
                        <td>003</td>
                        <td>Torres</td>
                        <td>Quispe</td>
                    </tr>
                </tbody>
            </table>--%>

            <asp:GridView ID="gvFamilias"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-bordered table-hover align-middle mb-0"
                GridLines="None"
                DataKeyNames="familia_id"
                OnRowDataBound="gvFamilias_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="familia_id" HeaderText="Código Familia">
                        <ItemStyle Width="180px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="apellido_paterno" HeaderText="Apellido Paterno" />
                    <asp:BoundField DataField="apellido_materno" HeaderText="Apellido Materno" />
                </Columns>
            </asp:GridView>


        </div>

        <!-- Lógica de borrado -->
        <div id="confirmDelete" class="confirm-overlay" aria-hidden="true">
            <div class="confirm-box">
                <div class="confirm-title">¿Estás seguro que deseas eliminar la familia?</div>
                <div class="confirm-actions">
                    <asp:LinkButton ID="btnDoDelete"
                        runat="server"
                        ClientIDMode="Static"
                        CssClass="btn-accept"
                        ToolTip="Sí, eliminar"
                        CausesValidation="false"
                        UseSubmitBehavior="false"
                        OnClick="btnDoDelete_Click">
                        <i class="fa-solid fa-check"></i>
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnCancelDelete"
                        runat="server"
                        ClientIDMode="Static"
                        CssClass="btn-cancel"
                        ToolTip="No, cancelar"
                        CausesValidation="false"
                        UseSubmitBehavior="false"
                        OnClientClick="return false;">
    <i class="fa-solid fa-xmark"></i>
                    </asp:LinkButton>

                </div>
            </div>
        </div>
        <asp:HiddenField ID="idFamiliaDelete" runat="server" Value="" />
    </div>

</asp:Content>
