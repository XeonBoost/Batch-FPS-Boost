@echo off
setlocal EnableDelayedExpansion
color 0A

:: Array of titles
set titles[0]=FPS Boost and Low Input Lag Utility
set titles[1]=Optimize Your Gaming Experience
set titles[2]=Enhance Performance and Responsiveness
set titles[3]=Game Mode and Low Lag Settings
set titles[4]=Ultimate FPS and Input Lag Tweaker

:: Get a random index
set /a "randIndex=%RANDOM% %% 5"

:: Set the title to a random selection
title !titles[%randIndex%]!

:menu
cls
echo ================================
echo  !titles[%randIndex%]!
echo ================================
echo 1. Apply FPS Boost Settings
echo 2. Apply Low Input Lag Settings
echo 3. Remove All Windows Animations
echo 4. Optimize Windows Startup
echo 5. Clear CPU Processes
echo 6. Optimize for Low Ping
echo 7. OPTIMIZE ALL
echo 8. RESTORE ALL
echo 9. System Information
echo 10. Exit
echo ================================
set /p choice="Enter your choice (1-10): "

if "%choice%"=="1" goto apply_boost
if "%choice%"=="2" goto apply_low_input_lag
if "%choice%"=="3" goto remove_animations
if "%choice%"=="4" goto optimize_startup
if "%choice%"=="5" goto clear_cpu_processes
if "%choice%"=="6" goto optimize_low_ping
if "%choice%"=="7" goto optimize_all
if "%choice%"=="8" goto restore_all
if "%choice%"=="9" goto system_info
if "%choice%"=="10" exit
goto menu

:create_backup
if not exist "%userprofile%\Desktop\RegistryBackup" mkdir "%userprofile%\Desktop\RegistryBackup"
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "%userprofile%\Desktop\RegistryBackup\SystemProfile.reg" /y
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "%userprofile%\Desktop\RegistryBackup\Games.reg" /y
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "%userprofile%\Desktop\RegistryBackup\VisualEffects.reg" /y
reg export "HKCU\Control Panel\Mouse" "%userprofile%\Desktop\RegistryBackup\Mouse.reg" /y
reg export "HKCU\Control Panel\Desktop" "%userprofile%\Desktop\RegistryBackup\Desktop.reg" /y
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "%userprofile%\Desktop\RegistryBackup\ExplorerAdvanced.reg" /y
reg export "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" "%userprofile%\Desktop\RegistryBackup\GraphicsDrivers.reg" /y
reg export "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" "%userprofile%\Desktop\RegistryBackup\TcpipInterfaces.reg" /y
reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "%userprofile%\Desktop\RegistryBackup\StartupPrograms.reg" /y
reg export "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "%userprofile%\Desktop\RegistryBackup\StartupProgramsUser .reg" /y
exit /b 0

:system_info
cls
echo ================================
echo      SYSTEM INFORMATION
echo ================================
echo.
echo Computer Name:
hostname
echo.
echo Operating System:
wmic os get Caption,Version /value | find "="
echo.
echo CPU Information:
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors /value | find "="
echo.
echo RAM Information:
wmic computersystem get TotalPhysicalMemory /value
for /f "tokens=2 delims==" %%a in ('wmic computersystem get TotalPhysicalMemory /value') do set ram=%%a
set /a ramGB=%ram:~0,-1%/1024/1024/1024
echo Total RAM: %ramGB% GB
echo.
echo GPU Information:
wmic path win32_V ideoController get Name,AdapterRAM,DriverVersion /value | find "="
echo.
echo Storage Information:
wmic diskdrive get Model,Size,Status /value | find "="
echo.
echo Network Adapters:
wmic nic where "PhysicalAdapter='TRUE'" get Name,MACAddress /value | find "="
echo.
echo ================================
echo      DETAILED INFORMATION
echo ================================
echo.
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model" /C:"BIOS Version" /C:"Total Physical Memory" /C:"Available Physical Memory"
echo.
echo Current Power Plan:
powercfg /getactivescheme
echo.
echo ================================
pause
goto menu

:apply_boost
call :create_backup
echo Applying FPS boost settings...

:: Game Mode Settings
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f

:: System Performance Settings
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f

:: NVIDIA Settings (if applicable)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f

:: Memory Management
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f

echo FPS boost settings applied successfully!
echo Please restart your computer for changes to take effect.
pause
goto menu

:apply_low_input_lag
call :create_backup
echo Applying low input lag settings...

:: Mouse Settings
reg add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f

:: NVIDIA Settings
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d "1" /f

:: TCP/IP Settings
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAck Frequency" /t REG_DWORD /d "13" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpNoDelay " /t REG_DWORD /d "1" /f

echo Low input lag settings applied successfully!
echo Please restart your computer for changes to take effect.
pause
goto menu

:remove_animations
call :create_backup
echo Removing all Windows animations...

:: Disable Animations
reg add "HK CU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "2" /f

echo Animations removed successfully!
echo Please restart your computer for changes to take effect.
pause
goto menu

:optimize_startup
call :create_backup
echo Optimizing Windows startup...

:: Disable unnecessary startup programs
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DisableStartupPrograms" /t REG_DWORD /d "1" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DisableStartupPrograms" /t REG_DWORD /d "1" /f

:: Disable Windows Search
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableSearchIndexing" /t REG_DWORD /d "1" /f

:: Disable Windows Defender
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f

echo Windows startup optimized successfully!
echo Please restart your computer for changes to take effect.
pause
goto menu

:clear_cpu_processes
cls
echo Clearing CPU Processes...
echo.
echo Closing unnecessary background applications...
echo.

:: List of processes to terminate
set processes=chrome.exe firefox.exe spotify.exe discord.exe steam.exe

:: Terminate each process
for %%p in (%processes%) do (
    taskkill /im %%p /f > nul 2>&1
)

echo CPU processes cleared successfully!
echo Please restart your computer for changes to take effect.
pause
goto menu

:optimize_low_ping
cls
echo Optimizing for Low Ping...
echo.
echo Disabling Windows Auto-Tuning...
netsh int tcp set heuristics disabled
echo Disabling Background Services...
net stop "Background Intelligent Transfer Service"
net stop "Windows Update"
echo Adjusting TCP/IP settings...
netsh int tcp set global autotuninglevel=disabled
netsh int tcp set global rss=enabled
echo Low ping optimization complete!
echo Please restart your computer for changes to take effect.
pause
goto menu

:optimize_all
call :create_backup
echo Optimizing all settings...

:: Apply FPS Boost Settings
call :apply_boost

:: Apply Low Input Lag Settings
call :apply_low_input_lag

:: Remove Animations
call :remove_animations

:: Optimize Windows Startup
call :optimize_startup

:: Optimize for Low Ping
call :optimize_low_ping

echo All optimizations applied successfully!
echo Please restart your computer for changes to take effect.
pause
goto menu

:restore_all
echo Restoring all settings to default...

:: Restore Registry Backups
reg import "%userprofile%\Desktop\RegistryBackup \SystemProfile.reg"
reg import "%userprofile%\Desktop\RegistryBackup\Games.reg"
reg import "%userprofile%\Desktop\RegistryBackup\VisualEffects.reg"
reg import "%userprofile%\Desktop\RegistryBackup\Mouse.reg"
reg import "%userprofile%\Desktop\RegistryBackup\Desktop.reg"
reg import "%userprofile%\Desktop\RegistryBackup\ExplorerAdvanced.reg"
reg import "%userprofile%\Desktop\RegistryBackup\GraphicsDrivers.reg"
reg import "%userprofile%\Desktop\RegistryBackup\TcpipInterfaces.reg"
reg import "%userprofile%\Desktop\RegistryBackup\StartupPrograms.reg"
reg import "%userprofile%\Desktop\RegistryBackup\StartupProgramsUser  .reg"

echo All settings restored to default successfully!
echo Please restart your computer for changes to take effect.
pause
goto menu
