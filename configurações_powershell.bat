@echo off
assoc .ps1=Microsoft.PowerShellScript.1
ftype Microsoft.PowerShellScript.1="C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -ExecutionPolicy Bypass -File "%%1"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d Bypass /f

mkdir C:\Program Files\ConsolePowerShell\Scripts

exit