# Manual de Despliegue de Infraestructura en AWS

Este documento detalla el procedimiento técnico para el despliegue de la solución en un entorno de producción utilizando Amazon Web Services (AWS). La arquitectura se compone de una base de datos relacional (RDS) y un servidor de aplicaciones alojado en una instancia EC2 con Windows Server.

## Tabla de Contenidos
   [Requisitos Previos](#requisitos-previos)
1. [Aprovisionamiento de Infraestructura (EC2)](#1-aprovisionamiento-de-infraestructura-ec2)
2. [Configuración del Entorno de Ejecución](#2-configuración-del-entorno-de-ejecución)
3. [Despliegue del Backend (GlassFish)](#3-despliegue-del-backend-glassfish)
4. [Despliegue del Frontend (IIS)](#4-despliegue-del-frontend-iis)
5. [Verificación y Acceso](#5-verificación-y-acceso)

---

## Requisitos Previos

Antes de iniciar el despliegue, asegúrese de disponer de los siguientes recursos en la máquina local para su transferencia al servidor:

* **Java Development Kit (JDK):** Versión 24.0.2.
* **Servidor de Aplicaciones:** GlassFish 7.0.25.
* **Framework:** .NET Framework 4.8.1 (Runtime y Developer Pack).
* **Artefactos de Software:** Archivo `.war` (Backend) y carpeta publicada del sitio web (Frontend).

---

## 1. Aprovisionamiento de Infraestructura (EC2)

### 1.1. Lanzamiento de la Instancia
En la consola de AWS, inicie una nueva instancia con las siguientes especificaciones:

* **Nombre:** Servidor Web
* **Imagen de Máquina (AMI):** Microsoft Windows Server 2025 Base
* **Tipo de Instancia:** t3.medium
* **Almacenamiento:** Predeterminado (gp3)

### 1.2. Seguridad y Acceso
1.  **Par de Claves:** Cree un nuevo par de claves tipo **RSA** en formato **.pem** con el nombre `llaves servidor web`.
2.  **Grupos de Seguridad:**
    * Asegúrese de que el tráfico RDP (Puerto 3389) esté permitido.
    * Agregue una regla personalizada para permitir tráfico TCP por el puerto **8080** (GlassFish) y puerto **80** (IIS) desde `0.0.0.0/0` (Anywhere).

### 1.3. Conexión
1.  Descargue el archivo de conexión a Escritorio Remoto.
2.  Utilice el archivo `.pem` generado para descifrar la contraseña de administrador.
3.  Conéctese a la instancia mediante RDP.

---

## 2. Configuración del Entorno de Ejecución

### 2.1. Instalación de Java y GlassFish
1.  Copie los instaladores a la instancia EC2.
2.  Instale el JDK 24.0.2 en la ruta por defecto (`C:\Program Files\Java\jdk-24`).
3.  Descomprima el archivo de GlassFish y ubique la carpeta en la raíz `C:\glassfish7`.

### 2.2. Configuración de Variables de Entorno
Es necesario vincular GlassFish con la instalación de Java.

1.  Navegue a `C:\glassfish7\glassfish\config\`.
2.  Edite el archivo `asenv.bat` (clic derecho -> Editar).
3.  Agregue la siguiente línea al final del archivo:
    ```bat
    set AS_JAVA=C:\Program Files\Java\jdk-24
    ```

### 2.3. Inicio del Servicio
1.  Abra el Símbolo del sistema (CMD) con privilegios de administrador.
2.  Ejecute los siguientes comandos:
    ```cmd
    cd C:\glassfish7\bin
    asadmin start-domain
    ```

---

## 3. Despliegue del Backend (GlassFish)

1.  Transfiera el archivo `.war` generado por el equipo de desarrollo a la instancia.
2.  Desde la terminal ubicada en `C:\glassfish7\bin`, ejecute el comando de despliegue:
    ```cmd
    asadmin deploy "C:\Ruta\Al\Archivo.war"
    ```
3.  **Configuración de Firewall de Windows:**
    * Abra "Windows Defender Firewall with Advanced Security".
    * Cree una nueva "Inbound Rule" para el puerto **8080 (TCP)**.
    * Nombre la regla como `GlassFish Web`.

---

## 4. Despliegue del Frontend (IIS)

### 4.1. Instalación de Roles
1.  En el **Server Manager**, seleccione **Add roles and features**.
2.  Instale el rol **Web Server (IIS)**.
3.  En la sección de características, asegúrese de habilitar:
    * .NET Framework 4.8 Features > ASP.NET 4.8.
    * WCF Services (HTTP Activation, TCP Port Sharing).

### 4.2. Publicación y Configuración del Sitio
1.  **Transferencia de Archivos:** Copie la carpeta del sitio web publicado (ej. `SisProgSite`) a la ruta `C:\inetpub\wwwroot\`.
2.  **Configuración en IIS Manager:**
    * Abra el **Internet Information Services (IIS) Manager**.
    * En el panel de conexiones, haga clic derecho sobre **Sites** y seleccione **Add Website**.
    * Configure los siguientes parámetros:
        * **Site name:** SisProgSite
        * **Physical path:** `C:\inetpub\wwwroot\SisProgSite`
        * **Port:** 80 (o el puerto configurado en su arquitectura).
    * Haga clic en **OK** para iniciar el sitio.

---

## 5. Verificación y Acceso

Una vez completados los pasos anteriores, la aplicación estará operativa.

### Pruebas de Conectividad

* **Prueba Local (desde el servidor):**
    ```
    http://localhost:8080/Login.aspx
    ```

* **Acceso Público (desde internet):**
    Utilice la dirección IPv4 pública asignada a la instancia EC2:
    ```
    http://[IP_PUBLICA_EC2]:8080/Paginaweb.aspx
    ```

> **Nota:** Si detiene y vuelve a iniciar la instancia, la dirección IP pública cambiará a menos que utilice una Elastic IP. Verifique siempre la IP actual en la consola de AWS.
