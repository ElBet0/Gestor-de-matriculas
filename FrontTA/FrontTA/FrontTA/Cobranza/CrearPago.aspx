<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="CrearPago.aspx.cs" Inherits="FrontTA.Cobranza.CrearPago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root{
            --verde:#74D569; --verdeOsc:#016A13; --gris:#E1E1E1; --blanco:#FFF; --borde:#D7D7D7; --texto:#1f2937;
        }

        /* Card principal (mismo que CrearDeuda) */
        .card-header{
            background-color: var(--verde) !important;
        }

        /* Subtítulo gris centrado (como en tu maqueta) */
        .subheader-box{
            background:#bdbdbd;
            color:#1f1f1f;
            font-weight:800;
            border-radius:10px;
            padding:.6rem 1rem;
            margin: .75rem auto 1.25rem auto;
            text-align:center;
            width: min(560px, 90%);
        }

        /* Controles */
        .form-label{ font-weight:700; color:var(--texto); }
        .form-control, .form-select{
            border:1px solid var(--borde);
            border-radius:8px;
            height:40px;
        }
        textarea.form-control{ height:auto; }

        /* Marco interior tipo “panel” (para parecerse al recuadro de la imagen) */
        .inner-panel{
            background:#F3F3F3;
            border:2px solid #BFBFBF;
            border-radius:14px;
            padding:1rem 1rem 0.75rem 1rem;
        }
        .inner-panel .inner-body{
            background:#ECECEC;
            border:2px solid #9C9C9C;
            border-radius:10px;
            padding:1rem;
        }

        /* Botones check / X (LinkButtons) reutilizando estilo del resto) */
        .btn-accept, .btn-cancel{
            text-decoration:none !important;
            width:64px; height:64px; border-radius:12px;
            border:2px solid #00000030; background:#fff;
            display:inline-flex; align-items:center; justify-content:center;
            font-size:2rem; cursor:pointer;
            transition:transform .15s ease, box-shadow .15s ease;
        }
        .btn-accept{ box-shadow:0 3px 8px rgba(0,128,0,.15); }
        .btn-cancel{ box-shadow:0 3px 8px rgba(255,0,0,.15); }
        .btn-accept i{ color:#2E7D32; }
        .btn-cancel i{ color:#D32F2F; }
        .btn-accept:hover, .btn-cancel:hover{ transform:translateY(-2px); }

        /* Botón “Añadir Pago” (opcional, como en la maqueta) */
        .btn-add-pago{
            background:#BFE7FF; color:#0b3650; border:1px solid #9fd5f7;
            padding:.6rem 1.25rem; border-radius:12px; font-weight:700;
            box-shadow:0 2px 6px rgba(0,0,0,.08);
        }
        .btn-add-pago:hover{ filter:brightness(.97); }

        /* Fondo gris para inputs solo lectura o deshabilitados */
        .form-control[readonly],
        .form-control:disabled {
            background-color: #e9ecef !important; /* gris claro */
            color: #495057; /* texto legible */
            opacity: 1; /* evita que se vea pálido */
            cursor: not-allowed;
        }



    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <asp:ScriptManager runat="server" />
    <div class="card shadow-lg border-0 mt-4">
        <div class="card-header text-white">
            <h5 class="mb-0">Crear Pago</h5>
        </div>

        <div class="card-body">
            <!-- Subtítulo gris centrado -->
            <%--<div class="subheader-box">Crear Pago</div>--%>

            <!-- Marco doble como en la imagen -->
            <div class="inner-panel">
                <div class="inner-body">
                    <div class="container-fluid px-2">
                        <div class="row g-3 align-items-center">
                            <div class="col-md-6">
                                <label class="form-label" for="txtIdDeuda">ID Deuda:</label>
                                <asp:TextBox ID="txtIdDeuda" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="ddlMedioPago">Medio de pago:</label>
                                <asp:DropDownList ID="ddlMedioPago" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label" for="txtFechaPago">Fecha de Pago:</label>
                                <asp:TextBox ID="txtFechaPago" runat="server" CssClass="form-control" TextMode="Date" />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="txtMonto">Monto:</label>
                                <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control" Text="0" />
                            </div>

                            <div class="col-12">
                                <label class="form-label" for="txtObservaciones">Observaciones:</label>
                                <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                            </div>
                        </div>

                        <!-- Aceptar / Cancelar (LinkButtons con íconos) -->
                        <div class="d-flex justify-content-end align-items-center mt-4 gap-3">
                            <asp:LinkButton ID="btnAceptar" runat="server" CssClass="btn-accept" ToolTip="Guardar pago" OnClick="btnAceptar_Click">
                                <i class="fa-solid fa-check"></i>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel" ToolTip="Cancelar" OnClick="btnCancelar_Click">
                                <i class="fa-solid fa-xmark"></i>
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div><!--/inner-panel-->
        </div><!--/card-body-->
    </div>
</asp:Content>
