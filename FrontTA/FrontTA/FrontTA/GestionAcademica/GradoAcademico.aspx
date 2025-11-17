<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="GradoAcademico.aspx.cs" Inherits="FrontTA.GestionAcademica.GestionAcademico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Búsqueda de Grado Académico
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

        .grados-container {
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
            color: #fff;
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

        .btn-add {
            position: relative;
        }

            .btn-add .fa-graduation-cap {
                font-size: 1.1rem;
            }

            .btn-add::after {
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

        /* Encabezados sin subrayado/azul cuando hay AllowSorting */
        .table-header a,
        .table-header a:link,
        .table-header a:visited,
        .table-header a:hover,
        .table-header a:focus,
        .table-header a:active {
            color: #000 !important;
            text-decoration: none !important;
        }

        .tabla-box table.table tbody tr.data-row {
            cursor: pointer;
        }

            .tabla-box table.table tbody tr.data-row:hover:not(.row-selected) > td {
                background-color: #F3FAFF !important;
            }

            .tabla-box table.table tbody tr.data-row.row-selected > td {
                background-color: #E6F4FF !important;
                transition: background-color .15s ease-in-out;
            }

        .header-cta {
            background: #F3F4F6;
            color: #000000;
            border: 1px solid #E5E7EB;
            padding: .5rem 1rem;
            border-radius: 4px;
            font-weight: 700;
            justify-self: center; /* centra dentro de la columna del medio */
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

        .toolbar {
            display: grid;
            grid-template-columns: 1fr auto 1fr; /* izquierda | centro | (vacío/derecha) */
            align-items: center;
            margin-bottom: 1rem;
        }

            /* La barra de iconos dentro de la toolbar va pegada a la izquierda */
            .toolbar .icon-bar {
                justify-self: start;
            }



    </style>

    <script>
        (function () {
            function getTable() { return document.getElementById('<%= gvGrados.ClientID %>'); }
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
                const subTitle = document.getElementById('subTitle');

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
                    e.stopPropagation();
                });

                // Deseleccionar afuera
                document.addEventListener('click', function (ev) {
                    if (!table.contains(ev.target)) {
                        const sel = getSelected();
                        if (sel) sel.classList.remove('row-selected');
                        setEnabled(false);
                    }
                });

                // Navegación
                if (btnAdd) {
                    btnAdd.type = 'button';
                    btnAdd.addEventListener('click', function (e) {
                        e.preventDefault();
                        window.location.href = "<%= ResolveUrl("~/GestionAcademica/CrearGradoAcademico.aspx") %>";
                    });
                }

                if (btnView) {
                    btnView.addEventListener('click', function () {
                        const sel = getSelected(); if (!sel) return;
                        const id = sel.getAttribute('data-id');
                        window.location.href = '<%= ResolveUrl("~/GestionAcademica/ConsultarGradoAcademico.aspx") %>?id=' + encodeURIComponent(id);
                    });
                }

                if (btnEdit) {
                    btnEdit.addEventListener('click', function () {
                        const sel = getSelected(); if (!sel) return;
                        const id = sel.getAttribute('data-id');
                        window.location.href = '<%= ResolveUrl("~/GestionAcademica/EditarGradoAcademico.aspx") %>?id=' + encodeURIComponent(id);
                    });
                }

                // Eliminar (UI)
                function closeDeleteUI() {
                    if (overlay) { overlay.classList.remove('show'); overlay.setAttribute('aria-hidden', 'true'); }
                    if (subTitle) subTitle.style.display = 'none';
                    if (btnDel) btnDel.classList.remove('btn-active');
                    if (btnAdd) btnAdd.classList.remove('btn-disabled');
                    [btnView, btnEdit, btnDel].forEach(b => b && b.classList.add('btn-disabled'));
                    setEnabled(false);
                }

                if (btnDel && overlay) {
                    btnDel.addEventListener('click', function () {
                        const sel = getSelected(); if (!sel) return;
                        const id = sel.getAttribute('data-id');
                        // 🔹 guardamos el id del grado seleccionado en el hidden
                        var hf = document.getElementById('hfGradoIdSeleccionado');
                        if (hf) hf.value = id;

                        if (btnAdd) btnAdd.classList.add('btn-disabled');
                        [btnView, btnEdit].forEach(b => b && b.classList.add('btn-disabled'));
                        btnDel.classList.remove('btn-disabled'); btnDel.classList.add('btn-active'); btnDel.disabled = false;
                        overlay.classList.add('show'); overlay.setAttribute('aria-hidden', 'false');
                        if (subTitle) { subTitle.textContent = 'Eliminar Grado Académico'; subTitle.style.display = 'inline-block'; }
                    });
                }

                

                if (btnCancelDelete && overlay) {
                    btnCancelDelete.addEventListener('click', closeDeleteUI);
                    overlay.addEventListener('click', e => { if (e.target === overlay) closeDeleteUI(); });
                    document.addEventListener('keydown', e => { if (e.key === 'Escape' && overlay.classList.contains('show')) closeDeleteUI(); });
                }
            }

            document.addEventListener('DOMContentLoaded', wireUp);
            if (window.Sys && Sys.Application) { Sys.Application.add_load(wireUp); }
        })();
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid grados-container">

        <!-- Barra superior: iconos + título "Gestión Grado Académico" -->
        <div class="toolbar mb-3">
            <div class="icon-bar">
                <button type="button" id="btnAdd" class="btn btn-icon btn-add" title="Crear grado académico">
                    <i class="fa-solid fa-graduation-cap"></i>
                </button>
                <button type="button" id="btnView" class="btn btn-icon btn-disabled" title="Consultar grado académico" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>
                <button type="button" id="btnEdit" class="btn btn-icon btn-disabled" title="Editar grado académico" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>
                <button type="button" id="btnDelete" class="btn btn-icon btn-disabled" title="Eliminar grado académico" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>

            <span class="header-cta">Gestión Grado Académico</span>
        </div>

        <!-- BÚSQUEDA -->
        <div class="busqueda-box mb-4">
            <div class="row align-items-center g-3">
                <div class="col-md-5">
                    <label for="txtNombre" class="form-label">Nombre:</label>
                    <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-5">
                    <label for="txtAbreviatura" class="form-label">Abreviatura:</label>
                    <asp:TextBox ID="txtAbreviatura" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-2 text-center">
                    <asp:LinkButton ID="btnBuscar" runat="server" CssClass="btn btn-search" ToolTip="Buscar"
                        OnClick="btnBuscar_Click" CausesValidation="false" UseSubmitBehavior="false">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </asp:LinkButton>
                </div>
            </div>
        </div>

        <!-- TABLA: GridView patrón -->
        <div class="tabla-box">
            <asp:GridView ID="gvGrados" runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-bordered table-hover align-middle mb-0"
                GridLines="None"
                DataKeyNames="Id"
                UseAccessibleHeader="true"
                AllowPaging="true" PageSize="10"
                AllowSorting="true"
                OnRowDataBound="gvGrados_RowDataBound"
                OnPageIndexChanging="gvGrados_PageIndexChanging"
                OnSorting="gvGrados_Sorting">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" SortExpression="Id">
                        <ItemStyle Width="180px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                    <asp:BoundField DataField="Abreviatura" HeaderText="Abreviatura" SortExpression="Abreviatura" />
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-state">No se encontraron grados académicos con los criterios ingresados.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>

        <asp:HiddenField ID="hfGradoIdSeleccionado" runat="server" ClientIDMode="Static" />

        <!-- MODAL ELIMINAR -->
        <div id="confirmDelete" class="confirm-overlay" aria-hidden="true">
            <div class="confirm-box">
                <div class="confirm-title">¿Estás seguro que deseas eliminar el grado académico?</div>
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
