<%@ Page Title="Búsqueda de Matrículas" Language="C#" MasterPageFile="~/SoftProg.Master"
    AutoEventWireup="true" CodeBehind="BuscarMatricula.aspx.cs" Inherits="FrontTA.Matricula.BuscarMatricula" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Búsqueda de Matrículas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --blanco: #FFF;
            --negro: #000;
            --celeste: #E6F4FF;
        }

        .matricula-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
        }

        /*  FILA SUPERIOR: Año + cápsula de acciones */
        .top-row {
            display: grid;
            grid-template-columns: auto 1fr auto; /* año | título | iconos */
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .year-box {
            background: #c9c9c9;
            border: 3px solid #111;
            border-radius: 16px;
            padding: .65rem 1.25rem;
            min-width: 360px;
            font-weight: 800;
            font-size: 2rem;
            color: #111;
            box-shadow: inset 0 3px 6px rgba(0,0,0,.12);
        }

            .year-box small {
                font-size: 1.25rem;
                font-weight: 800;
                margin-right: .5rem;
            }

        .icon-bar { /* igual que Familias */
            display: inline-flex;
            gap: .75rem;
            background: var(--blanco);
            border-radius: 12px;
            padding: .6rem .75rem;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
        }

        .btn-icon { /* igual que Familias */
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

            .btn-icon.btn-disabled, .btn-icon[disabled] {
                background: var(--gris) !important;
                color: #777 !important;
                cursor: not-allowed;
                transform: none !important;
                box-shadow: none !important;
            }

        /*  BÚSQUEDA  */
        .busqueda-box {
            background: var(--blanco);
            border-radius: 12px;
            padding: 1rem 1.25rem;
            box-shadow: 0 2px 5px rgba(0,0,0,.08);
            margin-bottom: 1.25rem;
        }

            .busqueda-box label {
                font-weight: 700;
                color: #111;
            }

        .form-control {
            border: 1px solid var(--gris);
            border-radius: 10px;
        }

        .readonly-gray {
            background: #eee !important;
            color: #333 !important;
        }

        .mini-btn {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            border: 2px solid #111;
            background: var(--blanco);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        /*  TABLA / GRIDVIEW  */
        .tabla-box {
            background: var(--blanco);
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
            overflow-x: auto;
        }

        .table-header {
            background: var(--verde);
            color: #fff;
            text-align: center;
        }

        #gvAlumnos {
            width: 100%;
        }

            #gvAlumnos th, #gvAlumnos td {
                text-align: center;
                vertical-align: middle;
            }

            #gvAlumnos tr.data-row {
                cursor: pointer;
            }

                #gvAlumnos tr.data-row:hover td {
                    background: var(--celeste);
                }

            #gvAlumnos tr.row-selected td {
                background: var(--celeste) !important;
                transition: background-color .12s ease-in-out;
            }

        /*  MODAL FAMILIAS  */
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
            background: #fff;
            border-radius: 14px;
            padding: 1.25rem 1.5rem;
            box-shadow: 0 12px 32px rgba(0,0,0,.25);
            min-width: 700px;
            max-width: 95%;
        }

        .modal-title {
            font-weight: 800;
            font-size: 1.2rem;
            margin-bottom: .8rem;
        }

        .tabla-box-modal {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,.1);
            overflow: auto;
        }

        .btn-exit {
            background: var(--verde);
            color: #fff;
            border: none;
            border-radius: 12px;
            padding: .6rem 1.25rem;
            font-weight: 700;
            float: right;
        }

        .header-cta {
            background: #F3F4F6;
            color: #000000;
            border: 1px solid #E5E7EB;
            padding: .5rem 1rem;
            border-radius: 4px;
            font-weight: 700;
            justify-self: center; /* centra dentro de la columna 2 */
        }


    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            //  selección de fila en GridView 
            const gv = document.getElementById('gvAlumnos');
            const btnEdit = document.getElementById('<%= btnEdit.ClientID %>');
            const btnView = document.getElementById('<%= btnView.ClientID %>');

            const setEnabled = (el, enabled) => {
                if (!el) return;
                el.disabled = !enabled;
                el.classList.toggle('btn-disabled', !enabled);
            };

            setEnabled(btnEdit, false);
            setEnabled(btnView, false);

            if (gv) {
                gv.addEventListener('click', function (e) {
                    const tr = e.target.closest('tr.data-row');
                    if (!tr) return;
                    gv.querySelectorAll('tr').forEach(r => r.classList.remove('row-selected'));
                    tr.classList.add('row-selected');
                    setEnabled(btnEdit, true);
                    setEnabled(btnView, true);
                });
            }

            const ov = document.getElementById('ovFamilias');
            document.getElementById('btnOpenFam').addEventListener('click', () => {
                ov.classList.add('show'); ov.setAttribute('aria-hidden', 'false');
            });
            document.getElementById('btnCloseFam').addEventListener('click', () => {
                ov.classList.remove('show'); ov.setAttribute('aria-hidden', 'true');
                clearFamSelection();
            });

            // === Filtro simple por apellidos (cliente) ===
            const inpPat = document.getElementById('famApePat');
            const inpMat = document.getElementById('famApeMat');
            const btnBuscar = document.getElementById('btnFamBuscar');
            const tbl = document.getElementById('tblFamRes').querySelector('tbody');

            function filtrar() {
                const pat = (inpPat.value || '').trim().toLowerCase();
                const mat = (inpMat.value || '').trim().toLowerCase();
                tbl.querySelectorAll('tr.fam-row').forEach(tr => {
                    const c2 = tr.children[1].textContent.trim().toLowerCase(); // paterno
                    const c3 = tr.children[2].textContent.trim().toLowerCase(); // materno
                    const ok = (!pat || c2.includes(pat)) && (!mat || c3.includes(mat));
                    tr.style.display = ok ? '' : 'none';
                });
            }
            btnBuscar.addEventListener('click', filtrar);

            const anio = (document.getElementById('<%= lblAnio.ClientID %>').textContent || '').trim();

            // helpers
            const selectedRow = () => gv ? gv.querySelector('tr.row-selected') : null;
            const getIdSel = () => {
                const tr = selectedRow();
                return tr ? tr.dataset.id : null;           // <-- lo llenaremos en el RowDataBound (ver punto 2)
            };

            // Navegación: Crear
            const btnCreate = document.getElementById('<%= btnCreate.ClientID %>');
            if (btnCreate) {
                btnCreate.addEventListener('click', function () {
                    // ir a Crear (no requiere selección)
                    window.location.href = '<%= ResolveUrl("~/Matricula/CrearMatricula.aspx") %>?anio=' + encodeURIComponent(anio);
                });
            }

            // Navegación: Consultar
            if (btnView) {
                btnView.addEventListener('click', function () {
                    const id = getIdSel();
                    /*if (!id) { alert('Seleccione un alumno / matrícula para consultar.'); return; }*/
                    window.location.href = '<%= ResolveUrl("~/Matricula/ConsultarMatricula.aspx") %>?anio='
            + encodeURIComponent(anio) + '&id=' + encodeURIComponent(id);
    });
            }

            // Navegación: Editar
            if (btnEdit) {
                btnEdit.addEventListener('click', function () {
                    const id = getIdSel();
                    /*if (!id) { alert('Seleccione un alumno / matrícula para editar.'); return; }*/
                    window.location.href = '<%= ResolveUrl("~/Matricula/EditarMatricula.aspx") %>?anio='
            + encodeURIComponent(anio) + '&id=' + encodeURIComponent(id);
    });
            }

            // === Selección de familia ===
            const btnOk = document.getElementById('btnFamOk');
            let famSelected = null;

            // reutilizo tu estilo de selección (celeste):
            function clearFamSelection() {
                famSelected = null;
                btnOk.disabled = true;
                btnOk.classList.add('btn-disabled');
                tbl.querySelectorAll('tr.fam-row').forEach(r => r.classList.remove('row-selected'));
            }

            tbl.addEventListener('click', (e) => {
                const tr = e.target.closest('tr.fam-row');
                if (!tr) return;
                tbl.querySelectorAll('tr.fam-row').forEach(r => r.classList.remove('row-selected'));
                tr.classList.add('row-selected');
                famSelected = tr.getAttribute('data-cod');
                btnOk.disabled = false;
                btnOk.classList.remove('btn-disabled');
            });

            // === Guardar selección (copiar código al textbox gris) ===
            btnOk.addEventListener('click', () => {
                if (!famSelected) return;
                const txtCod = document.getElementById('<%= txtCodFam.ClientID %>');
                txtCod.value = famSelected;
                ov.classList.remove('show'); ov.setAttribute('aria-hidden', 'true');
                clearFamSelection();
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid matricula-container">

        <!--  Fila superior  -->
        <div class="top-row">
            <!-- Año -->
            <div class="year-box">
                <small>Año</small>
                <asp:Label ID="lblAnio" runat="server" Text=""></asp:Label>
            </div>

            <!-- Título central -->
            <span class="header-cta">Gestión Matrícula</span>

            <!-- cápsula estilo Familias: Crear / Editar / Consultar -->
            <div class="icon-bar">
                <button id="btnCreate" runat="server" type="button" class="btn-icon" title="Crear matrícula">
                    <i class="fa-solid fa-user-plus"></i>
                </button>
                <button id="btnView" runat="server" type="button" class="btn-icon btn-disabled" title="Consultar matrícula" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>
                <button id="btnEdit" runat="server" type="button" class="btn-icon btn-disabled" title="Editar matrícula" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>
            </div>
        </div>

        <!--  Búsqueda (con Nombre) + cápsula derecha con Reporte y Buscar  -->
        <div class="busqueda-box">
            <div class="row g-3 align-items-end">
                <div class="col-lg-4">
                    <label class="form-label">Código Familia:</label>
                    <div class="input-group">
                        <asp:TextBox ID="txtCodFam" runat="server" CssClass="form-control readonly-gray" ReadOnly="true"></asp:TextBox>
                        <button id="btnOpenFam" type="button" class="btn-icon" title="Buscar familia">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
                </div>

                <div class="col-lg-2">
                    <label class="form-label">Apellido Paterno:</label>
                    <asp:TextBox ID="txtApePat" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-lg-2">
                    <label class="form-label">Apellido Materno:</label>
                    <asp:TextBox ID="txtApeMat" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-lg-2">
                    <label class="form-label">Nombre:</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-lg-2">
                    <label class="form-label">DNI:</label>
                    <asp:TextBox ID="txtDni" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <!-- cápsula derecha con Reporte y Buscar -->
            <div class="d-flex justify-content-end mt-3">
                <div class="icon-bar">
                    <asp:HyperLink ID="lnkReporte" runat="server" CssClass="btn-icon" ToolTip="Reporte por año">
                        <i class="fa-solid fa-clipboard-list"></i>
                    </asp:HyperLink>
                    <button id="btnBuscar" runat="server" type="button" class="btn-icon" title="Buscar alumnos">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </div>
            </div>
        </div>

        <!--  Tabla / GridView  -->
        <div class="tabla-box">
            <asp:GridView ID="gvAlumnos" runat="server" AutoGenerateColumns="False"
                  CssClass="table table-bordered table-hover align-middle mb-0"
                ClientIDMode="Static" OnRowDataBound="gvAlumnos_RowDataBound" ShowHeaderWhenEmpty="true">
                <HeaderStyle CssClass="table-header" />
                <Columns>
                    <asp:BoundField HeaderText="Género" DataField="Genero" />
                    <asp:BoundField HeaderText="Apellido Paterno" DataField="ApePat" />
                    <asp:BoundField HeaderText="Apellido Materno" DataField="ApeMat" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                </Columns>
                <EmptyDataTemplate>
                    <tr>
                        <td colspan="4" class="text-muted">Sin resultados</td>
                    </tr>
                </EmptyDataTemplate>
                <RowStyle CssClass="data-row" />
            </asp:GridView>
        </div>

        <!--  Modal Familias (simple)  -->
        <div id="ovFamilias" class="overlay" aria-hidden="true">
            <div class="modal-box" role="dialog" aria-modal="true" aria-labelledby="famTitle">
                <div class="modal-title" id="famTitle">Buscar Familia</div>

                <!-- Filtros de apellidos + botón Buscar (mismo look que el resto) -->
                <div class="busqueda-box mb-3">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-5">
                            <label class="form-label">Apellido Paterno:</label>
                            <input type="text" id="famApePat" class="form-control" />
                        </div>
                        <div class="col-md-5">
                            <label class="form-label">Apellido Materno:</label>
                            <input type="text" id="famApeMat" class="form-control" />
                        </div>
                        <div class="col-md-2 d-flex justify-content-center">
                            <button type="button" id="btnFamBuscar" class="btn-icon" title="Buscar">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Tabla de resultados -->
                <div class="tabla-box-modal mb-3">
                    <table class="table table-bordered table-hover align-middle mb-0" id="tblFamRes">
                        <thead class="table-header">
                            <tr>
                                <th style="width: 180px;">Código Familia</th>
                                <th>Apellido Paterno</th>
                                <th>Apellido Materno</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Ejemplos; puedes llenar esto desde servidor si luego lo prefieres -->
                            <tr class="fam-row" data-cod="FAM001">
                                <td>FAM001</td>
                                <td>García</td>
                                <td>Pérez</td>
                            </tr>
                            <tr class="fam-row" data-cod="FAM002">
                                <td>FAM002</td>
                                <td>Ramos</td>
                                <td>López</td>
                            </tr>
                            <tr class="fam-row" data-cod="FAM003">
                                <td>FAM003</td>
                                <td>Torres</td>
                                <td>Quispe</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Acciones -->
                <div class="d-flex justify-content-end gap-2">
                    <button type="button" id="btnFamOk" class="btn-icon btn-disabled" disabled title="Guardar selección">
                        <i class="fa-solid fa-check"></i>
                    </button>
                    <button type="button" id="btnCloseFam" class="btn-icon" title="Salir">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
