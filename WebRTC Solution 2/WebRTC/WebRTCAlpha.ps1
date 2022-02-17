Param($Argument='""')
$New = $Argument -replace "webrtc:",""
[System.Diagnostics.Process]::Start("Chrome", $New)
Start-Sleep -Seconds 1
get-Process | Where {$_.ProcessName -like "*powershell*"} | Stop-Process