@echo off
setlocal EnableDelayedExpansion
title PZ Firewall Manager

net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo ERROR: Run this script as Administrator.
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
echo Removing named firewall rules...
for /L %%P in (16261,1,16272) do (
    netsh advfirewall firewall delete rule name="PZ UDP %%P" >nul
)

netsh advfirewall firewall delete rule name="PZ Steam 8766 UDP" >nul
netsh advfirewall firewall delete rule name="PZ Steam 8767 UDP" >nul

echo Done.
pause
goto MENU

:CHECK
cls
echo ======================================
echo   PZ Firewall Manager  by  Glytch3r
echo ======================================
echo.
echo Checking UDP ports 16261-16272:
echo.

for /L %%P in (16261,1,16272) do (
    netsh advfirewall firewall show rule name="PZ UDP %%P" >nul 2>&1
    if !errorlevel! EQU 0 (
        echo UDP %%P : FOUND
    ) else (
        echo UDP %%P : NOT FOUND
    )
)

echo.
netsh advfirewall firewall show rule name="PZ Steam 8766 UDP" >nul 2>&1
if %errorlevel% EQU 0 (
    echo UDP 8766 : FOUND
) else (
    echo UDP 8766 : NOT FOUND
)

netsh advfirewall firewall show rule name="PZ Steam 8767 UDP" >nul 2>&1
if %errorlevel% EQU 0 (
    echo UDP 8767 : FOUND
) else (
    echo UDP 8767 : NOT FOUND
)

pause
goto MENU

:NUCLEAR
echo WARNING:
echo This will delete ALL firewall rules using PZ ports.
echo.
pause

for /L %%P in (16261,1,16272) do (
    netsh advfirewall firewall delete rule protocol=UDP localport=%%P >nul
)

netsh advfirewall firewall delete rule protocol=UDP localport=8766 >nul
netsh advfirewall firewall delete rule protocol=UDP localport=8767 >nul

echo Done.
pause
goto MENU
