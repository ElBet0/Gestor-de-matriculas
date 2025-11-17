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

        /* icon-bar (mismo look de Cobranza/CrearDeuda) */
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
        }

            .btn-icon:hover {
                background: var(--verdeOsc);
                transform: scale(1.05);
            }

        .btn-disabled {
            background: #E1E1E1 !important;
            color: #777 !important;
            cursor: not-allowed;
            transform: none !important;
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

        /* modal de confirmación (igual estilo) */
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

            .btn-accept:hover, .btn-cancel:hover {
                transform: translateY(-2px);
            }

        .btn-accept i {
            color: #2E7D32;
        }

        .btn-cancel i {
            color: #D32F2F;
        }
        .pagos-stack {
            display: flex;
            flex-direction: column;
            align-items: flex-start; /* pegado a la izquierda */
            gap: .5rem;
        }

            .pagos-stack .icon-bar {
                margin-left: 0;
            }
        /* asegura alineación izquierda */

    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const ddlPagos = document.getElementById('<%= ddlPagos.ClientID %>');
        const btnPagoVer = document.getElementById('<%= btnPagoVer.ClientID %>');   // bloqueado
        const btnPagoEdit = document.getElementById('<%= btnPagoEditar.ClientID %>'); // verde
        const btnPagoDel = document.getElementById('<%= btnPagoEliminar.ClientID %>'); // verde

        // CONSULTAR (bloqueado)
        if (btnPagoVer) {
            btnPagoVer.classList.add('btn-disabled');
            btnPagoVer.setAttribute('disabled', 'disabled');
        }

        // EDITAR: requiere selección
        if (btnPagoEdit) {
            btnPagoEdit.addEventListener('click', function (e) {
                e.preventDefault();
                const id = ddlPagos.value;
                if (!id) {
                    alert('Seleccione un pago para editar.'); return;
                }
                window.location.href = '<%= ResolveUrl("~/Cobranza/EditarPago.aspx") %>?idPago=' + encodeURIComponent(id);
        });
        }

        // ELIMINAR: requiere selección + modal confirmación
        const ovEliminar = document.getElementById('ovEliminarPago');
        const btnDoDelete = document.getElementById('<%= btnDoDelete.ClientID %>');
        const btnCancelDelete = document.getElementById('<%= btnCancelDelete.ClientID %>');

        if (btnPagoDel) {
            btnPagoDel.addEventListener('click', function (e) {
                e.preventDefault();
                const id = ddlPagos.value;
                if (!id) {
                    alert('Seleccione un pago para eliminar.'); return;
                }
                ovEliminar.classList.add('show');
                ovEliminar.setAttribute('aria-hidden', 'false');
            });
        }

        function cerrarEliminar() {
            ovEliminar.classList.remove('show');
            ovEliminar.setAttribute('aria-hidden', 'true');
        }

        if (btnCancelDelete) { btnCancelDelete.addEventListener('click', function (e) { e.preventDefault(); cerrarEliminar(); }); }
        if (ovEliminar) { ovEliminar.addEventListener('click', function (e) { if (e.target === ovEliminar) cerrarEliminar(); }); }
        document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && ovEliminar && ovEliminar.classList.contains('show')) cerrarEliminar(); });

        // Confirmar eliminación (demo en cliente; en servidor tienes stub)
        if (btnDoDelete) {
            btnDoDelete.addEventListener('click', function (e) {
                e.preventDefault();
                const id = ddlPagos.value;
                if (!id) { cerrarEliminar(); return; }
                // quitar del dropdown (demo)
                const opt = ddlPagos.querySelector(`option[value="${CSS.escape(id)}"]`);
                if (opt) opt.remove();
                ddlPagos.selectedIndex = 0;
                cerrarEliminar();
            });
        }
    });
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="card shadow-lg border-0 mt-4">
        <div class="card-header text-white">
            <h5 class="mb-0">Editar Deuda</h5>
        </div>

        <div class="card-body">
            <form>
                <!-- Datos de la deuda -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Código deuda</label>
                        <asp:TextBox ID="txtCodigoDeuda" runat="server" CssClass="form-control" ReadOnly="true" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Tipo Deuda</label>
                        <select id="tipoDeuda" class="form-select">
                            <option selected disabled>Seleccione tipo de deuda</option>
                            <option value="mensualidad">Mensualidad</option>
                            <option value="matricula">Matrícula</option>
                            <option value="otros">Otros</option>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Alumno</label>
                        <select id="alumno" class="form-select">
                            <option selected disabled>Seleccione alumno</option>
                            <option value="1">Juan Pérez</option>
                            <option value="2">María Torres</option>
                            <option value="3">Carlos Díaz</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Monto</label>
                        <input type="text" id="monto" class="form-control" placeholder="S/. 0.00" disabled>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Fecha Emisión</label>
                        <input type="date" id="fechaEmision" class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Fecha Vencimiento</label>
                        <input type="date" id="fechaVencimiento" class="form-control">
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Descuento</label>
                        <input type="number" id="descuento" class="form-control" placeholder="Ingrese descuento en S/.">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Total</label>
                        <input type="text" id="total" class="form-control" placeholder="S/. 0.00" disabled>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Descripción</label>
                    <textarea id="descripcion" class="form-control" rows="3" placeholder="Escriba una descripción"></textarea>
                </div>

                <!-- Panel de Pagos -->
                <div class="pagos-panel mb-4">
                    <div class="pagos-stack">
                        <!-- 1) Título -->
                        <label class="form-label mb-0">Pagos</label>

                        <!-- 2) Botonera (Consultar gris, Editar/Eliminar verdes) -->
                        <div class="icon-bar">
                            <asp:LinkButton ID="btnPagoVer" runat="server" CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Consultar pago">
        <i class="fa-solid fa-eye"></i>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPagoEditar" runat="server" CssClass="btn-icon" ToolTip="Editar pago" UseSubmitBehavior="false" OnClientClick="return false;">
        <i class="fa-solid fa-pen"></i>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPagoEliminar" runat="server" CssClass="btn-icon" ToolTip="Eliminar pago" UseSubmitBehavior="false" OnClientClick="return false;">
        <i class="fa-solid fa-trash"></i>
                            </asp:LinkButton>
                        </div>

                        <!-- 3) Barra (DropDown + caret) -->
                        <div class="input-group" style="width: 100%;">
                            <asp:DropDownList ID="ddlPagos" runat="server" CssClass="form-select" Style="width: 100%;"></asp:DropDownList>
                            <button type="button" class="btn btn-outline-secondary" style="height: 40px; border-radius: 8px; border: 1px solid var(--borde);" disabled>
                                <i class="fa-solid fa-caret-down"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Acción principal de la deuda -->
                <div class="text-end">
                    <asp:LinkButton ID="btnGuardar3" runat="server" CssClass="btn btn-success me-2" OnClick="btnGuardar_Click" ToolTip="Guardar">
            <i class="fa-solid fa-check"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancelar3" runat="server" CssClass="btn btn-danger me-2" OnClick="btnCancelar_Click" ToolTip="Cancelar">
            <i class="fa-solid fa-xmark"></i>
                    </asp:LinkButton>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal eliminar pago -->
    <div id="ovEliminarPago" class="confirm-overlay" aria-hidden="true">
        <div class="confirm-box">
            <div class="confirm-title">¿Deseas eliminar el pago seleccionado?</div>
            <div class="confirm-actions">
                <asp:LinkButton ID="btnDoDelete" runat="server" CssClass="btn-accept" ToolTip="Sí, eliminar" OnClick="btnEliminarPago_Server">
          <i class="fa-solid fa-check"></i>
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancelDelete" runat="server" CssClass="btn-cancel" ToolTip="No, cancelar" OnClientClick="return false;">
          <i class="fa-solid fa-xmark"></i>
                </asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>
