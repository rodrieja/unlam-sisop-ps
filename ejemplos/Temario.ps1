#  1. Filtrado de archivos por extensión
#  2. Lectura de archivos
#  3. Escritura de archivos
#  4. ForEach-Object (Split)
#  5. Eventos
#  6. Add-Type
#  7. Scopes
#  8. Arrays y Hash Tables
#  9. Parametros
# 10. Metodos Write-

# 1. Filtrado de archivos por extensión
# -Filter: permite filtrar por una expresión regular.
# -Path: indica el directorio a listar
# -Recurse: muestra el contenido del directorio y los subdirectorios
ls /home/alejandro/Documentos/
Get-ChildItem -Path /home
Get-ChildItem -Filter "*pdf" -Recurse
Get-ChildItem -Filter "*pdf" -Recurse | Select-Object -Property Directory, Name, Length

# 2. 
# Lectura de archivos: Get-Content
#
# -Path: para indicar la ruta del archivo
# -TotalCount N: N primeras líneas, similar a head
# -Tail N: N últimas líneas, similar a tail
# -Wait: Lee el archivo en tiempo real, similar a tail -f
#        Para cancelarlo, oprimir Ctrl-C

Get-Content -Path /home/alejandro/Documentos/ParaLeer.txt -Wait
# -TotalCount 3
# -Tail 3
# -Wait

# 3. Escritura de archivos
# Out-File
# -FilePath: indica el archivo a escribir.
# -Append: indica que se debe agregar contenido, 
# caso contrario sobreescribe el archivo
# -NoClobber: indica que el archivo no debe sobreescribirse
$texto = "Creando Archivo"
$archivo = "/home/alejandro/Documentos/file.out"

Out-File -FilePath $archivo -InputObject $texto
Get-Content $archivo

$texto = "Sobreescribiendo archivo"
Out-File -FilePath $archivo -InputObject $texto
Get-Content $archivo

Out-File -FilePath $archivo -InputObject $texto -Append
Get-Content $archivo

Out-File -FilePath $archivo -InputObject $texto -NoClobber
# Out-File : The file '/home/alejandro/Documentos/file.out' already exists.
# At line:1 char:1
# + Out-File -FilePath $archivo -InputObject $texto -NoClobber
# + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# + CategoryInfo          : ResourceExists: (/home/alejandro/Documentos/file.out:String) [Out-File], IOException
# + FullyQualifiedErrorId : NoClobber,Microsoft.PowerShell.Commands.OutFileCommand

# Para conocer todo el detalle de la exception
# $Error[0] | Select-Object -Property *

try {
    Out-File -FilePath $archivo -InputObject $texto -NoClobber
    Write-Host "Despues de la exception"
}
catch [System.IO.IOException] {
    Write-host "Error al escribir el archivo: $archivo" -ForegroundColor Green
} 

# 4. ForEach-Object
# Itera sobre la colection de objetos

$delimitados = "/home/alejandro/Documentos/delimitados.txt"
$global:lines = 0
Get-Content $delimitados | ForEach-Object { 
    $lines++
    $fields = 0
    Write-Host "Line $lines`: $_"
    foreach ($value in $_.ToString().Split("|") ) { 
        $fields++; 
        Write-Host "`tField $fields`: $value"
    }
}

# 5. Eventos

# Obtención de los eventos que puede registrar un objeto
New-Object Timers.Timer | Get-Member -Type Event | Select Name
# 
# Name    
# ----    
# Disposed
# Elapsed 

New-Object System.Net.WebClient | Get-Member -Type Event | Select Name 
# 
# Name                   
# ----                   
# Disposed               
# DownloadDataCompleted  
# DownloadFileCompleted  
# DownloadProgressChanged
# DownloadStringCompleted
# OpenReadCompleted      
# OpenWriteCompleted     
# UploadDataCompleted    
# UploadFileCompleted    
# UploadProgressChanged  
# UploadStringCompleted  
# UploadValuesCompleted  
# WriteStreamClosed   
#
# Ejemplo de uso:
$timer = New-Object Timers.Timer 
$timer2 = New-Object Timers.Timer 
$timer3 = New-Object Timers.Timer 
$repeticiones = 1 
$action = {
    write-host "$repeticiones, Timer Elapse Event: $(get-date -Format ‘HH:mm:ss’)"
    $repeticiones++ } 
$timer.Interval = 1000 #3 seconds  
$timer2.Interval = 2000 #3 seconds  
$timer3.Interval = 3000 #3 seconds  
    

Register-ObjectEvent -InputObject $timer -EventName elapsed –SourceIdentifier thetimer -Action $action 
Register-ObjectEvent -InputObject $timer2 -EventName elapsed –SourceIdentifier thetimer2 -Action $action 
Register-ObjectEvent -InputObject $timer3 -EventName elapsed –SourceIdentifier thetimer3 -Action $action 

# Para iniciar el timer
$timer.start()
$timer2.start()
$timer3.start()

# Para detenerlo
$timer.stop() 

# Borro el registro del evento
Unregister-Event thetimer
# Obtengo los eventos registrados
Get-EventSubscriber | Unregister-Event

# Ejemplo utilizando la función de forma global
function global:MainAction {
    write-host "$repeticiones, Timer Elapse Event: $(get-date -Format ‘HH:mm:ss’)"
}

$Action = { MainAction }

$Timer = New-Object Timers.Timer
$EventJob = Register-ObjectEvent -InputObject $Timer -EventName Elapsed -Action $Action

$Timer.Interval = 5000
$Timer.AutoReset = $true
$Timer.Start()

# 6. Add-Type
# Permite agregar assemblies de .NET para crear objetos
$source = "/home/alejandro/Documentos/"
$destination = "/home/alejandro/Descargas/backup.zip"
Write-Host $source
Write-Host $destination

# Permite comprimir un directorio
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::CreateFromDirectory($source, $destination) 

# A partir de la versión 5 se pueden utilizar los cmdlets Compress-Archive y Expand-Archive
# Igual al ejemplo con Add-Type
Compress-Archive -Path $source -DestinationPath $destination
# Ahora puedo filtrar los componentes y agrear
$directorio = "/home/alejandro/Documentos"
Compress-Archive -Path "$directorio/*.txt" -DestinationPath "$directorio/txtBackup.zip"
Compress-Archive -Path "$directorio/*.pdf" -Update -DestinationPath "$directorio/txtBackup.zip"

$resultado = Get-ChildItem -Path $directorio/*.txt
if ($resultado.Length -gt 0) {
    Write-Host "existen" -ForegroundColor Blue
    Compress-Archive -Path "$directorio/*.txt" -Update -DestinationPath "$directorio/txtBackup.zip"

} 

# Descomprimo los archivos
Expand-Archive -Path "$directorio/txtBackup.zip" -DestinationPath "$directorio/extraidos"

# 7. Scopes
# $global:variable = value
# https://docs.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_scopes?view=powershell-4.0

# get-item permite obtener los valores existentes
# remove-item -path variable: o function:

# 8. Arrays y Hash Tables
# Arrays: 
$array = @()
$array += 1
$array += 2
$array += (3..9)
$array

$importado = Import-CSV -Delimiter ',' -Path ./delimitados.txt

$importado | Sort-Object -Property Patente

$importado | Get-Member
$patente = 0
$importado | ForEach-Object {
    if ($patente -eq $_.patente) {
        # mientras sean iguales acumulo
        
    }
    else {
        # imprimo
    }
}


$paises = New-Object System.Collections.ArrayList
$paises.Add('Argentina')
$paises.Add('Brasil') > $null
$paises.Add(22)
$paises
# Hast Tables: 
# Hash Table vacío
$materias = @{ }
# Hash Table inicializado con valores
$materias = @{SO= "Sistemas Operativos"; CP = "Compiladores"; BD = "Base de Datos" }
# Agregar y quitar valores
$materias.add("PR1", "Programación 1")
$materias["PR1"]

$materias.Remove("PR1")
$materias["PR1"]

$materias["PR1"] = "Programación 1"
$materias["PR1"]

# 9. Parámetros
# 9.1 - Definición de Parámetros
# 9.2 - Validaciones
# [ValidateScript({Test-Path $_ -PathType 'Container'})] 
# [String] 
# $Path 
# 9.3 - Tipos Especiales

function parameterTest {
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $stringValue,
        [Parameter(Mandatory=$false)]
        [switch]
        $switchValue,
        [Parameter(ParameterSetName="set1")]
        [switch]
        $set1,
        [Parameter(ParameterSetName="set1")]
        [string]
        $stringSet1,
        [Parameter(ParameterSetName="set2")]
        [switch]
        $set2,
        [Parameter(ParameterSetName="set2")]
        [int32]
        $intSet2
        
    )
    
    if ($switchValue){
        Write-Host "Se seleccionó el parámetro switch" -ForegroundColor Green
    }

    if ($set1){
        Write-Host "Se seleccionó el parámetro grupo set1: $stringSet1" -ForegroundColor Yellow
    }

    if ($set2){
        Write-Host "Se seleccionó el parámetro grupo set2: $intSet2" -ForegroundColor Red
    }

    Write-Host "Este siempre viene stringValue: $stringValue" -ForegroundColor Green
}

parameterTest -stringValue "f" -set1 
parameterTest -stringValue "f" -set1 -stringSet1 "sef" 
parameterTest -stringValue "f" -set1 -stringSet1 "sef" -set2
parameterTest -stringValue "f" -set2
parameterTest -stringValue "f" -set2 -intSet2 22
parameterTest -stringValue "f" -set2 -intSet2 22 -stringSet1 "ss"
parameterTest -set2 -intSet2 22