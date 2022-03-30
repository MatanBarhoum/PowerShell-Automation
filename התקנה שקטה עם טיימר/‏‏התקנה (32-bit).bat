@echo off
start "Install Timer, Please Wait..." cmd /c timer\timer.bat -wait

echo Please wait.....

echo Installing Java.....
@echo off
start /w Data\32\jdk-6u22-windows-i586.exe /s
echo Java installed successfully!
echo Proceeding...
echo Installing SDK.....
@echo off
msiexec /i Data\32\Wacom-Signature-SDK-x86-4.7.0.msi /passive
echo SDK installed successfully!
echo Proceeding...
echo Installing Drivers and neccessery components
start /w Data\64\Wacom-STU-SigCaptX-1.4.7.exe /install /passive /norestart
msiexec /i Data\32\Wacom-STU-SigCaptX-x86-1.4.7.msi /passive /norestart
echo The Installation finished, you can close this window and the timer window.
taskkill /IM cmd.exe /FI "WINDOWTITLE eq Install Timer, Please Wait..."
pause