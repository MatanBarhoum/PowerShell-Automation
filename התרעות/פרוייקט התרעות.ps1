$users = Get-WmiObject -Class Win32_UserProfile | Select-Object -Property LocalPath
$diskQ = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$Size = $diskQ.Size / 1GB
$Free = $diskQ.FreeSpace / 1GB
$Used = $size - $Free

if ($free -lt "5") {

$outlook = New-Object -ComObject Outlook.Application

$email = $outlook.CreateItem(0)
$email.To = "למי לשלוח?"
$email.Subject = "חריגת מקום פנוי בכונן זוהתה"
$email.Body = "                                                                                                                                                                                                                      לידיעתך, במחשב זה נותרו פחות מ-20 ג'יגה פנויים בכונן"

$email.Send()

}