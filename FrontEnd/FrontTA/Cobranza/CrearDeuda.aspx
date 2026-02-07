<%@ Page Title="Crear Deuda" Language="C#" MasterPageFile="~/SoftProg.Master"
    AutoEventWireup="true" CodeBehind="CrearDeuda.aspx.cs"
    Inherits="FrontTA.Cobranza.CrearDeuda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Crear Deuda
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --blanco: #FFF;
            --borde: #D7D7D7;
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
            transition: transform .15s;
        }

        .btn-disabled {
            background: #F1F1F1;
            color: #9aa0a6;
            cursor: not-allowed;
            opacity: .9;
        }

        .btn-active {
            background: var(--verde);
            color: #fff;
        }

        .pagos-panel {
            background: #F8F8F8;
            border: 2px solid #E8E8E8;
            border-radius: 16px;
            padding: 1rem;
        }

        .pagos-select {
            height: 40px;
            border: 1px solid var(--borde);
            border-radius: 8px;
            background: #E9EDF2;
            color: #555;
        }

        .btn-caret {
            width: 44px;
            height: 40px;
            border-radius: 8px;
            border: 1px solid var(--borde);
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

    <div class="card shadow-lg border-0 mt-4">
        <div class="card-header text-white" style="background-color: #74D569;">
            <h5 class="mb-0">Crear Deuda</h5>
        </div>

        <div class="card-body">

            <!-- NO usar <form>, ya lo tiene la MasterPage -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Código deuda</label>
                    <asp:TextBox ID="txtCodigoDeuda" runat="server"
                        CssClass="form-control" Enabled="false" />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Tipo Deuda</label>
                    <asp:DropDownList ID="ddlTipoDeuda" runat="server"
                        CssClass="form-select"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlTipoDeuda_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Alumno</label>
                    <asp:DropDownList ID="ddlAlumno" runat="server"
                        CssClass="form-select">
                    </asp:DropDownList>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Monto</label>
                    <asp:TextBox ID="txtMonto" runat="server"
                        CssClass="form-control" Enabled="false" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Fecha Emisión</label>
                    <asp:TextBox ID="txtFechaEmision" runat="server"
                        CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Fecha Vencimiento</label>
                    <asp:TextBox ID="txtFechaVencimiento" runat="server"
                        CssClass="form-control" TextMode="Date" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Descuento</label>
                    <asp:TextBox ID="txtDescuento" runat="server"
                        CssClass="form-control"
                        Placeholder="Ingrese descuento en S/."
                        AutoPostBack="true"
                        OnTextChanged="txtDescuento_TextChanged"
                        TextMode="Number" />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Total</label>
                    <asp:TextBox ID="txtTotal" runat="server"
                        CssClass="form-control" Enabled="false" />
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Descripción</label>
                <asp:TextBox ID="txtDescripcion" runat="server"
                    CssClass="form-control" TextMode="MultiLine" Rows="3"
                    Placeholder="Escriba una descripción" />
            </div>

            <!-- Panel Pagos (bloqueado) -->
            <div class="pagos-panel mt-5">
                <div><label class="form-label">Pagos</label></div>

                <div class="icon-bar mb-3">
                    <asp:LinkButton ID="btnPagoCrear" runat="server"
                        CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Crear pago">
                        <i class="fa-solid fa-money-bill-transfer"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnPagoEditar" runat="server"
                        CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Editar pago">
                        <i class="fa-solid fa-eye"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnPagoEliminar" runat="server"
                        CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Eliminar pago">
                        <i class="fa-solid fa-trash-can"></i>
                    </asp:LinkButton>
                </div>

                <div class="mb-2">
                    <div class="input-group">
                        <asp:DropDownList ID="ddlPagos" runat="server"
                            CssClass="form-select pagos-select" Enabled="false">
                            <asp:ListItem Text="(sin pagos)" Value="" />
                        </asp:DropDownList>
                        <button type="button" class="btn btn-outline-secondary btn-caret"
                            disabled aria-label="Mostrar pagos">
                            <i class="fa-solid fa-caret-down"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Botones Guardar / Cancelar -->
            <div class="text-end mt-3">
                <asp:LinkButton ID="btnGuardar2" runat="server"
                    CssClass="btn btn-success me-2"
                    OnClick="btnGuardar_Click" ToolTip="Guardar">
                    <i class="fa-solid fa-check"></i>
                </asp:LinkButton>

                <asp:LinkButton ID="btnCancelar2" runat="server"
                    CssClass="btn btn-danger" OnClick="btnCancelar_Click"
                    ToolTip="Cancelar">
                    <i class="fa-solid fa-xmark"></i>
                </asp:LinkButton>
            </div>

            <!-- Hidden para familia y monto base -->
            <asp:HiddenField ID="hfFamiliaId" runat="server" />
            <asp:HiddenField ID="hfMontoBase" runat="server" />

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
