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
            box-shadow: 03px8px rgba(0,0,0,.1);
        }

        .icon-bar {
            display: inline-flex;
            gap: .75rem;
            background: var(--blanco);
            border-radius: 12px;
            padding: .6rem .75rem;
            box-shadow: 02px6px rgba(0,0,0,.1);
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


        .card-form {
            background: var(--blanco);
            border-radius: 16px;
            padding: 1.25rem;
            box-shadow: 02px6px rgba(0,0,0,.12);
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
            box-shadow: 03px8px rgba(0,128,0,.15);
        }

        .btn-cancel {
            box-shadow: 03px8px rgba(255,0,0,.15);
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

        .overlay {
            position: fixed;
            inset: 0;
            display: none;
            align-items: center;
            justify-content: center;
            background: rgba(0,0,0,0.45);
            z-index: 1050;
        }

            .overlay.show {
                display: flex;
            }

        .modal-box {
            background: #fff;
            border-radius: 12px;
            padding: 1rem;
            width: 80%;
            max-width: 720px;
            position: relative;
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
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var btnOk = document.getElementById('<%= btnConfirmar.ClientID %>');
            var btnCancel = document.getElementById('<%= btnCancelar.ClientID %>');
            var ovCargos = document.getElementById('ovCargos');
            var txtCargoClientId = '<%= txtCargo.ClientID %>';

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
            if (btnCloseHistorialEl) btnCloseHistorialEl.addEventListener('click', function () { if (ovCargos) closeOv(ovCargos); });
            if (ovCargos) ovCargos.addEventListener('click', function (e) { if (e.target === ovCargos) closeOv(ovCargos); });

            document.addEventListener('keydown', function (e) { if (e.key === 'Escape') { if (ovCargos && ovCargos.classList.contains('show')) closeOv(ovCargos); } });


            function closeOv(ov) { ov.classList.remove('show'); ov.setAttribute('aria-hidden', 'true'); }


            window.selectCargo = function (cargoName) {
                try {
                    var target = document.getElementById(txtCargoClientId);
                    if (target) target.value = cargoName || '';
                    if (ovCargos) closeOv(ovCargos);
                } catch (err) { console.error('selectCargo error', err); }
            };


            window.highlightRow = function (el) {
                if (!el) return; var tb = el.closest('tbody'); if (!tb) return; tb.querySelectorAll('tr').forEach(function (r) { r.classList.remove('selected'); }); el.classList.add('selected');
            };
        });
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
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
                                <label class="form-label">ID:</label></div>
                            <div class="col-7">
                                <asp:TextBox ID="txtId" runat="server" CssClass="form-control input-disabled" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Nombre -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label">Nombre:</label></div>
                            <div class="col-7">
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="120"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Apellidos -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label">Apellido Paterno:</label></div>
                            <div class="col-7">
                                <asp:TextBox ID="txtApePaterno" runat="server" CssClass="form-control" MaxLength="120"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label">Apellido Materno:</label></div>
                            <div class="col-7">
                                <asp:TextBox ID="txtApeMaterno" runat="server" CssClass="form-control" MaxLength="120"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Cargos -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label">Cargo:</label></div>
                            <div class="col-4 text-end">
                                <asp:TextBox ID="txtCargo" runat="server" CssClass="form-control" MaxLength="80" ReadOnly="true"></asp:TextBox>
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
                                <label class="form-label">Num Telf:</label></div>
                            <div class="col-3">
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                            </div>
                            <div class="col-2 text-end">
                                <label class="form-label">Sueldo:</label></div>
                            <div class="col-2">
                                <asp:TextBox ID="txtSueldo" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Email + Fechas -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label">Email:</label></div>
                            <div class="col-3">
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" MaxLength="150"></asp:TextBox>
                            </div>
                            <div class="col-2 text-end">
                                <label class="form-label">Fecha Inicio Contrato:</label></div>
                            <div class="col-2">
                                <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end"></div>
                            <div class="col-3"></div>
                            <div class="col-2 text-end">
                                <label class="form-label">Fecha Fin Contrato:</label></div>
                            <div class="col-2">
                                <asp:TextBox ID="txtFechaFin" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Tipo de contrato -->
                        <div class="row g-3 align-items-center">
                            <div class="col-5 text-end">
                                <label class="form-label">Tipo Contrato:</label></div>
                            <div class="col-7">
                                <asp:DropDownList ID="ddlTipoContrato" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Seleccionar..." Value="" />
                                    <asp:ListItem Text="Tiempo Completo" Value="TiempoCompleto" />
                                    <asp:ListItem Text="Medio Tiempo" Value="MedioTiempo" />
                                    <asp:ListItem Text="Temporal" Value="Temporal" />
                                    <asp:ListItem Text="Prácticas" Value="Practicas" />
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>

                    <!-- ✔ guardar / ✖ cancelar (solo navegación por ahora) -->
                    <div class="action-buttons mt-3">
                        <a href="#" id="btnConfirmar" runat="server" class="btn-accept" title="Guardar">
                            <i class="fa-solid fa-check"></i>
                        </a>
                        <a href="#" id="btnCancelar" runat="server" class="btn-cancel" title="Cancelar">
                            <i class="fa-solid fa-xmark"></i>
                        </a>
                    </div>
                </div>

                <div id="ovCargos" class="overlay" aria-hidden="true">
                    <div class="modal-box">
                        <button type="button" id="btnCloseHistorial" class="btn-close" aria-label="Cerrar" style="position: absolute; top: 12px; right: 12px; background: transparent; border: 0; font-size: 1.25rem; cursor: pointer;">&times;</button>
                        <div class="modal-inner">
                            <!-- Minimal form: Nombre cargo -->
                            <div class="mb-3">
                                <label class="form-label">Nombre cargo:</label>
                                <div class="col-4 text-end">
                                    <asp:TextBox ID="txtNombreModal" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                </div>
                                <div class="col-3">
                                    <button type="button" class="btn-icon" title="Añadir cargo">
                                        <i class="fa-solid fa-user-plus"></i>
                                    </button>
                                </div>

                            </div>

                            <!-- Selectable grid below -->
                            <div class="tabla-box mb-3">
                                <table class="table table-bordered table-hover align-middle mb-0">
                                    <thead class="table-header">
                                        <tr>
                                            <th style="width: 8rem;">Seleccionar</th>
                                            <th>Cargo</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Example static rows so the grid is not empty during design/demo -->
                                        <tr class="selectable-row" onclick='highlightRow(this); selectCargo("Director")'>
                                            <td class="text-center">
                                                <input type="radio" name="selectedCargo" onclick='selectCargo("Director")' /></td>
                                            <td>Director</td>
                                        </tr>
                                        <tr class="selectable-row" onclick='highlightRow(this); selectCargo("Profesor de Matemáticas")'>
                                            <td class="text-center">
                                                <input type="radio" name="selectedCargo" onclick='selectCargo("Profesor de Matemáticas")' /></td>
                                            <td>Profesor de Matemáticas</td>
                                        </tr>
                                        <tr class="selectable-row" onclick='highlightRow(this); selectCargo("Coordinador Académico")'>
                                            <td class="text-center">
                                                <input type="radio" name="selectedCargo" onclick='selectCargo("Coordinador Académico")' /></td>
                                            <td>Coordinador Académico</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- panel derecho -->
                <div class="col-lg-4">
                    <div class="side-panel">
                        <div class="side-img">
                            <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" AlternateText="Colegio" />
                        </div>
                    </div>
                </div>

            </div>
            <!-- /row -->
        </div>
        <!-- /card -->
    </div>
</asp:Content>
