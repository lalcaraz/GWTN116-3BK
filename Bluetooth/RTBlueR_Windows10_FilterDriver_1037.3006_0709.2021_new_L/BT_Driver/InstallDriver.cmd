@echo off
setlocal enabledelayedexpansion

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    wscript "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------


echo **************************************************************
echo ***  Batch Install Realtek Bluetooth Filter Driver               
echo ***                                                            
echo ***  Please wait a moment	                  
echo=

if %PROCESSOR_ARCHITECTURE%==AMD64 (
    set BTDIR="C:\Program Files (x86)\REALTEK\Realtek Bluetooth"
    set DriverSrcPath=%~dp0Win10x64
)
if %PROCESSOR_ARCHITECTURE%==x86 (
    set BTDIR="C:\Program Files\REALTEK\Realtek Bluetooth"
    set DriverSrcPath=%~dp0Win10x86
)

set var=%BTDIR:~1,-1%

xcopy /y "%DriverSrcPath%\*" "%var%\" /s /e

pnputil /add-driver "%var%\*.inf" /install >%BTDIR%\pnp.log

echo=     
echo **************************************************************
echo ***  Driver Install Finished                                       
echo=

rem if exist %sourcePath% (rd /s/q %sourcePath%) -> Add these two command
popd