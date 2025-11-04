@echo off
title WinBoost v1.0
color 0B
openfiles >nul 2>nul
if %errorlevel% neq 0 (
    echo Demande des droits administrateur...
    powershell -command "Start-Process '%~f0' -Verb RunAs"
    exit
)

goto main

:main
    cls

    echo. =====================================
    echo. ============ WinBoost ===============
    echo. =====================================
    echo.
    echo. [Cleaning]
    echo. 1. Clean Temp / Download
    echo. 2. Flush DNS
    echo.
    echo. [OPTIMIZATION / REPAIR]
    echo. 3. Set High Performance
    echo. 4. Run System File Checker (SFC)
    echo. 5. Run DISM Repair Tool
    echo. 6. Disable Unnecessary Services 
    echo. 7. Optimize All Disk
    echo.
    echo. 8. Restore Defaults

set /p choix="Choice : "


if /I "%choix%"=="1" goto clean_temp
if /I "%choix%"=="2" goto flush_dns
if /I "%choix%"=="3" goto high_performance
if /I "%choix%"=="4" goto SFC
if /I "%choix%"=="5" goto DISM
if /I "%choix%"=="6" goto unnecessary_services
if /I "%choix%"=="7" goto opti_disk
if /I "%choix%"=="8" goto restore_defaults

 

:clean_temp
    cls
    echo Clean Temp          En Cours...
    del /F /S /Q "C:\Windows\Temp\*.*" >nul 2>nul
    del /F /S /Q "%TEMP%\*.*" >nul 2>nul
    for /d %%D in ("%TEMP%\*") do rd /S /Q "%%D" >nul 2>nul
    for /d %%D in ("C:\Windows\Temp\*") do rd /S /Q "%%D" >nul 2>nul
    echo Clean Temp          Done
    echo.
    echo Clean Download      En Cours...
    del /F /S /Q "%USERPROFILE%\Downloads\*.*" >nul 2>nul
    for /d %%D in ("%USERPROFILE%\Downloads\*") do rd /S /Q "%%D" >nul 2>nul
    echo Clean Download      Done
    echo.
    echo Finished

    pause 
    goto main

:flush_dns
    cls 
    echo Clean DNS          En Cours...
    ipconfig /flushdns >nul 2>nul
    echo Clean DNS          Done

    echo.
    echo Finished

    pause
    goto main

:high_performance
cls

echo Set High Performance           En Cours...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo Set High Performance           Done

echo.
echo Finished

pause
goto main

:SFC
cls

echo Run System File Checker (SFC)          En Cours...
sfc /scannow 
echo Run System File Checker (SFC)          Done

echo.
echo Finished

pause
goto main

:DISM
cls

echo Run DISM Repair Tool           En Cours...
DISM /Online /Cleanup-Image /RestoreHealth
echo Run DISM Repair Tool           Done

echo.
echo Finished

pause
goto main

:unnecessary_services
cls

echo Stop SysMain               En Cours...
sc stop "SysMain" >nul 2>nul
sc config "SysMain" start=disabled >nul 2>nul
echo Stop SysMain               Done

echo.
echo Stop Windows Search        En Cours...
sc stop "WSearch" >nul 2>nul
sc config "WSearch" start=disabled >nul 2>nul
echo Stop Window Search         Done

echo.
echo Disable Telemetry          En Cours...
sc stop "DiagTrack" >nul 2>nul
sc config "DiagTrack" start=disabled >nul 2>nul
echo Disable Telemetry          Done

echo.
echo Disable P2P Updates        En Cours...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>nul
echo Disable P2P Updates        Done

echo.
echo Disable Hibernation        En Cours...
powercfg /hibernate off >nul 2>nul
echo Disable Hibernation        Done

echo.
echo Disable Xbox Services      En Cours...
sc stop "XblAuthManager" >nul 2>nul
sc config "XblAuthManager" start=disabled >nul 2>nul

sc stop "XblGameSave" >nul 2>nul
sc config "XblGameSave" start=disabled >nul 2>nul

sc stop "XboxGipSvc" >nul 2>nul
sc config "XboxGipSvc" start=disabled >nul 2>nul

sc stop "XboxNetApiSvc" >nul 2>nul
sc config "XboxNetApiSvc" start=disabled >nul 2>nul
echo Disable Xbox Services      Done

echo.
echo Stop Maps App              En Cours...
sc stop "MapsBroker" >nul 2>nul
sc config "MapsBroker" start=disabled >nul 2>nul
echo Stop Maps App              Done

echo. 
echo Ajust Visual Effects       En Cours...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul 2>nul
echo Ajust Visual Effects       Done

echo.
echo Advanced Windows Update Cleanup            En Cours...
Dism.exe /online /Cleanup-Image /StartComponentCleanup
echo Advanced Windows Update Cleanup            Done

echo.
echo Finished

pause
goto main


:opti_disk
cls

echo Optimize All Disks             En Cours...
defrag /C /O
echo Optimize All Disks             Done

echo. 
echo Finished

pause 
goto main

:restore_defaults
    cls
    echo   Restoring all services and settings to default...
    echo   (This may take a moment)
    echo.
    
    rem --- SERVICES ---
    echo   Re-enabling Telemetry...
    sc config "DiagTrack" start=auto >nul 2>nul
    sc start "DiagTrack" >nul 2>nul
    
    echo   Re-enabling SysMain (Superfetch)...
    sc config "SysMain" start=auto >nul 2>nul
    sc start "SysMain" >nul 2>nul

    echo   Re-enabling Windows Search...
    sc config "WSearch" start=auto >nul 2>nul
    sc start "WSearch" >nul 2>nul
    
    echo   Re-enabling Xbox services...
    sc config "XblAuthManager" start=demand >nul 2>nul
    sc config "XblGameSave" start=demand >nul 2>nul
    sc config "XboxGipSvc" start=demand >nul 2>nul
    sc config "XboxNetApiSvc" start=demand >nul 2>nul
    
    rem --- REGISTRY & POWER ---
    echo   Re-enabling P2P Updates...
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 3 /f >nul 2>nul
    
    echo   Re-enabling Hibernation...
    powercfg /hibernate on >nul 2>nul
    
    echo   Restoring default visual effects...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 0 /f >nul 2>nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul 2>nul

    echo.
    echo   All settings have been restored to default.
    echo   A restart might be required for all changes to take effect.
    echo.
    pause >nul
    goto main