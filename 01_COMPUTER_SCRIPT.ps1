Import-Module ActiveDirectory
$dcs = Get-ADDomainController -Filter * | Select-Object -ExpandProperty HostName
$menu = @"



        ███████╗██╗  ██╗ ██████╗██╗     ██╗   ██╗██╗██████╗     ███╗   ███╗ █████╗  ██████╗ ██╗   ██╗██╗███╗   ██╗ █████╗ 
        ██╔════╝╚██╗██╔╝██╔════╝██║     ██║   ██║██║██╔══██╗    ████╗ ████║██╔══██╗██╔═══██╗██║   ██║██║████╗  ██║██╔══██╗
        █████╗   ╚███╔╝ ██║     ██║     ██║   ██║██║██████╔╝    ██╔████╔██║███████║██║   ██║██║   ██║██║██╔██╗ ██║███████║
        ██╔══╝   ██╔██╗ ██║     ██║     ██║   ██║██║██╔══██╗    ██║╚██╔╝██║██╔══██║██║▄▄ ██║██║   ██║██║██║╚██╗██║██╔══██║
        ███████╗██╔╝ ██╗╚██████╗███████╗╚██████╔╝██║██║  ██║    ██║ ╚═╝ ██║██║  ██║╚██████╔╝╚██████╔╝██║██║ ╚████║██║  ██║
        ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝ ╚═════╝ ╚═╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚═╝  ╚═╝ ╚══▀▀═╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝
   

        [1] EXCLUIR UMA MÁQUINA

        [2] EXCLUIR VÁRIAS MÁQUINAS a partir de um .txt  
        
        [0] SAIR                                                         



"@

do {
    Write-Host $menu -ForegroundColor Yellow
    $choice = Read-Host "....INSIRA A OPCAO:"

    switch ($choice) {
        1 {
            Write-Host "INICIANDO SCRIPT..." -ForegroundColor Green
            Write-Host ""
            Start-Sleep -Seconds 2
            script_01
            $validChoice = $true
        }
        2 {
            Write-Host "INICIANDO SCRIPT..." -ForegroundColor Green
            Write-Host ""
            Start-Sleep -Seconds 2
            script_02
            $validChoice = $true
        }
        0 {
            Write-Host "SAINDO..." -ForegroundColor Green
            Write-Host ""
            exit
        }
        default {
            Write-Host "Opção inválida. Tente novamente." -ForegroundColor Red
            Start-Sleep -Seconds 2
            Clear-Host
            $validChoice = $false
        }
    }
} while ($validChoice -eq $false)


function script_1 {
        $computerName = Read-Host -Prompt "Digite o nome da Maquina "

        Write-Host "Digite 'del' para confirmar a exclusao da maquina $computerName"
        $confirmation = Read-Host -Prompt "Confirmacao"

        if ($confirmation -ne "del") {
            Write-Host "Exclusao cancelada."
            exit
        }

        foreach ($dc in $dcs) {
    
            $computer = Get-ADComputer -Identity $computerName -Server $dc -ErrorAction SilentlyContinue
            if ($null -eq $computer) {
                Write-Host "Computador $computerName nÃ£o encontrado no DC $dc"
                continue
            }

    
            $childObjects = Get-ADObject -Filter * -SearchBase $computer.DistinguishedName -SearchScope OneLevel -Server $dc
            foreach ($child in $childObjects) {
        
                if ($child.ObjectClass -ne "computer") {
                    Remove-ADObject -Identity $child.DistinguishedName -Server $dc -Confirm:$false
                    Write-Host "Objeto filho $($child.Name) removido do computador $computerName no DC $dc"
                }
            }

    
            Remove-ADComputer -Identity $computerName -Server $dc -Confirm:$false
            Write-Host "Maquina $computerName removida do DC $dc"

    
        }
}
function script_2 { 
        # Solicita o caminho do arquivo de entrada
        $path = Read-Host -Prompt "Digite o caminho completo do arquivo .txt com os nomes das máquinas"

        # Verifica se o arquivo existe
        if (-not (Test-Path $path)) {
            Write-Host "Arquivo não encontrado: $path"
            exit
        }

        # Lê os nomes dos computadores do arquivo
        $computers = Get-Content $path | Where-Object { $_.Trim() -ne "" }

        # Exibe a lista de computadores a serem excluídos para revisão
        Write-Host "`nAs seguintes máquinas serão processadas para exclusão:"
        $computers | ForEach-Object { Write-Host "- $_" }
        Write-Host ""

        # Solicita confirmação UMA ÚNICA VEZ para todas as máquinas
        Write-Host "Digite 'del' para confirmar a exclusão de TODAS as máquinas listadas acima."
        $confirmation = Read-Host -Prompt "Confirmação"

        if ($confirmation -ne "del") {
            Write-Host "Exclusão cancelada para todas as máquinas."
            exit
        }

        Write-Host "`nConfirmação recebida. Iniciando a exclusão por DC..."

        foreach ($dc in $dcs) {
            Write-Host "`n=============================================="
            Write-Host "Processando DC: $dc"
            Write-Host "=============================================="

            foreach ($computerName in $computers) {
                Write-Host "  Verificando máquina: $computerName no DC: $dc"

                # Tenta localizar o computador no DC atual
                $computer = Get-ADComputer -Identity $computerName -Server $dc -ErrorAction SilentlyContinue

                if ($null -eq $computer) {
                    Write-Host "    Máquina $computerName não encontrada no DC $dc"
                    continue
                }

                Write-Host "    Máquina $computerName encontrada no DC $dc. Iniciando remoção..."

                # Remove objetos filhos (exceto o próprio computador)
                try {
                    $childObjects = Get-ADObject -Filter * -SearchBase $computer.DistinguishedName -SearchScope OneLevel -Server $dc -ErrorAction Stop
                    foreach ($child in $childObjects) {
                        if ($child.ObjectClass -ne "computer") {
                            Remove-ADObject -Identity $child.DistinguishedName -Server $dc -Confirm:$false -ErrorAction Stop
                            Write-Host "      Objeto filho $($child.Name) removido do computador $computerName"
                        }
                    }
                } catch {
                    Write-Host "    Erro ao remover objetos filhos de $computerName : $($_.Exception.Message)"
                }

                # Remove o computador do DC
                try {
                    Remove-ADComputer -Identity $computerName -Server $dc -Confirm:$false -ErrorAction Stop
                    Write-Host "    Máquina $computerName removida do DC $dc"
                } catch {
                    Write-Host "    Erro ao remover $computerName do DC $dc : $($_.Exception.Message)"
                }
            }
        }
}

Write-Host "`nProcesso de exclusão concluído."