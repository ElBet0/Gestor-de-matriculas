<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true"
    CodeBehind="ConsultarGradoAcademico.aspx.cs"
    Inherits="FrontTA.GestionAcademica.ConsultarGradoAcademico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Consultar Grado Académico
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --grisTexto: #777;
            --blanco: #FFF;
            --negro: #000;
            --borde: #D7D7D7;
        }

        .familias-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
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
            transition: transform .15s ease, background .15s ease, color .15s;
        }

        .btn-active {
            background: #8FD2FF;
            color: #00324D;
        }

        .btn-muted {
            background: #F1F1F1;
            color: #9aa0a6;
        }

        .toolbar {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            align-items: center;
        }

        .header-cta {
            background: #F3F4F6;
            color: #000;
            border: 1px solid #E5E7EB;
            padding: .5rem 1rem;
            border-radius: 4px;
            font-weight: 700;
            justify-self: center;
        }

        .toolbar .icon-bar {
            justify-self: start;
        }

        .card-form {
            background: var(--blanco);
            border-radius: 16px;
            padding: 1.25rem;
            box-shadow: 0 2px 6px rgba(0,0,0,.12);
        }

        .fieldset {
            border: 2px solid #E8E8E8;
            border-radius: 16px;
            padding: 1.25rem;
            background: #F8F8F8;
        }

        .form-label {
            font-weight: 700;
            font-size: 1.15rem;
            color: #1f2937;
        }

        .form-control {
            border: 1px solid var(--borde);
            border-radius: 8px;
            height: 44px;
        }

        .input-disabled {
            background: #BDBDBD;
            color: #444;
            border: 1px solid #AFAFAF;
        }

        .side-panel {
            min-height: 420px;
            padding: 2rem;
            border-radius: 16px;
            background: #BFE7FF;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            border: 1px solid #a7d7f3;
        }

        .side-title {
            display: inline-block;
            font-weight: 800;
            font-size: 1.25rem;
            color: #0b3650;
            margin-bottom: .75rem;
        }

        .side-img {
            background: #ffffffaa;
            border: 3px solid #d7eefc;
            border-radius: 16px;
            padding: 1.25rem;
            text-align: center;
        }

            .side-img img {
                max-width: 220px;
                height: auto;
                display: block;
                margin: auto;
            }

        .footer-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            align-items: center;
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

        .btn-flat {
            background: #A2F2B9;
            border: 1px solid #96e2ab;
            color: #0c3b22;
            font-weight: 800;
            padding: .75rem 1.5rem;
            border-radius: 12px;
            min-width: 220px;
            text-align: center;
            box-shadow: 0 2px 0 rgba(0,0,0,.1) inset;
        }

            .btn-flat:hover {
                filter: brightness(.97);
            }

        /* Overlays / Modales */
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
            width: min(1000px,92vw);
            box-shadow: 0 16px 40px rgba(0,0,0,.35);
            border: 6px solid #000;
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

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            padding: 1rem 0;
        }

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

        /* Tabla patrón */
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

        /* Encabezados GridView sin subrayado/azul */
        .table-header a,
        .table-header a:link,
        .table-header a:visited,
        .table-header a:hover,
        .table-header a:focus,
        .table-header a:active {
            color: #000 !important;
            text-decoration: none !important;
        }

        /* Hover/selección (por consistencia visual) */
        .tabla-box table.table tbody tr.data-row {
            cursor: pointer;
        }

            .tabla-box table.table tbody tr.data-row:hover:not(.row-selected) > td {
                background-color: #F3FAFF !important;
            }

            .tabla-box table.table tbody tr.data-row.row-selected > td {
                background-color: #E6F4FF !important;
                transition: background-color .15s ease-in-out;
            }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Aulas
            const ovAulas = document.getElementById('ovAulas');
            document.getElementById('btnAulas').addEventListener('click', () => { ovAulas.classList.add('show'); ovAulas.setAttribute('aria-hidden', 'false'); });
            document.getElementById('btnCloseAulas').addEventListener('click', () => closeOv(ovAulas));
            ovAulas.addEventListener('click', (e) => { if (e.target === ovAulas) closeOv(ovAulas); });

            // Cursos
            const ovCursos = document.getElementById('ovCursos');
            document.getElementById('btnCursos').addEventListener('click', () => { ovCursos.classList.add('show'); ovCursos.setAttribute('aria-hidden', 'false'); });
            document.getElementById('btnCloseCursos').addEventListener('click', () => closeOv(ovCursos));
            ovCursos.addEventListener('click', (e) => { if (e.target === ovCursos) closeOv(ovCursos); });

            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape') [ovAulas, ovCursos].forEach(o => { if (o.classList.contains('show')) closeOv(o); });
            });

            function closeOv(ov) { ov.classList.remove('show'); ov.setAttribute('aria-hidden', 'true'); }
        });
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid familias-container">

        <!-- barra superior -->
        <div class="toolbar mb-3">
            <div class="icon-bar">
                <button type="button" class="btn-icon btn-active" title="Consultar grado académico">
                    <i class="fa-solid fa-eye"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Crear" disabled>
                    <i class="fa-solid fa-graduation-cap"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Editar" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Eliminar" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>
            <span class="header-cta">Consultar Grado Académico</span>
        </div>

        <!-- contenido -->
        <div class="card-form">
            <div class="row g-4">
                <!-- formulario -->
                <div class="col-lg-8">
                    <div class="fieldset">
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label">ID:</label></div>
                            <div class="col-7">
                                <asp:TextBox ID="txtId" runat="server" CssClass="form-control input-disabled" ReadOnly="true" /></div>
                        </div>
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label">Nombre:</label></div>
                            <div class="col-7">
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control input-disabled" ReadOnly="true" /></div>
                        </div>
                        <div class="row g-3 align-items-center mb-2">
                            <div class="col-5 text-end">
                                <label class="form-label">Abreviatura:</label></div>
                            <div class="col-7">
                                <asp:TextBox ID="txtAbreviatura" runat="server" CssClass="form-control input-disabled" ReadOnly="true" /></div>
                        </div>
                        <div class="row g-3 align-items-center">
                            <div class="col-5 text-end">
                                <label class="form-label">Activo:</label></div>
                            <div class="col-7">
                                <asp:DropDownList ID="ddlActivo" runat="server" CssClass="form-control input-disabled" Enabled="false">
                                    <asp:ListItem Text="Vigente" Value="1" Selected="True" />
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>

                    <div class="footer-actions mt-4">
                        <button type="button" id="btnAulas" class="btn-flat">Aulas</button>
                        <button type="button" id="btnCursos" class="btn-flat">Cursos</button>
                        <asp:LinkButton ID="btnSalir" runat="server" CssClass="btn-exit" OnClick="btnSalir_Click">Salir</asp:LinkButton>
                    </div>
                </div>

                <!-- panel lateral -->
                <div class="col-lg-4">
                    <div class="side-panel">
                        <div class="w-100">
                            <div class="side-title">Consultar Grado Académico</div>
                            <div class="side-img">
                                <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" AlternateText="Colegio" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /row -->
        </div>
        <!-- /card -->

        <!-- ===== Overlay Aulas ===== -->
        <div id="ovAulas" class="overlay" aria-hidden="true">
            <div class="modal-box">
                <div class="modal-inner">
                    <div class="modal-title">Aulas del Grado Académico</div>

                    <div class="modal-flex">
                        <div class="tabla-box mb-3 flex-grow-1">
                            <asp:GridView ID="gvAulas" runat="server"
                                AutoGenerateColumns="False"
                                CssClass="table table-bordered table-hover align-middle mb-0"
                                GridLines="None"
                                UseAccessibleHeader="true"
                                AllowPaging="true" PageSize="10"
                                AllowSorting="true"
                                OnRowDataBound="gvAulas_RowDataBound"
                                OnPageIndexChanging="gvAulas_PageIndexChanging"
                                OnSorting="gvAulas_Sorting">
                                <Columns>
                                    <asp:BoundField DataField="Codigo" HeaderText="Código Aula" SortExpression="Codigo">
                                        <ItemStyle Width="220px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="empty-state">No hay aulas para este grado.</div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>

                        <div class="side-img-modal">
                            <asp:Image ID="imgAulasEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" id="btnCloseAulas" class="btn-exit">Salir</button>
                </div>
            </div>
        </div>

        <!-- ===== Overlay Cursos ===== -->
        <div id="ovCursos" class="overlay" aria-hidden="true">
            <div class="modal-box">
                <div class="modal-inner">
                    <div class="modal-title">Cursos del Grado Académico</div>

                    <div class="modal-flex">
                        <div class="tabla-box mb-3 flex-grow-1">
                            <asp:GridView ID="gvCursos" runat="server"
                                AutoGenerateColumns="False"
                                CssClass="table table-bordered table-hover align-middle mb-0"
                                GridLines="None"
                                UseAccessibleHeader="true"
                                AllowPaging="true" PageSize="10"
                                AllowSorting="true"
                                OnRowDataBound="gvCursos_RowDataBound"
                                OnPageIndexChanging="gvCursos_PageIndexChanging"
                                OnSorting="gvCursos_Sorting">
                                <Columns>
                                    <asp:BoundField DataField="Codigo" HeaderText="Código Curso" SortExpression="Codigo">
                                        <ItemStyle Width="220px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                                    <asp:BoundField DataField="Abreviatura" HeaderText="Abreviatura" SortExpression="Abreviatura" />
                                    <asp:BoundField DataField="Horas" HeaderText="Horas sem" SortExpression="Horas" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="empty-state">No hay cursos para este grado.</div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>

                        <div class="side-img-modal">
                            <asp:Image ID="imgCursosEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" id="btnCloseCursos" class="btn-exit">Salir</button>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
