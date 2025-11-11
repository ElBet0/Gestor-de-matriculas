<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="Alumnos.aspx.cs" Inherits="FrontTA.Alumnos.Alumnos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Búsqueda de Alumnos
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --blanco: #FFF;
            --negro: #000;
        }

        .alumnos-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
        }

        /* Estado deshabilitado: gris, sin hover */
        .btn-icon.btn-disabled,
        .btn-icon[disabled] {
            background: var(--gris) !important; /* #E1E1E1 */
            color: #777 !important;
            cursor: not-allowed;
            transform: none !important;
            box-shadow: none !important;
        }

        /* Selección de fila */
        /* === Forzar resaltado celeste de la fila seleccionada en Bootstrap === */
        .tabla-box .table tbody tr.data-row.row-selected > td,
        .table tbody tr.data-row.row-selected > td,
        .table.table-hover tbody tr.data-row.row-selected:hover > td {
            background-color: #E6F4FF !important;
            transition: background-color .15s ease-in-out;
        }

        /* Si la tabla tiene striping, anula la cebra para la fila seleccionada */
        .table.table-striped > tbody > tr.data-row.row-selected:nth-of-type(odd) > td {
            --bs-table-accent-bg: transparent; /* BS5 */
            background-color: #E6F4FF !important;
        }

        /* Mantén el hover solo cuando NO esté seleccionada */
        .table tbody tr.data-row:hover:not(.row-selected) > td {
            background-color: #F3FAFF !important;
        }

        .icon-bar-wrap {
            display: block;
        }

        .icon-bar {
            display: inline-flex; /* clave: caja se ajusta al contenido */
            gap: .75rem;
            background: var(--blanco);
            border-radius: 12px;
            padding: .6rem .75rem;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
        }

        tr.data-row.row-selected {
            background-color: #E6F4FF; /* celeste claro */
            transition: background-color .15s ease-in-out;
        }


        tr.data-row {
            cursor: pointer;
        }

            tr.data-row:hover {
                background-color: #F3FAFF;
            }

        .btn-icon {
            background: var(--verde);
            color: var(--blanco);
            border: 0;
            width: 44px;
            height: 44px;
            border-radius: 12px;
            font-size: 1.15rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: transform .15s ease, background .15s ease;
        }

            .btn-icon:hover {
                background: var(--verdeOsc);
                transform: scale(1.05);
            }

        /* Icono “Añadir familia”: grupo + badge de + */
        .btn-add-student {
            position: relative;
        }

            .btn-add-student .fa-user-graduate {
                font-size: 1.1rem;
            }

            .btn-add-student::after {
                content: "+";
                position: absolute;
                right: -4px;
                top: -4px;
                width: 18px;
                height: 18px;
                border-radius: 50%;
                background: var(--verdeOsc);
                color: #fff;
                font-weight: 800;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: .85rem;
                line-height: 1;
                box-shadow: 0 1px 3px rgba(0,0,0,.25);
            }

        /*Boton de Seleccionar Familia*/
        .btn-add-family {
            position: relative;
        }

            .btn-add-family .fa-people-group {
                font-size: 1.1rem;
            }

            .btn-add-family::after {
                content: "\f002"; /* código unicode del ícono de lupa de Font Awesome */
                font-family: "Font Awesome 6 Pro";
                font-weight: 900; /* importante para solid */
                position: absolute;
                right: -4px;
                bottom: -4px; /* 👈 mueve el círculo a la parte inferior */
                width: 18px;
                height: 18px;
                border-radius: 50%;
                background: var(--verdeOsc);
                color: #fff;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: .65rem; /* ajusta el tamaño del ícono */
                line-height: 1;
                box-shadow: 0 1px 3px rgba(0,0,0,.25);
            }


        /* === Bloque búsqueda === */
        .busqueda-box {
            background: var(--blanco);
            border-radius: 10px;
            padding: 1rem;
            box-shadow: 0 2px 5px rgba(0,0,0,.08);
        }

            .busqueda-box label {
                font-weight: 600;
                color: var(--negro);
            }

        .form-control {
            border: 1px solid var(--gris);
            border-radius: 8px;
        }

        .btn-search {
            background: var(--verde);
            color: #fff;
            border: 0;
            width: 44px;
            height: 44px;
            border-radius: 12px;
        }

            .btn-search:hover {
                background: var(--verdeOsc);
            }

        /* === Tabla === */
        .tabla-box {
            background: var(--blanco);
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
            overflow-x: auto;
        }

        .table-header {
            background: var(--verde);
            color: #fff;
            text-align: center;
        }

        th, td {
            text-align: center;
            vertical-align: middle;
        }

        .empty-state {
            color: #6c757d;
            font-style: italic;
        }

        /*BORRADO ESTILOS: */
        /* ====== SUBTÍTULO (como en otras pantallas) ====== */
        .header-cta {
            background: #CFEFFF;
            color: #0d3a52;
            border: 1px solid #a9daf7;
            padding: .6rem 1rem;
            border-radius: 12px;
            font-weight: 700;
        }

        /* ====== MODAL DE CONFIRMACIÓN ====== */
        .confirm-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.35);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1050;
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

        /* Botones de la ventanita (reutiliza estilos de otras pantallas) */
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

        .btn-exit {
            background: #fff;
            border: 1px solid #cbd5e1;
            color: #1f2937;
            font-weight: 700;
            padding: .65rem 1.25rem;
            border-radius: 12px;
            min-width: 140px;
            box-shadow: 0 2px 6px rgba(0,0,0,.08);
        }

            .btn-exit:hover {
                background: #f8fafc;
            }

        /* ===== Modal (Seleccionar Familia) ===== */
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
            background: #e9ecef;
            border-radius: 14px;
            padding: 1.5rem;
            width: min(1000px, 92vw);
            box-shadow: 0 16px 40px rgba(0,0,0,.35);
            border: 6px solid #000; /* marco negro grueso como en la maqueta */
        }

        .modal-inner {
            background: #f3f5f7;
            border: 3px solid #222;
            border-radius: 12px;
            padding: 1rem 1rem 0 1rem;
        }

        .modal-title {
            font-weight: 800;
            color: #0b3650;
            margin-bottom: .5rem;
        }

        .tabla-box {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
            overflow-x: auto;
        }

        .table-header {
            background: var(--verde);
            color: #fff;
            text-align: center;
        }

        th, td {
            text-align: center;
            vertical-align: middle;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            padding: 1rem 0;
        }

        /* === NUEVO: logo dentro del modal, tamaño controlado === */
        .modal-flex {
            display: flex;
            gap: 1rem;
            align-items: flex-start;
        }

        .side-img-modal {
            background: #ffffffcc;
            border: 2px solid #d7eefc;
            border-radius: 12px;
            padding: .75rem;
            text-align: center;
            width: 180px;
            min-width: 180px;
            align-self: flex-start;
        }

            .side-img-modal img {
                max-width: 140px;
                height: auto;
                display: block;
                margin: auto;
            }

        .form-label {
            font-weight: 700;
            font-size: 1.15rem;
            color: #1f2937;
        }

</style>

    <script>
        (function () {
            function getTable() {
                return document.getElementById('<%= gvAlumnos.ClientID %>');
      }
      function getSelected() {
          return getTable()?.querySelector('tr.data-row.row-selected');
      }

      function wireUp() {
          const table = getTable();
          const btnAdd = document.getElementById('btnAdd');
          const btnView = document.getElementById('btnView');
          const btnEdit = document.getElementById('btnEdit');
          const btnDel = document.getElementById('btnDelete');

          const overlay = document.getElementById('confirmDelete');
          const btnCancelDelete = document.getElementById('btnCancelDelete');
          const hiddenID = document.getElementById('<%= idAlumnoDelete.ClientID %>');

          const ovFamilia = document.getElementById('ovFamilia');
          const btnAddFamilia = document.getElementById('btnAddFamilia');
          const btnCloseFamilia = document.getElementById('btnCloseFamilia');


        function setEnabled(enabled) {
            [btnView, btnEdit, btnDel].forEach(b => {
                if (!b) return;
                b.disabled = !enabled;
                b.classList.toggle('btn-disabled', !enabled);
            });
        }
          setEnabled(false);

          function openOv() {
              if (!ovFamilia) return;
              ovFamilia.classList.add('show');
              ovFamilia.setAttribute('aria-hidden', 'false');
          }
          function closeOv() {
              if (!ovFamilia) return;
              ovFamilia.classList.remove('show');
              ovFamilia.setAttribute('aria-hidden', 'true');
          }

          if (btnAddFamilia) {
              btnAddFamilia.type = 'button';
              btnAddFamilia.addEventListener('click', function (e) {
                  e.preventDefault();
                  openOv();
              });
          }
          if (btnCloseFamilia) {
              btnCloseFamilia.addEventListener('click', function (e) {
                  e.preventDefault();
                  closeOv();
              });
          }
          if (ovFamilia) {
              // click fuera del cuadro cierra
              ovFamilia.addEventListener('click', function (e) {
                  if (e.target === ovFamilia) closeOv();
              });
          }
          document.addEventListener('keydown', function (e) {
              if (e.key === 'Escape' && ovFamilia && ovFamilia.classList.contains('show')) {
                  closeOv();
              }
          });
        

          if (!table) return;

          if (window.__alumnosWireUpBound) return;
          window.__alumnosWireUpBound = true;

          // Selección de fila en GridView
          table.addEventListener('click', function (e) {
              const tr = e.target.closest('tr');
              if (!tr || !table.contains(tr)) return;
              if (tr.parentElement && tr.parentElement.tagName === 'THEAD') return;
              if (!tr.classList.contains('data-row')) return;

              table.querySelectorAll('tr.row-selected, tr.selected')
                  .forEach(r => r.classList.remove('row-selected', 'selected'));

              tr.classList.add('row-selected');
              setEnabled(true);

              // detiene la burbuja para que NO llegue al document click
              e.stopPropagation();
          });

          // Click fuera -> deseleccionar (ignora clicks dentro del gvAlumnos)
          document.addEventListener('click', function (ev) {
              // si el click estuvo dentro del grid, no hagas nada
              if (ev.target.closest('#<%= gvAlumnos.ClientID %>')) return;

              const sel = getSelected();
              if (sel) sel.classList.remove('row-selected');
              setEnabled(false);
          });

        // Navegación
        if (btnAdd) {
            btnAdd.type = 'button';
            btnAdd.addEventListener('click', function (e) {
                e.preventDefault();
                window.location.href = "<%= ResolveUrl("~/Alumnos/CrearAlumno.aspx") %>";
        });
      }
      if (btnView) {
        btnView.addEventListener('click', function () {
          const sel = getSelected(); if (!sel) return;
          const id = sel.getAttribute('data-id');
          window.location.href = '<%= ResolveUrl("~/Alumnos/ConsultarAlumno.aspx") %>?id=' + encodeURIComponent(id);
        });
      }
      if (btnEdit) {
        btnEdit.addEventListener('click', function () {
          const sel = getSelected(); if (!sel) return;
          const id = sel.getAttribute('data-id');
          window.location.href = '<%= ResolveUrl("~/Alumnos/EditarAlumno.aspx") %>?id=' + encodeURIComponent(id);
        });
                }

                // Borrado (abre modal y guarda id en HiddenField)
                if (btnDel && overlay) {
                    btnDel.addEventListener('click', function () {
                        const sel = getSelected(); if (!sel) return;
                        const id = sel.getAttribute('data-id') || '';
                        if (hiddenID) hiddenID.value = id.trim();
                        overlay.classList.add('show');
                        overlay.setAttribute('aria-hidden', 'false');
                    });
                }

                // Cancelar modal
                if (btnCancelDelete && overlay) {
                    btnCancelDelete.addEventListener('click', closeDeleteUI);
                    overlay.addEventListener('click', function (e) {
                        if (e.target === overlay) closeDeleteUI();
                    });
                    document.addEventListener('keydown', function (e) {
                        if (e.key === 'Escape' && overlay.classList.contains('show')) closeDeleteUI();
                    });
                }

                function closeDeleteUI() {
                    overlay.classList.remove('show');
                    overlay.setAttribute('aria-hidden', 'true');
                }
            }

            document.addEventListener('DOMContentLoaded', wireUp);
            if (window.Sys && Sys.Application) {
                Sys.Application.add_load(wireUp);
            }
        })();
    </script>




</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid alumnos-container">
        
        <!-- ICONOS (izquierda) -->
        <div class="icon-bar-wrap mb-3">
            <div class="icon-bar">
                <button type="button" id="btnAdd" class="btn btn-icon btn-add-student" title="Añadir Alumno">
                    <i class="fa-solid fa-user-graduate"></i>
                </button>

                <button type="button" id="btnView" class="btn btn-icon btn-disabled" title="Consultar Alumno" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>

                <button type="button" id="btnEdit" class="btn btn-icon btn-disabled" title="Editar Alumno" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>

                <button type="button" id="btnDelete" class="btn btn-icon btn-disabled" title="Eliminar Alumno" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>
        </div>

        <!--BUSQUEDA -->
        <div class="busqueda-box mb-4">
            <div class="mb-1 row">
                <div class="col-md-5">
                    <label for="txtCodigoFamilia" class="form-label">Código Familia:</label>
                    <asp:TextBox ID="txtCodigoFamilia" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-5 align-content-md-center">
                    <button type="button" id="btnAddFamilia" class="btn btn-icon btn-add-family position-relative" title="Añadir familia">
                        <i class="fa-solid fa-people-group"></i>
                    </button>
                </div>
                <div class="col-md-2 text-center align-content-md-center">
                    <%--<button type="button" class="btn btn-search" title="Buscar">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>--%>
                    <asp:LinkButton ID="btnBuscar"
                        runat="server"
                        CssClass="btn btn-search"
                        ToolTip="Buscar"
                        OnClick="btnBuscar_Click"
                        CausesValidation="false"
                        UseSubmitBehavior="false">
     <i class="fa-solid fa-magnifying-glass"></i>
                    </asp:LinkButton>

                </div>
            </div>

            <div class="mb-1 row">
                <div class="col-md-5">
                    <label for="txtApellidoPaterno" class="form-label">Apellido Paterno:</label>
                    <asp:TextBox ID="txtApellidoPaterno" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-5">
                    <label for="txtApellidoMaterno" class="form-label">Apellido Materno:</label>
                    <asp:TextBox ID="txtApellidoMaterno" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="mb-1 row">
                <div class="col-md-5">
                    <label for="txtDNI" class="form-label">DNI:</label>
                    <asp:TextBox ID="txtDNI" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-5">
                    <label for="txtNombre" class="form-label">Nombre:</label>
                    <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
        </div>

        <!-- TABLA (sin filas de ejemplo PARA RELLENAR DATOS CON LA BD) -->
        <!--
        <div class="tabla-box">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-header">
                    <tr>
                        <th style="width: 180px;">Código Alumno</th>
                        <th>Apellido Paterno</th>
                        <th>Apellido Materno</th>
                        <th>Nombre</th>
                    </tr>
                </thead>
                <tbody id="tbodyFamilias">
                    <tr class="data-row" data-id="001">
                        <td>001</td>
                        <td>García</td>
                        <td>Pérez</td>
                        <td>Gino</td>
                    </tr>
                    <tr class="data-row" data-id="002">
                        <td>002</td>
                        <td>Ramos</td>
                        <td>López</td>
                        <td>Fabrizio</td>
                    </tr>
                    <tr class="data-row" data-id="003">
                        <td>003</td>
                        <td>Torres</td>
                        <td>Quispe</td>
                        <td>Joaquin</td>
                    </tr>
                </tbody>
            </table>
            -->
        <asp:GridView ID="gvAlumnos"
            runat="server"
            AutoGenerateColumns="false"
            CssClass="table table-bordered table-hover align-middle mb-0"
            DataKeyNames="alumno_id"
            OnRowDataBound="gvAlumnos_RowDataBound">
            <Columns>
                <asp:BoundField DataField="alumno_id" HeaderText="Código Alumno">
                    <ItemStyle Width="180px" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="Nombre">
                    <ItemTemplate><%# Eval("nombre") %></ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Apellido Paterno">
                    <ItemTemplate><%# Eval("padres.apellido_paterno") %></ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Apellido Materno">
                    <ItemTemplate><%# Eval("padres.apellido_materno") %></ItemTemplate>
                </asp:TemplateField>
            </Columns>
</asp:GridView>

        <!-- BORRADO -->
        <div id="confirmDelete" class="confirm-overlay" aria-hidden="true">
            <div class="confirm-box">
                <div class="confirm-title">¿Estás seguro que deseas eliminar al alumno?</div>
                <div class="confirm-actions">
                    <asp:LinkButton ID="btnDoDelete"
                        runat="server"
                        ClientIDMode="Static"
                        CssClass="btn-accept"
                        ToolTip="Sí, eliminar"
                        CausesValidation="false"
                        UseSubmitBehavior="false"
                        OnClick="btnDoDelete_Click">
<i class="fa-solid fa-check"></i>
                    </asp:LinkButton>
                    <asp:HiddenField ID="idAlumnoDelete" runat="server" Value="" />

                    <asp:LinkButton ID="btnCancelDelete"
                        runat="server"
                        ClientIDMode="Static"
                        CssClass="btn-cancel"
                        ToolTip="No, cancelar"
                        CausesValidation="false"
                        UseSubmitBehavior="false"
                        OnClientClick="return false;">
<i class="fa-solid fa-xmark"></i>
                    </asp:LinkButton>



                </div>
            </div>
        </div>

        <!-- Seleccionar Familia -->
        <div id="ovFamilia" class="overlay" aria-hidden="true">
            <div class="modal-box">
                <div class="modal-inner">

                    <!-- fila: tabla + logo (adentro del rectángulo gris) -->
                    <div class="modal-flex">
                        <div class="col-9">
                            <div class="mb-2 row">
                                <div class="col-md-10">
                                    <div class="mb-2 row">
                                        <div class="col-md-4">
                                            <label class="form-label align-content-center">Apellido Paterno:</label>
                                        </div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtApePaternoModal" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="mb-2 row">
                                        <div class="col-md-4">
                                            <label class="form-label align-content-center text-nowrap">Apellido Materno:</label>
                                        </div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtApeMaternoModal" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-2 d-flex justify-content-center align-items-center">
                                    <%--<button type="button" class="btn btn-search" title="Buscar">
                                        <i class="fa-solid fa-magnifying-glass"></i>
                                    </button>--%>
                                    <asp:LinkButton ID="btnBuscarModal"
                                        runat="server"
                                        CssClass="btn btn-search"
                                        ToolTip="Buscar"
                                        OnClick="btnBuscar_Click2"
                                        CausesValidation="false"
                                        UseSubmitBehavior="false">
    <i class="fa-solid fa-magnifying-glass" aria-hidden="true"></i>
    <span class="sr-only">Buscar</span>
                                    </asp:LinkButton>


                                </div>
                            </div>
                            <div class="tabla-box mb-3 flex-grow-1">
                                <table class="table table-bordered table-hover align-middle mb-0">
                                    <thead class="table-header">
                                        <tr>
                                            <th>Código Familia</th>
                                            <th>Apellido Paterno</th>
                                            <th>Apellido Materno</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="reFamilias" runat="server">
                                            <ItemTemplate>
                                                <tr class="data-row">
                                                    <td><%# Eval("alumno_id") %></td>
                                                    <td><%# Eval("padres.apellido_paterno") %></td>
                                                    <td><%# Eval("padres.apellido_materno") %></td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-3 align-content-center">
                            <div class="side-img-modal">
                                <asp:Image ID="imgCursosEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <div class="action-buttons mt-3">
                        
                        <asp:LinkButton ID="btnConfirmar" runat="server" CssClass="btn-accept" Text="<i class='fa-solid fa-check'></i>" OnClick="btnConfirmar_Click" ToolTip="Crear y volver">
                            
                        </asp:LinkButton>
                        <button type="button" id="btnCloseFamilia" class="btn-cancel"><i class="fa-solid fa-xmark"></i></button>
                    
                    
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
</asp:Content>