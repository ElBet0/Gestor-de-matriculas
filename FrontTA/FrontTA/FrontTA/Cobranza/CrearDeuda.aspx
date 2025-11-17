<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="CrearDeuda.aspx.cs" Inherits="FrontTA.Cobranza.CrearDeuda" %>
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
        /* Botonera (mismo estilo de Cobranza) */
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

        /* Panel y barra de pagos (nuevo) */
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

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="card shadow-lg border-0 mt-4">
  <div class="card-header text-white" style="background-color: #74D569;" >
    <h5 class="mb-0">Crear Deuda</h5>
  </div>
  <div class="card-body">
    <form>
      <div class="row mb-3">
        <div class="col-md-6">
          <label for="codigoDeuda" class="form-label">Código deuda</label>
          <input type="text" id="codigoDeuda" class="form-control" placeholder="" disabled>
        </div>
        <div class="col-md-6">
          <label for="tipoDeuda" class="form-label">Tipo Deuda</label>
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
          <label for="alumno" class="form-label">Alumno</label>
          <select id="alumno" class="form-select">
            <option selected disabled>Seleccione alumno</option>
            <option value="1">Juan Pérez</option>
            <option value="2">María Torres</option>
            <option value="3">Carlos Díaz</option>
          </select>
        </div>
        <div class="col-md-6">
          <label for="monto" class="form-label">Monto</label>
          <input type="text" id="monto" class="form-control" placeholder="S/. 0.00" disabled>
        </div>
      </div>

      <div class="row mb-3">
        <div class="col-md-6">
          <label for="fechaEmision" class="form-label">Fecha Emisión</label>
          <input type="date" id="fechaEmision" class="form-control">
        </div>
        <div class="col-md-6">
          <label for="fechaVencimiento" class="form-label">Fecha Vencimiento</label>
          <input type="date" id="fechaVencimiento" class="form-control">
        </div>
      </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="descuento" class="form-label">Descuento</label>
                <input type="number" id="descuento" class="form-control" placeholder="Ingrese descuento en S/.">
            </div>
            <div class="col-md-6">
                <label for="total" class="form-label">Total</label>
                <input type="text" id="total" class="form-control" placeholder="S/. 0.00" disabled>
            </div>
        </div>

        <div class="mb-3">
            <label for="descripcion" class="form-label">Descripción</label>
            <textarea id="descripcion" class="form-control" rows="3" placeholder="Escriba una descripción"></textarea>
        </div>

        <div class="pagos-panel mt-5">
            <div> <label class="form-label">Pagos</label> </div>
            
            <!-- Botonera de pagos (mismo estilo que Cobranza) -->
            <div class="icon-bar mb-3">
                <asp:LinkButton ID="btnPagoCrear" runat="server" CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Crear pago">
      <i class="fa-solid fa-money-bill-transfer"></i>
                </asp:LinkButton>
                <asp:LinkButton ID="btnPagoEditar" runat="server" CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Editar pago">
      <i class="fa-solid fa-solid fa-eye"></i>
                </asp:LinkButton>
                <asp:LinkButton ID="btnPagoEliminar" runat="server" CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Eliminar pago">
      <i class="fa-solid fa-trash-can"></i>
                </asp:LinkButton>
            </div>

            <!-- Barra de pagos con flecha (deshabilitada) -->
            <div class="mb-2">
            <div class="input-group">
                <asp:DropDownList ID="ddlPagos" runat="server" CssClass="form-select pagos-select" Enabled="false">
                    <asp:ListItem Text="(sin pagos)" Value="" />
                </asp:DropDownList>
                <button type="button" class="btn btn-outline-secondary btn-caret" disabled aria-label="Mostrar pagos">
                    <i class="fa-solid fa-caret-down"></i>
                </button>
            </div>
        </div>

        <div class="text-end">

            <asp:LinkButton ID="btnGuardar2" runat="server"
                CssClass="btn btn-success me-2" OnClick="btnGuardar_Click" ToolTip="Guardar">
    <i class="fa-solid fa-check"></i>
            </asp:LinkButton>

            <asp:LinkButton ID="btnCancelar2" runat="server"
                CssClass="btn btn-danger me-2" OnClick="btnCancelar_Click" ToolTip="Cancelar">
    <i class="fa-solid fa-xmark"></i>
            </asp:LinkButton>



      </div>
    </form>
  </div>
</div>

</asp:Content>
