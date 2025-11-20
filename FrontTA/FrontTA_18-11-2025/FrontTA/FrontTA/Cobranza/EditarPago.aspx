<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true"
    CodeBehind="EditarPago.aspx.cs" Inherits="FrontTA.Cobranza.EditarPago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Editar Pago
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --blanco: #FFF;
            --borde: #D7D7D7;
            --texto: #1f2937;
        }

        .card-header {
            background-color: var(--verde) !important;
        }

        .form-label {
            font-weight: 700;
            color: var(--texto);
        }

        .form-control,
        .form-select {
            border: 1px solid var(--borde);
            border-radius: 8px;
            height: 40px;
        }

        textarea.form-control {
            height: auto;
        }

        .inner-panel {
            background: #F3F3F3;
            border: 2px solid #BFBFBF;
            border-radius: 14px;
            padding: 1rem 1rem 0.75rem 1rem;
        }

        .inner-panel .inner-body {
            background: #ECECEC;
            border: 2px solid #9C9C9C;
            border-radius: 10px;
            padding: 1rem;
        }

        .btn-accept,
        .btn-cancel {
            text-decoration: none !important;
            width: 64px;
            height: 64px;
            border-radius: 12px;
            border: 2px solid #00000030;
            background: #fff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            cursor: pointer;
            transition: transform .15s ease, box-shadow .15s ease;
        }

        .btn-accept {
            box-shadow: 0 3px 8px rgba(0, 128, 0, .15);
        }

        .btn-cancel {
            box-shadow: 0 3px 8px rgba(255, 0, 0, .15);
        }

        .btn-accept i {
            color: #2E7D32;
        }

        .btn-cancel i {
            color: #D32F2F;
        }

        .btn-accept:hover,
        .btn-cancel:hover {
            transform: translateY(-2px);
        }

        .form-control[readonly],
        .form-control:disabled {
            background-color: #e9ecef !important;
            color: #495057;
            opacity: 1;
            cursor: not-allowed;
        }
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
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <!-- Hidden para manejo interno -->
    <asp:HiddenField ID="hfDeudaId" runat="server" />
    <asp:HiddenField ID="hfPagoId" runat="server" />
    <asp:HiddenField ID="hfMontoDeuda" runat="server" />
    <asp:HiddenField ID="hfSaldoActual" runat="server" />
    <asp:HiddenField ID="hfFamiliaId" runat="server" />

    <div class="card shadow-lg border-0 mt-4">
        <div class="card-header text-white">
            <h5 class="mb-0">Editar Pago</h5>
        </div>

        <div class="card-body">
            <div class="inner-panel">
                <div class="inner-body">
                    <div class="container-fluid px-2">
                        <div class="row g-3 align-items-center">
                            <!-- Fila 1: ID Deuda + ID Pago -->
                            <div class="col-md-6">
                                <label class="form-label" for="txtIdDeuda">ID Deuda:</label>
                                <asp:TextBox ID="txtIdDeuda" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="txtIdPago">ID Pago:</label>
                                <asp:TextBox ID="txtIdPago" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>

                            <!-- Fila 2: monto deuda + saldo disponible -->
                            <div class="col-md-6">
                                <label class="form-label" for="txtMontoDeuda">Monto deuda:</label>
                                <asp:TextBox ID="txtMontoDeuda" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="txtSaldoActual">Saldo restante:</label>
                                <asp:TextBox ID="txtSaldoActual" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>

                            <!-- Fila 3: medio pago + fecha -->
                            <div class="col-md-6">
                                <label class="form-label" for="ddlMedioPago">Medio de pago:</label>
                                <asp:DropDownList ID="ddlMedioPago" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="txtFechaPago">Fecha de Pago:</label>
                                <asp:TextBox ID="txtFechaPago" runat="server" CssClass="form-control" TextMode="Date" />
                            </div>

                            <!-- Fila 4: monto pago -->
                            <div class="col-md-6">
                                <label class="form-label" for="txtMonto">Monto:</label>
                                <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control" TextMode="Number" />
                            </div>

                            <!-- Observaciones -->
                            <div class="col-12">
                                <label class="form-label" for="txtObservaciones">Observaciones:</label>
                                <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control"
                                    TextMode="MultiLine" Rows="3" />
                            </div>
                        </div>

                        <!-- Botones -->
                        <div class="d-flex justify-content-end align-items-center mt-4 gap-3">
                            <asp:LinkButton ID="btnAceptar" runat="server" CssClass="btn-accept"
                                ToolTip="Guardar cambios" OnClick="btnAceptar_Click">
                                <i class="fa-solid fa-check"></i>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel"
                                ToolTip="Cancelar" OnClick="btnCancelar_Click">
                                <i class="fa-solid fa-xmark"></i>
                            </asp:LinkButton>
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
