$intA = 10
$intB = 29

$calc = New-WebServiceProxy -Uri http://www.dneonline.com/calculator.asmx?WSDL 
$result = $calc.Add($intA, $intB)

Write-Output "$intA + $intB = $result"

