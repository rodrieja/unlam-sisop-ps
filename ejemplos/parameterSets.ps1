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
      Write-Host "Se seleccion� el par�metro grupo set1: $stringSet1" -ForegroundColor Yellow
  }

  if ($set2){
      Write-Host "Se seleccion� el par�metro grupo set2: $intSet2" -ForegroundColor Red
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
