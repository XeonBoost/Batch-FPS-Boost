    @echo off
    setlocal EnableDelayedExpansion
    color 0A

    set titles[0]=FPS Boost and Low Input Lag Utility
    set titles[1]=Optimize Your Gaming Experience
    set titles[2]=Enhance Performance and Responsiveness
    set titles[3]=Game Mode and Low Lag Settings
    set titles[4]=Ultimate FPS and Input Lag Tweaker
    set titles[5]=Turbocharge Your Gaming PC
    set titles[6]=Unleash Maximum FPS Potential
    set titles[7]=Revolutionize Your Gaming Experience
    set titles[8]=Extreme Performance Optimization
    set titles[9]=FPS Boost and Lag Reduction Expert
    set titles[10]=Transform Your Gaming Rig

    :: Get a random index
    set /a "randIndex=%RANDOM% %% 11"

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
    echo 10. Restart Explorer.exe
    echo 11. Stop Useless Services
    echo 12. Clear Temp Files and Prefetch Files
    echo 0. Exit
    echo ================================
    set /p choice="Enter your choice (1-13): "

    if "%choice%"=="1" goto apply_boost
    if "%choice%"=="2" goto apply_low_input_lag
    if "%choice%"=="3" goto remove_animations
    if "%choice%"=="4" goto optimize_startup
    if "%choice%"=="5" goto clear_cpu_processes
    if "%choice%"=="6" goto optimize_low_ping
    if "%choice%"=="7" goto optimize_all
    if "%choice%"=="8" goto restore_all
    if "%choice%"=="9" goto system_info
    if "%choice%"=="10" goto restart_explorer
    if "%choice%"=="11" goto stop_start_useless_service
    if "%choice%"=="12" goto clear_temp_prefetch
    if "%choice%"=="0" exit
    goto menu

    :create_backup
    if not exist "%userprofile%\Desktop\RegistryBackup" mkdir "%userprofile%\Desktop\RegistryBackup"
    echo Creating comprehensive backup...

    :: System Profile
    reg export "HKLM\SOFTWARE\Microsoft\Winedows NT\CurrentVersion\Multimedia\SystemProfile" "%userprofile%\Desktop\RegistryBackup\SystemProfile.reg" /y

    :: Games Settings
    reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "%userprofile%\Desktop\RegistryBackup\Games.reg" /y

    :: Visual Effects
    reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "%userprofile%\Desktop\RegistryBackup\VisualEffects.reg" /y

    :: Mouse Settings
    reg export "HKCU\Control Panel\Mouse" "%userprofile%\Desktop\RegistryBackup\Mouse.reg" /y

    :: Desktop Settings
    reg export "HKCU\Control Panel\Desktop" "%userprofile%\Desktop\RegistryBackup\Desktop.reg" /y

    :: Explorer Advanced Settings
    reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "%userprofile%\Desktop\RegistryBackup\ExplorerAdvanced.reg" /y

    :: Graphics Drivers Settings
    reg export "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" "%userprofile%\Desktop\RegistryBackup\GraphicsDrivers.reg" /y

    :: TCP/IP Settings
    reg export "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" "%userprofile%\Desktop\RegistryBackup\TcpipParameters.reg" /y
    reg export "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" "%userprofile%\Desktop\RegistryBackup\TcpipInterfaces.reg" /y

    :: Startup Programs
    reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "%userprofile%\Desktop\RegistryBackup\StartupPrograms.reg" /y
    reg export "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "%userprofile%\Desktop\RegistryBackup\StartupProgramsUser.reg" /y

    :: Windows Search
    reg export "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "%userprofile%\Desktop\RegistryBackup\WindowsSearch.reg" /y

    :: Windows Defender
    reg export "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" "%userprofile%\Desktop\RegistryBackup\WindowsDefender.reg" /y

    :: Network Adapters
    reg export "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" "%userprofile%\Desktop\RegistryBackup\NetworkAdapters.reg" /y

    :: Power Settings
    reg export "HKLM\SYSTEM\CurrentControlSet\Control\Power" "%userprofile%\Desktop\RegistryBackup\PowerSettings.reg" /y

    :: System Services
    reg export "HKLM\SYSTEM\CurrentControlSet\Services" "%userprofile%\Desktop\RegistryBackup\SystemServices.reg" /y

    echo Backup created successfully in %userprofile%\Desktop\RegistryBackup
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
    wmic path win32_VideoController get Name,AdapterRAM,DriverVersion /value | find "="
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
    reg add " HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "Priority" /t REG_DWORD /d "1" /f

    :: Graphics Settings
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "1" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "1" /f

    echo FPS boost settings applied successfully!
    pause
    goto menu

    :apply_low_input_lag
    call :create_backup
    echo Applying low input lag settings...

    :: Mouse Settings
    reg add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f
    reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "10" /f

    :: Keyboard Settings
    reg add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f
    reg add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f

    :: Graphics Settings
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GraphicsPriority" /t REG_DWORD /d "1" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "1" /f

    echo Low input lag settings applied successfully!
    pause
    goto menu

    :remove_animations
    call :create_backup
    echo Removing all Windows animations...

    :: Disable Animations
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AnimationDuration" /t REG_DWORD /d "0" /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "0" /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d "0" /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f

    echo All Windows animations removed successfully!
    pause
    goto menu

    :optimize_startup
    call :create_backup
    echo Optimizing Windows startup...

    :: Disable Startup Programs
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DisableStartup" /t REG_DWORD /d "1" /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DisableStartup" /t REG_DWORD /d "1" /f

    :: Disable Startup Services
    reg add "HKLM\SYSTEM\CurrentControlSet\Services" /v "DisableStartup" /t REG_DWORD /d "1" /f

    echo Windows startup optimized successfully!
    pause
    goto menu

    :clear_cpu_processes
    call :create_backup
    echo Clearing CPU processes...

    :: Clear CPU Processes
    taskkill /im explorer.exe /f
    taskkill /im dwm.exe /f
    taskkill /im RuntimeBroker.exe /f
    taskkill /im SearchUI.exe /f
    taskkill /im ShellExperienceHost.exe /f
    taskkill /im WindowsInternal.ComposableShell.Experiences.TextInput.InputApp.exe /f
    start explorer.exe
    echo CPU processes cleared successfully!
    pause
    goto menu

    :optimize_low_ping
    call :create_backup
    echo Optimizing for low ping...

    :: Disable Nagle's Algorithm
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpNoDelay" /t REG_DWORD /d "1" /f

    :: Disable Large Send Offload
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableLso" /t REG_DWORD /d "0" /f

    :: Disable Receive-Side Scaling
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableRSS" /t REG_DWORD /d "0" /f

    echo Low ping optimization applied successfully!
    pause
    goto menu

    :optimize_all
    call :create _backup
    echo Optimizing all settings...

    :: Apply FPS Boost Settings
    call :apply_boost

    :: Apply Low Input Lag Settings
    call :apply_low_input_lag

    :: Remove All Windows Animations
    call :remove_animations

    :: Optimize Windows Startup
    call :optimize_startup

    :: Clear CPU Processes
    call :clear_cpu_processes

    :: Optimize for Low Ping
    call :optimize_low_ping

    echo All optimizations applied successfully!
    pause
    goto menu

    :restore_all
    call :create_backup
    echo Restoring all settings to default...

    :: Restore Game Mode Settings
    reg delete "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /f
    reg delete "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /f

    :: Restore System Performance Settings
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /f
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /f
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "Priority" /f

    :: Restore Graphics Settings
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /f
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /f

    :: Restore Mouse Settings
    reg delete "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /f
    reg delete "HKCU\Control Panel\Mouse" /v "MouseSpeed" /f

    :: Restore Keyboard Settings
    reg delete "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /f
    reg delete "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /f

    :: Restore Graphics Settings
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GraphicsPriority" /f
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /f

    :: Restore Animations
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AnimationDuration" /f
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /f
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /f
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /f

    :: Restore Startup Programs
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DisableStartup" /f
    reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DisableStartup" /f

    :: Restore Startup Services
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services" /v "DisableStartup" /f

    :: Restore Nagle's Algorithm
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpAckFrequency" /f
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpNoDelay" /f

    :: Restore Large Send Offload
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableLso" /f

    :: Restore Receive-Side Scaling
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableRSS" /f

    echo All settings restored to default successfully!
    pause
    goto menu

    :restart_explorer
    taskkill /im explorer.exe /f
    start explorer.exe
    echo Explorer.exe restarted successfully!
    pause
    goto menu

    :stop_start_useless_service
    echo Stopping and disabling useless services...

    :: Stop and Disable Windows Search
    net stop wsearch
    sc config wsearch start= disabled

    :: Stop and Disable Windows Defender
    net stop windefend
    sc config windefend start= disabled

    :: Stop and Disable Windows Update
    net stop wuauserv
    sc config wuauserv start= disabled

    echo Useless services stopped and disabled successfully!
    pause
    goto menu

    :clear_temp_prefetch
    echo Clearing Temp and Prefetch files...

    :: Clear Temp Files
    del /q /s /f "%temp%\*"

    :: Clear Prefetch Files
    del /q /s /f "%windir%\Prefetch\ *"

    echo Temp and Prefetch files cleared successfully!
    pause
    goto menu
