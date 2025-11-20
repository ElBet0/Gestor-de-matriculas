<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FrontTA.Login" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <title>Inicio de Sesión - IEP Rafael Mariscal Quintanilla</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Fonts/css/all.css" rel="stylesheet" />

    <style>
        :root {
            --verde: #74D569;
            --verdeOsc: #016A13;
            --gris: #E1E1E1;
            --blanco: #FFFFFF;
            --negro: #000000;
            --amarillo: #FCD404;
            --logo-size: 300px;
        }

        html, body {
            height: 100%;
            margin: 0;
            background: var(--blanco);
            font-family: 'Segoe UI', sans-serif;
        }

        .login-container {
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* Izquierda (más angosta y pegada al borde) */
        .login-left {
            flex: 0 0 28%;
            background: var(--blanco);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 2rem 2rem 2rem 1.25rem;
            box-shadow: 4px 0 12px rgba(0,0,0,.08);
        }

            .login-left img {
                width: var(--logo-size);
                height: auto;
                margin-bottom: 2rem;
            }

        .login-title {
            font-weight: 600;
            font-size: 1.15rem;
            margin-bottom: 1.5rem;
            color: var(--negro);
        }

        /* formulario alineado a la izquierda y angosto */
        .login-form {
            width: 100%;
            max-width: 320px;
        }

            .login-form .input-group {
                margin-bottom: 1rem;
            }

        .form-control {
            border-radius: .5rem;
            border: 1px solid var(--gris);
            padding: .6rem .75rem;
        }

        .btn-login {
            background: var(--verdeOsc);
            color: var(--blanco);
            width: 100%;
            padding: .6rem;
            font-weight: 600;
            border-radius: .5rem;
            border: none;
        }

            .btn-login:hover {
                background: var(--verde);
                color: var(--negro);
            }

        /* Derecha  */
        .login-right {
            flex: 1 1 100%;
            background: url('Images/ImagenInicial.png') center center / cover no-repeat;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <!-- Panel Izquierdo -->
            <div class="login-left">
                <img src="Images/escudo_colegio.png" alt="Logo Colegio" />
                <div class="login-title">IEP Rafael Mariscal Quintanilla</div>

                <div class="login-form">
                    <div class="input-group mb-3">
                        <span class="input-group-text">
                            <i class="fa-solid fa-user"></i>
                        </span>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="Usuario"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                        <span class="input-group-text">
                            <i class="fa-solid fa-lock"></i>
                        </span>

                        <asp:TextBox ID="txtClave" runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            placeholder="Contraseña"></asp:TextBox>

                        
                        <span class="input-group-text" style="cursor: pointer;" id="btnVerClave">
                            <i class="fa-solid fa-eye" id="iconoClave"></i>
                        </span>
                    </div>

                    <asp:Button ID="btnIngresar" runat="server" Text="INGRESAR" CssClass="btn-login" OnClick="btnIngresar_Click" />
                    <asp:Label ID="lblMensaje" runat="server"
                        ForeColor="Red"
                        Font-Bold="true"
                        Font-Size="X-Large"
                        Visible="false"></asp:Label>
                </div>
            </div>

            <!-- Panel Derecho -->
            <div class="login-right"></div>
        </div>
    </form>
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const txtClave = document.getElementById("<%= txtClave.ClientID %>");
        const btnVer = document.getElementById("btnVerClave");
        const icono = document.getElementById("iconoClave");

        btnVer.addEventListener("click", function () {
            if (txtClave.type === "password") {
                txtClave.type = "text";
                icono.classList.remove("fa-eye");
                icono.classList.add("fa-eye-slash");
            } else {
                txtClave.type = "password";
                icono.classList.remove("fa-eye-slash");
                icono.classList.add("fa-eye");
            }
        });
    });
    </script>
</body>
</html>
