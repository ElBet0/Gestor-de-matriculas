<%@ Page Title="Consultar Matrícula" Language="C#" MasterPageFile="~/SoftProg.Master"
    AutoEventWireup="true" CodeBehind="ConsultarMatricula.aspx.cs"
    Inherits="FrontTA.Matricula.ConsultarMatricula" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Consultar Matrícula
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root{
            --verde:#74D569; --verdeOsc:#016A13; --gris:#E1E1E1;
            --grisTexto:#777; --blanco:#FFF; --negro:#000;
            --celeste:#BFE7FF; --celesteBtn:#8FD2FF; --borde:#D7D7D7;
        }

        .matricula-container{ background:var(--gris); padding:1.5rem; border-radius:1rem; box-shadow:0 3px 8px rgba(0,0,0,.1); }

        /* ===== top layout (Año | Consultar Matrícula | iconos) ===== */
        .top-grid{ display:grid; grid-template-columns:1fr auto 1fr; align-items:center; gap:1rem; margin-bottom:.75rem; }
        .top-right{ justify-self:end; }
        .top-center{ justify-self:center; }

        .year-box{ background:#c9c9c9; border:3px solid #111; border-radius:16px; padding:.65rem 1.25rem; min-width:360px; font-weight:800; font-size:2rem; color:#111; box-shadow:inset 0 3px 6px rgba(0,0,0,.12); }
        .year-box small{ font-size:1.25rem; font-weight:800; margin-right:.5rem; }

        .icon-bar{ display:inline-flex; gap:.75rem; background:var(--blanco); border-radius:12px; padding:.6rem .75rem; box-shadow:0 2px 6px rgba(0,0,0,.1); }
        .btn-icon{ border:0; width:44px; height:44px; border-radius:12px; display:inline-flex; align-items:center; justify-content:center; font-size:1.15rem; transition:transform .15s ease, background .15s ease, color .15s; }
        .btn-active{ background:var(--celesteBtn); color:#00324D; }
        .btn-muted{ background:#F1F1F1; color:#9aa0a6; }
        .btn-muted[disabled]{ cursor:not-allowed; }

        .header-cta-btn{
            background:#F3F4F6; color:#000; border:1px solid #E5E7EB;
            padding:.55rem 1.15rem; border-radius:6px; font-weight:800;
            box-shadow:0 2px 6px rgba(0,0,0,.06);
        }

        /* ===== formulario ===== */
        .card-form{ background:var(--blanco); border-radius:16px; padding:1.25rem; box-shadow:0 2px 6px rgba(0,0,0,.12); }
        .fieldset{ border:2px solid #E0E0E0; border-radius:16px; padding:1.25rem; background:#F8F8F8; }
        .legend-title{
            font-weight:800; color:#444; padding:.25rem .6rem; border:2px solid #D0D0D0;
            border-radius:10px; background:#F2F2F2;
        }
        .form-label{ font-weight:700; font-size:1.05rem; color:#1f2937; }
        .form-control{ border:1px solid var(--borde); border-radius:8px; height:44px; }
        .readonly-gray{ background:#BDBDBD !important; color:#444 !important; border:1px solid #AFAFAF !important; }

        .side-panel{ max-width:300px; min-width:200px; padding:1rem 2rem; border-radius:16px; background:var(--celeste); display:flex; align-items:center; justify-content:center; border:1px solid #a7d7f3; }
        .side-img{ background:#ffffffaa; border:2px solid #d7eefc; border-radius:16px; padding:1rem; }

        .btn-icon-2{ background:var(--verde); color:#fff; border:0; width:44px; height:44px; border-radius:12px; font-size:1.15rem; display:inline-flex; align-items:center; justify-content:center; }
        .btn-icon-2 i{ color:#fff !important; }
        .btn-icon-2[disabled]{ background:#E5E7EB; color:#9aa0a6 !important; cursor:not-allowed; }
        .btn-icon-2[disabled] i{ color:#9aa0a6 !important; }

        .action-buttons{ display:flex; gap:1rem; justify-content:flex-end; }
        .btn-accept,.btn-cancel{ width:56px; height:56px; border-radius:12px; border:2px solid #00000030; display:inline-flex; align-items:center; justify-content:center; font-size:1.6rem; background:#fff; }
        .btn-accept i{ color:#2E7D32 !important; }
        .btn-cancel i{ color:#D32F2F !important; }

        /* Fix: sin subrayado/azul en botones (incluye LinkButton) */
        a.btn-accept, a.btn-cancel, .btn-accept, .btn-cancel,
        .icon-bar a, .icon-bar button, .btn-icon, .btn-icon-2 {
            text-decoration:none !important; color:inherit !important;
        }
        .btn-accept:focus, .btn-cancel:focus, .btn-icon:focus, .btn-icon-2:focus {
            outline:none !important; box-shadow:none !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid matricula-container">

        <!-- Año | Consultar | Iconos -->
        <div class="top-grid">
            <div class="year-box">
                <small>Año</small><asp:Label ID="lblAnio" runat="server" Text=""></asp:Label>
            </div>

            <div class="top-center">
                <span class="header-cta-btn">Consultar Matrícula</span>
            </div>

            <div class="icon-bar top-right">
                <!-- Crear (apagado) -->
                <button type="button" class="btn-icon btn-muted" title="Crear" disabled><i class="fa-solid fa-user-plus"></i></button>
                <!-- Consultar (activo celeste) -->
                <button type="button" class="btn-icon btn-active" title="Consultar Matrícula"><i class="fa-solid fa-eye"></i></button>
                <!-- Editar (apagado) -->
                <button type="button" class="btn-icon btn-muted" title="Editar" disabled><i class="fa-solid fa-pen"></i></button>
            </div>
        </div>

        <!-- FORM (todo bloqueado) -->
        <div class="card-form">
            <div class="fieldset">
                <div class="mb-2 row g-4 align-items-start">
                    <!-- izquierda -->
                    <div class="col-lg-7">
                        <div class="mb-3 row">
                            <div class="col-md-4"><label class="form-label">Alumno:</label></div>
                            <div class="col-md-7">
                                <asp:TextBox ID="txtAlumno" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>
                                <asp:HiddenField ID="hdnAlumnoId" runat="server" />
                            </div>
                            <div class="col-md-1">
                                <!-- botón de búsqueda DESHABILITADO -->
                                <button type="button" class="btn-icon-2" title="Buscar Alumno" disabled>
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-md-4"><label class="form-label">Monto:</label></div>
                            <div class="col-md-7"><asp:TextBox ID="txtMonto" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox></div>
                        </div>

                        <div class="mb-3 row">
                            <div class="col-md-4"><label class="form-label">Activo:</label></div>
                            <div class="col-md-7"><asp:TextBox ID="txtActivo" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox></div>
                        </div>
                    </div>

                    <!-- derecha -->
                    <div class="col-lg-5 d-flex">
                        <div class="side-panel flex-fill flex-column justify-content-center">
                            <div class="text-center">
                                <div class="side-img">
                                    <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" AlternateText="Colegio" Style="max-width:150px; max-height:120px;" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- AULA (bloqueado) -->
                <fieldset class="p-3" style="border:2px solid #d0d0d0;border-radius:12px;background:#f6f6f6;">
                    <legend class="legend-title">Aula</legend>

                    <div class="row g-3 align-items-end">
                        <div class="col-lg-6">
                            <label class="form-label">Aula</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtAula" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>
                                <asp:HiddenField ID="hdnAulaId" runat="server" />
                                <!-- DESHABILITADO -->
                                <button type="button" class="btn-icon-2" title="Buscar Aula" disabled>
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <label class="form-label">Capacidad</label>
                            <asp:TextBox ID="txtCapacidad" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-lg-3">
                            <label class="form-label">Vacantes</label>
                            <asp:TextBox ID="txtVacantes" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>
                </fieldset>
            </div>

            <!-- ✔ / ✖ (ambos solo navegan) -->
            <div class="action-buttons mt-3">
                <asp:LinkButton ID="btnVolver" runat="server" CssClass="btn-accept" OnClick="btnVolver_Click" ToolTip="Volver">
                    <i class="fa-solid fa-check"></i>
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel" OnClick="btnCancelar_Click" ToolTip="Regresar">
                    <i class="fa-solid fa-xmark"></i>
                </asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>
