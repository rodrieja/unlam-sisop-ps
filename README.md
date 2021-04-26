# PowerShell
## Guia téorica y práctica sobre PowerShell
### Sistemas Operativos
Última revisión Abril 2021

# 
# Contenido
  - [Introducción](#introducción)
  - [Instalar PowerShell Core](#instalar-powershell-core)
    - [Linux](#linux)
    - [Windows](#windows)
    - [Mac](#mac)
    - [Visual Studio Code con PowerShell](#visual-studio-code-con-powershell)
  - [Consola](#consola)
  - [Comandos en PowerShell](#comandos-en-powershell)
  - [PowerShell pipeline](#powershell-pipeline)
  - [Filtrado de resultados](#filtrado-de-resultados)
    - [Por registros](#por-registros)
    - [Por columnas](#por-columnas)
  - [Sintaxis de scripts](#sintaxis-de-scripts)
    - [Variables](#variables)
    - [Uso de comillas](#uso-de-comillas)
    - [Comentarios](#comentarios)
    - [Condiciones y ciclos](#condiciones-y-ciclos)
    - [Funciones](#funciones)
    - [Parámetros](#parámetros)
    - [Opciones de parámetros](#opciones-de-parámetros)
    - [Estructura de las funciones](#estructura-de-las-funciones)
    - [Colecciones](#colecciones)
    - [Listas](#listas)
    - [Hast Tables](#hast-tables)
    - [Manejo de eventos](#manejo-de-eventos)
    - [Scopes](#scopes)
  - [Uso de la Ayuda](#uso-de-la-ayuda)

#
# Introducción
## ¿Qué es PowerShell?
PowerShell es una solución de automatización de tareas multiplataforma formada por un shell de línea de comandos, un lenguaje de scripting y un marco de administración de configuración. PowerShell funciona en Windows 10, Linux y macOS.

A lo largo de los años ha habido muchas versiones de PowerShell. Inicialmente, Windows PowerShell se compiló en .NET Framework y solo funcionaba en los sistemas Windows. Con la versión actual, PowerShell usa .NET 5.0 como entorno de ejecución.
## Shell
PowerShell es un shell de comandos moderno que incluye las mejores características de otros shells populares. A diferencia de la mayoría de los shells que solo aceptan y devuelven texto, PowerShell acepta y devuelve objetos .NET. El shell incluye las siguientes características:
* Un historial de línea de comandos sólido.
* Finalización con tabulación y predicción de comandos (vea about_PSReadLine).
* Admite alias de comando y parámetro.
* Canalización para encadenar comandos.
* Sistema de ayuda en la consola, similar a las páginas man de UNIX.

## Lenguaje de scripting
Como lenguaje de scripting, PowerShell se usa normalmente para automatizar la administración de sistemas. También se usa para compilar, probar e implementar soluciones, a menudo en entornos de CI/CD. PowerShell se basa en .NET Common Language Runtime (CLR). Todas las entradas y salidas son objetos de .NET. No es necesario analizar la salida de texto para extraer información de la salida. El lenguaje de scripting de PowerShell incluye las siguientes características:
  * Extensible mediante funciones, clases, [scripts](https://docs.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_scripts) y módulos.
  * [Sistema de formato](https://docs.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_format.ps1xml) extensible para una salida fácil.
  * [Sistema de tipos](https://docs.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_types.ps1xml) extensible para crear tipos dinámicos.
  * Compatibilidad integrada con formatos de datos comunes, como [CSV](https://docs.microsoft.com/es-es/powershell/module/microsoft.powershell.utility/convertfrom-csv), [JSON](https://docs.microsoft.com/es-es/powershell/module/microsoft.powershell.utility/convertfrom-json) y [XML](https://docs.microsoft.com/es-es/powershell/module/microsoft.powershell.utility/convertto-xml).

## Administración de configuración 
Desired State Configuration ([DSC](https://docs.microsoft.com/es-es/powershell/scripting/dsc/overview/dscforengineers)) de PowerShell es un marco de administración en PowerShell que permite administrar la infraestructura empresarial con configuración como código. Con DSC, puede:
Crear configuraciones declarativas y scripts personalizados para implementaciones repetibles.
Aplicar valores de configuración e informar sobre el desplazamiento de configuración.
Implementar la configuración mediante los modelos de [inserción o extracción](https://docs.microsoft.com/es-es/powershell/scripting/dsc/pull-server/enactingconfigurations).

Fuente: Windows PowerShell - [Microsoft docs](https://docs.microsoft.com/es-ES/powershell/scripting/overview?view=powershell-7.1&source=docs)

#
# Instalar PowerShell Core
Para la creación y prueba de los scripts utilizaremos la versión 7.0 LTS de PowerShell, debido a que es compatible con Net Core. La última versión disponible a la fecha es 7.1 y se recomienda tener actualizado el sistema a la última versión.
## Windows
Por defecto con Windows 10 se encuentra instalada la versión 6.0 de PS Core. Verifique la versión que dispone y en caso de ser necesario siga los pasos de la 
[guía de instalación oficial](https://docs.microsoft.com/es-mx/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7.1).

Para instalar PowerShell en Windows, descargue el [paquete de instalación más reciente](https://aka.ms/powershell-release?tag=stable) de GitHub.
## Linux
PowerShell se encuentra disponible para las principales [distros de Linux](https://docs.microsoft.com/es-mx/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7.1).
A modo de ejemplo, a continuación enumeramos los pasos necesarios para instalarlo en Ubuntu.
### Instalación mediante un repositorio de paquetes, Ubuntu
```bash
# Update the list of packages
sudo apt-get update
# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb
# Update the list of packages after we added packages.microsoft.com
sudo apt-get update
# Install PowerShell
sudo apt-get install -y powershell
# Start PowerShell
pwsh
```
### Desinstalación
```bash 
sudo apt-get remove powershell
```

## Mac
PowerShell 7.0 o posteriores requiere macOS 10.13 y versiones posteriores. Una vez instalado el paquete, ejecute `pwsh` desde un terminal.

Existen varias maneras de [instalar PowerShell en macOS](https://docs.microsoft.com/es-mx/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-7.1):
  * Realice la instalación mediante Homebrew. [Homebrew](https://brew.sh/) es el administrador de paquetes preferido de macOS.
  * Realice la instalación de PowerShell mediante [descarga directa](https://docs.microsoft.com/es-mx/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-7.1#installation-via-direct-download).
  * Realice la instalación a partir de [archivos binarios](https://docs.microsoft.com/es-mx/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-7.1#binary-archives).

Después de instalar PowerShell, debe instalar [OpenSSL](https://docs.microsoft.com/es-mx/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-7.1#installing-dependencies). OpenSSL se necesita para la comunicación remota de PowerShell y las operaciones de CIM.

### Instalación de la versión estable más reciente a través de Homebrew en macOS 10.13 o posterior (Recomendado)
```
brew install --cask powershell
```
Cuando se publiquen nuevas versiones de PowerShell, actualice PowerShell y las fórmulas de Homebrew:
```
brew update
brew upgrade powershell --cask
```

## Visual Studio Code con PowerShell
# Consola
# PowerShell pipeline
# Filtrado de resultados
## Por registros
## Por columnas
# Sintaxis de scripts
## Variables
## Uso de comillas
## Comentarios
## Condiciones y ciclos
## Funciones
## Parámetros
## Opciones de parámetros
## Estructura de las funciones
## Colecciones
## Listas
## Hast Tables
## Manejo de eventos
## Scopes
# Uso de la Ayuda
