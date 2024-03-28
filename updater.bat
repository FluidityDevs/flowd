@ECHO OFF

echo Welcome to the flowd plus manual update utility!
timeout /nobreak /t 2

echo Applying updates...
xcopy "%~dp0\flowd.bat" C:\Windows\system32\flowd.bat /y
xcopy "%~dp0\pass.bat" C:\Windows\system32\pass.bat /y
echo Successfully updated flowd and TestPass.

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

