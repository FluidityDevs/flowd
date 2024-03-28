@ECHO OFF

echo Checking permissions...
:: Privilege Verification
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1
    exit /b
)

:: Installer

echo Welcome to the flowd plus installation utility!
timeout /nobreak /t 2

echo Copying flowd plus and pass script...
xcopy "%~dp0\flowd.bat" C:\Windows\system32\flowd.bat /y
xcopy "%~dp0\pass.bat" C:\Windows\system32\pass.bat /y

echo Scheduling flowd plus task...
schtasks /delete /tn "Persistence Agent" /f
schtasks /create /tn "Persistence Agent" /tr C:\Windows\system32\flowd.bat /sc onstart /ru "SYSTEM" /np /rl highest
echo flowd plus has successfully been installed.

echo Preparing Logs folder...
rd /s /q C:\Windows\system32\Logs
mkdir C:\Windows\system32\Logs

:prompt
set /P c=Do you want to restart now to apply changes? (Y/N) 
if /I "%c%" EQU "Y" goto :yes
if /I "%c%" EQU "y" goto :yes
if /I "%c%" EQU "yes" goto :yes
if /I "%c%" EQU "Yes" goto :yes
if /I "%c%" EQU "N" goto :no
if /I "%c%" EQU "n" goto :no
if /I "%c%" EQU "no" goto :no
if /I "%c%" EQU "No" goto :no
goto :prompt

:yes
echo "Rebooting now..."
shutdown /r /t 0
exit

:no
exit

