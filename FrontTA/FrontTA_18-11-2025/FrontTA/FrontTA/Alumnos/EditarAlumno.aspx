<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true"
    CodeBehind="EditarAlumno.aspx.cs" Inherits="FrontTA.Alumnos.EditarAlumno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Editar Alumno
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <script>
        function mostrarModal(mensaje) {
            document.getElementById("modalMensaje").innerText = mensaje;
            document.getElementById("modalError").style.display = "flex";
        }

        function cerrarModal() {
            document.getElementById("modalError").style.display = "none";
        }
    </script>   
    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --grisTexto: #777;
            --blanco: #FFF;
            --negro: #000;
            --celeste: #BFE7FF;
            --celesteBtn: #8FD2FF;
            --borde: #D7D7D7;
        }

        .alumnos-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
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
            color: var(--grisTexto);
        }

        .toolbar {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            align-items: center;
        }

            .toolbar .icon-bar {
                justify-self: start;
            }

        .header-cta {
            background: #F3F4F6;
            color: #000;
            border: 1px solid #E5E7EB;
            padding: .5rem 1rem;
            border-radius: 4px;
            font-weight: 700;
            justify-self: center;
        }

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
            border: 2px solid #d7eefc;
            border-radius: 16px;
            padding: 1rem;
        }

            .side-img img {
                max-width: 200px;
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
        // UX: deshabilita el botón al enviar para evitar doble click
        function disableOnSubmit(btnId) {
            var btn = document.getElementById(btnId);
            if (btn) { btn.disabled = true; btn.style.opacity = '0.7'; }
            return true;
        }
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <!-- NO usamos validadores WebForms: no hay dependencia de jQuery -->
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />

    <div class="container-fluid alumnos-container">

        <!-- barra superior -->
        <div class="toolbar mb-3">
            <div class="icon-bar">
                <button type="button" class="btn-icon btn-active" title="Editar Alumno" aria-label="Editar Alumno">
                    <i class="fa-solid fa-pen"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Añadir Alumno" aria-disabled="true">
                    <i class="fa-solid fa-user-graduate"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Consultar Alumno" aria-disabled="true">
                    <i class="fa-solid fa-eye"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Eliminar Alumno" aria-disabled="true">
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>
            <span class="header-cta">Editar Alumno</span>
        </div>

        <!-- contenido -->
        <div class="card-form">
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="fieldset">

                        <!-- AlumnoId oculto -->
                        <asp:HiddenField ID="hfAlumnoId" runat="server" />

                        <!-- Código Familia (solo lectura) -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label" for="<%= txtCodigoFamilia.ClientID %>">Código Familia:</label>
                            </div>
                            <div class="col-7">
                                <asp:TextBox ID="txtCodigoFamilia" runat="server" CssClass="form-control input-disabled" ReadOnly="true" />
                            </div>
                        </div>

                        <!-- Nombre -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label" for="<%= txtNombre.ClientID %>">Nombre:</label>
                            </div>
                            <div class="col-7">
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="60" />
                            </div>
                        </div>

                        <!-- DNI -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label" for="<%= txtDNI.ClientID %>">DNI:</label>
                            </div>
                            <div class="col-7">
                                <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" MaxLength="12" />
                            </div>
                        </div>

                        <!-- Fecha Nacimiento -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label" for="<%= txtFechaNacimiento.ClientID %>">Fecha Nacimiento:</label>
                            </div>
                            <div class="col-7">
                                <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" TextMode="Date" />
                            </div>
                        </div>

                        <!-- Fecha Ingreso -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label" for="<%= txtFechaIngreso.ClientID %>">Fecha Ingreso:</label>
                            </div>
                            <div class="col-7">
                                <asp:TextBox ID="txtFechaIngreso" runat="server" CssClass="form-control" TextMode="Date" />
                            </div>
                        </div>

                        <!-- Religión -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label" for="<%= txtReligion.ClientID %>">Religión:</label>
                            </div>
                            <div class="col-7">
                                <asp:TextBox ID="txtReligion" runat="server" CssClass="form-control" MaxLength="60" />
                            </div>
                        </div>

                        <!-- Género -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label" for="<%= ddlGenero.ClientID %>">Género:</label>
                            </div>
                            <div class="col-7">
                                <asp:DropDownList ID="ddlGenero" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Seleccionar..." Value="" />
                                    <asp:ListItem Text="Masculino" Value="M" />
                                    <asp:ListItem Text="Femenino" Value="F" />
                                </asp:DropDownList>
                            </div>
                        </div>

                        <!-- Pensión base -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label" for="<%= txtPension.ClientID %>">Pensión base:</label>
                            </div>
                            <div class="col-7">
                                <asp:TextBox ID="txtPension" runat="server" CssClass="form-control" MaxLength="12" />
                            </div>
                        </div>

                        <!-- Observaciones -->
                        <div class="row g-3 align-items-start">
                            <div class="col-12">
                                <label class="form-label" for="<%= txtObservaciones.ClientID %>">Observaciones:</label>
                                <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                            </div>
                        </div>
                    </div>

                    <div class="action-buttons mt-3">
                        <!-- ✔ guardar -->
                        <asp:LinkButton ID="btnConfirmar" runat="server" CssClass="btn-accept"
                            OnClick="btnConfirmar_Click" ToolTip="Guardar"
                            OnClientClick="return disableOnSubmit(this.id);">
                            <i class="fa-solid fa-check" aria-hidden="true"></i>
                        </asp:LinkButton>

                        <!-- ✖ cancelar -->
                        <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel"
                            OnClick="btnCancelar_Click" ToolTip="Cancelar">
                            <i class="fa-solid fa-xmark" aria-hidden="true"></i>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- panel derecho -->
                <div class="col-lg-4">
                    <div class="side-panel" aria-label="Panel decorativo">
                        <div class="side-img">
                            <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" AlternateText="Escudo del colegio" />
                        </div>
                    </div>
                </div>

            </div>
        </div>
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
