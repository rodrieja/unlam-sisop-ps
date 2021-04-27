#$global:repeticiones = 0

function global:MainAction() {
    $global:repeticiones++
    "$repeticiones, Timer Elapse Event: $(get-date -Format ‘HH:mm:ss’)" >> log
}

$Action = { MainAction }

$repeticiones = 0
$global:Timer = New-Object Timers.Timer
$EventJob = Register-ObjectEvent -InputObject $Timer -EventName Elapsed -Action $Action 

$Timer.Interval = 1000
$Timer.AutoReset = $true
$Timer.Start()