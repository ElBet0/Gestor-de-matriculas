<%@ Page Title="" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="EditarAlumno.aspx.cs" Inherits="FrontTA.Alumnos.EditarAlumno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Editar Alumno
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
            max-width: 300px;        /* límite razonable para pantallas grandes */
    min-width: 200px;        /* mantiene algo de consistencia */
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

    </style>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <div class="container-fluid alumnos-container">

        <div class="toolbar mb-3">
            <div class="icon-bar">
                <!-- ACTIVO (Agregar) -->
                <button type="button" class="btn-icon btn-active" title="Editar Alumno" disabled>
                    <i class="fa-solid fa-pen"></i>
                </button>
                <!-- INACTIVOS -->
                <button type="button" class="btn-icon btn-muted" title="Añadir Alumno">
                    <i class="fa-solid fa-user-graduate"></i>
                </button>
                <button type="button" class="btn-icon btn-muted" title="Consultar Alumno" disabled>
                    <i class="fa-solid fa-eye"></i>
                </button>
                
                <button type="button" class="btn-icon btn-muted" title="Eliminar Alumno" disabled>
                    <i class="fa-solid fa-trash"></i>
                </button>
            </div>

            <span class="header-cta">Editar Alumno</span>
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
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">DNI:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Fecha Nacimiento:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
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
                                    <asp:TextBox ID="txtFechaIngreso" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Religión:</label>
                                </div>
                                <div class="col-md-6 align-content-md-center">
                                    <asp:TextBox ID="txtReligion" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Género:</label>
                                </div>
                                <div class="col-md-8 align-content-md-center">
                                    <asp:DropDownList ID="ddlGenero" runat="server" CssClass="form-control">
                                        <asp:ListItem Text="Seleccionar..." Value="" />
                                        <asp:ListItem Text="Masculino" Value="TiempoCompleto" />
                                        <asp:ListItem Text="Femenino" Value="MedioTiempo" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="mb-2 row">
                                <div class="col-md-4 align-content-lg-center">
                                    <label class="form-label">Pensión base:</label>
                                </div>
                                <div class="col-md-8 align-content-md-center">
                                    <asp:TextBox ID="txtPension" runat="server" CssClass="form-control" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mb-2 row align-items-center g-3">
                        <div class="row">
                            <label class="form-label align-content-center">Observaciones:</label>
                        </div>
                        <div class="mb-0 row p-lg-3">
                            <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control align-content-center"  Multiline="True"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="action-buttons mt-3">
                <!-- ✔ crear y volver FALTA AÑADIR EL GUARDADO-->
                <asp:LinkButton ID="btnConfirmar" runat="server" CssClass="btn-accept" OnClick="btnConfirmar_Click" ToolTip="Crear y volver">
                        <i class="fa-solid fa-check"></i>
                </asp:LinkButton>
                <!-- ✖ cancelar y volver -->
                <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-cancel" OnClick="btnCancelar_Click" ToolTip="Cancelar y volver">
                        <i class="fa-solid fa-xmark"></i>
                </asp:LinkButton>
            </div>
        </div>
    </div>

</asp:Content>