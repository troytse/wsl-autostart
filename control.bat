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
REM Just define the service start commands in here.
REM (You need to modify the /etc/sudoers file to specifies that they can be called without a password.)
REM E.g:
REM     %sudo ALL=NOPASSWD: /etc/init.d/cron
REM     %sudo ALL=NOPASSWD: /etc/init.d/ssh
REM     %sudo ALL=NOPASSWD: /etc/init.d/mysql
REM     %sudo ALL=NOPASSWD: /etc/init.d/apache2
for /f %%i in (%~dp0commands.txt) do (wsl sudo %%i %*)

:end