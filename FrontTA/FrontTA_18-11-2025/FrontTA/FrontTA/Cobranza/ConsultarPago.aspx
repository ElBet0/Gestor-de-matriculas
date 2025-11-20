<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true"
    CodeBehind="ConsultarPago.aspx.cs" Inherits="FrontTA.Cobranza.ConsultarPago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
  <style>
    :root{ --verde:#74D569; --verdeOsc:#016A13; --gris:#E1E1E1; --blanco:#FFF; --borde:#D7D7D7; --texto:#1f2937; }
    .card-header{ background-color: var(--verde) !important; }
    .form-label{ font-weight:700; color:var(--texto); }
    .form-control,.form-select{ border:1px solid var(--borde); border-radius:8px; height:40px; }
    .form-control[readonly], .form-control:disabled{ background:#e9ecef !important; color:#495057; opacity:1; cursor:not-allowed; }
    .form-select:disabled{ background:#e9ecef !important; opacity:1; cursor:not-allowed; }

    /* icon-bar (igual que CrearPago) */
    .icon-bar{ display:inline-flex; gap:.75rem; background:var(--blanco); border-radius:12px; padding:.6rem .75rem; box-shadow:0 2px 6px rgba(0,0,0,.1); }
    .btn-icon{ border:0; width:44px; height:44px; border-radius:12px; display:inline-flex; align-items:center; justify-content:center; font-size:1.15rem; transition:transform .15s; background:#E1E1E1; color:#777; }
    .btn-disabled{ background:#E1E1E1 !important; color:#777 !important; cursor:not-allowed; transform:none !important; }

    .pagos-panel{ background:#F8F8F8; border:2px solid #E8E8E8; border-radius:16px; padding:1rem; }
    .pagos-select{ height:40px; border:1px solid var(--borde); border-radius:8px; background:#E9EDF2; color:#555; }
    .btn-caret{ width:44px; height:40px; border-radius:8px; border:1px solid var(--borde); }

    /* Subtítulo gris centrado */
    .sub-title{
      background:#bdbdbd; color:#1f1f1f; font-weight:800; border-radius:10px;
      padding:.6rem 1rem; margin:0 auto 1rem auto; text-align:center; width:min(480px, 90%);
    }

    /* Botones check / X */
    .btn-accept,.btn-cancel{
      text-decoration:none !important; width:64px; height:64px; border-radius:12px; border:2px solid #00000030;
      display:inline-flex; align-items:center; justify-content:center; font-size:2rem; background:#fff;
      cursor:pointer; transition:transform .15s ease, box-shadow .15s ease;
    }
    .btn-accept{ box-shadow:0 3px 8px rgba(0,128,0,.15); }
    .btn-cancel{ box-shadow:0 3px 8px rgba(255,0,0,.15); }
    .btn-accept i{ color:#2E7D32; } .btn-cancel i{ color:#D32F2F; }
    .btn-accept.btn-disabled{ cursor:not-allowed; opacity:.75; }
  </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
  <div class="card shadow-lg border-0 mt-4">
    <div class="card-header text-white">
      <h5 class="mb-0">Consultar Pago</h5>
    </div>
    <div class="card-body">
      <%--<div class="sub-title">Consultar Pago</div>--%>

      <form>
        <div class="row mb-3">
          <div class="col-md-6">
            <label class="form-label">ID Deuda</label>
            <asp:TextBox ID="txtIdDeuda" runat="server" CssClass="form-control" ReadOnly="true" />
          </div>
          <div class="col-md-6">
            <label class="form-label">Medio de pago</label>
              <asp:DropDownList ID="ddlMedio" runat="server" CssClass="form-select" Enabled="false">
                  <asp:ListItem Text="Efectivo" Value="EFECTIVO" />
                  <asp:ListItem Text="Tarjeta" Value="TARJETA" />
                  <asp:ListItem Text="Transferencia" Value="TRANSFERENCIA" />
                  <asp:ListItem Text="Depósito" Value="DEPOSITO" />
              </asp:DropDownList>

          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <label class="form-label">Fecha de Pago</label>
            <asp:TextBox ID="dtpFecha" runat="server" TextMode="Date" CssClass="form-control" Enabled="false" />
          </div>
          <div class="col-md-6">
            <label class="form-label">Monto</label>
            <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control" Enabled="false" />
          </div>
        </div>

        <div class="mb-4">
          <label class="form-label">Observaciones</label>
          <asp:TextBox ID="txtObs" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" Enabled="false" />
        </div>

       <%-- <!-- Panel de Pagos deshabilitado (mismo bloque que CrearPago) -->
        <div class="pagos-panel mt-4">
          <div class="mb-1"><label class="form-label mb-0">Pagos</label></div>

          <div class="icon-bar mb-3">
            <asp:LinkButton ID="btnPagoCrear" runat="server" CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Crear pago">
              <i class="fa-solid fa-eye"></i>
            </asp:LinkButton>
            <asp:LinkButton ID="btnPagoEditar" runat="server" CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Editar pago">
              <i class="fa-solid fa-pen"></i>
            </asp:LinkButton>
            <asp:LinkButton ID="btnPagoEliminar" runat="server" CssClass="btn-icon btn-disabled" Enabled="false" ToolTip="Eliminar pago">
              <i class="fa-solid fa-trash-can"></i>
            </asp:LinkButton>
          </div>

          <div class="input-group">
            <asp:DropDownList ID="ddlPagos" runat="server" CssClass="form-select pagos-select" Enabled="false">
              <asp:ListItem Text="(sin pagos)" Value="" />
            </asp:DropDownList>
            <button type="button" class="btn btn-outline-secondary btn-caret" disabled aria-label="Mostrar pagos">
              <i class="fa-solid fa-caret-down"></i>
            </button>
          </div>
        </div>--%>

        <div class="d-flex justify-content-end gap-3 mt-4">
          <!-- ✓ deshabilitado -->
          <asp:LinkButton ID="btnGuardar" runat="server" CssClass="btn-accept btn-disabled" Enabled="false" ToolTip="Guardar (solo lectura)">
            <i class="fa-solid fa-check"></i>
          </asp:LinkButton>
          <!-- X activo: volver -->
          <asp:LinkButton ID="btnCerrar" runat="server" CssClass="btn-cancel" ToolTip="Cerrar" OnClick="btnCerrar_Click">
            <i class="fa-solid fa-xmark"></i>
          </asp:LinkButton>
        </div>
      </form>
    </div>
  </div>
</asp:Content>
