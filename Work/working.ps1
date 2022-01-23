Start .\timer.bat
Start -FilePath C:\Users\Admin\Desktop\jdk-6u45-windows-x64.exe
$wshell = New-Object -ComObject wscript.shell;
$wshell.AppActivate('jdk-6u45-windows-x66')
Sleep 2
$wshell.SendKeys('~')
