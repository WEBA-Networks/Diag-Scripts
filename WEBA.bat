@echo off

setlocal
1>nul chcp 1251

title WEBA Diagnostic script
set day=%DATE:~0,2%
set month=%DATE:~3,2%
set year=%DATE:~6,4%
set $date=%year%.%month%.%day%
set log=WEBA_%$date%.log
rem cd /d %~dp0
cd /d %HOMEPATH%

echo ***     WEBA Diagnostic     ***
echo =-=-=-=-=     WEBA Diagnostic     =-=-=-=-= > %log%



echo    - OS Version
echo    ************ OS Version ************ >> %log%
for /f "tokens=*" %%i in ('ver') do call:echo "%%i"
::ver >> %log%

echo    - IP Interfaces parameters
echo    ************ IP Interfaces parameters ************ >> %log%
for /f "tokens=*" %%i in ('ipconfig /all') do call:echo "%%i"
::ipconfig /all >> %log%

echo    - Routing Table
echo    ************ Routing Table ************ >> %log%
for /f "tokens=*" %%i in ('route PRINT') do call:echo "%%i"
::route PRINT >> %log%

echo    - ARP-Table
echo    ************ ARP-Table ************ >> %log%
for /f "tokens=*" %%i in ('arp -a') do call:echo "%%i"
::arp -a >> %log%

echo    - Current Connections
echo    ************ Current Connections ************ >> %log%
for /f "tokens=*" %%i in ('netstat -na') do call:echo "%%i"
::netstat -na >> %log%

echo    - Current Connections Detailed
echo    ************ Current Connections Detailed ************ >> %log%
for /f "tokens=*" %%i in ('netstat -nab') do call:echo "%%i"
::netstat -nab >> %log%

echo    - Ping 10x to WEBA-DNS1
echo    ************ Ping 10x to WEBA-DNS1 ************ >> %log%
for /f "tokens=*" %%i in ('ping -n 10 37.153.1.2') do call:echo "%%i"
::ping -n 10 37.153.1.2 >> %log%

echo    - Ping 10x to WEBA-DNS2
echo    ************ Ping 10x to WEBA-DNS2 ************ >> %log%
for /f "tokens=*" %%i in ('ping -n 10 37.153.0.5') do call:echo "%%i"
::ping -n 10 37.153.0.5 >> %log%

echo    - Ping 10x to WEBA-DNS3
echo    ************ Ping 10x to WEBA-DNS3 ************ >> %log%
for /f "tokens=*" %%i in ('ping -n 10 37.153.1.5') do call:echo "%%i"
::ping -n 10 37.153.1.5 >> %log%

echo    - Ping 10x to Mail.ru
echo    ************ Ping 10x to Mail.ru ************ >> %log%
for /f "tokens=*" %%i in ('ping -n 10 mail.ru') do call:echo "%%i"
::ping -n 10 mail.ru >> %log%

echo    - Ping 10x to Yahoo.com
echo    ************ Ping 10x to Yahoo.com ************ >> %log%
for /f "tokens=*" %%i in ('ping -n 10 yahoo.com') do call:echo "%%i"
::ping -n 10 yahoo.com >> %log%



echo    - Trace to Google-DNS
echo    ************ Trace to Google-DNS ************ >> %log%
for /f "tokens=*" %%i in ('tracert -d -w 2000 8.8.8.8') do call:echo "%%i"
::tracert -d -w 2000 8.8.8.8 >> %log%

echo    - Trace to 109.167.190.190 (Lan-IX.Ru, PEERING)
echo    ************ Trace to 109.167.190.190 (Lan-IX.Ru, PEERING) ************ >> %log%
for /f "tokens=*" %%i in ('tracert -d -w 2000 109.167.190.190') do call:echo "%%i"
::tracert -d -w 2000 109.167.190.190 >> %log%

echo    - Trace to 178.18.224.100 (DataIX-1, PEERING)
echo    ************ Trace to 178.18.224.100 (DataIX-1, PEERING) ************ >> %log%
for /f "tokens=*" %%i in ('tracert -d -w 2000 178.18.224.100') do call:echo "%%i"
::tracert -d -w 2000 178.18.224.100 >> %log%

echo    - Trace to 178.18.227.100 (DataIX-2, PEERING)
echo    ************ Trace to 178.18.227.100 (DataIX-2, PEERING) ************ >> %log%
for /f "tokens=*" %%i in ('tracert -d -w 2000 178.18.227.100') do call:echo "%%i"
::tracert -d -w 2000 178.18.227.100 >> %log%

echo    - Trace to 193.28.6.1 (Pirix, PEERING)
echo    ************ Trace to 193.28.6.1 (Pirix, PEERING) ************ >> %log%
for /f "tokens=*" %%i in ('tracert -d -w 2000 193.28.6.1') do call:echo "%%i"
::tracert -d -w 2000 193.28.6.1 >> %log%

echo    - Trace to 185.47.53.153 (Comfortel, INET)
echo    ************ Trace to 185.47.53.153 (Pirix, PEERING) ************ >> %log%
for /f "tokens=*" %%i in ('tracert -d -w 2000 185.47.53.153') do call:echo "%%i"
::tracert -d -w 2000 185.47.53.153 >> %log%

echo    - Trace to WEBA.RU
echo    ************ Trace to WEBA.RU ************ >> %log%
for /f "tokens=*" %%i in ('tracert -w 2000 weba.ru') do call:echo "%%i"
::tracert -w 2000 weba.ru >> %log%

echo    - Name resolving tests
echo    ************ Name resolving tests ************ >> %log%
for /f "tokens=*" %%i in ('nslookup weba.ru.') do call:echo "%%i"
for /f "tokens=*" %%i in ('nslookup mail.ru.') do call:echo "%%i"
for /f "tokens=*" %%i in ('nslookup google.ru.') do call:echo "%%i"
for /f "tokens=*" %%i in ('nslookup google.cn.') do call:echo "%%i"
for /f "tokens=*" %%i in ('nslookup cisco.com.') do call:echo "%%i"
for /f "tokens=*" %%i in ('nslookup microsoft.com.') do call:echo "%%i"
for /f "tokens=*" %%i in ('nslookup drweb.com.') do call:echo "%%i"
for /f "tokens=*" %%i in ('nslookup kaspersky.com.') do call:echo "%%i"
for /f "tokens=*" %%i in ('nslookup dataix.ru.') do call:echo "%%i"
for /f "tokens=*" %%i in ('nslookup lan-ix.ru.') do call:echo "%%i"
::nslookup weba.ru. >> %log%
::nslookup mail.ru. >> %log%
::nslookup google.ru. >> %log%
::nslookup google.cn. >> %log%
::nslookup cisco.com. >> %log%
::nslookup microsoft.com. >> %log%
::nslookup drweb.com. >> %log%
::nslookup kaspersky.com. >> %log%
::nslookup dataix.ru. >> %log%
::nslookup lan-ix.ru. >> %log%


echo ~
echo =-=-=-=-=   Diagnostic finished.   =-=-=-=-=
echo =-=-=-=-=   Diagnostic finished.   =-=-=-=-= >> %log%
echo ~
echo =-= Send %log% to support@weba.ru =-=
echo =-= from %HOMEPATH% =-=
echo ~
echo =-=-=-=-=   CIIACU6O.   =-=-=-=-=
pause
goto:eof

:echo
if %1=="" (1>>"%log%" echo. && goto:eof)

1>nul chcp 1251

set "str=%~1"
set "str=%str:/=^/%"
set "str=%str:>=^>%"
set "str=%str:<=^<%"

1>>"%log%" echo %str%

1>nul chcp 866

rem  Make by syd
