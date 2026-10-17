@echo off
setlocal
title GTFO Airfield Lighting Installer

set "SCRIPT_FILE=%~dp0installer\install-gtfo-airfield-lighting.ps1"
if not exist "%SCRIPT_FILE%" set "SCRIPT_FILE=%~dp0install-gtfo-airfield-lighting.ps1"

if not exist "%SCRIPT_FILE%" (
    set "SCRIPT_FILE=%TEMP%\gtfo-airfield-lighting-installer.ps1"
    echo  [....] Fetching latest installer script from GitHub...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "$uris = @('https://raw.githubusercontent.com/pschilly/gtfo-airfield-lighting/master/installer/install-gtfo-airfield-lighting.ps1', 'https://raw.githubusercontent.com/pschilly/gtfo-airfield-lighting/main/installer/install-gtfo-airfield-lighting.ps1'); $success = $false; foreach ($uri in $uris) { try { Invoke-WebRequest -Uri $uri -OutFile '%TEMP%\gtfo-airfield-lighting-installer.ps1' -Headers @{'User-Agent'='GTFO-Airfield-Lighting-Installer'} -ErrorAction Stop; $success = $true; break } catch {} }; if (-not $success) { Write-Host '  [ERROR] Failed to download installer script from GitHub.' -ForegroundColor Red; exit 1 }"
    if %ERRORLEVEL% NEQ 0 (
        echo.
        echo  Please check your internet connection and try again.
        pause
        exit /b 1
    )
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_FILE%"
exit /b %ERRORLEVEL%
