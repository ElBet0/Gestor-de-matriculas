<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="EditarDeuda.aspx.cs" Inherits="FrontTA.Cobranza.EditarDeuda" %>

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
            --texto: #1f2937;
        }

        .card-header {
            background-color: var(--verde) !important;
        }

        .form-label {
            font-weight: 700;
            color: var(--texto);
        }

        .form-control, .form-select {
            border: 1px solid var(--borde);
            border-radius: 8px;
            height: 40px;
        }

        .form-control[readonly], .form-control:disabled {
            background: #e9ecef !important;
            color: #495057;
            opacity: 1;
            cursor: not-allowed;
        }

        /* panel pagos */
        .pagos-panel {
            background: #F8F8F8;
            border: 2px solid #E8E8E8;
            border-radius: 16px;
            padding: 1rem;
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
            transition: transform .15s ease, background .15s ease, color .15s ease;
            background: var(--verde);
            color: #fff;
            text-decoration: none !important;
        }

        .btn-icon:hover {
            background: var(--verdeOsc);
            transform: scale(1.05);
            text-decoration: none !important;
        }

            .btn-icon i {
                text-decoration: none !important;
            }

        .btn-disabled {
            background: #E1E1E1 !important;
            color: #777 !important;
            cursor: not-allowed;
            transform: none !important;
        }

        .pagos-stack {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: .5rem;
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
            background: #fff;
            cursor: pointer;
            transition: transform .15s ease, box-shadow .15s ease;
        }

        .btn-accept {
            box-shadow: 0 3px 8px rgba(0,128,0,.15);
        }

        .btn-cancel {
            box-shadow: 0 3px 8px rgba(255,0,0,.15);
        }

        .btn-accept i {
            color: #2E7D32;
        }

        .btn-cancel i {
            color: #D32F2F;
        }

        .confirm-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.35);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 2000;
        }

            .confirm-overlay.show {
                display: flex;
            }

        .confirm-box {
            background: #fff;
            border-radius: 14px;
            padding: 1.25rem 1.5rem;
            box-shadow: 0 12px 32px rgba(0,0,0,.25);
            min-width: 420px;
            max-width: 90%;
            text-align: center;
        }

        .confirm-title {
            background: #bdbdbd;
            color: #1f1f1f;
            font-weight: 800;
            border-radius: 10px;
            padding: .6rem 1rem;
            margin-bottom: 1rem;
        }

        .confirm-actions {
            display: flex;
            gap: 1.25rem;
            justify-content: center;
        }

    </style>


    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const ovEliminarPago = document.getElementById('ovEliminarPago');
            const btnCancelarEliminarPago = document.getElementById('btnCancelarEliminarPago');

            // función global para usar en OnClientClick
            window.mostrarModalEliminarPago = function () {
                ovEliminarPago.classList.add('show');
                ovEliminarPago.setAttribute('aria-hidden', 'false');
            };

            if (btnCancelarEliminarPago && ovEliminarPago) {
                btnCancelarEliminarPago.addEventListener('click', function (e) {
                    e.preventDefault();
                    ovEliminarPago.classList.remove('show');
                    ovEliminarPago.setAttribute('aria-hidden', 'true');
                });
            }

            // cerrar clicando fuera
            if (ovEliminarPago) {
                ovEliminarPago.addEventListener('click', function (e) {
                    if (e.target === ovEliminarPago) {
                        ovEliminarPago.classList.remove('show');
                        ovEliminarPago.setAttribute('aria-hidden', 'true');
                    }
                });
            }

            // cerrar con ESC
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape' && ovEliminarPago.classList.contains('show')) {
                    ovEliminarPago.classList.remove('show');
                    ovEliminarPago.setAttribute('aria-hidden', 'true');
                }
            });
        });
    </script>
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
    <asp:ScriptManager runat="server" />

    <!-- hidden helpers -->
    <asp:HiddenField ID="hfFamiliaId" runat="server" />
    <asp:HiddenField ID="hfMontoBase" runat="server" />

    <div class="card shadow-lg border-0 mt-4">
        <div class="card-header text-white">
            <h5 class="mb-0">Editar Deuda</h5>
        </div>

        <div class="card-body">

            <!-- Datos de la deuda -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Código deuda</label>
                    <asp:TextBox ID="txtCodigoDeuda" runat="server" CssClass="form-control" ReadOnly="true" />
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
                    <asp:DropDownList ID="ddlAlumno" runat="server" CssClass="form-select">
                    </asp:DropDownList>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Monto</label>
                    <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Fecha Emisión</label>
                    <asp:TextBox ID="txtFechaEmision" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Fecha Vencimiento</label>
                    <asp:TextBox ID="txtFechaVencimiento" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Descuento</label>
                    <asp:TextBox ID="txtDescuento" runat="server"
                        CssClass="form-control"
                        AutoPostBack="true"
                        OnTextChanged="txtDescuento_TextChanged" />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Total</label>
                    <asp:TextBox ID="txtTotal" runat="server" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Descripción</label>
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
            </div>

            <!-- Panel de Pagos -->
            <div class="pagos-panel mb-4">
                <div class="pagos-stack">
                    <label class="form-label mb-0">Pagos</label>

                    <div class="icon-bar">
                        <asp:LinkButton ID="btnPagoConsultar" runat="server"
                            CssClass="btn-icon btn-disabled"
                            ToolTip="Consultar pago"
                            Enabled="false"
                            OnClick="btnPagoConsultar_Click">
    <i class="fa-solid fa-eye"></i>
                        </asp:LinkButton>



                        <asp:LinkButton ID="btnPagoEditar" runat="server"
                            CssClass="btn-icon"
                            ToolTip="Editar pago"
                            OnClick="btnPagoEditar_Click">
                            <i class="fa-solid fa-pen"></i>
                        </asp:LinkButton>

                        <asp:LinkButton ID="btnPagoEliminar" runat="server"
                            CssClass="btn-icon"
                            ToolTip="Eliminar pago"
                            OnClientClick="mostrarModalEliminarPago(); return false;">
    <i class="fa-solid fa-trash"></i>
                        </asp:LinkButton>



                    </div>

                    <div class="input-group" style="width: 100%;">

                        <asp:DropDownList ID="ddlPagos" runat="server"
                            CssClass="form-select"
                            Style="width: 100%;"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlPagos_SelectedIndexChanged">
                        </asp:DropDownList>

                        <button type="button" class="btn btn-outline-secondary"
                                style="height: 40px; border-radius: 8px; border: 1px solid var(--borde);" disabled>
                            <i class="fa-solid fa-caret-down"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Acción principal de la deuda -->
            <div class="d-flex justify-content-end gap-3">
                <asp:LinkButton ID="btnGuardar" runat="server"
                    CssClass="btn-accept" ToolTip="Guardar cambios"
                    OnClick="btnGuardar_Click">
                    <i class="fa-solid fa-check"></i>
                </asp:LinkButton>

                <asp:LinkButton ID="btnCancelar" runat="server"
                    CssClass="btn-cancel" ToolTip="Cancelar"
                    OnClick="btnCancelar_Click">
                    <i class="fa-solid fa-xmark"></i>
                </asp:LinkButton>
            </div>

        </div>
    </div>

    <!-- Overlay: Confirmar eliminación de pago -->
    <div id="ovEliminarPago" class="confirm-overlay" aria-hidden="true">
        <div class="confirm-box">
            <div class="confirm-title">¿Estás seguro que desea colocar en No Vigente este pago?</div>
            <div class="confirm-actions">
                <asp:LinkButton ID="btnConfirmarEliminarPago" runat="server"
                    CssClass="btn-accept"
                    ToolTip="Sí, eliminar"
                    OnClick="btnConfirmarEliminarPago_Click"
                    CausesValidation="false"
                    UseSubmitBehavior="false">
                <i class="fa-solid fa-check"></i>
                </asp:LinkButton>
                <button type="button" id="btnCancelarEliminarPago" class="btn-cancel">
                    <i class="fa-solid fa-xmark"></i>
                </button>
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
