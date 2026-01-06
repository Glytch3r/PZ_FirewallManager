@echo off
setlocal EnableDelayedExpansion
title Project Zomboid Firewall Manager

:CHECK_ADMIN
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo ERROR: Run this script as Administrator.
    pause
    exit /b 1
)

:MENU
cls
echo ======================================
echo   Project Zomboid Firewall Manager
echo ======================================
echo.
echo 1. OpenPorts
echo 2. ClosePorts
echo 3. CheckPorts
echo 4. NuclearDelete
echo 5. Exit
echo.
set /p choice=Select an option [1-5]: 

if "%choice%"=="1" goto OPEN
if "%choice%"=="2" goto CLOSE
if "%choice%"=="3" goto CHECK
if "%choice%"=="4" goto NUCLEAR
if "%choice%"=="5" goto EXIT

goto MENU

:OPEN
echo Opening firewall ports...
netsh advfirewall firewall add rule name="PZ Server 16261 UDP" dir=in action=allow protocol=UDP localport=16261
netsh advfirewall firewall add rule name="PZ Server 16262 UDP" dir=in action=allow protocol=UDP localport=16262
netsh advfirewall firewall add rule name="PZ Steam 8766 UDP" dir=in action=allow protocol=UDP localport=8766
netsh advfirewall firewall add rule name="PZ Steam 8767 UDP" dir=in action=allow protocol=UDP localport=8767
echo Done.
pause
goto MENU

:CLOSE
echo Deleting named firewall rules...
netsh advfirewall firewall delete rule name="PZ Server 16261 UDP"
netsh advfirewall firewall delete rule name="PZ Server 16262 UDP"
netsh advfirewall firewall delete rule name="PZ Steam 8766 UDP"
netsh advfirewall firewall delete rule name="PZ Steam 8767 UDP"
echo Done.
pause
goto MENU

:CHECK
echo Checking firewall rules...
echo.
netsh advfirewall firewall show rule name=all | findstr /i "16261 16262 8766 8767"
echo.
pause
goto MENU

:NUCLEAR
echo WARNING: This will delete ANY firewall rule using these ports.
echo.
pause
netsh advfirewall firewall delete rule protocol=UDP localport=16261
netsh advfirewall firewall delete rule protocol=UDP localport=16262
netsh advfirewall firewall delete rule protocol=UDP localport=8766
netsh advfirewall firewall delete rule protocol=UDP localport=8767
echo Done.
pause
goto MENU

:EXIT
exit /b
