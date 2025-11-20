<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/SoftProg.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="FrontTA.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_Title" runat="server">
    Colegio Rafael Mariscal Quintanilla - Inicio
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cph_Scripts" runat="server">
    <style>
        /* --- COLORES ---  ACTUALIZADO 14/11/2025 */
        :root {
            --verde: #74D569;
            --blanco: #FFFFFF;
            --gris: #E1E1E1;
            --negro: #000000;
            --rojo: #FC0200;
            --amarillo: #FCD404;
        }

        .home-container {
            background: var(--gris);
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,.05);
        }

        .bienvenido {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--negro);
            text-align: center;
            margin-bottom: 2rem;
        }

        .matricula-card {
            background: var(--verde);
            border-radius: 1.2rem;
            color: var(--blanco);
            padding: 1.5rem;
            height: 100%;  
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .matricula-card h2 {
            font-weight: 800;
            color: var(--amarillo);
        }

        .matricula-card h4 {
            font-weight: 700;
            color: var(--blanco);
        }

        .matricula-card ul {
            margin: 0;
            padding-left: 1rem;
        }

        .matricula-card li {
            list-style-type: disc;
            font-size: .95rem;
        }

        .contacto-box {
            background: var(--blanco);
            border: 2px solid var(--verde);
            border-radius: 10px;
            padding: .75rem 1rem;
            text-align: center;
            font-weight: 600;
            color: var(--verde);
            margin-top: 1rem;
        }

        .contacto-box i {
            color: var(--verde);
            margin-right: .4rem;
        }


        .home-logo {
            display: block;
            margin: 0 auto; 
            width: 300px; 
            height: auto;
        }

        /* Alto del lienzo. Ajusta  calc(...) según el alto de tu topbar/márgenes */
        .content-viewport {
            height: calc(100vh - 170px);
        }

        .equal-row {
            height: 100%;
        }

            .equal-row > [class*="col-"] {
                height: 100%;
            }

        /* Contenedor de la foto a la MISMA altura que la tarjeta */
        .foto-wrap {
            position: relative;
            height: 100%;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 3px 8px rgba(0,0,0,.15);
            background: #ccc; /* fallback mientras carga */
        }

        /* La imagen llena todo el alto y ancho del contenedor sin deformarse */
        .foto-alumnos {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover; /* clave: llena y recorta si hace falta */
        }

    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cph_Contenido" runat="server">
   <div class="home-container">
    <h1 class="bienvenido">¡BIENVENIDO!</h1>

    <!-- Alto controlado por viewport -->
    <div class="content-viewport">
        <div class="row g-4 equal-row">
            <!-- Izquierda: MATRÍCULA -->
            <div class="col-md-6 d-flex">
                <div class="matricula-card w-100">
                    <div>
                        <asp:Image ID="imgLogoHome" runat="server"
                            ImageUrl="~/Images/escudo_colegio.png"
                            AlternateText="IEP Logo"
                            CssClass="home-logo mb-3" />
                        <h2>2024 MATRÍCULA</h2>
                        <h4>(Inicial - Primaria - Secundaria)</h4>
                        <p class="mt-3 mb-2" style="font-size: .9rem;">
                            “Cree en ti mismo y en lo que eres. Sé consciente de que hay algo en tu interior que es más grande que cualquier obstáculo”.
                        </p>
                        <ul>
                            <li>Personal Docente Calificado.</li>
                            <li>Talleres de Ciencia.</li>
                            <li>Aulas Inteligentes.</li>
                            <li>Formación Científica Humanista.</li>
                            <li>Departamento Psicopedagógico permanente.</li>
                            <li>Sólida Formación en Valores.</li>
                        </ul>
                    </div>

                    <!-- Contactos -->
                    <div class="contacto-box">
                        <span><i class="fa-solid fa-phone"></i> 01-3022991 | 955440308</span><br />
                        <span><i class="fa-solid fa-location-dot"></i> Los Queros 7410 - Independencia</span>
                    </div>
                </div>
            </div>

            <!-- Derecha: FOTO (misma altura) -->
            <div class="col-md-6 d-flex">
                <div class="foto-wrap w-100">
                    <asp:Image ID="imgAlumnos" runat="server"
                        ImageUrl="~/Images/alumnos.png"
                        AlternateText="Alumnos"
                        CssClass="foto-alumnos" />
                </div>
            </div>
        </div>
    </div>
</div>

</asp:Content>
