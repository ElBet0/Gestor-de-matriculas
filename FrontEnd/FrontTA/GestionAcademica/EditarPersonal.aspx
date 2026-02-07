<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true"
    CodeBehind="EditarPersonal.aspx.cs" Inherits="FrontTA.GestionAcademica.EditarPersonal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Editar Personal
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
            --celeste: #BFE7FF; /* panel lateral */
            --celesteBtn: #8FD2FF; /* botón activo barra */
            --borde: #D7D7D7;
        }

        .familias-container {
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

        .btn-active {
            background: var(--celesteBtn);
            color: #00324D;
        }

        .btn-muted {
            background: #F1F1F1;
            color: #9aa0a6;
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

        .form-label2 {
            font-weight: 700;
            font-size: 1.05rem;
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
        /* solo lectura gris */

        /* panel derecho con escudo */
        .side-panel {
            min-height: 320px;
            padding: 1.5rem;
            border-radius: 16px;
            background: var(--celeste);
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #a7d7f3;
        }

        .side-img {
            background: #ffffffaa;
            border: 3px solid #d7eefc;
            border-radius: 16px;
            padding: 1rem;
            text-align: center;
        }

            .side-img img {
                max-width: 220px;
                height: auto;
                display: block;
            }

        /* botones ✔ / ✖ */
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
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
            cursor: pointer;
            background: #fff;
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

        /* overlay / modal styles */
        /*.overlay {
            position: fixed !important;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            width: 100vw;
            height: 100vh;
            display: none;
            align-items: center;
            justify-content: center;
            background: rgba(0,0,0,0.45);
            z-index: 9999;
            padding: 1rem;
        }

            .overlay.show {
                display: flex;
            }*/

        /*.modal-box {
            background: #fff;
            border-radius: 12px;
            padding: 1rem;
            width: 100%;
            max-width: 720px;
            position: relative;
            max-height: calc(100vh - 2rem);
            overflow: auto;
        }*/

        /* ===== Modal (Seleccionar Familia) ===== */
        /*.overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.35);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1050;
        }*/

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        /* Caja principal del modal */
        .modal-box {
            background: white;
            width: 60%; /* 👈 puedes ajustar (por ejemplo 50% o 70%) */
            max-height: 80vh; /* 👈 controla el alto máximo */
            border-radius: 10px;
            padding: 20px;
            overflow-y: auto; /* 👈 activa el scroll interno vertical */
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
        }

            /* Opcional: mejora del scrollbar */
            .modal-box::-webkit-scrollbar {
                width: 8px;
            }

            .modal-box::-webkit-scrollbar-thumb {
                background-color: #ccc;
                border-radius: 4px;
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


        .selectable-row {
            cursor: pointer;
        }

            .selectable-row:hover {
                background: #f1f5f9;
            }

        .selected {
            background: #e6f7ff !important;
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


    </style>
    <%--<script>
        document.addEventListener('DOMContentLoaded', function () {
            try {
                var btnOk = document.getElementById('<%= btnConfirmar.ClientID %>');
                var btnCancel = document.getElementById('<%= btnCancelar.ClientID %>');
                var ovCargos = document.getElementById('ovCargos');
                var modalBox = ovCargos ? ovCargos.querySelector('.modal-box') : null;
                var txtCargoClientId = '<%= txtCargo.ClientID %>';
                var txtNombreModalClientId = '<%= txtNombreModal.ClientID %>';

                if (btnOk) btnOk.addEventListener('click', function (e) { e.preventDefault(); window.location.href = '<%= ResolveUrl("~/GestionAcademica/Personal.aspx") %>'; });
                if (btnCancel) btnCancel.addEventListener('click', function (e) { e.preventDefault(); window.location.href = '<%= ResolveUrl("~/GestionAcademica/Personal.aspx") %>'; });


                var btnCargosEl = document.getElementById('btnCargos');
                if (btnCargosEl) {
                    btnCargosEl.addEventListener('click', function () {
                        if (ovCargos) {
                            ovCargos.classList.add('show');
                            ovCargos.setAttribute('aria-hidden', 'false');
                        }
                    });
                }


                var btnCloseHistorialEl = document.getElementById('btnCloseHistorial');
                if (btnCloseHistorialEl) btnCloseHistorialEl.addEventListener('click', function () { closeOv(ovCargos, modalBox); });


                // Close when clicking outside the modal-box (more reliable than e.target === ov)
                if (ovCargos) {
                    ovCargos.addEventListener('click', function (e) {
                        if (modalBox && !modalBox.contains(e.target)) {
                            closeOv(ovCargos, modalBox);
                        }
                    });
                }


                // ESC closes overlay
                document.addEventListener('keydown', function (e) {
                    if (e.key === 'Escape' || e.key === 'Esc') {
                        if (ovCargos && ovCargos.classList.contains('show')) closeOv(ovCargos, modalBox);
                    }
                });


                function closeOv(ov, mb) {
                    if (!ov) return;
                    try { ov.classList.remove('show'); } catch (e) { }
                    try { ov.setAttribute('aria-hidden', 'true'); } catch (e) { }
                    // fallback: ensure overlay not visible
                    try { ov.style.display = 'none'; } catch (e) { }
                    // ensure modal focus is returned (optional)
                    try {
                        var target = document.getElementById(txtCargoClientId);
                        if (target) target.focus();
                    } catch (e) { }
                }


                // Expose selectCargo for rows/radios
                window.selectCargo = function (cargoName) {
                    try {
                        var target = document.getElementById(txtCargoClientId);
                        if (target) target.value = cargoName || '';
                        closeOv(ovCargos, modalBox);
                    } catch (err) { console.error('selectCargo error', err); }
                };


                // highlight row helper
                window.highlightRow = function (el) {
                    if (!el) return; var tb = el.closest('tbody'); if (!tb) return; tb.querySelectorAll('tr').forEach(function (r) { r.classList.remove('selected'); }); el.classList.add('selected');
                };


                // If modal is opened programmatically elsewhere, ensure display style is managed
                var observer = new MutationObserver(function () {
                    if (ovCargos) {
                        if (ovCargos.classList.contains('show')) ovCargos.style.display = 'flex'; else ovCargos.style.display = 'none';
                    }
                });
                if (ovCargos) observer.observe(ovCargos, { attributes: true, attributeFilter: ['class'] });

            } catch (ex) {
                console.error('Error initializing CrearPersonal modal script', ex);
            }

            function abrirOverlay() {
                document.getElementById("ovCargos").style.display = "block";
            }

            function cerrarOverlay() {
                document.getElementById("ovCargos").style.display = "none";
            }

            function seleccionarCargo(id, nombre) {
                document.getElementById("<%= hfCargoId.ClientID %>").value = id;
                document.getElementById("<%= txtCargoSeleccionado.ClientID %>").value = nombre;
                cerrarOverlay();
            }

        });
    </script>--%>

   <script>
       document.addEventListener('DOMContentLoaded', function () {
           const ovCargos = document.getElementById('ovCargos');
           const modalBox = ovCargos ? ovCargos.querySelector('.modal-box') : null;

           const btnCargos = document.getElementById('btnCargos');
           const txtCargo = document.getElementById('<%= txtCargo.ClientID %>');
           const hfCargoId = document.getElementById('<%= hfCargoId.ClientID %>');
  const hfCargoNombre = document.getElementById('<%= hfCargoNombre.ClientID %>');

    function cerrarOverlay() {
        if (!ovCargos) return;
        ovCargos.classList.remove('show');
        ovCargos.style.display = 'none';
        ovCargos.setAttribute('aria-hidden', 'true');
    }

    if (btnCargos) {
        btnCargos.addEventListener('click', function () {
            ovCargos.classList.add('show');
            ovCargos.style.display = 'flex';
            ovCargos.setAttribute('aria-hidden', 'false');
        });
    }

    // ÚNICA función global que usará el GridView (onclick en la fila/radio)
    window.seleccionarCargo = function (id, nombre) {
        if (hfCargoId) hfCargoId.value = id;
        if (hfCargoNombre) hfCargoNombre.value = nombre;
        if (txtCargo) txtCargo.value = nombre;
        cerrarOverlay();
    };

    if (ovCargos) {
        ovCargos.addEventListener('click', function (e) {
            if (modalBox && !modalBox.contains(e.target)) cerrarOverlay();
        });
    }

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') cerrarOverlay();
    });

    // Mantener el observer si quieres
    const observer = new MutationObserver(function () {
        if (ovCargos) {
            ovCargos.style.display = ovCargos.classList.contains('show') ? 'flex' : 'none';
        }
    });
    if (ovCargos) observer.observe(ovCargos, { attributes: true, attributeFilter: ['class'] });
});
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
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div class="container-fluid familias-container">

        <!-- barra superior -->
        <div class="toolbar mb-3">
            <div class="icon-bar">
                <!-- lápiz ACTIVO (celeste) -->
                <button type="button" class="btn-icon btn-active" title="Editar personal">
                    <i class="fa-solid fa-pen"></i>
                </button>
                <!-- resto en gris -->
                <button type="button" class="btn-icon btn-muted" title="Añadir personal" disabled>
                    <i class="fa-solid fa-user"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Consultar personal" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Eliminar personal" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>

            <span class="header-cta">Editar Personal</span>
        </div>

        <!-- contenido -->
        <div class="card-form">
            <div class="row g-4">

                <!-- formulario -->
                <div class="col-lg-8">
                    <div class="fieldset">
                        <!-- ID bloqueado -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label2">ID:</label>
                            </div>
                            <div class="col-7">
                                <asp:TextBox ID="txtId" runat="server" CssClass="form-control input-disabled" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Nombre -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label2">Nombre:</label>
                            </div>
                            <div class="col-7">
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="120"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Apellidos -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label2">Apellido Paterno:</label>
                            </div>
                            <div class="col-7">
                                <asp:TextBox ID="txtApePaterno" runat="server" CssClass="form-control" MaxLength="120"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label2">Apellido Materno:</label>
                            </div>
                            <div class="col-7">
                                <asp:TextBox ID="txtApeMaterno" runat="server" CssClass="form-control" MaxLength="120"></asp:TextBox>
                            </div>
                        </div>


                        <!-- Cargos -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label2">Cargo:</label></div>
                            <div class="col-4 text-end">
                                <asp:TextBox ID="txtCargo" runat="server" CssClass="form-control" MaxLength="80" ReadOnly="true"></asp:TextBox>
                                <asp:HiddenField ID="hfCargoId" runat="server" />
                                <asp:HiddenField ID="hfCargoNombre" runat="server" />
                            </div>
                            <div class="col-3">
                                <button type="button" id="btnCargos" class="btn-icon btn-info" title="Buscar Cargo">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Teléfono + Sueldo -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label2">Num Telf:</label>
                            </div>
                            <div class="col-3">
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                            </div>
                            <div class="col-2 text-end">
                                <label class="form-label2">Sueldo:</label>
                            </div>
                            <div class="col-2">
                                <asp:TextBox ID="txtSueldo" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Email + Fechas -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label2">Email:</label>
                            </div>
                            <div class="col-3">
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" MaxLength="150"></asp:TextBox>
                            </div>
                            <div class="col-2 text-end">
                                <label class="form-label2">Fecha Inicio Contrato:</label>
                            </div>
                            <div class="col-2">
                                <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>

                        <!-- DNI + Fecha Fin Contrato -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label2">DNI:</label>
                            </div>
                            <div class="col-3">
                                <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" MaxLength="8"></asp:TextBox>
                            </div>
                            <div class="col-2 text-end">
                                <label class="form-label2">Fecha Fin Contrato:</label>
                            </div>
                            <div class="col-2">
                                <asp:TextBox ID="txtFechaFin" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Tipo de contrato (enum) -->
                        <div class="row g-3 align-items-center">
                            <div class="col-5 text-end">
                                <label class="form-label2">Tipo Contrato:</label></div>
                            <div class="col-7">
                                <asp:DropDownList ID="ddlTipoContrato" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Tiempo Completo" Value="COMPLETO"></asp:ListItem>
                                    <asp:ListItem Text="Parcial" Value="PARCIAL"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>

                    <!-- ✔ crear / ✖ cancelar -->
                    <div class="action-buttons mt-3">
                        <asp:LinkButton ID="btnConfirmar" runat="server" CssClass="btn-accept" OnClick="btnConfirmar_Click" ToolTip="Crear">
                            <i class="fa-solid fa-check"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel" OnClick="btnCancelar_Click" ToolTip="Cancelar">
                            <i class="fa-solid fa-xmark"></i>
                        </asp:LinkButton>
                    </div>
                </div>
                <!-- panel derecho con escudo -->
                <div class="col-lg-4">
                    <div class="side-panel">
                        <div class="side-img">
                            <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" AlternateText="Colegio" />
                        </div>
                    </div>
                </div>

            </div>
            

            <div id="ovCargos" class="overlay" style="display: none;">
                <div class="modal-box">
                    <%--<button type="button" id="btnCloseHistorial" class="btn-close" aria-label="Cerrar" style="position: absolute; top: 12px; right: 12px; background: transparent; border: 0; font-size: 1.25rem; cursor: pointer;">&times;</button>--%>
                    <div class="modal-inner">

                        <!-- fila: tabla + logo (adentro del rectángulo gris) -->
                        <div class="modal-flex">
                            <div class="col-9">
                                <asp:UpdatePanel ID="upCargos" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <div class="mb-2 row">
                                            <div class="col-md-10">
                                                <div class="mb-2 row">
                                                    <div class="col-md-4">
                                                        <label class="form-label2 align-content-center">Nombre Cargo:</label>
                                                    </div>
                                                    <div class="col-8">
                                                        <asp:TextBox ID="txtNombreModal" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="d-flex justify-content-center align-items-center">
                                                <asp:LinkButton ID="btnAgregarCargo" runat="server" CssClass="btn-search" OnClick="btnAgregarCargo_Click" ToolTip="Crear">
                                            <i class="fa-solid fa-user-plus"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </div>

                                        <asp:GridView ID="gvCargos" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" OnRowDataBound="gvCargos_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Seleccionar">
                                                    <ItemTemplate>
                                                        <input type="radio" name="cargoRadio"
                                                            value='<%# Eval("cargo_id") %>'
                                                            onclick="seleccionarCargo('<%# Eval("cargo_id") %>', '<%# Eval("nombre") %>')" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>




                            </div>
                            <div class="col-3 align-content-center">
                                <div class="side-img-modal">
                                    <asp:Image ID="imgCursosEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
            <!-- /row -->

       


        </div>
        <!-- /card -->

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