$ChromeVer = (Get-Item (Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo
if ($ChromeVer.ProductVersion -le "93.0.4577.63")
{
$regPaths = 
"HKLM:\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall",
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

$productCodes = @( $regPaths | Foreach-Object {
    Get-ItemProperty "${_}\*" | Where-Object {
      $_.DisplayName -eq 'Google Chrome'
    }
  } ).PSPath
 
$productCodes | ForEach-Object {

  $keyName = ( Get-ItemProperty $_ ).PSChildName
$keyName
Start MsiExec.exe /X$keyName
}
}
else
{
Write-Host "Google Chrome do not exist"
}
$Path = 'HKLM:\SOFTWARE\Policies\Google\Update'
$Name = 'UpdateDefault','Update{8A69D345-D564-463C-AFF1-A69D9E530F96}','Update{8237E44A-0054-442C-B6B6-EA0509993955}','Update{4DC8B4CA-1BDA-483E-B5FA-D3C12E15B62D}','InstallDefault','Install{8A69D345-D564-463C-AFF1-A69D9E530F96}','Install{8237E44A-0054-442C-B6B6-EA0509993955}','Install{4DC8B4CA-1BDA-483E-B5FA-D3C12E15B62D}'
ForEach ($i in $Name) {
New-ItemProperty -Path $Path -Name $i -Value '0x00000001' -PropertyType REG_DWORD -Verb runas -Force
}