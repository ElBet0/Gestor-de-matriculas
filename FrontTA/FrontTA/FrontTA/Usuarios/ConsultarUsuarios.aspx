<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="ConsultarUsuarios.aspx.cs" Inherits="FrontTA.Usuarios.ConsultarUsuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Consultar Usuario
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

        /* solo lectura gris */
        .input-disabled {
            background: #BDBDBD !important;
            color: #444 !important;
            border: 1px solid #AFAFAF !important;
        }
        /* select deshabilitado también en gris */
        select.input-disabled:disabled {
            background: #BDBDBD !important;
            color: #444 !important;
            border: 1px solid #AFAFAF !important;
        }

        /* panel derecho celeste */
        .side-panel {
            min-height: 420px;
            padding: 2rem;
            border-radius: 16px;
            background: var(--celeste);
            display: flex;
            align-items: flex-start;
            justify-content: center;
            border: 1px solid #a7d7f3;
        }

        .side-title {
            display: inline-block;
            font-weight: 800;
            font-size: 1.25rem;
            color: #0b3650;
            margin-bottom: .75rem;
        }

        .side-img {
            background: #ffffffaa;
            border: 3px solid #d7eefc;
            border-radius: 16px;
            padding: 1.25rem;
            text-align: center;
        }

            .side-img img {
                max-width: 220px;
                height: auto;
                display: block;
                margin: auto;
            }

        /* bloque lateral informativo reutilizable */
        .box-hijos {
            margin-top: 1rem;
            background: #ffffffcc;
            border: 1px solid #cfe6f9;
            border-radius: 12px;
            padding: .75rem 1rem;
        }

            .box-hijos .title {
                font-weight: 700;
                margin-bottom: .5rem;
                color: #0b3650;
            }

        /* botón Salir */
        .footer-actions {
            display: flex;
            justify-content: flex-end;
        }

        .btn-exit {
            background: #fff;
            border: 1px solid #cbd5e1;
            color: #1f2937;
            font-weight: 700;
            padding: .65rem 1.25rem;
            border-radius: 12px;
            min-width: 140px;
            box-shadow: 0 2px 6px rgba(0,0,0,.08);
        }

            .btn-exit:hover {
                background: #f8fafc;
            }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid familias-container">

        <!-- barra superior -->
        <div class="toolbar mb-3">
            <div class="icon-bar">
                <!-- lupa ACTIVA (celeste) -->
                <button type="button" class="btn-icon btn-active" title="Consultar usuario">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
                <!-- resto en gris -->
                <button type="button" class="btn-icon btn-muted" title="Añadir usuario" disabled>
                    <i class="fa-solid fa-user"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Editar usuario" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Eliminar usuario" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>

            <span class="header-cta">Consultar Usuario</span>
        </div>

        <!-- contenido -->
        <div class="card-form">
            <div class="row g-4">
                <!-- formulario solo lectura -->
                <div class="col-lg-8">
                    <div class="fieldset">
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label">ID:</label></div>
                            <div class="col-7">
                                <asp:TextBox ID="txtId" runat="server" CssClass="form-control input-disabled" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label">Nombre:</label></div>
                            <div class="col-7">
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control input-disabled" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label">Clave:</label></div>
                            <div class="col-7">
                                <!-- se muestra enmascarada, solo lectura -->
                                <asp:TextBox ID="txtClave" runat="server" CssClass="form-control input-disabled">xxxxxxxx</asp:TextBox>
                            </div>
                        </div>

                        <div class="row g-3 align-items-center">
                            <div class="col-5 text-end">
                                <label class="form-label">Rol:</label></div>
                            <div class="col-7">
                                <!-- dropdown deshabilitado para mantener icono de despliegue -->
                                <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-control input-disabled" Enabled="false">
                                    <asp:ListItem Text="Administrador" Value="PERSONAL_ADMINISTRATIVO" />
                                    <asp:ListItem Text="Director" Value="DIRECTOR" />
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>

                    <div class="footer-actions mt-3">
                        <asp:LinkButton ID="btnSalir" runat="server" CssClass="btn-exit" OnClick="btnSalir_Click">Salir</asp:LinkButton>
                    </div>
                </div>

                <!-- panel lateral derecho -->
                <div class="col-lg-4">
                    <div class="side-panel">
                        <div class="w-100">
                            <div class="side-title">Consultar Usuario</div>
                            <div class="side-img mb-3">
                                <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" AlternateText="Colegio" />
                            </div>

                            <div class="box-hijos">
                                <div class="title">Información:</div>
                                <ul class="mb-0 ps-3">
                                    <li>Los datos están en modo lectura.</li>
                                    <li>Use “Editar” (pantalla aparte) para actualizar.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /row -->
        </div>
        <!-- /card -->
    </div>
</asp:Content>