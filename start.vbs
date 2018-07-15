' Start services
Set WinScriptHost = CreateObject("WScript.Shell")
WinScriptHost.Run Chr(34) & CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) & "\control.bat" & " ""start""" & Chr(34), 0
Set WinScriptHost = Nothing
