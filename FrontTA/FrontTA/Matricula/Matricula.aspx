<%@ Page Title="Matrícula" Language="C#" MasterPageFile="~/SoftProg.Master"
    AutoEventWireup="true" CodeBehind="Matricula.aspx.cs"
    Inherits="FrontTA.Matricula.Matricula" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Matrícula
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --blanco: #FFFFFF;
            --negro: #000;
        }

        /* FILA única por año */
        .matri-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            background: #f3f3f3;
            border: 1px solid #d7d7d7;
            border-radius: 16px;
            padding: 14px 18px;
            box-shadow: 0 4px 10px rgba(0,0,0,.15);
            margin-bottom: 16px;
        }

        /* Bloque izquierdo: año + texto + “cifra” gris */
        .matri-left {
            display: flex;
            align-items: center;
            gap: 18px;
            min-width: 0;
        }

        .year-badge {
            min-width: 120px;
            height: 70px;
            border-radius: 14px;
            background: #e9e9e9;
            border: 2px solid #bdbdbd;
            font-weight: 800;
            font-size: 2rem;
            color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: inset 0 0 0 3px #e5e5e5, 0 6px 8px rgba(0,0,0,.15);
        }

        .matri-title {
            font-weight: 800;
            font-size: 1.45rem;
            color: #333;
            white-space: nowrap;
        }

        .count-pill {
            display: inline-block;
            width: 220px;
            height: 44px;
            border-radius: 12px;
            background: #c9c9c9;
            border: 2px solid #8f8f8f;
            box-shadow: inset 0 2px 2px rgba(0,0,0,.05);
        }

        /* Bloque derecho: Reporte + Acción */
        .matri-right {
            display: flex;
            align-items: center;
            gap: .75rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: .5rem;
            padding: .6rem 1rem;
            border-radius: 12px;
            font-weight: 800;
            text-decoration: none;
            border: 2px solid transparent;
            box-shadow: 0 6px 8px rgba(0,0,0,.15);
        }
        /* Reporte */
        .btn-report {
            background: var(--blanco);
            color: var(--verdeOsc);
            border-color: var(--verdeOsc);
        }

            .btn-report:hover {
                background: var(--verde);
                color: #fff;
            }

        /* Acción */
        .btn-green {
            background: var(--verdeOsc);
            color: #fff;
            border-color: #0f571a;
        }

            .btn-green:hover {
                background: #0f571a;
                color: #fff;
            }

        .btn-gray {
            background: #e6e6e6;
            color: #222;
            border-color: #bdbdbd;
        }

            .btn-gray:hover {
                background: #dbdbdb;
                color: #111;
            }

        /* Icono */
        .btn i {
            font-size: 1.1rem;
        }

    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
    <asp:Repeater ID="rptAnios" runat="server"
        OnItemDataBound="rptAnios_ItemDataBound"
        OnItemCommand="rptAnios_ItemCommand">

        <ItemTemplate>
            <div class="matri-row">
                <!-- IZQUIERDA -->
                <div class="matri-left">
                    <div class="year-badge"><%# Eval("Anio") %></div>
                    <div class="matri-title">Alumnos Matriculados</div>
                    
                    <span class="count-pill" title="Cantidad (ejemplo)"></span>
                </div>

                <!-- DERECHA -->
                <div class="matri-right">
                    <asp:HyperLink ID="lnkReporte" runat="server" CssClass="btn btn-report" ToolTip="Reporte por año">
                        <i class="fa-solid fa-clipboard-list"></i><span>Reporte</span>
                    </asp:HyperLink>

                    <asp:LinkButton ID="btnAccion" runat="server" CssClass="btn"
                        CommandName="abrir" CommandArgument='<%# Eval("Anio") %>'>
                        <i class="fa-solid fa-user-plus"></i><span>Acción</span>
                    </asp:LinkButton>

                    <asp:HiddenField ID="hfEsVigente" runat="server" Value='<%# Eval("EsVigente") %>' />
                </div>
            </div>
        </ItemTemplate>

    </asp:Repeater>
</asp:Content>
