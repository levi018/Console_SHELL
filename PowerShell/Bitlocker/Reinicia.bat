if %COMPUTERNAME:~0,7% == JPA_AT_ goto sair

C:\Windows\System32\shutdown.exe /r /f /t 30 /c "REINICIALIZACAO DIARIA AUTOMATICA POR INATIVIDADE"

:sair
exit