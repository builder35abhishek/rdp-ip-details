@ECHO OFF
SET /a COUNT=0
for /f "tokens=3 delims=: " %%i in ('netstat -an ^|find "3389" ^|find "ESTAB"') DO (if %%i EQU 3389 SET /a COUNT+=1)
if %COUNT% == 0 goto OK
if %COUNT% == 1 goto WARN
if %COUNT% GEQ 2 goto CRITICAL
:OK
Echo User OK, %COUNT% User/s Logged in^|'Users'=%COUNT%;1;2;0
exit 0
:WARN
for /f "tokens=3 " %%i in ('netstat -an ^|find "3389" ^|find "ESTAB"') DO @echo %%i
echo %COUNT% from ip %i% User/s Logon type: RDP Login^|'Users'=%COUNT%;1;2;0
exit 1
:CRITICAL
for /f "tokens=3 " %%i in ('netstat -an ^|find "3389" ^|find "ESTAB"') DO set ip=%%i 
echo ip %ip%
exit 2
