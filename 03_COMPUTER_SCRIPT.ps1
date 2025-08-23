$menu = @"


        ██╗  ██╗ █████╗ ██████╗ ██╗██╗     ██╗████████╗ █████╗ ██████╗     ███╗   ███╗ █████╗  ██████╗ ██╗   ██╗██╗███╗   ██╗ █████╗ ███████╗
        ██║  ██║██╔══██╗██╔══██╗██║██║     ██║╚══██╔══╝██╔══██╗██╔══██╗    ████╗ ████║██╔══██╗██╔═══██╗██║   ██║██║████╗  ██║██╔══██╗██╔════╝
        ███████║███████║██████╔╝██║██║     ██║   ██║   ███████║██████╔╝    ██╔████╔██║███████║██║   ██║██║   ██║██║██╔██╗ ██║███████║███████╗
        ██╔══██║██╔══██║██╔══██╗██║██║     ██║   ██║   ██╔══██║██╔══██╗    ██║╚██╔╝██║██╔══██║██║▄▄ ██║██║   ██║██║██║╚██╗██║██╔══██║╚════██║
        ██║  ██║██║  ██║██████╔╝██║███████╗██║   ██║   ██║  ██║██║  ██║    ██║ ╚═╝ ██║██║  ██║╚██████╔╝╚██████╔╝██║██║ ╚████║██║  ██║███████║
        ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝╚══════╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚═╝  ╚═╝ ╚══▀▀═╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
                                                                                                                                     

        [1] HABLITAR UMA MÁQUINA
        [2] HABLITAR VÁRIAS MÁQUINAS a partir de um .txt

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


fuction script_01 {

        Import-Module ActiveDirectory

        # Nome da conta de computador
        $computerName = Read-Host "Digite o nome da conta de computador (ex: PC123 ou PC123$)"
        $computerName = $computerName.TrimEnd('$')

        # Lista todos os controladores de domínio
        $domainControllers = Get-ADDomainController -Filter *

        foreach ($dc in $domainControllers) {
            Write-Host "`n🔄 Conectando ao DC: $($dc.HostName)" -ForegroundColor Cyan
            try {
                # Busca o computador no DC atual
                $computer = Get-ADComputer -Server $dc.HostName -Filter "Name -eq '$computerName'" -Properties Enabled
        
                if ($computer) {
                    if ($computer.Enabled) {
                        Write-Host "✅ Conta '$computerName' já está habilitada no DC $($dc.HostName)." -ForegroundColor Yellow
                    } else {
                        Enable-ADAccount -Identity $computer.DistinguishedName -Server $dc.HostName
                        Write-Host "✅ Conta '$computerName' habilitada com sucesso no DC $($dc.HostName)!" -ForegroundColor Green
                    }
                } else {
                    Write-Host "❌ Conta '$computerName' não encontrada no DC $($dc.HostName)." -ForegroundColor Yellow
                }
            } catch {
                Write-Host "🚫 Erro ao conectar no DC $($dc.HostName): $_" -ForegroundColor Red
            }
        }


}
fuction script_02 {

        Import-Module ActiveDirectory

        # Laço para solicitar o caminho do arquivo até que um válido seja fornecido
        do {
            $listPath = Read-Host "Digite o caminho completo para o arquivo de texto com a lista de computadores (ex: C:\temp\computadores.txt)"

            # Verifica se o arquivo existe. A condição '$null -ne' garante que o usuário não deixou a entrada em branco
            if ((Test-Path $listPath) -and ($null -ne $listPath)) {
                $validPath = $true
            } else {
                Write-Host "❌ O caminho digitado não é válido. Por favor, tente novamente." -ForegroundColor Red
                $validPath = $false
            }
        } until ($validPath)

        # Lê cada nome de computador do arquivo e armazena em uma variável
        $computerNames = Get-Content -Path $listPath

        # Lista todos os controladores de domínio
        $domainControllers = Get-ADDomainController -Filter *

        # Loop principal para cada computador na lista
        foreach ($computerName in $computerNames) {
            # Limpa o nome, removendo espaços e o cifrão ($) se houver
            $computerName = $computerName.Trim().TrimEnd('$')

            # Exibe qual computador está sendo processado
            Write-Host "--- Processando computador: $computerName ---" -ForegroundColor Yellow

            # Loop para cada controlador de domínio
            foreach ($dc in $domainControllers) {
                Write-Host "`n🔄 Conectando ao DC: $($dc.HostName)" -ForegroundColor Cyan
                try {
                    # Busca o computador no DC atual
                    $computer = Get-ADComputer -Server $dc.HostName -Filter "Name -eq '$computerName'" -Properties Enabled -ErrorAction SilentlyContinue

                    if ($computer) {
                        if ($computer.Enabled) {
                            Write-Host "✅ Conta '$computerName' já está habilitada no DC $($dc.HostName)." -ForegroundColor Yellow
                        } else {
                            Enable-ADAccount -Identity $computer.DistinguishedName -Server $dc.HostName
                            Write-Host "✅ Conta '$computerName' habilitada com sucesso no DC $($dc.HostName)!" -ForegroundColor Green
                        }
                    } else {
                        Write-Host "❌ Conta '$computerName' não encontrada no DC $($dc.HostName)." -ForegroundColor Yellow
                    }
                } catch {
                    Write-Host "🚫 Erro ao conectar no DC $($dc.HostName): $_" -ForegroundColor Red
                }
            }
        }

        Write-Host "`n✅ Processamento de todos os computadores concluído." -ForegroundColor Green

}