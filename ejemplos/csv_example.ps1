$csvFile = './CSV/notas.csv'
# Identifico la cantidad de ejercicios en el parcial
$ejerciciosCount = (Get-Content $csvFile -TotalCount 1).Split(',').Count - 1
# Genero el header para leer el csv (DNI, ej1, ej2, ... , ejn)
$header = @('DNI')
(1..$ejerciciosCount) | ForEach-Object { $header += "ej$_" }
# Ahora sí importo el archivo
$csvContent = Import-Csv -Path $csvFile -Header $header 
# Inspecciono los datos
$csvContent | Format-Table
# Estructura del objeto
$csvContent | Get-Member
'DNI: ' + $csvContent.DNI
'ej1: ' + $csvContent.ej1
'ej2: ' + $csvContent.ej2
'ej3: ' + $csvContent.ej3
'ej4: ' + $csvContent.ej4
'ej5: ' + $csvContent.ej5