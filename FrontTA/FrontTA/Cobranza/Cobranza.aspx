<%@ Page Title="Cobranza" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true"
    CodeBehind="Cobranza.aspx.cs" Inherits="FrontTA.Cobranza.Cobranza" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Cobranza
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    
    <style>
        .btn-accept,
        .btn-accept:focus,
        .btn-accept:active,
        .btn-accept:hover,
        .btn-accept i {
            text-decoration: none !important;
            outline: none !important;
            box-shadow: none !important;
            color: #2E7D32;
        }

        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --grisTexto: #777;
            --blanco: #FFF;
            --negro: #000;
            --celeste: #BFE7FF;
            --celesteBtn: #8FD2FF;
            --borde: #D7D7D7;
        }

        .familias-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
        }

        /* === barra superior === */
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
            transition: transform .15s ease, background .15s ease, color .15s;
        }

        .btn-active {
            background: var(--verde);
            color: #fff;
        }

        .btn-muted, .btn-disabled {
            background: #F1F1F1;
            color: #9aa0a6;
            cursor: not-allowed;
        }

        .header-cta {
            background: #CFEFFF;
            color: #0d3a52;
            border: 1px solid #a9daf7;
            padding: .6rem 1rem;
            border-radius: 12px;
            font-weight: 700;
        }

        /* === filtro superior === */
        .fieldset {
            border: 2px solid #E8E8E8;
            border-radius: 16px;
            padding: 1.25rem;
            background: #F8F8F8;
        }

        .form-label {
            font-weight: 700;
            font-size: 1.05rem;
            color: #1f2937;
        }

        .form-control {
            border: 1px solid var(--borde);
            border-radius: 8px;
            height: 40px;
        }

        .input-disabled {
            background: #BDBDBD;
            color: #444;
            border: 1px solid #AFAFAF;
        }

        .btn-buscar {
            background: var(--verde);
            border: 0;
            color: #fff;
            border-radius: 8px;
            width: 44px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

            .btn-buscar:hover {
                background: var(--verdeOsc);
            }

        .filtro-select {
            width: 100%;
            height: 40px;
            border-radius: 8px;
            border: 1px solid var(--borde);
        }

        /* === tabla de deudas === */
        .tabla-box {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
            overflow-x: auto;
        }

        table.table {
            width: 100%;
        }

        thead.table-header {
            background: var(--verde);
            color: #fff;
            text-align: center;
        }

        th, td {
            text-align: center;
            vertical-align: middle;
        }

        tbody tr.data-row {
            cursor: pointer;
        }
        /* seleccionado */
        .tabla-box table.table tbody tr.data-row.row-selected > td {
            background: #E6F4FF !important;
            transition: background-color .15s ease-in-out;
        }
        /* hover cuando NO está seleccionada */
        .tabla-box table.table tbody tr.data-row:hover:not(.row-selected) > td {
            background: #F3FAFF !important;
        }

        /* === overlay buscar familia === */
        .overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.35);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1050;
        }

            .overlay.show {
                display: flex;
            }

        .modal-box {
            position: relative;
            background: #fff;
            border-radius: 14px;
            padding: 1.25rem 1.5rem;
            width: auto;
            min-width: 420px;
            max-width: 90vw;
            box-shadow: 0 12px 32px rgba(0,0,0,.25);
            border: none;
            text-align: center;
        }

.modal-inner{
  background:transparent;          
  border:none;                    
  border-radius:0;
  padding:0;                       
}

.modal-title{
  background:#bdbdbd;              
  color:#1f1f1f;
  font-weight:800;
  border-radius:10px;
  padding:.6rem 1rem;
  margin-bottom:1rem;
  font-size:1.05rem;
}

.modal-footer{
  display:flex;
  gap:1.25rem;                    
  justify-content:center;          
  padding-top:0;                   
}

/* Botones de confirmación (check / X) */
.btn-accept, .btn-cancel{
  width:64px; height:64px;
  border-radius:12px;
  border:2px solid #00000030;
  display:inline-flex; align-items:center; justify-content:center;
  font-size:2rem;
  background:#fff;
  cursor:pointer;
  transition:transform .15s ease, box-shadow .15s ease;


}

.btn-accept{ box-shadow:0 3px 8px rgba(0,128,0,.15); }
.btn-cancel{ box-shadow:0 3px 8px rgba(255,0,0,.15); }

.btn-accept:hover, .btn-cancel:hover{ transform:translateY(-2px); }

.btn-accept i{ color:#2E7D32; }
.btn-cancel i{ color:#D32F2F; }

.topbar { position: relative; z-index: 1056; }
        .dropdown-menu { z-index: 2000; }
        .content-wrapper, .content-inner { overflow: visible !important; }


    </style>

    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const btnConfirmarEliminar = document.getElementById("btnConfirmarEliminar");
            if (btnConfirmarEliminar) {
                btnConfirmarEliminar.addEventListener("click", () => {
                    alert("Deuda eliminada correctamente.");
                    const modal = bootstrap.Modal.getInstance(document.getElementById("modalEliminar"));
                    if (modal) modal.hide();
                });
            }
        });

        document.addEventListener('DOMContentLoaded', function () {
            const ovBuscar = document.getElementById('ovBuscar');
            const btnAbrirBuscar = document.getElementById('btnBuscarFamilia');
            const btnCerrarBuscar = document.getElementById('btnCerrarBuscar');

            const btnCrearDeuda = document.getElementById('btnCrearDeuda');
            const btnCrearPago = document.getElementById('btnCrearPago');
            const btnConsultar = document.getElementById('btnConsultar');
            const btnEditar = document.getElementById('btnEditar');
            const btnEliminar = document.getElementById('btnEliminar');
            const btnReporte = document.getElementById('btnReporte');

            function setToolbarState(state) {
                [btnCrearDeuda, btnCrearPago, btnConsultar, btnEditar, btnEliminar, btnReporte].forEach(b => {
                    b.classList.add('btn-disabled'); b.classList.remove('btn-active'); b.disabled = true;
                });
                if (state >= 1) [btnCrearDeuda, btnReporte].forEach(b => { b.classList.remove('btn-disabled'); b.classList.add('btn-active'); b.disabled = false; });
                if (state >= 2) [btnCrearPago, btnConsultar, btnEditar, btnEliminar].forEach(b => { b.classList.remove('btn-disabled'); b.classList.add('btn-active'); b.disabled = false; });
            }

            btnCrearDeuda.addEventListener('click', function () {
                const sel = document.querySelector('#tbodyDeudas tr.row-selected'); if (!sel) return;
                const id = sel.getAttribute('Id');
                window.location.href = '<%= ResolveUrl("~/Cobranza/CrearDeuda.aspx") %>?id=' + encodeURIComponent(id);
            });
            btnConsultar.addEventListener('click', function () {
                const sel = document.querySelector('#tbodyDeudas tr.row-selected'); if (!sel) return;
                const id = sel.getAttribute('Id');
                window.location.href = '<%= ResolveUrl("~/Cobranza/ConsultarDeuda.aspx") %>?id=' + encodeURIComponent(id);
            });
            btnEditar.addEventListener('click', function () {
                const sel = document.querySelector('#tbodyDeudas tr.row-selected'); if (!sel) return;
                const id = sel.getAttribute('Id');
                window.location.href = '<%= ResolveUrl("~/Cobranza/EditarDeuda.aspx") %>?id=' + encodeURIComponent(id);
            });

            setToolbarState(0);

            btnAbrirBuscar.addEventListener('click', () => { ovBuscar.classList.add('show'); ovBuscar.setAttribute('aria-hidden', 'false'); });
            btnCerrarBuscar.addEventListener('click', () => { ovBuscar.classList.remove('show'); ovBuscar.setAttribute('aria-hidden', 'true'); });

            const tbody = document.getElementById('tbodyDeudas');
            if (tbody) {
                tbody.addEventListener('click', (e) => {
                    const tr = e.target.closest('tr.data-row'); if (!tr || !tbody.contains(tr)) return;
                    tbody.querySelectorAll('tr.row-selected').forEach(r => r.classList.remove('row-selected'));
                    tr.classList.add('row-selected');
                    setToolbarState(2);
                    e.stopPropagation();
                });
            }

            document.addEventListener('click', (e) => {
                const grid = document.querySelector('.tabla-box');
                if (grid && !grid.contains(e.target)) {
                    const selFam = document.getElementById('<%= hfFamCodigo.ClientID %>').value;
                    if (tbody) tbody.querySelectorAll('tr.row-selected').forEach(r => r.classList.remove('row-selected'));
                    setToolbarState(selFam ? 1 : 0);
                }
            });

            window.__Cobranza__FamiliaElegida = function () {
                setToolbarState(1);
                ovBuscar.classList.remove('show');
                ovBuscar.setAttribute('aria-hidden', 'true');
            }
        });

        function seleccionarFamilia(codigo, apePat, apeMat, tr) {
            document.getElementById('<%= hfFamCodigo.ClientID %>').value = codigo;
            document.getElementById('<%= hfFamApePat.ClientID %>').value = apePat;
            document.getElementById('<%= hfFamApeMat.ClientID %>').value = apeMat;

            const tbody = document.getElementById('tbodyFamilias');
            if (tbody) {
                tbody.querySelectorAll('tr.row-selected').forEach(r => r.classList.remove('row-selected'));
                tr.classList.add('row-selected');
            }
        }


    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid familias-container">

        <!-- barra superior -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="icon-bar">
                <button type="button" id="btnCrearDeuda"  class="btn-icon btn-disabled" title="Crear deuda" disabled><i class="fa-solid fa-hand-holding-dollar"></i></button>
                <button type="button" id="btnCrearPago"   class="btn-icon btn-disabled" title="Crear pago" disabled><i class="fa-solid fa-money-bill-transfer"></i></button>
                <button type="button" id="btnConsultar"   class="btn-icon btn-disabled" title="Consultar deuda" disabled><i class="fa-solid fa-eye"></i></button>
                <button type="button" id="btnEditar"      class="btn-icon btn-disabled" title="Editar deuda" disabled><i class="fa-solid fa-pen"></i></button>
                <!-- BOTÓN ELIMINAR -->
                <button
                    type="button"
                    id="btnEliminar"
                    class="btn-icon btn-disabled"
                    title="Eliminar deuda"
                    disabled
                    data-bs-toggle="modal"
                    data-bs-target="#modalEliminar">
                    <i class="fa-solid fa-trash"></i>
                </button>

            </div>

<%--            <span class="header-cta">Cobranza</span>--%>
        </div>


        <!-- filtro / datos familia -->
        <div class="fieldset">
            <div class="row g-3 align-items-center mb-2">
                <div class="col-md-2 text-end"><label class="form-label">Código Familia:</label></div>
                <div class="col-md-4">
                    <asp:TextBox ID="txtCodigoFamilia" runat="server" CssClass="form-control input-disabled" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="col-md-1">
                    <button type="button" id="btnBuscarFamilia" class="btn-buscar" title="Buscar familia"><i class="fa-solid fa-users-viewfinder"></i></button>
                </div>
                <div class="col-md-2 text-end"><label class="form-label">Filtro:</label></div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlFiltro" runat="server" CssClass="filtro-select">
                        <asp:ListItem Text="0 Seleccionados" />
                        <asp:ListItem Text="Matrícula" />
                        <asp:ListItem Text="Pensión" />
                        <asp:ListItem Text="Mora" />
                    </asp:DropDownList>
                </div>
            </div>

            <div class="row g-3 align-items-center">
                <div class="col-md-2 text-end"><label class="form-label">Apellido Paterno:</label></div>
                <div class="col-md-4"><asp:TextBox ID="txtApePaterno" runat="server" CssClass="form-control input-disabled" ReadOnly="true"></asp:TextBox></div>
                <div class="col-md-2 text-end"><label class="form-label">Apellido Materno:</label></div>
                <div class="col-md-4"><asp:TextBox ID="txtApeMaterno" runat="server" CssClass="form-control input-disabled" ReadOnly="true"></asp:TextBox></div>
            </div>
        </div>

        <!-- tabla -->
        <div class="tabla-box mt-3">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-header">
                    <tr>
                        <th>Id</th>
                        <th>Alumno</th>
                        <th>Tipo Deuda</th>
                        <th>Monto Deuda</th>
                        <th>Pagado</th>
                        <th>Saldo</th>
                        <th>Fecha Emisión</th>
                        <th>Fecha Vencimiento</th>
                        <th>Descuento</th>
                        <th>Activo</th>
                    </tr>
                </thead>
                <tbody id="tbodyDeudas">
                    <asp:Repeater ID="repDeudas" runat="server">
                        <ItemTemplate>
                            <tr class="data-row">
                                <td><%# Eval("Id") %></td>
                                <td><%# Eval("Alumno") %></td>
                                <td><%# Eval("TipoDeuda") %></td>
                                <td><%# Eval("MontoDeuda") %></td>
                                <td><%# Eval("Pagado") %></td>
                                <td><%# Eval("Saldo") %></td>
                                <td><%# Eval("FechaEmision","{0:dd/MM/yyyy}") %></td>
                                <td><%# Eval("FechaVencimiento","{0:dd/MM/yyyy}") %></td>
                                <td><%# Eval("Descuento") %></td>
                                <td><%# Eval("Activo") %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>

        
        <div class="mt-2 d-flex justify-content-end">
            <button type="button" id="btnReporte" class="btn-icon btn-disabled" title="Reporte" disabled>
                <i class="fa-solid fa-clipboard-list"></i>
            </button>
        </div>

        <!--  Overlay Buscar Familia  -->
        <asp:HiddenField ID="hfFamCodigo" runat="server" />
        <asp:HiddenField ID="hfFamApePat" runat="server" />
        <asp:HiddenField ID="hfFamApeMat" runat="server" />

        <div id="ovBuscar" class="overlay" aria-hidden="true">
            <div class="modal-box">
                <div class="modal-inner">
                    <div class="modal-title">Buscar Familia</div>

                    <div class="row g-3 align-items-center mb-3">
                        <div class="col-4 text-end"><label class="form-label">Apellido Paterno:</label></div>
                        <div class="col-3"><asp:TextBox ID="txtBuscarApePat" runat="server" CssClass="form-control"></asp:TextBox></div>
                        <div class="col-2 text-end">
                            <label class="form-label">Apellido Materno:</label></div>
                        <div class="col-3 d-flex align-items-center gap-2">
                            <asp:TextBox ID="txtBuscarApeMat" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn-buscar" OnClick="btnBuscar_Click" ToolTip="Buscar">
            <i class="fa-solid fa-magnifying-glass"></i>
                            </asp:LinkButton>
                        </div>
                    </div>

                   

                    <div class="tabla-box">
                        <table class="table table-bordered table-hover align-middle mb-0">
                            <thead class="table-header">
                                <tr>
                                    <th>Código Familia</th>
                                    <th>Apellido Paterno</th>
                                    <th>Apellido Materno</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyFamilias">
                                <asp:Repeater ID="repFamilias" runat="server">
                                    <ItemTemplate>
                                        <tr class="data-row" onclick="seleccionarFamilia('<%# Eval("CodigoFamilia") %>','<%# Eval("ApePaterno") %>','<%# Eval("ApeMaterno") %>', this)">
                                            <td><%# Eval("CodigoFamilia") %></td>
                                            <td><%# Eval("ApePaterno") %></td>
                                            <td><%# Eval("ApeMaterno") %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:LinkButton ID="btnConfirmarFamilia" runat="server" CssClass="btn-accept" OnClick="btnConfirmarFamilia_Click" ToolTip="Confirmar selección">
    <i class="fa-solid fa-check"></i>
                    </asp:LinkButton>
                    <button type="button" id="btnCerrarBuscar" class="btn-cancel"><i class="fa-solid fa-xmark"></i></button>

                </div>
            </div>
        </div>
    </div>


   <!-- MODAL BOOTSTRAP -->
<div class="modal fade" id="modalEliminar" tabindex="-1" aria-labelledby="modalEliminarLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="modalEliminarLabel">
          <i class="fa-solid fa-triangle-exclamation me-2"></i>Confirmar eliminación
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body text-center">
        <p class="mb-3 fs-5">¿Estás seguro que deseas eliminar esta deuda?</p>
        <p class="text-muted mb-0">Esta acción no se puede deshacer.</p>
      </div>
      <div class="modal-footer justify-content-center">
          <button type="button" id="btnConfirmarEliminar" class="btn btn-danger px-4">
              Sí, eliminar
          </button>
        <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">
          No
        </button>
        
      </div>
    </div>
  </div>
</div>
</asp:Content>

