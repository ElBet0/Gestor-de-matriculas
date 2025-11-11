<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="ConsultarDeuda.aspx.cs" Inherits="FrontTA.Cobranza.ConsultarDeuda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
        <div class="card shadow-lg border-0 mt-4">
  <div class="card-header text-white" style="background-color: #74D569;" >
    <h5 class="mb-0">Consultar Deuda</h5>
  </div>
  <div class="card-body">
    <form>
      <div class="row mb-3">
        <div class="col-md-6">
          <label for="codigoDeuda" class="form-label">Código deuda</label>
          <input type="text" id="codigoDeuda" class="form-control" placeholder="" disabled>
        </div>
        <div class="col-md-6">
          <label for="tipoDeuda" class="form-label">Tipo Deuda </label> 
          <select id="tipoDeuda" class="form-select" disabled>
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
          <select id="alumno" class="form-select" disabled>
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
          <input type="date" id="fechaEmision" class="form-control" disabled>
        </div>
        <div class="col-md-6">
          <label for="fechaVencimiento" class="form-label">Fecha Vencimiento</label>
          <input type="date" id="fechaVencimiento" class="form-control" disabled>
        </div>
      </div>

      <div class="row mb-3">
        <div class="col-md-6">
          <label for="descuento" class="form-label">Descuento</label>
          <input type="number" id="descuento" class="form-control" placeholder="Ingrese descuento en S/." disabled>
        </div>
        <div class="col-md-6">
          <label for="total" class="form-label">Total</label>
          <input type="text" id="total" class="form-control" placeholder="S/. 0.00" disabled>
        </div>
      </div>

      <div class="mb-3">
        <label for="descripcion" class="form-label">Descripción</label>
        <textarea id="descripcion" class="form-control" rows="3" placeholder="Escriba una descripción" disabled></textarea >
      </div>

      <div class="text-end">

          <asp:Button ID="btnSalir" runat="server" CssClass="btn btn-success me-2"
              Text="Salir" OnClick="btnSalir_Click" />
      </div>
    </form>
  </div>
</div>

</asp:Content>
