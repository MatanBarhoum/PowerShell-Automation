$Server = "DC-TLV","DC-NY" ##Server's Names.. 

ForEach ($i in $Server) {
Invoke-Command -ComputerName $i -ScriptBlock { $DNS_Service = Get-Service | Where-Object {$_.DisplayName -like "*DNS*"} | select -ExpandProperty Status }
if ($DNS_Service -eq "Stopped")
{ Start-Service
Write-Output "Service Started Successfuly." } 
else {
Write-Output "Service is running already.."
} 
}
