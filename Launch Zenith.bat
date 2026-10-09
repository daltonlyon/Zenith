@echo off
title Zenith
cd /d "%~dp0"

:: Ask for Administrator rights (needed to change system settings)
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: Remove the "downloaded from the internet" block, then start the app without a console window
powershell -NoProfile -ExecutionPolicy Bypass -Command "Unblock-File -LiteralPath '%~dp0Zenith.ps1'" >nul 2>&1
start "" powershell.exe -NoProfile -ExecutionPolicy Bypass -STA -WindowStyle Hidden -File "%~dp0Zenith.ps1"
exit /b
