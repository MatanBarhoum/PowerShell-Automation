$timeout = New-TimeSpan -Seconds 30
$startclock = [Diagnostics.stopwatch]::StartNew()
while($startclock.elapsed -lt $timeout){
$isIEopen = Get-Process | Where-Object {$_.ProcessName -like "*iexp*"} | Select -ExpandProperty ProcessName 
$isCHopen = Get-Process | Where-Object {$_.ProcessName -like "*chrome*"} | Select -ExpandProperty ProcessName 
if (($isIEopen -contains "iexplore") -eq $True){
$FindUrl = (New-Object -ComObject Shell.Application).Windows()}
start-sleep -Seconds 1.5
if ($isIEopen -contains "iexplore" -and ($FindUrl | Where {$_.LocationUrl -like "https://join.*"}).LocationUrl -like "*https://join.*") 
{[System.Diagnostics.Process]::Start("chrome", ($FindUrl | Where {$_.LocationUrl -like "https://join.*"}).LocationUrl)
Get-Process | Where-Object {$_.ProcessName -like "*iexp*"} | Stop-Process}
}
