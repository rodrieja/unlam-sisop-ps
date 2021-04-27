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
  - [IDE](#ide)
    - [Windows PowerShell ISE](#windows-powershell-ise)
    - [Visual Studio Code (Recomendado)](#visual-studio-code-recomendado)
  - [CLI](#cli)
    - [cmdlets en PowerShell](#cmdlets-en-powerShell)
    - [Algunos ejemplos](#algunos-ejemplos)
  - [PowerShell pipeline](#powershell-pipeline)
  - [Filtrado de resultados](#filtrado-de-resultados)
    - [Por registros](#por-registros)
    - [Por columnas](#por-columnas)
  - [Sintaxis de los scripts](#sintaxis-de-los-scripts)
    - [Variables](#variables)
    - [Uso de comillas](#uso-de-comillas)
    - [Comentarios](#comentarios)
    - [Condiciones y ciclos](#condiciones-y-ciclos)
    - [Funciones](#funciones)
    - [Parámetros](#parámetros)
    - [Opciones de parámetros](#opciones-de-parámetros)
    - [ParameterSets (Conjunto de parámetros)](#parametersets-conjunto-de-parámetros)
    - [Estructura de las funciones](#estructura-de-las-funciones)
    - [Colecciones](#colecciones)
      - [Listas](#listas)
      - [Hast Tables](#hast-tables)
  - [Manejo de eventos](#manejo-de-eventos)
  - [Scopes](#scopes)
  - [Manejo de Errores](#manejo-de-errores)
  - [Sección Ayuda](#sección-ayuda)
  - [Cmdlets frecuentes](#cmdlets-frecuentes)
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

#
# IDE
Si bien el desarrollo de los scripts se puede realizar en cualquier editor de texto, los siguientes IDEs son los recomendados para ser utilizados cuando trabajamos con PowerShell.
## Windows PowerShell ISE
Windows PowerShell Integrated Scripting Environment (ISE) es una aplicación host de Windows PowerShell. En el ISE, puede ejecutar comandos y escribir, probar y depurar scripts en una única interfaz gráfica de usuario basada en Windows. El ISE proporciona edición de varias líneas, finalización con tabulación, color de sintaxis, ejecución selectiva, ayuda contextual y compatibilidad con idiomas de derecha a izquierda.
### Para iniciar Windows PowerShell ISE
Haga clic en Inicio , seleccione Windows PowerShell y, después, haga clic en Windows PowerShell ISE. Como alternativa, puede escribir powershell_ise.exe en cualquier shell de comandos o en el cuadro Ejecutar.
## Visual Studio Code (Recomendado)
[Visual Studio Code](https://code.visualstudio.com/) es un editor de scripts multiplataforma de Microsoft. Junto con la [extensión de PowerShell](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell), proporciona una experiencia de edición de scripts enriquecida e interactiva que facilita la escritura de scripts confiables de PowerShell. Visual Studio Code con la extensión de PowerShell es el editor recomendado para escribir scripts de PowerShell.

![VS Code extension](https://docs.microsoft.com/es-mx/powershell/docs-conceptual/dev-cross-plat/vscode/media/using-vscode/vscode.png?view=powershell-7.1)

# CLI
Al igual que sucede con Bash, PowerShell (PS) hace uso de un interprete y desde el mismo se pueden ejecutar tres tipos de comandos: 
  * cmdlets 
  * scripts
  * programas ejecutables (binarios)
## cmdlets en PowerShell
Un cmdlet es un comando único que participa en la semántica de canalización de PowerShell y, normalmente, devuelve un objeto .NET. Los cmdlets son comandos de PowerShell nativos, no ejecutables independientes. Los cmdlets se recopilan en módulos de PowerShell que se pueden cargar a petición. Los cmdlets se pueden escribir en cualquier lenguaje .NET compilado o en el mismo lenguaje de scripting de PowerShell.

Teniendo en cuenta que PowerShell está pensado como una herramienta de administración de sistemas, muchos de los comandos pueden ser ejecutados de manera remota en otra computadora, normalmente con el parámetro -ComputerName.

Teniendo en cuenta que la administración de servidores tiene una larga historia en el mundo Unix, existe una serie de [alias](https://docs.microsoft.com/es-es/powershell/scripting/samples/appendix-1---compatibility-aliases?view=powershell-7.1) que remiten a los comandos más utilizados en esos entornos. Adicionalmente, cada usuario puede crear su lote de alias para mejorar su experiencia. 

## Nombres de cmdlets
PowerShell usa un par de términos verbo-nombre para asignar nombres a los cmdlets. Por ejemplo, el cmdlet Get-Command incluido en PowerShell se usa para obtener todos los cmdlets que están registrados en el shell de comandos. El verbo identifica la acción que realiza el cmdlet y el nombre identifica el recurso en el que el cmdlet realiza la acción.

A diferencia de los comandos de otros shells, los cmdlets tienen las siguientes características:
  * Son instancias de clases de .NET.
  * Generalmente no manejan su propia salida de datos, ya sea la salida por pantalla o la salida de error. Estas tareas las maneja el mismo PowerShell.
  * Procesan objetos como entrada en vez de texto, y normalmente también devuelven objetos. 
  * Normalmente, la salida de un cmdlet, es la entrada de otro. Para pasar la salida de un cmdlet como entrada de otro se usa el símbolo “|”.

## Algunos ejemplos
A continuación, se mencionan y explican algunos de los cmdlets más comunes.

```powershell
# Muestra un listado de todos los cmdlets que se encuentran disponibles para usar.
Get-Command 

# Muestra la ayuda de un cmdlet. Ejemplo:
Get-Help

# Muestra la ayuda de Get-Command
Get-Help Get-Command

# Muestra la ayuda detallada de Get-ChildItem
Get-Help Get-ChildItem -detailed

# Muestra la ayuda de Select-String en Internet
Get-Help Select-String -online

# Actualiza la ayuda.
Update-Help

# Muestra las propiedades, métodos y eventos de un tipo de objeto. Ejemplo de uso:
Get-Member

# En este caso mostrará información acerca de las clases System.IO.DirectoryInfo y System.IO.FileInfo, que son los tipos de objetos que devuelve Get-ChildItem.
Get-ChildItem | Get-Member

# Muestra el contenido de un directorio.
Get-ChildItem

# Muestra los procesos que están corriendo actualmente en el sistema.
Get-Process

# Muestra contadores de performance (uso de la red, uso del procesador, uso de memoria, etc.) del equipo local o de un equipo remoto.
Get-Counter

# Hace una pausa de 10 segundos.
Start-Sleep -Seconds 10

# Muestra un mensaje por pantalla.
Write-Output

# Lee una línea de entrada de la consola. 
Read-Host

# Termina el script actual o la sesión de PowerShell.
Exit

# Obtiene un objeto con la información del host. Con este objeto se puede verificar la versión de PowerShell.
Get-host
```

#
# PowerShell pipeline
El pipeline actúa como una serie de segmentos de canalización conectados. Los elementos que se mueven por el pipeline pasan a través de cada segmento. Para crear una canalización en PowerShell, se conectan comandos con el operador "|". La salida de cada comando se usa como entrada para el siguiente.

La notación utilizada es similar a la notación utilizada en otros shells. A primera vista, puede que no sea evidente en qué se diferencia de otros shells, pero el pipeline en PowerShell, aunque muestre texto, en realidad está enviando objetos por el pipeline entre los comandos.

Para evidenciar esto utilizaremos el cmdlet Get-Member, el cual muestra la estructura de la salida del comando:

```powershell
Get-Location | Get-Member

   TypeName: System.Management.Automation.PathInfo

Name         MemberType Definition
----         ---------- ----------
Equals       Method     bool Equals(System.Object obj)
GetHashCode  Method     int GetHashCode()
GetType      Method     type GetType()
ToString     Method     string ToString()
Drive        Property   System.Management.Automation.PSDriveInfo Drive {get;}
Path         Property   string Path {get;}
Provider     Property   System.Management.Automation.ProviderInfo Provider {get;}
ProviderPath Property   string ProviderPath {get;}
```

#
# Filtrado de resultados
Si bien existen muchos cmdlets que definen la opción de filtrado por alguna condición, utilizando el pipeline podemos realizar filtros sobre los resultados obtenidos, tanto en cantidad de registros, como en campos/columnas obtenidos.

```powershell
Get-ChildItem -Filter "*pdf" -Recurse
```

El cmdlet `Get-ChildItem` define el parámetro `-Filter` el cual filtrará los archivos que cumplan con la condición de finalizar el pdf.

## Por registros
Para realizar el filtro de los resultados por registros o filas, utilizaremos el cmdlet Where-Object, al cual le indicaremos una condición por la cual realizar el filtrado. Esta condición se evaluará registro a registro y producirá un resultado acorde.

```powershell
Get-Process | Where-Object ProcessName -Match “^p.*”
Get-Process | Where-Object {$_.WorkingSet -gt 25000}
```

El cmdlet `Get-Process` devuelve la información de los procesos que están en ejecución, en una lista de objetos de tipo `System.Diagnostics.Process`. El siguiente cmdlet, recibe por el pipeline esta lista de objetos y realiza las siguiente acciones:
  1. Define una expresión regular que se debe cumplir a través de `-Match`. En este caso devolverá todos los objetos cuyo `Property ProcessName` empiece con la letra **p** y luego lo siga cualquier carácter
  2. En este caso es filtrarán los procesos donde su `Property WorkingSet` (Memoria física) sea mayor a (gt) 25000 bytes.

## Por columnas
Para realizar el filtro de los resultados por registros o filas, utilizaremos el cmdlet `Select-Object`, al cual le indicaremos una condición por la cual realizar el filtrado. Esta condición se evaluará registro a registro y producirá un resultado acorde.

```powershell
# (WS = working set = memoria)
Get-Process | Select-Object -Property ProcessName, Id, WS
```

En este caso se seleccionan las Propiedades ProcessName, Id y WS. Los valores a utilizar se pueden obtener como ya vimos previamente con el cmdlet Get-Member

#
# Sintaxis de los scripts
## Variables
PowerShell soporta el uso de variables en scripts. Todos los nombres de variables empiezan con el signo \$, pueden ser dinámicas o de un tipo específico y no son case sensitive (al igual que todos los comandos).

Las variables pertenecen al ámbito en donde fueron declaradas. Esto quiere decir que si se declara una variable dentro de una función, sólo será accesible dentro de ella.

Las siguientes son variables propias de PowerShell:

| Variable        | Contiene                                                                         |
| --------------- | -------------------------------------------------------------------------------- |
| $_              | Objeto proveniente del pipeline                                                  |
| $Args           | Array que contiene cada uno de los parámetros pasados                            |
| $?              | Estado del último comando ejecutado. True si fue exitoso, False en caso de error |
| $False          | Valor booleano False                                                             |
| $True           | Constante True                                                                   |
| $Null           | Constante Null                                                                   |
| $PSVersionTable | Versión de PowerShell                                                            |
| $Pwd            | Path actual                                                                      |
| $Errors         | Array con los últimos errores, siendo $Error[0] el más reciente                  |


```powershell
Write-Output ('Primer parámetro: ' + $Args[0])
Write-Output ('Último parámetro: ' + $Args[-1])
Write-Output ('Cantidad de argumentos: ' + $Args.Count) 

Primer parámetro: param1
Último parámetro: param3
Cantidad de argumentos: 3 
```

## Uso de comillas
Es importante señalar que, al momento de trabajar con texto, el uso de las comillas varía dependiendo del comportamiento que se espera. Existen 3 tipos de comillas a utilizar: las comillas dobles (“), comillas simples (‘) y acento grave o francés (\`).

  * Las comillas dobles, también denominadas comillas débiles, permiten utilizar texto e interpretar variables al mismo tiempo.
  * Las comillas simples, también denominadas comillas fuertes, generan que el texto delimitado entre ellas se utilice de forma literal, lo que evita que se interpreten las variables.
  * El acento grave, es el carácter de escape para evitar la interpretación de los caracteres especiales, como por ejemplo el símbolo \$.

```powershell
$version = Get-Host | Select version
Write-Output "la versión de PS es: $version"
Write-Output 'la versión de PS es: $version'
Write-Output "la versión de PS es: `$version" 

la versión de PS es: @{Version=7.1.3}
la versión de PS es: $version
la versión de PS es: $version
```

## Comentarios
Para la utilización de comentarios dentro del código tenemos 2 opciones, los comentarios de línea o los de múltiples líneas:

```powershell
# Comentario Simple

<# 
  Comentario
  Multi
  Línea
#> 
```
## Condiciones y ciclos
Las estructuras de control con las que contamos para utilizar en nuestros scripts, son las siguientes:

```powershell
# Condiciones
if ($variable -eq 'valor')
{ 
  ...
}
elseif ($variable -lt 'valor')
{ 
  ... 
}
else
{ 
  ... 
}

# Ciclo for
for ($i = 0; $i -lt 10; $i++)
{ 
  ... 
}

# Ciclo foreach
foreach ($item in $array)
{
  ... 
}

# Ciclo while
while ($variable -lt 5)
{ 
  ... 
}

# Ciclo do while
do
{ 
  ... 
} while ($variable -lt 10) 
```

## Funciones
En los scripts de PowerShell se pueden definir funciones para facilitar el armado de la estructura y reutilizar código dentro del scripts.

Estas funciones estarán definidas por los siguientes atributos:
  * Por la palabra reservada Function 
  * Un scope o ámbito (opcional)
  * El nombre con el cual se identificará a la función
  * Parámetros (opcional)
  * Secuencia de comandos definidos en el ámbito de la función (entre las llaves { })

El siguiente es un script que utiliza una función de manera recursiva para calcular el factorial de un número.

```powershell
function Get-Factorial()
{
  Param (
	  [int]$value
  )

  if ($value -lt 0) {
      $result = 0
  } elseif ($value -le 1) {
    $result = 1
  } else {
      $result = $value * (Get-Factorial($value - 1))
  }

  return $result
}

$value = Read-Host 'Ingrese un número'
$result = Get-Factorial $value     
# $result = Get-Factorial -value $value
Write-Output "$value! = $result"


./script.sh 11

11! = 39916800
```

## Parámetros
A pesar de que se puede acceder a los parámetros del script con la variable $Args, también es posible accederlos al igual que hacemos en Shell scripting $1, $2, etc. y adicionalmente, podemos declarar parámetros con nombre y asignarle un tipo de datos y validaciones.

En el siguiente ejemplo se declaran dos parámetros con nombre. 
  * El primero, llamado `name`, es obligatorio `(Mandatory=$True)`, de tipo `String` y si no se lo pasa por nombre, será el primer parámetro sin nombre `(Position=1)`. 
  * El segundo parámetro, `firstName`, no es obligatorio y al no tener especificada una posición, si no se lo pasa por nombre no tendrá valor.

```powershell
Param(
    [Parameter(Mandatory=$True,  Position=1)] [string]$name,
    [Parameter(Mandatory=$False)] $lastName
)

Write-Output "Hola $name $lastName "

# Se ejecuta de la siguiente manera:
# Los dos parámetros se pasan por nombre.
.\script.ps1 -name Alejandro -lastName Rodriguez

Hola Alejandro Rodriguez

# Un parámetro es pasado por nombre y el otro por posición.
.\script.ps1 -lastName Rodriguez Alejandro

Hola Alejandro Rodriguez

# No se puede ejecutar de esta manera, ya que dará error porque no se especificó el parámetro “name” que era obligatorio.
# Se solicita el ingreso del parámetro ya que es requerido.
.\script.ps1 -lastName Rodriguez
Ingrese valor para $name: _

Hola Alejandro Rodriguez
```

## Opciones de parámetros
La [definición de parámetros](https://docs.microsoft.com/es-mx/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.1) en PowerShell, nos permite especificar una gran variedad de opciones y validaciones, que el Engine se encargará de resolver automáticamente al recibir los valores en los parámetros.
Además de las opciones ya vistas, se pueden añadir validaciones a los parámetros, ya sea de tipo, rango, largo, vacío o null, patrones (con expresiones regulares), entre otras.

```powershell
Param(
  [Parameter(Mandatory=$true)]
  [ValidateNotNullOrEmpty()]
  [ValidateLength(5,8)] # De 5 a 8 caracteres de largo
  [ValidatePattern('^.*@.*\.[a-z]{3}$')]
  [string] $cadena,

  [Parameter(Mandatory=$true)]
  [ValidateNotNullOrEmpty()]
  [ValidateRange(1,10)]
  [int] $entero

  [Parameter(Mandatory=$true)]
  [ValidateScript({$_ -ge (Get-Date)})]
  [DateTime] $fecha

  [Parameter(Mandatory=$true)]
  [ValidateSet("Bien", "Mal", "Regular")]
  [String] $nota
)
```
## ParameterSets (Conjunto de parámetros)
Los conjuntos de parámetros permiten exponer diferentes parámetros al usuario y devolver información diferente en función de los parámetros especificados por el usuario.

El argumento `ParameterSetName` especifica el conjunto de parámetros al que pertenece un parámetro. Si no se especifica ningún conjunto de parámetros, el parámetro pertenece a todos los conjuntos de parámetros definidos por la función. Por lo tanto, para que sea único, cada conjunto de parámetros debe tener al menos un parámetro que no sea miembro de ningún otro conjunto de parámetros.

### Declarar conjuntos de parámetros
Para crear un conjunto de parámetros, debe especificar la ParameterSetName palabra clave al declarar el atributo de parámetro para cada parámetro del conjunto de parámetros. Para los parámetros que pertenecen a varios conjuntos de parámetros, agregue un atributo de parámetro para cada conjunto de parámetros. Este atributo permite definir el parámetro de forma diferente para cada conjunto de parámetros. Por ejemplo, puede definir un parámetro como obligatorio en un conjunto y opcional en otro. Sin embargo, cada conjunto de parámetros debe contener un parámetro único.

```powershell
Param(
  [Parameter(Mandatory=$true, ParameterSetName="Computer")]
  [String[]]
  $ComputerName,

  [Parameter(Mandatory=$true, ParameterSetName="User")]
  [String[]]
  $UserName,

  [Parameter(Mandatory=$false)]
  [Switch]
  $Summary
)
```

Solo puede especificar un valor ParameterSetName en cada argumento y solo un argumento en cada atributo ParameterSetName Parameter. Para indicar que un parámetro aparece en más de un conjunto de parámetros, agregue atributos de parámetro adicionales.

```powershell
Param(
  [Parameter(Mandatory=$true, ParameterSetName="Computer")]
  [String[]]
  $ComputerName,

  [Parameter(Mandatory=$true, ParameterSetName="User")]
  [String[]]
  $UserName,

  [Parameter(Mandatory=$false, ParameterSetName="Computer")]
  [Parameter(Mandatory=$true, ParameterSetName="User")]
  [Switch]
  $Summary
)
```
## Parámetros desde el pipeline
Existen 2 argumentos que nos permite indicar que un parámetros puede recibir valores a través del pipeline. 

`ValueFromPipeline` indica que el parámetro acepta la entrada de un objeto por el pipeline. La función acepta todo el objeto, no solo una propiedad del objeto.
```powershell
Param(
  [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
  [String[]]
  $ComputerName
)
```
`ValueFromPipelineByPropertyName` indica que el parámetro acepta la entrada de una propiedad de un objeto a través del pipeline. La propiedad de objeto debe tener el mismo nombre o alias que el parámetro.

Por ejemplo, si la función tiene un parámetro ComputerName y el objeto recibido tiene una propiedad ComputerName, el valor de la propiedad ComputerName se asigna al parámetro ComputerName de la función.

```powershell
Param(
  [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
  [String[]]
  $ComputerName
)
```

## Estructura de las funciones
Esta estructura es similar a la de **AWK**, donde tenemos el bloque **Begin**, que se ejecutará por única vez al comienzo de la invocación y el bloque **End** que se ejecutará por única vez, al finalizar la ejecución. En cambio, el bloque **Process** veremos que se puede ejecutar más de una vez si utilizamos la función en un pipeline de ejecución.

```powershell
Begin {
    <#
    Code
    #>
}
Process {
    <#
    Code
    #>
}
End {
    <#
    Code
    #>
} 
```

En el siguiente ejemplo veremos la iteración del bloque Process:
```powershell
function Get-Multiplicacion() {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [int]$value
    )
    Begin { $result = 0 }
    Process {
        Write-Output "Resultado parcial: $result"

        if($value -lt 0)
        {
            $result = 0
        }
        elseif($value -le 1)
        {
            $result = 1
        }
        else
        {
            $result = $value * $result
        }
    }

    End { Write-Output "Resultado Final: $result" }
} 

PS > 1 .. 8 | Get-Multiplicacion
Resultado parcial: 0
Resultado parcial: 1
Resultado parcial: 2
Resultado parcial: 6
Resultado parcial: 24
Resultado parcial: 120
Resultado parcial: 720
Resultado parcial: 50040
Resultado Final: 40320
```

## Colecciones
En PS, a diferencia de Bash, manejaremos objetos. Veremos como utilizar algunas de las collections más utilizadas: `Listas` y `Hash Tables`

### Listas
Podemos definir listas de 2 formas: 
  * `@()` definr una nueva lista con la sentencia @()
  ```powershell
  # Agrego valores a la lista.
  $array = @()
  $array += 1 # Agrega el elemento 1
  $array += 2
  $array += (3..9) # Agrega una lista con valores entre 3 y 9

  # Procesa un archivo CSV y asigna los valores en $datos
  $datos = Import-CSV -Delimiter ',' -Path ./notas.csv
  $datos | Sort-Object -Property Patente
  # Get-Member permite ver la estructura de los objetos
  $datos | Get-Member 

  $patente = 0
  $datos | ForEach-Object {
    if ($patente -eq $_.patente) {
            # mientras sean iguales acumulo
    }
    else {
            # imprimo
    }
  }
  ```

  - Instanciado un objeto lista
  ```powershell
  $paises = New-Object System.Collections.ArrayList
  $paises.Add('Argentina')
  $paises.Add('Brasil') > $null
  $paises.Add(22)
  $paises
  ```

### Hast Tables
Defino un nuevo Hash Table vacío con la sentencia @{}

```powershell
$materias = @{ }
```

Puedo asignarle valores iniciales:
```powershell
$materias = @{SO= "Sistemas Operativos"; CP = "Compiladores"; BD = "Base de Datos" }
```

Agregar y quitar valores:
```powershell
$materias.add("PR1", "Programación 1")
$materias["PR1"]

$materias.Remove("PR1")
$materias["PR1"]
```

Accedo a los valores haciendo referencia por medio del subíndice, que puede ser un número o un string.
```powershell
$materias["PR1"] = "Programación 1"
$materias["PR1"]
```

## Manejo de eventos
PowerShell nos permite definir acciones ante la ocurrencia de eventos relacionados a los objetos. 

Para ello haremos uso de los siguientes cmdlet para registrar, validar y eliminar los eventos.

  - `Register-ObjectEvent`: Registra el evento en el sistema
  - `Get-EventSubscriber`: Obtiene los eventos registrados
  - `Unregister-Event`: Elimina el evento registrado

Para registrar un evento en el sistema debemos definir los siguientes atributos:
  - `InputObject`: objeto que utilizaremos para registrar el evento
  - `EventName`: evento a registrar del objeto 
  - `SourceIdentifier`: identificador que utilizaremos definir al evento
  - `Action`: serie de comandos a ejecutar cuando se invoque el evento

Para conocer los eventos que podemos registrar de un objeto utilizaremos el cmdlet Get-Member

```powershell
# Obtención de los eventos que puede registrar un objeto
New-Object Timers.Timer | Get-Member -Type Event | Select Name

Name    
----    
Disposed
Elapsed

# Ejemplo de uso:
$timer = New-Object Timers.Timer
$timer2 = New-Object Timers.Timer
$timer3 = New-Object Timers.Timer

# Tener en cuenta es es posible que sea necesario utilizar el scope Global si se controlará por fuera del script.
$repeticiones = 1

$action = {
	write-host "$repeticiones, Timer Elapse Event: $(get-date -Format ‘HH:mm:ss’)"
	$repeticiones++ }

$timer.Interval = 1000 #1 seconds  
$timer2.Interval = 2000 #2 seconds  
$timer3.Interval = 3000 #3 seconds  

Register-ObjectEvent -InputObject $timer -EventName elapsed –SourceIdentifier timer1seg -Action $action
Register-ObjectEvent -InputObject $timer2 -EventName elapsed –SourceIdentifier timer2seg -Action $action
Register-ObjectEvent -InputObject $timer3 -EventName elapsed –SourceIdentifier timer3seg -Action $action

# Para iniciar el timer
$timer.start()
$timer2.start()
$timer3.start()

# Para detenerlo
$timer.stop()

# Borro el registro del evento
Unregister-Event timer1seg

# Obtengo los eventos registrados
Get-EventSubscriber | Unregister-Event
```

## Scopes
PowerShell maneja el concepto de scope o ámbito, el cual se aplica en 3 niveles y puede ser utilizado para modificar variables, alias y funciones.
  - Global: El scope que está vigente cuando se inicia PowerShell. Las variables y funciones que están presentes cuando se inicia PowerShell se han creado en el ámbito global, como las variables automáticas y las variables de preferencia. Las variables, los alias y las funciones en sus perfiles de PowerShell también se crean en el ámbito global.
  - Local: El scope actual. El ámbito local puede ser el ámbito global o cualquier otro ámbito.
  - Script: El scope que se crea mientras se ejecuta un archivo de script. Solo los comandos en el script se ejecutan en el alcance del script. Para los comandos en un script, el alcance del script es el alcance local.
 
La sintaxis es la siguiente:
```powershell
$[<scope-modifier>:]<name> = <value>
function [<scope-modifier>:]<name> {<function-body>}
```

Para más información: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes?view=powershell-7.1

#
# Manejo de Errores
Para el manejo de errores, tendremos la opción de capturarlos y darles un tratamiento adecuado, al igual que podemos hacer en lenguajes como .NET o Java, entre otros, y adicionalmente, definir un comportamiento por defecto ante la aparición de alguna excepción.

La sintaxis es la siguiente:
```powershell
try {
    <#
    Código con posibilidad de error
    #>
}
catch {
    <#
    Acciones a tomar ante la excepción
    #>
}
finally {
    <#
    Acciones que siempre se ejecutaran
    #>
}
```

Al incorporar la directiva `CmdLetBinding`, que ya hemos mencionado anteriormente, se nos habilitan los siguientes argumentos a las funciones: `ErrorAction` y `ErrorVarible`. 

  - `ErrorAction` (EA), es una enumeración que nos permite setear el comportamiento ante una excepción en la ejecución del CmdLet o la función. Si queremos que el error encontrado sea capturado, entonces se debe setear el argumento con “Stop”.
  - `ErrorVariable` (EV), nos permite crear una variable donde se almacenaran los errores obtenidos para inspeccionarlos y poder analizar las causas y determinar las acciones a tomar.

Adicionalmente, a estos argumentos, es importante resaltar la existencia y diferencia en el uso de los cmdLets para la escritura de información:
  - `Write-Error`: Muestra el mensaje especificado y finaliza la ejecución de la función.
  - `Write-Warning`: Muestra el mensaje en un color diferente al normal a la consola, con la leyenda “WARNING” o “ADVERTENCIA”, dependiendo del lenguaje.
  - `Write-Output`: Muestra el mensaje especificado en el estándar output.
  - `Write-Debug`: Muestra el mensaje en un color diferente al normal con la leyenda “Debug”, solamente si la variable `–Debug` ha sido seteada en la ejecución del CmdLet.

```powershell
function Detener-Proceso()
{
  [CmdLetBinding()]
  Param(
    [Parameter(Mandatory=$True,
              ValueFromPipeline=$true,
              ValueFromPipelineByPropertyName=$true)]
    [Int[]]$Id
  )
  Process{
    foreach ($proc in $Id)
    {
      try{
        kill -Id $proc # Alias de Stop-Process
        Write-Output "El proceso $proc fue detenido exitosamente"
      }
      catch{
        Write-Warning "El proceso $proc no existe en el sistema"
      }
    }
  }
} 
```

Ejemplos de uso:

```powershell
# Ejecutar la función con Ids inexistentes:
Detener-Proceso -Id 3324, 3325 -ErrorVariable errorKill -ErrorAction Stop 
```
El resultado será el siguiente:
```powershell
ADVERTENCIA: El proceso 3324 no existe en el sistema
ADVERTENCIA: El proceso 3325 no existe en el sistema 
```

Usando el Pipeline:
```powershell
# Verificamos que existan procesos:
get-process -Name notepad* 

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName                                                                                                                
-------  ------    -----      ----- -----   ------     -- -----------                                                                                                                
     61       3     1212       4904    64     0,06   5344 notepad                                                                                                                    
    121       9    10592      16760   100     0,42   4124 notepad++      

# Ejecución de la instrucción:
get-process -Name notepad* | Detener-Proceso -EA Stop -EV errorKill 

El proceso 5344 fue detenido exitosamente
El proceso 4124 fue detenido exitosamente 

# Ejecución de la función para Ids existentes e inexistentes:
Detener-Proceso -Id 4364, 3984 -EV errorKill -EA Stop 

ADVERTENCIA: El proceso 4364 no existe en el sistema
El proceso 3984 fue detenido exitosamente 

$errorKill 

Se detuvo el comando en ejecución porque la variable de preferencia "ErrorActionPreference" o un parámetro común se han establecido en Stop: No se encuentra ningún proceso con el 
identificador 4364.
kill : No se encuentra ningún proceso con el identificador 4364.
En C:\Users\Public\Documents\Manuales\PowerShell\Scripts\pruebas.ps1: 15 Carácter: 17
+                 kill -Id $proc
+                 ~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (4364:Int32) [Stop-Process], ProcessCommandException
    + FullyQualifiedErrorId : NoProcessFoundForGivenId,Microsoft.PowerShell.Commands.StopProcessCommand
```
#
# Sección Ayuda
Para obtener ayuda sobre los cmdlet existe el Get-Help, que nos brindará la información funcional, sobre los parámetros, el modo de uso, entre otros temas.

PowerShell genera de forma automática, una hoja de ayuda con las funciones que creamos, con la información básica. Esto nos brinda una ayuda estándar para todos los cmdlet y funciones de usuario que se desarrollan. 

La recopilación de la información de ayuda de la función se realiza mediante metadata que se debe especificar inmediatamente antes de la palabra reservada function, sin dejar espacios ni saltos de línea, ya que de lo contrario no se identificará como parte de la ayuda sino como un comentario del script.

Dentro de la especificación existen varias secciones que son las que luego se mostraran con `Get-Help`. Las mismas son:

- .Synopsis
- .Description
- .Example (puede ser más de 1)
- .Inputs
- .Outputs

A continuación se muestra un ejemplo básico de estas secciones:
```powershell 
<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Set-Help {
    <# 
    CODE 
    #>
}
```

Agregando la sección de ayuda a la función `Get-Factorial` obtenemos el siguiente resultado:
```powershell 
<#
.Synopsis
Esta función calcula el factorial de un número de manera recursiva
.Description
Esta función calcula el factorial de un número de manera recursiva
.Parameter value
Este parámetro indicará cuál el número al cuál calcular el factorial
.Example
Get-Factorial -value 5
120
#>
function Get-Factorial()
{ 
...
}
```

Note que para obtener diferentes grados de información podemos utilizar los parámetros `–Example, –Detailed o –Full`, los cuales irán mostrando un mayor detalle de la ayuda informada en la metadata de la función.

#
# Cmdlets frecuentes
A continuación una lista de los cmdlets más usados:

- Archivos:
  - Get-ChildItem
  - Copy-Item
  - Move-Item
  - Get-Content
  - Set-Content
  - Out-File
  - Out-Null
  - Export-Csv
- Cadenas:
  - Select-String
- Manejo de colecciones de objetos:
  - Select-Object
  - Where-Object
  - ForEach-Object
  - Sort-Object
- Procesos y datos del sistema:
  - Get-Process
  - Get-WmiObject
  - Get-Counter
  - Test-Connection (ping)
  - Add-Type (agrega bibliotecas de .Net)
