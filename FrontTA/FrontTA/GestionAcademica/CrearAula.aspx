<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true"
    CodeBehind="CrearAula.aspx.cs" Inherits="FrontTA.GestionAcademica.CrearAula" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Crear Aula
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root{
            --verde:#74D569; --verdeOsc:#016A13; --gris:#E1E1E1;
            --grisTexto:#777; --blanco:#FFF; --negro:#000;
            --celeste:#BFE7FF; --celesteBtn:#8FD2FF; --borde:#D7D7D7;
        }

        .familias-container{ background:var(--gris); padding:1.5rem; border-radius:1rem; box-shadow:0 3px 8px rgba(0,0,0,.1); }

        /* barra de iconos */
        .icon-bar{ display:inline-flex; gap:.75rem; background:var(--blanco); border-radius:12px; padding:.6rem .75rem; box-shadow:0 2px 6px rgba(0,0,0,.1); }
        .btn-icon{ border:0; width:44px; height:44px; border-radius:12px; display:inline-flex; align-items:center; justify-content:center;
                   font-size:1.15rem; transition:transform .15s ease, background .15s ease, color .15s; }
        .btn-active{ background:var(--celesteBtn); color:#00324D; }
        .btn-active:hover{ transform:scale(1.05); }
        .btn-muted{ background:#F1F1F1; color:var(--grisTexto); }
        .btn-muted:hover{ background:#E9E9E9; }


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

        /* tarjeta / formulario */
        .card-form{ background:var(--blanco); border-radius:16px; padding:1.25rem; box-shadow:0 2px 6px rgba(0,0,0,.12); }
        .fieldset{ border:2px solid #E8E8E8; border-radius:16px; padding:1.25rem; background:#F8F8F8; }
        .form-label{ font-weight:700; font-size:1.15rem; color:#1f2937; }
        .form-control{ border:1px solid var(--borde); border-radius:8px; height:44px; }
        .input-disabled{ background:#BDBDBD; color:#444; border:1px solid #AFAFAF; }

        select.form-select{ border:1px solid var(--borde); border-radius:8px; height:44px; background:#fff; }

        /* panel derecho celeste */
        .side-panel{ height:100%; min-height:420px; padding:2rem; border-radius:16px; background:var(--celeste);
                     display:flex; align-items:center; justify-content:center; border:1px solid #a7d7f3; }
        .side-title{ font-weight:800; font-size:1.25rem; color:#0b3650; margin-bottom:.5rem; display:none!important; }
        .side-img{ background:#ffffffaa; border:2px solid #d7eefc; border-radius:16px; padding:2rem; height:auto; }

        /* botones ✔ / ✖ */
        .action-buttons{ display:flex; gap:1rem; justify-content:flex-end; }
        .btn-accept, .btn-cancel{
            text-decoration:none!important; width:56px; height:56px; border-radius:12px; border:2px solid #00000030;
            display:inline-flex; align-items:center; justify-content:center; font-size:1.6rem; cursor:pointer; background:#fff;
            transition:transform .15s ease, box-shadow .15s ease;
        }
        .btn-accept{ box-shadow:0 3px 8px rgba(0,128,0,.15); }
        .btn-accept:hover, .btn-cancel:hover{ transform:translateY(-2px); }
        .action-buttons .btn-accept i{ color:#2E7D32!important; font-size:1.7rem; }
        .action-buttons .btn-cancel i{ color:#D32F2F!important; font-size:1.7rem; }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid familias-container">

        <!-- barra superior -->
        <div class="toolbar mb-3">
            <div class="icon-bar">
                <!-- ACTIVO (Crear Aula) -->
                <button type="button" class="btn-icon btn-active" title="Crear aula">
                    <i class="fa-solid fa-people-roof"></i>
                </button>
                <!-- INACTIVOS -->
                <button type="button" class="btn-icon btn-muted" title="Consultar aula" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Editar aula" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Eliminar aula" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>

            <span class="header-cta">Crear Aula</span>
        </div>

        <!-- contenido -->
        <div class="card-form">
            <div class="row g-4">

                <!-- formulario -->
                <div class="col-lg-8">
                    <div class="fieldset">
                        <!-- Código Aula (gris, bloqueado) -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end"><label for="txtCodigoAula" class="form-label">Código Aula:</label></div>
                            <div class="col-7">
                                <asp:TextBox ID="txtCodigoAula" runat="server" CssClass="form-control input-disabled"
                                    ReadOnly="true" Text=""></asp:TextBox>
                            </div>
                        </div>

                        <!-- Grado Académico (DropDown con flecha) -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end"><label for="ddlGrado" class="form-label">Grado Académico:</label></div>
                            <div class="col-7">
                                <asp:DropDownList ID="ddlGrado" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>
                        </div>

                        <!-- Nombre -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end"><label for="txtNombre" class="form-label">Nombre:</label></div>
                            <div class="col-7"><asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="80"></asp:TextBox></div>
                        </div>

                        <!-- Activo (Sí/No) -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end"><label for="ddlActivo" class="form-label">Activo:</label></div>
                            <div class="col-7">
                                <asp:DropDownList ID="ddlActivo" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Vigente" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No Vigente" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <!-- Capacidad -->
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end"><label for="txtCapacidad" class="form-label">Capacidad:</label></div>
                            <div class="col-7"><asp:TextBox ID="txtCapacidad" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox></div>
                        </div>

                        <!-- Vacantes (gris, bloqueado) -->
                        <div class="row g-3 align-items-center">
                            <div class="col-5 text-end"><label for="txtVacantes" class="form-label">Vacantes:</label></div>
                            <div class="col-7">
                                <asp:TextBox ID="txtVacantes" runat="server" CssClass="form-control input-disabled" ReadOnly="true" Text=""></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <!-- ✔ / ✖ -->
                    <div class="action-buttons mt-3">
                        <asp:LinkButton ID="btnConfirmar" runat="server" CssClass="btn-accept" OnClick="btnConfirmar_Click" ToolTip="Crear y volver">
                            <i class="fa-solid fa-check"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel" OnClick="btnCancelar_Click" ToolTip="Cancelar y volver">
                            <i class="fa-solid fa-xmark"></i>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- panel lateral derecho -->
                <div class="col-lg-4">
                    <div class="side-panel">
                        <div class="text-center">
                            <div class="side-title">Crear Aula</div>
                            <div class="side-img">
                                <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png"
                                           AlternateText="Colegio" Style="max-width:250px;height:auto;" />
                            </div>
                        </div>
                    </div>
                </div>

            </div><!-- /row -->
        </div><!-- /card -->
    </div>
</asp:Content>

