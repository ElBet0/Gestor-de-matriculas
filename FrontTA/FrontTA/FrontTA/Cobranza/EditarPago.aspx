<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="EditarPago.aspx.cs" Inherits="FrontTA.Cobranza.EditarPago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
  <style>
    :root{
      --verde:#74D569; --verdeOsc:#016A13; --gris:#E1E1E1; --blanco:#FFF; --borde:#D7D7D7; --texto:#1f2937;
    }
    .card-header{ background-color: var(--verde) !important; }
    .form-label{ font-weight:700; color:var(--texto); }
    .form-control,.form-select{ border:1px solid var(--borde); border-radius:8px; height:40px; }
    .form-control[readonly], .form-control:disabled{ background:#e9ecef !important; color:#495057; opacity:1; cursor:not-allowed; }

    /* Subtítulo gris centrado (como en la maqueta) */
    .sub-title{
      background:#bdbdbd; color:#1f1f1f; font-weight:800; border-radius:10px;
      padding:.6rem 1rem; margin:0 auto 1rem auto; text-align:center; width:min(480px, 90%);
    }

    /* Botones check / X (mismo set que usas en Cobranza) */
    .btn-accept,.btn-cancel{
      text-decoration:none !important; width:64px; height:64px; border-radius:12px; border:2px solid #00000030;
      display:inline-flex; align-items:center; justify-content:center; font-size:2rem; background:#fff;
      cursor:pointer; transition:transform .15s ease, box-shadow .15s ease;
    }
    .btn-accept{ box-shadow:0 3px 8px rgba(0,128,0,.15); }
    .btn-cancel{ box-shadow:0 3px 8px rgba(255,0,0,.15); }
    .btn-accept:hover,.btn-cancel:hover{ transform:translateY(-2px); }
    .btn-accept i{ color:#2E7D32; } .btn-cancel i{ color:#D32F2F; }
  </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
  <div class="card shadow-lg border-0 mt-4">
    <div class="card-header text-white">
      <h5 class="mb-0">Editar Pago</h5>
    </div>

    <div class="card-body">

      <div class="row mb-3">
        <div class="col-md-6">
          <label for="<%= txtIdDeuda.ClientID %>" class="form-label">ID Deuda</label>
          <asp:TextBox ID="txtIdDeuda" runat="server" CssClass="form-control" ReadOnly="true" />
        </div>
        <div class="col-md-6">
          <label for="<%= txtIdPago.ClientID %>" class="form-label">ID Pago</label>
          <asp:TextBox ID="txtIdPago" runat="server" CssClass="form-control" ReadOnly="true" />
        </div>
      </div>

      <div class="row mb-3">
        <div class="col-md-6">
          <label for="<%= ddlMedio.ClientID %>" class="form-label">Medio de pago</label>
          <asp:DropDownList ID="ddlMedio" runat="server" CssClass="form-select">
            <asp:ListItem Text="Efectivo" Value="EF" />
            <asp:ListItem Text="Tarjeta" Value="TJ" />
            <asp:ListItem Text="Transferencia" Value="TR" />
            <asp:ListItem Text="Yape/Plin" Value="YP" />
          </asp:DropDownList>
        </div>
        <div class="col-md-6">
          <label for="<%= txtMonto.ClientID %>" class="form-label">Monto</label>
          <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control" />
        </div>
      </div>

      <div class="row mb-3">
        <div class="col-md-6">
          <label for="<%= dtpFecha.ClientID %>" class="form-label">Fecha de Pago</label>
          <asp:TextBox ID="dtpFecha" runat="server" TextMode="Date" CssClass="form-control" />
        </div>
        <div class="col-md-6">
          <label for="<%= txtObs.ClientID %>" class="form-label">Observaciones</label>
          <asp:TextBox ID="txtObs" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
        </div>
      </div>

      <div class="d-flex justify-content-end gap-3 mt-3">
        <asp:LinkButton ID="btnGuardar" runat="server" CssClass="btn-accept" ToolTip="Guardar cambios"
                        OnClick="btnGuardar_Click">
          <i class="fa-solid fa-check"></i>
        </asp:LinkButton>
        <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel" ToolTip="Cancelar"
                        OnClick="btnCancelar_Click">
          <i class="fa-solid fa-xmark"></i>
        </asp:LinkButton>
      </div>
    </div>
  </div>
</asp:Content>
