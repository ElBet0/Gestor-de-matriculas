<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="CrearUsuarios.aspx.cs" Inherits="FrontTA.Usuarios.CrearUsuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Consultar Usuario
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root{
            --verde:#74D569;
            --verdeOsc:#016A13;
            --gris:#E1E1E1;
            --grisTexto:#777;
            --blanco:#FFF;
            --negro:#000;
            --celeste:#BFE7FF;     /* panel lateral */
            --celesteBtn:#8FD2FF;  /* botón activo barra */
            --borde:#D7D7D7;
        }

        .familias-container{ /* mantenemos el mismo wrapper */
            background:var(--gris);
            padding:1.5rem;
            border-radius:1rem;
            box-shadow:0 3px 8px rgba(0,0,0,.1);
        }

        /*  Barra de iconos */
        .icon-bar{
            display:inline-flex;
            gap:.75rem;
            background:var(--blanco);
            border-radius:12px;
            padding:.6rem .75rem;
            box-shadow:0 2px 6px rgba(0,0,0,.1);
        }
        .btn-icon{
            border:0;
            width:44px;
            height:44px;
            border-radius:12px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            font-size:1.15rem;
            transition:transform .15s ease, background .15s ease, color .15s;
        }
        .btn-active{ background:var(--celesteBtn); color:#00324D; }
        .btn-muted{ background:#F1F1F1; color:#9aa0a6; }

        /* Subtítulo tipo “pill” */
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


        /*  Tarjeta/form  */
        .card-form{
            background:var(--blanco);
            border-radius:16px;
            padding:1.25rem;
            box-shadow:0 2px 6px rgba(0,0,0,.12);
        }
        .fieldset{
            border:2px solid #E8E8E8;
            border-radius:16px;
            padding:1.25rem;
            background:#F8F8F8;
        }
        .form-label{
            font-weight:700;
            font-size:1.15rem;
            color:#1f2937;
        }
        .form-control{
            border:1px solid var(--borde);
            border-radius:8px;
            height:44px;
        }

        /* Solo lectura gris para ID */
        .input-disabled{
            background:#BDBDBD;
            color:#444;
            border:1px solid #AFAFAF;
        }

        /* Panel lateral */
        .side-panel{
            min-height:420px;
            padding:2rem;
            border-radius:16px;
            background:var(--celeste);
            display:flex;
            align-items:flex-start;
            justify-content:center;
            border:1px solid #a7d7f3;
        }
        .side-title{
            display:inline-block;
            font-weight:800;
            font-size:1.25rem;
            color:#0b3650;
            margin-bottom:.75rem;
        }
        .side-img{
            background:#ffffffaa;
            border:3px solid #d7eefc;
            border-radius:16px;
            padding:1.25rem;
            text-align:center;
        }
        .side-img img{
            max-width:220px;
            height:auto;
            display:block;
            margin:auto;
        }

        /* Botones ✔ ✖ al pie */
        .footer-actions{ display:flex; justify-content:flex-end; gap:1rem; }
        .btn-accept, .btn-cancel{
            text-decoration:none !important;
            width:64px; height:64px;
            border-radius:12px;
            border:2px solid #00000030;
            display:inline-flex; align-items:center; justify-content:center;
            font-size:2rem; background:#fff; cursor:pointer;
            transition:transform .15s ease, box-shadow .15s ease;
        }
        .btn-accept{ box-shadow:0 3px 8px rgba(0,128,0,.15); }
        .btn-cancel{ box-shadow:0 3px 8px rgba(255,0,0,.15); }
        .btn-accept:hover, .btn-cancel:hover{ transform:translateY(-2px); }
        .btn-accept i{ color:#2E7D32; }
        .btn-cancel i{ color:#D32F2F; }
    </style>
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
    <div class="container-fluid familias-container">

        <!-- Barra superior -->
        <div class="toolbar mb-3">
            <div class="icon-bar">
                <!-- Añadir ACTIVO (celeste) -->
                <button type="button" class="btn-icon btn-active" title="Añadir usuario">
                    <i class="fa-solid fa-user"></i>
                </button>
                <!-- Resto en gris -->
                <button type="button" class="btn-icon btn-muted" title="Consultar usuario" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Editar usuario" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Eliminar usuario" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>

            <!-- Subtítulo -->
            <span class="header-cta">Crear Usuario</span>
        </div>

        <!-- Contenido -->
        <div class="card-form">
            <div class="row g-4">

                <!-- Formulario -->
                <div class="col-lg-8">
                    <div class="fieldset">
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-4 text-end"><label class="form-label">ID:</label></div>
                            <div class="col-8">
                                <asp:TextBox ID="txtId" runat="server" CssClass="form-control input-disabled" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-4 text-end"><label class="form-label">Nombre:</label></div>
                            <div class="col-8">
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="120"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-4 text-end">
                                <label class="form-label">Clave:</label></div>
                            <div class="col-8">
                                <asp:TextBox ID="txtClave" runat="server" CssClass="form-control" MaxLength="120"></asp:TextBox>
                            </div>
                        </div>
                        

                        <div class="row g-3 align-items-center">
                            <div class="col-4 text-end"><label class="form-label">Rol:</label></div>
                            <div class="col-8">

                                <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-control" >
                                    <asp:ListItem Text="Seleccionar..." Value="" />
                                    <asp:ListItem Text="Administrador" Value="PERSONAL_ADMINISTRATIVO" />
                                    <asp:ListItem Text="Director" Value="DIRECTOR" />
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>

                    <!-- Botones ✔ ✖ -->
                    <div class="footer-actions mt-3">
                        <asp:LinkButton ID="btnConfirmar" runat="server" CssClass="btn-accept" OnClick="btnConfirmar_Click" ToolTip="Confirmar">
                            <i class="fa-solid fa-check"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel" OnClick="btnCancelar_Click" ToolTip="Cancelar">
                            <i class="fa-solid fa-xmark"></i>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Panel lateral derecho -->
                <div class="col-lg-4">
                    <div class="side-panel">
                        <div class="w-100">
                            <div class="side-title">Crear Usuario</div>
                            <div class="side-img mb-3">
                                <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" AlternateText="Colegio" />
                            </div>
                            <!-- Caja opcional para info extra (opcional y evaluar si lo dejamos) -->
                            <div class="box-hijos" style="margin-top:1rem; background:#ffffffcc; border:1px solid #cfe6f9; border-radius:12px; padding:.75rem 1rem;">
                                <div class="title" style="font-weight:700; margin-bottom:.5rem; color:#0b3650;">Indicaciones:</div>
                                <ul class="mb-0 ps-3">
                                    <li>El ID es asignado por el sistema.</li>
                                    <li>Define un rol para el usuario.</li>
                                    <li>Recuerda guardar con ✓.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

            </div><!-- /row -->
        </div><!-- /card -->
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