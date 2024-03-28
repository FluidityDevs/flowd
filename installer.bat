@ECHO OFF

echo Checking permissions...
:: Privilege Verification
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1
    exit /b
)

:: Installer

echo Welcome to the flowd installation utility!
echo Please make sure you're running this tool as an administrator! Press Ctrl + C NOW if you are not!
timeout /nobreak /t 2

echo Copying flowd (don't worry about copy failures!)...
xcopy "%~dp0\flowd.bat" C:\Windows\system32\flowd.bat /y
xcopy "D:\Programs\Tools for flowd\flowd.bat" C:\Windows\system32\flowd.bat /y
xcopy %USERPROFILE%\Downloads\flowd.bat C:\Windows\system32\flowd.bat /y
xcopy D:\flowd.bat C:\Windows\system32\flowd.bat /y

echo Scheduling flowd task...
schtasks /delete /tn "Persistence Agent" /f
schtasks /create /tn "Persistence Agent" /tr C:\Windows\system32\flowd.bat /sc onstart /ru "SYSTEM" /np /rl highest
echo flowd has successfully been installed.

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

