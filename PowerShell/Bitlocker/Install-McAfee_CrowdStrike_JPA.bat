��&cls
@echo off

IF NOT EXIST "C:\Program Files\McAfee\Agent\cmdagent.exe" (

net use /delete /yes \\192.168.207.100\jpscripts
net use \\192.168.207.100\jpscripts /user:192.168.207.100\script hora2012*
net use \\palestra2.grupoaec.com.br\NETLOGON\msi

xcopy \\palestra2.grupoaec.com.br\NETLOGON\msi\mcafee\McAfeeSmartInstall.exe C:\
xcopy \\palestra2.grupoaec.com.br\NETLOGON\msi\mcafee\SiteList.xml C:\

taskkill /im msiexec.exe /f
del /q \\192.168.207.100\jpscripts\LOGS\logs_McAfee_CrowdStrike\%computername%_McAfee.txt
C:\McAfeeSmartInstall.exe -s >> \\192.168.207.100\jpscripts\LOGS\logs_McAfee_CrowdStrike\%computername%_McAfee.txt
del /q C:\McAfeeSmartInstall.exe
del /q C:\SiteList.xml

net use /delete /yes \\192.168.207.100\jpscripts

) ELSE (
    Goto CrowdStrike
)

:CrowdStrike

IF NOT EXIST "C:\Program Files\CrowdStrike\CSFalconService.exe" (

net use /delete /yes \\192.168.207.100\jpscripts
net use \\192.168.207.100\jpscripts /user:192.168.207.100\script hora2012*
net use \\palestra2.grupoaec.com.br\NETLOGON\msi

xcopy \\palestra2.grupoaec.com.br\NETLOGON\msi\CS-WindowsSensor.exe C:\

taskkill /im msiexec.exe /f
del /q \\192.168.207.100\jpscripts\LOGS\logs_McAfee_CrowdStrike\%computername%_CrowdStrike.txt
C:\CS-WindowsSensor.exe /install /quiet /norestart CID=647770B327F54E9A8E1417D093F32CCB-F8 APP_PROXYNAME=proxy.grupoaec.com.br APP_PROXYPORT=8080 >> \\192.168.207.100\jpscripts\LOGS\logs_McAfee_CrowdStrike\%computername%_CrowdStrike.txt
dir "C:\Program Files\CrowdStrike\CSFalconService.exe" >> \\192.168.207.100\jpscripts\LOGS\logs_McAfee_CrowdStrike\%computername%_CrowdStrike.txt
del /q C:\CS-WindowsSensor.exe

net use /delete /yes \\192.168.207.100\jpscripts

) ELSE (
exit
)
