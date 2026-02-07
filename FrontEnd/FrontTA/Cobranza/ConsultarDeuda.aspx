<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="ConsultarDeuda.aspx.cs" Inherits="FrontTA.Cobranza.ConsultarDeuda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
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

        /* gris para solo lectura / deshabilitados */
        .form-control[readonly],
        .form-control:disabled,
        .form-select:disabled {
            background-color: #e9ecef !important;
            color: #495057;
            opacity: 1;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <asp:ScriptManager runat="server" />
    <div class="card shadow-lg border-0 mt-4">
        <div class="card-header text-white" style="background-color: #74D569;">
            <h5 class="mb-0">Consultar Deuda</h5>
        </div>
        <div class="card-body">

            <!-- NO poner <form> aquí, ya lo maneja la MasterPage -->

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="txtCodigoDeuda" class="form-label">Código deuda</label>
                    <asp:TextBox ID="txtCodigoDeuda" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
                <div class="col-md-6">
                    <label for="ddlTipoDeuda" class="form-label">Tipo Deuda</label>
                    <asp:DropDownList ID="ddlTipoDeuda" runat="server" CssClass="form-select" Enabled="false" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="ddlAlumno" class="form-label">Alumno</label>
                    <asp:DropDownList ID="ddlAlumno" runat="server" CssClass="form-select" Enabled="false" />
                </div>
                <div class="col-md-6">
                    <label for="txtMonto" class="form-label">Monto</label>
                    <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="txtFechaEmision" class="form-label">Fecha Emisión</label>
                    <asp:TextBox ID="txtFechaEmision" runat="server" CssClass="form-control" TextMode="Date" Enabled="false" />
                </div>
                <div class="col-md-6">
                    <label for="txtFechaVencimiento" class="form-label">Fecha Vencimiento</label>
                    <asp:TextBox ID="txtFechaVencimiento" runat="server" CssClass="form-control" TextMode="Date" Enabled="false" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="txtDescuento" class="form-label">Descuento</label>
                    <asp:TextBox ID="txtDescuento" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
                <div class="col-md-6">
                    <label for="txtTotal" class="form-label">Total</label>
                    <asp:TextBox ID="txtTotal" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>

            <div class="mb-3">
                <label for="txtDescripcion" class="form-label">Descripción</label>
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" ReadOnly="true" />
            </div>

            <!-- Panel de pagos -->
            <div class="pagos-panel mt-5">
                <div>
                    <label class="form-label">Pagos</label>
                </div>

                <div class="icon-bar mb-3">
                    <!-- Sólo Consultar se activará cuando elija un pago -->
                    <asp:LinkButton ID="btnPagoConsultar" runat="server"
                        CssClass="btn-icon btn-disabled" Enabled="false"
                        ToolTip="Consultar pago" CausesValidation="false"
                        OnClick="btnPagoConsultar_Click">
                        <i class="fa-solid fa-eye"></i>
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnPagoEditar" runat="server"
                        CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Editar pago">
                        <i class="fa-solid fa-pen"></i>
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnPagoEliminar" runat="server"
                        CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Eliminar pago">
                        <i class="fa-solid fa-trash-can"></i>
                    </asp:LinkButton>
                </div>

                <div class="mb-2">
                    <div class="input-group">
                        <asp:DropDownList ID="ddlPagos" runat="server"
                            CssClass="form-select pagos-select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlPagos_SelectedIndexChanged">
                        </asp:DropDownList>

                        <button type="button" class="btn btn-outline-secondary btn-caret" disabled aria-label="Mostrar pagos">
                            <i class="fa-solid fa-caret-down"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="text-end mt-3">
                <asp:Button ID="btnSalir" runat="server" CssClass="btn btn-success me-2" Text="Salir" OnClick="btnSalir_Click" />
            </div>

        </div>
    </div>
</asp:Content>
