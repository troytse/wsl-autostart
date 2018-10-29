# WSL Autostart
Support for starting the Linux services in Windows Subsystem for Linux (WSL) on Windows startup.

[README](README.md) | [中文文档](README_zh.md)

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)

## Installation

* Clone to any directory using the git command: (e.g `C:\wsl-autostart`)
``` shell
git clone https://github.com/troytse/wsl-autostart
```

* Add a startup item to the registry.
![run-regedit](doc/run-regedit.png)

* Add a string item under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run` (e.g `WSLAutostart`)
![regedit-new-item](doc/regedit-new-item.png)

* Set the path to the script (e.g `C:\wsl-autostart\start.vbs`)
![regedit-set-path](doc/regedit-set-path.png)

## Usage

* Modify `/etc/sudoers` file in the WSL to specify the service commands calling on startup without a password.
e.g:
``` sudoers
%sudo ALL=NOPASSWD: /etc/init.d/cron
%sudo ALL=NOPASSWD: /etc/init.d/ssh
%sudo ALL=NOPASSWD: /etc/init.d/mysql
%sudo ALL=NOPASSWD: /etc/init.d/apache2
```
* Modify `commands.txt` file to specify the service commands for your need.
e.g:
``` shell
/etc/init.d/cron
/etc/init.d/ssh
/etc/init.d/mysql
/etc/init.d/apache2
```

## Other methods
* Using `gpedit.msc`, it is possible to define a program that runs when the computer starts
  > Note that the configured program will run as the system user.
* Using `taskschd.msc`, it is possible to schedule a task after the startup of the computer.
  > You may configure which user will run the program, a delay before a run and a number of retries.
the same `taskschd.msc` program will show a specific log regarding the execution of the task
