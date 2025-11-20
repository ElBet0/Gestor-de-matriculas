<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="ConsultarAlumno.aspx.cs" Inherits="FrontTA.Alumnos.ConsultarAlumno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Consultar Alumno
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
            --celeste: #BFE7FF; /* panel lateral */
            --celesteBtn: #8FD2FF; /* botón activo barra */
            --borde: #D7D7D7;
        }

        .alumnos-container {
            background: var(--gris);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,.1);
        }

        /* barra de iconos */
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

        .btn-icon-2 {
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

            .btn-icon-2:hover {
                background: var(--verdeOsc);
                transform: scale(1.05);
            }

        /*Boton de Seleccionar Familia*/
        .btn-add-family {
            position: relative;
        }

            .btn-add-family .fa-people-group {
                font-size: 1.1rem;
            }

            .btn-add-family::after {
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

        .btn-active {
            background: var(--celesteBtn);
            color: #00324D;
        }

            .btn-active:hover {
                transform: scale(1.05);
            }

        .btn-muted {
            background: #F1F1F1;
            color: var(--grisTexto);
        }

            .btn-muted:hover {
                background: #E9E9E9;
            }

        .toolbar {
            display: grid;
            grid-template-columns: 1fr auto 1fr; /* izq | centro | der */
            align-items: center;
        }

        .header-cta {
            background: #F3F4F6;
            color: #000000;
            border: 1px solid #E5E7EB;
            padding: .5rem 1rem;
            border-radius: 4px;
            font-weight: 700;
            justify-self: center; /* centra en la columna 2 */
        }

        .toolbar .icon-bar {
            justify-self: start;
        }

        /* tarjeta */
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

        /* panel derecho celeste */

        .side-panel {
            max-width: 300px; /* límite razonable para pantallas grandes */
            min-width: 200px; /* mantiene algo de consistencia */
            height: auto;
            padding: 1rem 2rem;
            border-radius: 16px;
            background: var(--celeste);
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #a7d7f3;
            margin: 0 auto;
        }

        .side-title {
            font-weight: 800;
            font-size: 1.25rem;
            color: #0b3650;
            margin-bottom: .5rem;
            display: none !important;
        }

        .side-img {
            background: #ffffffaa;
            border: 2px solid #d7eefc;
            border-radius: 16px;
            padding: 1rem;
            border-width: 2px;
            height: auto;
        }

        /* botones ✔ / ✖ */
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            text-decoration: none !important;
        }

        .btn-accept, .btn-cancel {
            text-decoration: none !important;
            width: 56px;
            height: 56px;
            border-radius: 12px;
            border: 2px solid #00000030;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            cursor: pointer;
            background: #fff;
            transition: transform .15s ease, box-shadow .15s ease;
        }

        .btn-accept {
            box-shadow: 0 3px 8px rgba(0,128,0,.15);
        }

            .btn-accept:hover, .btn-cancel:hover {
                transform: translateY(-2px);
            }

            .btn-accept i {
                color: #2E7D32;
            }

        .action-buttons .btn-accept i {
            color: #2E7D32 !important;
            font-size: 1.7rem;
        }

        .action-buttons .btn-cancel i {
            color: #D32F2F !important;
            font-size: 1.7rem;
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


        /* ===== Modales (Aulas / Cursos) ===== */
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
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Abrir / cerrar Historial
            const ovHistorial = document.getElementById('ovHistorial');
            document.getElementById('btnHistorial').addEventListener('click', () => {
                ovHistorial.classList.add('show');
                ovHistorial.setAttribute('aria-hidden', 'false');
            });
            document.getElementById('btnCloseHistorial').addEventListener('click', () => closeOv(ovHistorial));
            ovHistorial.addEventListener('click', (e) => { if (e.target === ovHistorial) closeOv(ovHistorial); });


            // ESC cierra cualquier overlay
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape') {
                    [ovHistorial].forEach(o => {
                        if (o.classList.contains('show')) closeOv(o);
                    });
                }
            });

            function closeOv(ov) {
                ov.classList.remove('show');
                ov.setAttribute('aria-hidden', 'true');
            }
        });

    </script>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid alumnos-container">

        <div class="toolbar mb-3">
            <div class="icon-bar">
                <!-- ACTIVO (Agregar) -->
                <button type="button" class="btn-icon btn-active" title="Consultar Alumno" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>
                <!-- INACTIVOS -->
                <button type="button" class="btn-icon btn-muted" title="Añadir Alumno">
                    <i class="fa-solid fa-user-graduate"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Editar Alumno" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Eliminar Alumno" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>

            <span class="header-cta">Consultar Alumno</span>
        </div>


        <!-- CONTENIDO -->
        <div class="card-form">
            <div class="row g-4">
                <div class="fieldset">
                    <div class="mb-2 row g-4 align-items-start">
                        <div class="col-7 ">
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Código Familia:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtCodigoFamilia" runat="server" CssClass="form-control input-disabled" ReadOnly="true" Text=""></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Nombre:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control input-disabled" ReadOnly="true" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Dni:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control input-disabled" ReadOnly="true" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Fecha Nacimiento:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control input-disabled" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="col-5 d-flex">
                            <div class="side-panel flex-fill flex-column justify-content-center">
                                <div class="text-center">
                                    <div class="side-title">Crear Familia</div>
                                    <div class="side-img">
                                        <asp:Image ID="imgEscudo" runat="server" ImageUrl="~/Images/escudo_colegio.png" AlternateText="Colegio" Style="max-width: 150px; max-height: 120px;" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mb-4 row align-items-center g-3">
                        <div class="col-7">
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Fecha Ingreso:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtFechaIngreso" runat="server" CssClass="form-control input-disabled" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Religión:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtReligion" runat="server" CssClass="form-control input-disabled" ReadOnly="true" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Género:</label>
                                </div>
                                <div class="col-md-8 align-content-md-center">
                                    <asp:TextBox ID="txtGenero" runat="server" CssClass="form-control input-disabled" ReadOnly="true" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Pensión base:</label>
                                </div>
                                <div class="col-md-8 align-content-md-center">
                                    <asp:TextBox ID="txtPension" runat="server" CssClass="form-control input-disabled" ReadOnly="true" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mb-2 row align-items-center g-3">
                        <div class="row">
                            <label class="form-label align-content-center">Observaciones:</label>
                        </div>
                        <div class="mb-0 row p-lg-3">
                            <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control input-disabled" ReadOnly="true" Multiline="True"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-actions mt-4 action-buttons mt-3">
                <!-- ✔ crear y volver FALTA AÑADIR EL GUARDADO-->
                <button type="button" id="btnHistorial" class="btn-flat">Historial</button>
                <!-- ✖ cancelar y volver -->
                <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-flat" OnClick="btnCancelar_Click" ToolTip="Cancelar y volver">
                        Salir
                </asp:LinkButton>
            </div>
        </div>

        <!-- HISTORIAL -->
        <div id="ovHistorial" class="overlay" aria-hidden="true">
            <div class="modal-box">
                <div class="modal-inner">

                    <!-- fila: tabla + logo (adentro del rectángulo gris) -->
                    <div class="modal-flex">
                        <div class="col-9">
                            <div class="mb-2 row">
                                <div class="col-md-3">
                                    <label class="form-label align-content-center">Nombre:</label>
                                </div>
                                <div class="col-9">
                                    <asp:TextBox ID="txtNombreModal" runat="server" CssClass="form-control" MaxLength="60" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="tabla-box mb-3 flex-grow-1">
                                <table class="table table-bordered table-hover align-middle mb-0">
                                    <thead class="table-header">
                                        <tr>
                                            <th>Año</th>
                                            <th>Grado Académico</th>
                                            <th>Aula</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="repGrados" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td><%# Eval("Anho") %></td>
                                                    <td><%# Eval("GradoAcademico") %></td>
                                                    <td><%# Eval("Aula") %></td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
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
                    <button type="button" id="btnCloseHistorial" class="btn-exit">Salir</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
