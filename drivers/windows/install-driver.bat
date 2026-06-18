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
    echo [ERROR] Not running as Administrator!
    echo.
    echo Please right-click this script and select "Run as Administrator"
    echo.
    pause
    exit /b 1
)
echo [OK] Administrator privileges detected.
echo.

:: Step 1: Check wdi-simple.exe
set "WDI_EXE=%~dp0wdi-simple.exe"
set "WDI_URL=https://github.com/Orangekostar/stm32-keyboard-flasher/raw/main/drivers/windows/wdi-simple.exe"

if not exist "%WDI_EXE%" (
    echo [STEP 1/2] Downloading wdi-simple.exe...
    powershell -Command ^
      "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;" ^
      "Invoke-WebRequest -Uri '%WDI_URL%' -OutFile '%WDI_EXE%' -UseBasicParsing"
    if %errorlevel% neq 0 (
        echo [ERROR] Download failed.
        echo Please download the full package from:
        echo   https://github.com/Orangekostar/stm32-keyboard-flasher
        pause
        exit /b 1
    )
    echo [OK] wdi-simple.exe downloaded.
) else (
    echo [STEP 1/2] wdi-simple.exe found locally.
)
echo.

:: Step 2: Install driver
echo [STEP 2/2] Installing WinUSB driver for Maple 003...
echo.
"%WDI_EXE%" --vid 0x1EAF --pid 0x0003 -t 0 -n "Maple 003 Bootloader" -s

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Driver installation failed.
    echo Make sure the keyboard is plugged in:
    echo    >>> HOLD the ESC key while plugging in the USB cable <<<
    echo Then re-run this script.
    echo.
    pause
    exit /b 1
)
echo.
echo [OK] WinUSB driver installed successfully!

echo.
echo ============================================
echo   Driver installation complete!
echo ============================================
echo.
echo Your Maple 003 keyboard is now ready for flashing.
echo Reload the flasher page and click "Connect Device".
echo.
echo Press any key to exit...
pause >nul
exit /b 0
