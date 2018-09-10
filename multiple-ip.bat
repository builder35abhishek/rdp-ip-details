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
for /f "tokens=3 " %%i in ('netstat -an ^|find "3389" ^|find "ESTAB"') DO set ip=%%i
echo %COUNT% from ip %ip% User/s Logon type: RDP Login
query user
exit 1
:CRITICAL
@ECHO OFF &SETLOCAL
FOR /f "tokens=3 " %%a IN ('netstat -an ^|find "3389" ^|find "ESTAB"') DO (
    CALL SET "ip2=%%ip1%%"
    SET "ip1=%%a"
)
ECHO RDP from ip1: %ip1% RDP from ip2 %ip2%
exit 2
