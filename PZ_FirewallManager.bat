@echo off
setlocal EnableDelayedExpansion
title Project Zomboid Firewall Manager

net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo ERROR: Run as Administrator.
    pause
    exit /b 1
)

:MENU
cls
echo ======================================
echo   PZ Firewall Manager  by  Glytch3r
echo ======================================
echo.
echo 1. OpenPorts
echo 2. ClosePorts
echo 3. CheckPorts
echo 4. NuclearDelete
echo 5. Exit
echo.
set /p choice=Select option [1-5]: 

if "%choice%"=="1" goto OPEN
if "%choice%"=="2" goto CLOSE
if "%choice%"=="3" goto CHECK
if "%choice%"=="4" goto NUCLEAR
if "%choice%"=="5" exit /b

goto MENU

:OPEN
echo Opening UDP ports 16261-16272...
for /L %%P in (16261,1,16272) do (
    netsh advfirewall firewall add rule name="PZ UDP %%P" dir=in action=allow protocol=UDP localport=%%P >nul
)

netsh advfirewall firewall add rule name="PZ Steam 8766 UDP" dir=in action=allow protocol=UDP localport=8766 >nul
netsh advfirewall firewall add rule name="PZ Steam 8767 UDP" dir=in action=allow protocol=UDP localport=8767 >nul

echo Done.
pause
goto MENU

:CLOSE
echo Removing named PZ firewall rules...
for /L %%P in (16261,1,16272) do (
    netsh advfirewall firewall delete rule name="PZ UDP %%P" >nul
)

netsh advfirewall firewall delete rule name="PZ Steam 8766 UDP" >nul
netsh advfirewall firewa
