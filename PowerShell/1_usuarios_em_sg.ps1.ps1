Clear-Host
#$host.UI.RawUI.WindowTitle = "CONSOLE POWERSHELL V.1.0"
#$host.UI.RawUI.WindowSize = @{width=150; height=45}

function Carregamento1 {
    param (
        [string]$Activity = "Processando...",
        [string]$Status = "Aguarde...",
        [int]$TotalSteps = 50,
        [int]$SleepTime = 10 # milissegundos
    )

    for ($i = 1; $i -le $TotalSteps; $i++) {
        # Calcula o percentual
        $percentComplete = [int](($i / $TotalSteps) * 100)

        # Atualiza a barra de progresso
        Write-Progress -Activity $Activity -Status "$Status - $percentComplete%" -PercentComplete $percentComplete

        Start-Sleep -Milliseconds $SleepTime
    }

    # Limpa a barra de progresso no final
    Write-Progress -Activity $Activity -Completed
}
Carregamento1 -Activity "Script para fazer isso!" -Status "Por favor, aguarde"
function Carregamento {
    param (
        [int]$TotalSteps = 50,
        [int]$SleepTime = 10 # Tempo de espera em milissegundos
    )

    Write-Host "Carregando script, por favor aguarde... " -NoNewline
    for ($i = 1; $i -le $TotalSteps; $i++) {
        Write-Host "█" -NoNewline
        Start-Sleep -Milliseconds $SleepTime
    }
    Write-Host "" # Nova linha no final
}
Carregamento

Clear-Host


Write-Host @" 

⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇ 
⑇⑇     _______ _______  ______ _____  _____  _______      _____      ⑇⑇
⑇⑇     |______ |       |_____/   |   |_____]    |           |        ⑇⑇
⑇⑇     ______| |_____  |    \_ __|__ |          |         __|__      ⑇⑇
⑇⑇                                                                   ⑇⑇
⑇⑇                                                                   ⑇⑇          
⑇⑇                                                                   ⑇⑇
⑇⑇     _______ _     _ _______ _______  ______ _____  _____          ⑇⑇ 
⑇⑇     |______ |     | |______ |_____| |_____/   |   |     |         ⑇⑇
⑇⑇     ______| |_____| ______| |     | |    \_ __|__ |_____|         ⑇⑇          
⑇⑇          _______ _______      _______  ______                     ⑇⑇ 
⑇⑇          |______ |  |  |      |______ |  ____                     ⑇⑇
⑇⑇          |______ |  |  |      ______| |_____|                     ⑇⑇
⑇⑇                                                                   ⑇⑇
⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇⑇   
                                                                                            
        
        

"@ -ForegroundColor Green




$SG = Read-Host "Digite o nome da SG"

# Pergunta o caminho completo (incluindo o nome do arquivo .csv) onde o relatório será salvo
$CaminhoCsv = Read-Host `
  "Digite o caminho completo onde deseja salvar o arquivo (ex.: C:\Relatorios\UsuariosSG.csv)"

# Busca membros do grupo, coleta os atributos desejados e exporta para o local informado
Get-ADGroupMember -Identity $SG |
    Get-ADUser -Properties SamAccountName,GivenName,Surname,EmailAddress |
    Select-Object SamAccountName,GivenName,Surname,EmailAddress |
    Export-Csv -Path $CaminhoCsv -NoTypeInformation -Encoding UTF8

Write-Host "Relatório gerado em: $CaminhoCsv"
