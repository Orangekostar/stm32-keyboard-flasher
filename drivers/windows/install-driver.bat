@echo off
setlocal enabledelayedexpansion
title STM32 Keyboard - Maple 003 Driver Installer

echo ============================================
echo   STM32F103 Keyboard - Driver Installer
echo   Maple 003 Bootloader (1EAF:0003)
echo ============================================
echo.

:: Check if running as admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Not running as Administrator!
    echo Zadig needs admin rights to install drivers.
    echo Please right-click this script and select "Run as Administrator"
    echo.
    pause
    exit /b 1
)

echo [INFO] Detected Administrator privileges.
echo.

:: Step 1: Download Zadig if not present
set "ZADIG_URL=https://github.com/pbatard/libwdi/releases/download/v1.5.1/zadig-2.9.exe"
set "ZADIG_EXE=%~dp0zadig.exe"

if not exist "%ZADIG_EXE%" (
    echo [STEP 1/3] Downloading Zadig...
    echo URL: %ZADIG_URL%
    echo.

    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%ZADIG_URL%' -OutFile '%ZADIG_EXE%' -UseBasicParsing}"

    if %errorlevel% neq 0 (
        echo.
        echo [ERROR] Failed to download Zadig.
        echo Please download it manually from:
        echo   https://zadig.akeo.ie/
        echo And save it as: %ZADIG_EXE%
        echo.
        pause
        exit /b 1
    )
    echo [OK] Zadig downloaded successfully.
) else (
    echo [STEP 1/3] Zadig already downloaded.
)
echo.

:: Step 2: Remind user to connect keyboard in DFU mode
echo [STEP 2/3] Connect your keyboard in DFU mode:
echo.
echo    >>> HOLD the ESC key while plugging in the USB cable <<<
echo.
echo    Keep holding ESC until the keyboard is connected.
echo.
echo    Press any key when ready...
pause >nul
echo.

:: Step 3: Launch Zadig
echo [STEP 3/3] Launching Zadig...
echo.
echo ============================================
echo   INSTRUCTIONS FOR ZADIG:
echo ============================================
echo.
echo 1. In Zadig, click "Options" -> "List All Devices"
echo 2. Select "Maple 003" from the dropdown
echo    (VID=1EAF, PID=0003)
echo 3. Select "WinUSB" as the driver (right side)
echo 4. Click "Install Driver" or "Replace Driver"
echo 5. Wait for "The driver was installed successfully"
echo 6. Close Zadig
echo.
echo ============================================
echo.
echo Launching Zadig now...

start "" "%ZADIG_EXE%"

echo.
echo After the driver is installed, your keyboard will be
echo ready for flashing! Open index.html in Chrome/Edge
echo and click "Connect Device" to get started.
echo.
echo Press any key to exit...
pause >nul
exit /b 0
