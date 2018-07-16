@echo off
REM Goto the detect section.
goto detect

:lxss
REM Start the LxssManager service
sc start LxssManager

:detect
REM Detect the LxssManager service status
for /f "skip=3 tokens=4" %%i in ('sc query LxssManager') do set "state=%%i" &goto :next

:next
REM If the LxssManager service is stopped, start it.
if /i "%state%"=="STOPPED" (goto lxss)
REM If the LxssManager service is starting, wait for it to finish start.
if /i "%state%"=="STARTING" (goto detect)
REM If the LxssManager service is running, start the linux service.
if /i "%state%"=="RUNNING" (goto start)
REM If the LxssManager service is stopping, nothing to do.
if /i "%state%"=="STOPPING" (goto end)

:start
REM Start services in the WSL
REM Define the service commands in commands.txt.
for /f %%i in (%~dp0commands.txt) do (wsl sudo %%i %*)

:end