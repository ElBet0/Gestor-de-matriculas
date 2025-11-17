<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="FrontTA.Usuarios.Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Búsqueda de Usuarios
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

        /* mismo contenedor estilo */
        .familias-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
        }

        .btn-icon.btn-disabled, .btn-icon[disabled] {
            background: var(--gris) !important;
            color: #777 !important;
            cursor: not-allowed;
            transform: none !important;
            box-shadow: none !important;
        }

        .tabla-box table.table tbody tr.data-row.row-selected > td {
            background-color: #E6F4FF !important;
            transition: background-color .15s;
        }

        .tabla-box table.table tbody tr.data-row:hover:not(.row-selected) > td {
            background-color: #F3FAFF !important;
        }

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
            transition: transform .15s, background .15s;
        }

            .btn-icon:hover {
                background: var(--verdeOsc);
                transform: scale(1.05);
            }

        .btn-add-usuario {
            position: relative;
        }

            .btn-add-usuario .fa-user {
                font-size: 1.1rem;
            }

            .btn-add-usuario::after {
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
            padding: 1rem;
        }

        .header-cta {
            background: #CFEFFF;
            color: #0d3a52;
            border: 1px solid #a9daf7;
            padding: .6rem 1rem;
            border-radius: 12px;
            font-weight: 700;
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
            transition: transform .15s, box-shadow .15s;
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

        .btn-active {
            outline: 2px solid #7bbef3;
            box-shadow: 0 0 0 3px rgba(123,190,243,.35);
        }

        .table-header a,
        .table-header a:link,
        .table-header a:visited {
            color: #000 !important;
            text-decoration: none !important;
        }

            /* Mantener sin subrayado también en hover/focus/active */
            .table-header a:hover,
            .table-header a:focus,
            .table-header a:active {
                color: #000 !important;
                text-decoration: none !important;
                outline: none;
            }

        /* (opcional) peso y tracking del título */
        .table-header th {
            font-weight: 700;
            letter-spacing: .2px;
        }

        .toolbar {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            align-items: center;
            margin-bottom: 1rem;
        }

            .toolbar .icon-bar {
                justify-self: start; /* iconos a la izquierda */
            }

        /* Subtítulo estándar */
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
        (function () {
            function getTable() { return document.getElementById('<%= gvUsuarios.ClientID %>'); }
            function getSelected() { return getTable()?.querySelector('tr.data-row.row-selected'); }

            function wireUp() {
                const table = getTable();
                const btnAdd = document.getElementById('btnAdd');
                const btnView = document.getElementById('btnView');
                const btnEdit = document.getElementById('btnEdit');
                const btnDel = document.getElementById('btnDelete');

                const overlay = document.getElementById('confirmDelete');
                const btnDoDelete = document.getElementById('btnDoDelete');
                const btnCancelDelete = document.getElementById('btnCancelDelete');
                const hiddenId = document.getElementById('<%= hfUsuarioIdSeleccionado.ClientID %>');

                if (!table) return;

                function setEnabled(enabled) {
                    [btnView, btnEdit, btnDel].forEach(b => {
                        if (!b) return;
                        b.disabled = !enabled;
                        b.classList.toggle('btn-disabled', !enabled);
                    });
                }
                setEnabled(false);

                // Selección de fila
                table.addEventListener('click', function (e) {
                    const tr = e.target.closest('tr');
                    if (!tr || !table.contains(tr)) return;
                    if (tr.parentElement && tr.parentElement.tagName === 'THEAD') return;
                    if (!tr.classList.contains('data-row')) return;

                    table.querySelectorAll('tr.row-selected, tr.selected').forEach(r => r.classList.remove('row-selected', 'selected'));
                    tr.classList.add('row-selected');
                    setEnabled(true);

                    if (hiddenId) hiddenId.value = tr.getAttribute('data-id');

                    e.stopPropagation();
                });

                // ❗ No deseleccionar si el overlay está abierto
                document.addEventListener('click', function (ev) {
                    if (table.contains(ev.target)) return;
                    if (overlay && overlay.classList.contains('show')) return; // <--- evita limpiar mientras está abierto
                    const sel = getSelected();
                    if (sel) sel.classList.remove('row-selected');
                    setEnabled(false);
                    if (hiddenId) hiddenId.value = '';
                });

                // Abrir overlay: asegura que el hidden tenga el id actual
                if (btnDel && overlay) {
                    btnDel.addEventListener('click', function (e) {
                        const sel = getSelected(); if (!sel) return;
                        if (hiddenId) hiddenId.value = sel.getAttribute('data-id'); // <--- refuerza el valor
                        overlay.classList.add('show');
                        overlay.setAttribute('aria-hidden', 'false');
                        e.stopPropagation(); // <--- evita que el click burbujee al document
                    });
                }

                // Confirmar: deja que haga postback, pero evita que el document lo limpie antes
                if (btnDoDelete) {
                    btnDoDelete.addEventListener('click', function (e) {
                        e.stopPropagation(); // <--- evita limpiar selección/hidden
                        const id = hiddenId ? hiddenId.value : null;
                        if (!id) {
                            alert('⚠️ No hay curso seleccionado para eliminar.');
                            if (overlay) { overlay.classList.remove('show'); overlay.setAttribute('aria-hidden', 'true'); }
                            return;
                        }
                        // sin preventDefault => LinkButton hará postback y ejecutará btnDoDelete_Click
                    });
                }

                // Cerrar overlay
                function closeDeleteUI() {
                    if (overlay) { overlay.classList.remove('show'); overlay.setAttribute('aria-hidden', 'true'); }
                    setEnabled(false);
                    const sel = getSelected(); if (sel) sel.classList.remove('row-selected');
                    if (hiddenId) hiddenId.value = '';
                }

                if (btnCancelDelete && overlay) {
                    btnCancelDelete.addEventListener('click', function (e) { e.stopPropagation(); closeDeleteUI(); });
                    overlay.addEventListener('click', e => { if (e.target === overlay) closeDeleteUI(); });
                    document.addEventListener('keydown', e => { if (e.key === 'Escape' && overlay.classList.contains('show')) closeDeleteUI(); });
                }

                // Navegación (sin cambios)
                if (btnAdd) {
                    btnAdd.type = 'button';
                    btnAdd.addEventListener('click', function (e) {
                        e.preventDefault();
                        window.location.href = "<%= ResolveUrl("~/Usuarios/CrearUsuarios.aspx") %>";
                     });
                }
                if (btnView) {
                    btnView.addEventListener('click', function () {
                        const sel = getSelected(); if (!sel) return;
                        const id = sel.getAttribute('data-id');
                        window.location.href = '<%= ResolveUrl("~/Usuarios/ConsultarUsuarios.aspx") %>?id=' + encodeURIComponent(id);
         });
                }
                if (btnEdit) {
                    btnEdit.addEventListener('click', function () {
                        const sel = getSelected(); if (!sel) return;
                        const id = sel.getAttribute('data-id');
                        window.location.href = '<%= ResolveUrl("~/Usuarios/EditarUsuarios.aspx") %>?id=' + encodeURIComponent(id);
         });
                }
            }

            document.addEventListener('DOMContentLoaded', wireUp);
            if (window.Sys && Sys.Application) { Sys.Application.add_load(wireUp); }
        })();
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid familias-container">

        <!-- ICONOS -->
        <div class="toolbar mb-2">
            <!-- Columna 1: iconos -->
            <div class="icon-bar">
                <button type="button" id="btnAdd" class="btn btn-icon btn-add-usuario" title="Añadir usuario">
                    <i class="fa-solid fa-user"></i>
                </button>
                <button type="button" id="btnView" class="btn btn-icon btn-disabled" title="Consultar usuario" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>
                <button type="button" id="btnEdit" class="btn btn-icon btn-disabled" title="Editar usuario" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>
                <button type="button" id="btnDelete" class="btn btn-icon btn-disabled" title="Eliminar usuario" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>

            <!-- Columna 2: subtítulo centrado -->
            <span id="subTitle" class="header-cta">Gestión Usuarios</span>

        </div>

        <!-- BÚSQUEDA -->
        <div class="busqueda-box mb-4">
            <div class="row align-items-center g-3">
                <div class="col-md-3">
                    <label for="txtNombre" class="form-label">Nombre:</label>
                    <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-3 text-end">
                    <asp:LinkButton ID="btnBuscar" runat="server" CssClass="btn btn-search" ToolTip="Buscar"
                        OnClick="btnBuscar_Click" CausesValidation="false" UseSubmitBehavior="false">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>

        <!-- TABLA: GridView estilo patrón -->
        <div class="tabla-box">
            <asp:GridView ID="gvUsuarios" runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-bordered table-hover align-middle mb-0"
                GridLines="None"
                DataKeyNames="usuario_id"
                UseAccessibleHeader="true"
                AllowPaging="true" PageSize="10"
                AllowSorting="true"
                OnRowDataBound="gvUsuarios_RowDataBound"
                OnPageIndexChanging="gvUsuarios_PageIndexChanging"
                OnSorting="gvUsuarios_Sorting">
                <Columns>
                    <asp:BoundField DataField="usuario_id" HeaderText="ID" SortExpression="Id">
                        <ItemStyle Width="120px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="nombre" HeaderText="Nombre" SortExpression="NombreCompleto" />
                    <asp:BoundField DataField="ultimo_acceso" HeaderText="Último Acceso" SortExpression="UltimoAcceso" />
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-state">No se encontraron usuarios con los criterios ingresados.</div>
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:HiddenField ID="hfUsuarioIdSeleccionado" runat="server" />
        </div>

        <!-- MODAL CONFIRMACIÓN -->
        <div id="confirmDelete" class="confirm-overlay" aria-hidden="true">
            <div class="confirm-box">
                <div class="confirm-title">¿Estás seguro que deseas eliminar el usuario?</div>
                <div class="confirm-actions">
                    <asp:LinkButton ID="btnDoDelete" runat="server" ClientIDMode="Static" CssClass="btn-accept"
                        ToolTip="Sí, eliminar" CausesValidation="false" UseSubmitBehavior="false"
                        OnClick="btnDoDelete_Click">
                        <i class="fa-solid fa-check"></i>
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnCancelDelete" runat="server" ClientIDMode="Static" CssClass="btn-cancel"
                        ToolTip="No, cancelar" CausesValidation="false" UseSubmitBehavior="false" OnClientClick="return false;">
                        <i class="fa-solid fa-xmark"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
