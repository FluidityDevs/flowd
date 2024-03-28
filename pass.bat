@ECHO OFF

echo Performing multi-use patches
taskkill /f /im eshell.exe
taskkill /f /im CustomShellHost.exe
taskkill /f /im HCPS_TestHub_Menu.exe
taskkill /f /im VolkeyUser.exe
taskkill /f /im NoOpenSave.exe
exit