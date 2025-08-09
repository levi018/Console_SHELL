@echo off
echo LockerLauncher V1.8.2407

for /f %%A in ('wmic product where "Name like 'SetupLauncher%%'" get version') do (
if %%A==1.8.2407 goto END
)
taskkill /f /im LockerLaunchService.exe
sc delete LockerLaunchService
taskkill /f /im LockerLauncher.exe
taskkill /f /im LockerAgente.exe
sc stop LockerLaunchService
wmic product where name="SetupLauncher" call uninstall /nointeractive
taskkill /f /im LockerLaunchService.exe
sc delete LockerLaunchService
taskkill /f /im LockerAgente.exe
taskkill /f /im LockerLaunchService.exe
rd /s /q "C:\LockerLauncher"
taskkill /f /im LockerAgente.exe
rd /s /q "C:\LockerAgente"
rd /s /q "C:\Program Files (x86)\AeC\SetupLauncher"
rd /s /q "C:\Program Files (x86)\Default Company Name\SetupLauncher"
reg delete "HKEY_CLASSES_ROOT\Installer\Assemblies\C:|Program Files (x86)|AeC|SetupLauncher|DotNetZip.dll" /f
reg delete "HKEY_CLASSES_ROOT\Installer\Assemblies\C:|Program Files (x86)|AeC|SetupLauncher|LauncherInstaller.exe" /f
reg delete "HKEY_CLASSES_ROOT\Installer\Assemblies\C:|Program Files (x86)|AeC|SetupLauncher|RestSharp.dll" /f
reg delete "HKEY_CLASSES_ROOT\Installer\Assemblies\C:|Program Files (x86)|AeC|SetupLauncher|System.Net.Http.dll" /f
reg delete "HKEY_CLASSES_ROOT\Installer\Assemblies\C:|Program Files (x86)|AeC|SetupLauncher|System.Net.Http.WebRequest.dll" /f
reg delete "HKEY_CLASSES_ROOT\Installer\Products\FDF5653A1EBFEFC4C961670B2C9E94C3" /f
reg delete "HKEY_CLASSES_ROOT\Installer\Products\FDF5653A1EBFEFC4C961670B2C9E94C3\SourceList" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Products\679D94492B5D8274D9D40DAE65517FE4" /f
reg delete  "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\LockerLaunchService" /f
reg delete  "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LockerLaunchService" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{9449D976-D5B2-4728-9D4D-D0EA5615F74E}" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{A3565FDF-FBE1-4CFE-9C16-76B0C2E9493C}" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{66F05588-D545-4FE0-9071-028AF1D610E7}" /f
reg delete  "HKEY_CLASSES_ROOT\Installer\Products\0519CD92FCEE59F41BA77B6A07F64C7F" /f
reg delete  "HKEY_CLASSES_ROOT\Installer\Products\0519CD92FCEE59F41BA77B6A07F64C7F\SourceList" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Assemblies\C:|Program Files (x86)|AeC|SetupLauncher|DotNetZip.dll" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Assemblies\C:|Program Files (x86)|AeC|SetupLauncher|LauncherInstaller.exe" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Assemblies\C:|Program Files (x86)|AeC|SetupLauncher|RestSharp.dll" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Assemblies\C:|Program Files (x86)|AeC|SetupLauncher|System.Net.Http.dll" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Assemblies\C:|Program Files (x86)|AeC|SetupLauncher|System.Net.Http.WebRequest.dll" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Products\0519CD92FCEE59F41BA77B6A07F64C7F" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Products\0519CD92FCEE59F41BA77B6A07F64C7F\SourceList" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\0519CD92FCEE59F41BA77B6A07F64C7F\InstallProperties" /f
reg delete  "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{29DC9150-EECF-4F95-B17A-B7A6706FC4F7}" /f
xcopy "\\DGT_PUBL_JPA\automacao.$\LockerLauncher_V1.8.2407\SetupLauncher.msi" "C:\" /e /y
xcopy "\\DGT_PUBL_JPA\automacao.$\LockerLauncherDOTNET\*.*" "C:\" /e /y
C:\windowsdesktop-runtime-6.0.21-win-x64.exe /install /quiet /norestart
msiexec /i "C:\SetupLauncher.msi" /qn ALLUSERS=1
C:\windowsdesktop-runtime-5.0.17-win-x64.exe /install /quiet /norestart
del C:\windowsdesktop-runtime-6.0.21-win-x64.exe
del C:\windowsdesktop-runtime-5.0.17-win-x64.exe
del C:\SetupLauncher.msi
exit
:END
Exit
