<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="CrearAlumno.aspx.cs" Inherits="FrontTA.Alumnos.CrearAlumno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">Colegio Rafael Mariscal Quintanilla - Crear Alumno </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        /*TABLA*/ .tabla-box table.table tbody tr.data-row.row-selected > td {
            background-color: #E6F4FF !important; /* celeste claro */
            transition: background-color .15s ease-in-out;
        }
        /* Hover solo si NO está seleccionada */

        .tabla-box table.table tbody tr.data-row:hover:not(.row-selected) > td {
            background-color: #F3FAFF !important;
        }

        .tabla-box {
            background: var(--blanco);
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
            overflow-x: auto;
            max-height: 200px;
            overflow-y: auto; 
            display: block;
        }

        .tabla-box {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
            overflow-x: auto;
            max-height: 200px;
            overflow-y: auto;
            display: block;
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

        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --grisTexto: #777;
            --blanco: #FFF;
            --negro: #000;
            --celeste: #BFE7FF; /* panel lateral */
            --celesteBtn: #8FD2FF; /* botón activo barra */
            --borde: #D7D7D7;
        }

        .alumnos-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
        }
        /* barra de iconos */

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

        .btn-icon-2 {
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

            .btn-icon-2:hover {
                background: var(--verdeOsc);
                transform: scale(1.05);
            }
        /*Boton de Seleccionar Familia*/

        .btn-add-family {
            position: relative;
        }

            .btn-add-family .fa-people-group {
                font-size: 1.1rem;
            }

            .btn-add-family::after {
                content: "\f002"; /* código unicode del ícono de lupa de Font Awesome */
                font-family: "Font Awesome 6 Pro";
                font-weight: 900; /* importante para solid */
                position: absolute;
                right: -4px;
                bottom: -4px; /* 👈 mueve el círculo a la parte inferior */
                width: 18px;
                height: 18px;
                border-radius: 50%;
                background: var(--verdeOsc);
                color: #fff;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: .65rem; /* ajusta el tamaño del ícono */
                line-height: 1;
                box-shadow: 0 1px 3px rgba(0,0,0,.25);
            }

        .btn-active {
            background: var(--celesteBtn);
            color: #00324D;
        }

            .btn-active:hover {
                transform: scale(1.05);
            }

        .btn-muted {
            background: #F1F1F1;
            color: var(--grisTexto);
        }

            .btn-muted:hover {
                background: #E9E9E9;
            }

        .toolbar {
            display: grid;
            grid-template-columns: 1fr auto 1fr; /* izq | centro | der */
            align-items: center;
        }

        .header-cta {
            background: #F3F4F6;
            color: #000000;
            border: 1px solid #E5E7EB;
            padding: .5rem 1rem;
            border-radius: 4px;
            font-weight: 700;
            justify-self: center; /* centra en la columna 2 */
        }

        .toolbar .icon-bar {
            justify-self: start;
        }
        /* tarjeta */

        .card-form {
            background: var(--blanco);
            border-radius: 16px;
            padding: 1.25rem;
            box-shadow: 0 2px 6px rgba(0,0,0,.12);
        }

        .fieldset {
            border: 2px solid #E8E8E8;
            border-radius: 16px;
            padding: 1.25rem;
            background: #F8F8F8;
        }

        .form-label {
            font-weight: 700;
            font-size: 1.15rem;
            color: #1f2937;
        }

        .form-control {
            border: 1px solid var(--borde);
            border-radius: 8px;
            height: 44px;
        }

        .input-disabled {
            background: #BDBDBD;
            color: #444;
            border: 1px solid #AFAFAF;
        }
        /* panel derecho celeste */

        .side-panel {
            max-width: 300px; /* límite razonable para pantallas grandes */
            min-width: 200px; /* mantiene algo de consistencia */
            height: auto;
            padding: 1rem 2rem;
            border-radius: 16px;
            background: var(--celeste);
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #a7d7f3;
            margin: 0 auto;
        }

        .side-title {
            font-weight: 800;
            font-size: 1.25rem;
            color: #0b3650;
            margin-bottom: .5rem;
            display: none !important;
        }

        .side-img {
            background: #ffffffaa;
            border: 2px solid #d7eefc;
            border-radius: 16px;
            padding: 1rem;
            border-width: 2px;
            height: auto;
        }
        /* botones ✔ / ✖ */

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            text-decoration: none !important;
        }

        .btn-accept, .btn-cancel {
            text-decoration: none !important;
            width: 56px;
            height: 56px;
            border-radius: 12px;
            border: 2px solid #00000030;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            cursor: pointer;
            background: #fff;
            transition: transform .15s ease, box-shadow .15s ease;
        }

        .btn-accept {
            box-shadow: 0 3px 8px rgba(0,128,0,.15);
        }

            .btn-accept:hover, .btn-cancel:hover {
                transform: translateY(-2px);
            }

            .btn-accept i {
                color: #2E7D32;
            }

        .action-buttons .btn-accept i {
            color: #2E7D32 !important;
            font-size: 1.7rem;
        }

        .action-buttons .btn-cancel i {
            color: #D32F2F !important;
            font-size: 1.7rem;
        }
        /* ===== Modal (Seleccionar Familia) ===== */

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
            border: 6px solid #000; /* marco negro grueso como en la maqueta */
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
        /* === NUEVO: logo dentro del modal, tamaño controlado === */

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

        html.ovlock, body.ovlock {
            overflow: hidden !important;
        }

        /* Unificación estilos tabla + selección (si ya existen, evita duplicados) */
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

        /* Fila seleccionada dentro de la tabla del modal */
        .tabla-box .table tbody tr.data-row.row-selected > td,
        .table tbody tr.data-row.row-selected > td,
        .table.table-hover tbody tr.data-row.row-selected:hover > td {
            background-color: #E6F4FF !important;
            transition: background-color .15s ease-in-out;
        }


    </style>

    <script>
        (function () {
            // Helpers
            function getOvFamilia() { return document.getElementById('ovFamilia'); }
            function lockBodyScroll(lock) {
                document.documentElement.classList.toggle('ovlock', !!lock);
                document.body.classList.toggle('ovlock', !!lock);
            }
            function focusModalFirstField() {
                var tb = document.getElementById('<%= txtApePaternoModal.ClientID %>');
                if (tb) { try { tb.focus(); tb.select(); } catch (_) { } }
            }

            // Abre/Cierra modal
            function openOv() {
                var ovFamilia = getOvFamilia();
                if (!ovFamilia) return;
                ovFamilia.classList.add('show');
                ovFamilia.setAttribute('aria-hidden', 'false');
                var btnConfirm = document.getElementById('btnConfirmarFamilia');
                if (btnConfirm) btnConfirm.classList.add('btn-disabled');
                lockBodyScroll(true);
                setTimeout(focusModalFirstField, 0);
            }
            function closeOv() {
                var ovFamilia = getOvFamilia();
                if (!ovFamilia) return;
                ovFamilia.classList.remove('show');
                ovFamilia.setAttribute('aria-hidden', 'true');
                lockBodyScroll(false);
            }

            // Copia selección a txtCodigoFamilia y cierra (sin postback)
            window.confirmarFamilia = function () {
                var ov = getOvFamilia(); if (!ov) return false;
                var sel = ov.querySelector('tr.fam-row.row-selected, tr.data-row.row-selected');
                if (!sel) return false;

                var cod = sel.getAttribute('data-familia');
                if (!cod) { // fallback por si viniera en celdas
                    var tds = sel.querySelectorAll('td');
                    cod = (tds[0]?.innerText.trim()) || '';
                }
                document.getElementById('<%= txtCodigoFamilia.ClientID %>').value = cod || '';
                closeOv();
                return false; // evita postback del LinkButton
            };

            // Delegación dentro del overlay del modal: seleccionar fila + botones
            function bindDelegatedModalHandlers() {
                var ov = getOvFamilia();
                if (!ov || ov.__delegatedBound) return;
                ov.__delegatedBound = true;

                ov.addEventListener('click', function (e) {
                    // Botón X
                    if (e.target.closest('#btnCloseFamilia')) {
                        closeOv();
                        e.preventDefault();
                        e.stopPropagation();
                        return;
                    }

                    // Selección de fila
                    var tr = e.target.closest('tr.fam-row, tr.data-row');
                    if (tr && ov.contains(tr)) {
                        var table = ov.querySelector('.tabla-box table');
                        if (table) {
                            table.querySelectorAll('tr.fam-row.row-selected, tr.data-row.row-selected')
                                .forEach(r => r.classList.remove('row-selected'));
                        }
                        tr.classList.add('row-selected');
                        var btnConfirm = document.getElementById('btnConfirmarFamilia');
                        if (btnConfirm) btnConfirm.classList.remove('btn-disabled');
                        return;
                    }

                    // Click fuera del cuadro => cerrar
                    if (e.target === ov) closeOv();
                }, { passive: true });
            }

            // Wire-up botones principales
            function wireUp() {
                var btnAddFamilia = document.getElementById('btnAddFamilia');
                var btnCloseFamilia = document.getElementById('btnCloseFamilia');

                if (btnAddFamilia) {
                    btnAddFamilia.type = 'button';
                    btnAddFamilia.addEventListener('click', function (e) {
                        e.preventDefault();
                        openOv();
                    });
                }
                if (btnCloseFamilia) {
                    btnCloseFamilia.addEventListener('click', function (e) {
                        e.preventDefault();
                        closeOv();
                    });
                }

                document.addEventListener('keydown', function (e) {
                    if (e.key === 'Escape') {
                        var ov = getOvFamilia();
                        if (ov && ov.classList.contains('show')) closeOv();
                    }
                });
            }

            // Inicio
            document.addEventListener('DOMContentLoaded', function () {
                wireUp();
                bindDelegatedModalHandlers();
            });

            // Re-enganchar tras cada async postback del UpdatePanel
            if (window.Sys && Sys.WebForms && Sys.WebForms.PageRequestManager) {
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                prm.add_endRequest(function () {
                    try {
                        bindDelegatedModalHandlers();
                    } catch (err) {
                        console.error('endRequest error:', err);
                    }
                });
            }
        })();
    </script>
    <script>
        function mostrarModal(mensaje) {
            document.getElementById("modalMensaje").innerText = mensaje;
            document.getElementById("modalError").style.display = "flex";
        }

        function cerrarModal() {
            document.getElementById("modalError").style.display = "none";
        }
    </script>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />


    <div class="container-fluid alumnos-container">
        <div class="toolbar mb-3">
            <div class="icon-bar">
                <!-- ACTIVO (Agregar) -->
                <button type="button" class="btn-icon btn-active" title="Añadir Alumno"><i class="fa-solid fa-user-graduate"></i></button>
                <!-- INACTIVOS -->
                <button type="button" class="btn-icon btn-muted" title="Consultar Alumno" disabled><i class="fa-solid fa-eye"></i></button>
                <button type="button" class="btn-icon btn-muted" title="Editar Alumno" disabled><i class="fa-solid fa-pen"></i></button>
                <button type="button" class="btn-icon btn-muted" title="Eliminar Alumno" disabled><i class="fa-solid fa-trash"></i></button>
            </div>
            <span class="header-cta">Crear Alumno</span> </div>
        <!-- CONTENIDO -->
        <div class="card-form">
            <div class="row g-4">
                <div class="fieldset">
                    <div class="mb-2 row g-4 align-items-start">
                        <div class="col-7 ">
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Código Familia:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <!-- Se quito en solo lectura para pruebas, una vez arreglado el modal, volver a colocar -->
                                    <asp:TextBox ID="txtCodigoFamilia" runat="server" CssClass="form-control" Text=""></asp:TextBox>
                                </div>
                                <div class="col-md-1 align-content-lg-start">
                                    <button type="button" id="btnAddFamilia" class="btn btn-icon-2 btn-add-family" title="Añadir familia"><i class="fa-solid fa-people-group"></i></button>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Nombre:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">DNI:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Fecha Nacimiento:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-5 d-flex">
                            <div class="side-panel flex-fill flex-column justify-content-center">
                                <div class="text-center">
                                    <div class="side-title">Crear Familia</div>
                                    <div class="side-img">
                                        <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" AlternateText="Colegio" Style="max-width: 150px; max-height: 120px;" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mb-4 row align-items-center g-3">
                        <div class="col-7">
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Fecha Ingreso:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtFechaIngreso" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Religión:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtReligion" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Género:</label>
                                </div>
                                <div class="col-md-8 align-content-md-center">
                                    <asp:DropDownList ID="ddlGenero" runat="server" CssClass="form-control">
                                        <asp:ListItem Text="Seleccionar..." Value="" />
                                        <asp:ListItem Text="Masculino" Value="M" />
                                        <asp:ListItem Text="Femenino" Value="F" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Pensión base:</label>
                                </div>
                                <div class="col-md-8 align-content-md-center">
                                    <asp:TextBox ID="txtPension" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mb-2 row align-items-center g-3">
                        <div class="row">
                            <label class="form-label align-content-center">Observaciones:</label>
                        </div>
                        <div class="mb-0 row p-lg-3">
                            <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control align-content-center" Multiline="True"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="action-buttons mt-3">
                <!-- ✔ crear y volver FALTA AÑADIR EL GUARDADO-->
                <asp:LinkButton ID="btnConfirmar" runat="server" CssClass="btn-accept" OnClick="btnConfirmar_Click" ToolTip="Crear y volver"> <i class="fa-solid fa-check"></i> </asp:LinkButton>
                <!-- ✖ cancelar y volver -->
                <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel" OnClick="btnCancelar_Click" ToolTip="Cancelar y volver"> <i class="fa-solid fa-xmark"></i> </asp:LinkButton>
            </div>
        </div>






        <!-- Seleccionar Familia -->
        <asp:UpdatePanel ID="upFamilia" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
            <ContentTemplate>
                <div id="ovFamilia" class="overlay" aria-hidden="true">
                    <div class="modal-box">
                        <div class="modal-inner">
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
                                                OnClick="btnBuscarModal_Click"
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
                                                            data-familia='<%# Eval("familia_id") %>'
                                                            data-ape-pat='<%# Eval("apellido_paterno") %>'
                                                            data-ape-mat='<%# Eval("apellido_materno") %>'>
                                                            <td><%# Eval("familia_id") %></td>
                                                            <td><%# Eval("apellido_paterno") %></td>
                                                            <td><%# Eval("apellido_materno") %></td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                Notas importantes:
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
                                <asp:LinkButton ID="btnConfirmarFamilia" runat="server" ClientIDMode="Static"
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
                <asp:AsyncPostBackTrigger ControlID="btnBuscarModal" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>



    </div>

    <!-- MODAL DE ERROR -->
<div id="modalError" class="modal">
    <div class="modal-content">
        <span class="close" onclick="cerrarModal()">&times;</span>
        <h3>Error</h3>
        <p id="modalMensaje"></p>
    </div>
</div>

<style>
    .modal {
        display: none;
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background: rgba(0,0,0,0.5);
        z-index: 9999;
        justify-content: center;
        align-items: center;
    }

    .modal-content {
        background: #fff;
        padding: 1.5rem;
        border-radius: 12px;
        width: 90%;
        max-width: 380px;
        text-align: center;
    }

    .close {
        float: right;
        font-size: 1.5rem;
        cursor: pointer;
    }
</style>

</asp:Content>
