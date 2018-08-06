@echo off
REM Goto the detect section.
goto lxssDetect

:lxssRestart
    REM ReStart the LxssManager service
    net stop LxssManager

:lxssStart
    REM Start the LxssManager service
    net start LxssManager

:lxssDetect
    REM Detect the LxssManager service status
    for /f "skip=3 tokens=4" %%i in ('sc query LxssManager') do set "state=%%i" &goto lxssStatus

:lxssStatus
    REM If the LxssManager service is stopped, start it.
    if /i "%state%"=="STOPPED" (goto lxssStart)
    REM If the LxssManager service is starting, wait for it to finish start.
    if /i "%state%"=="STARTING" (goto lxssDetect)
    REM If the LxssManager service is running, start the linux service.
    if /i "%state%"=="RUNNING" (goto next)
    REM If the LxssManager service is stopping, nothing to do.
    if /i "%state%"=="STOPPING" (goto end)

:next
    REM Check the LxssManager service is started correctly.
    wsl echo OK >nul 2>nul
    if not %errorlevel% == 0 (goto lxssRestart)

    REM Start services in the WSL
    REM Define the service commands in commands.txt.
    for /f %%i in (%~dp0commands.txt) do (wsl sudo %%i %*)

:end