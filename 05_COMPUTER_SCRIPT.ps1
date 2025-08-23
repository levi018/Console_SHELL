$menu = @"


        ██████╗ ██╗   ██╗███████╗ ██████╗ █████╗ ██████╗     ███╗   ██╗ ██████╗ ███████╗    ██████╗  ██████╗███████╗
        ██╔══██╗██║   ██║██╔════╝██╔════╝██╔══██╗██╔══██╗    ████╗  ██║██╔═══██╗██╔════╝    ██╔══██╗██╔════╝██╔════╝
        ██████╔╝██║   ██║███████╗██║     ███████║██████╔╝    ██╔██╗ ██║██║   ██║███████╗    ██║  ██║██║     ███████╗
        ██╔══██╗██║   ██║╚════██║██║     ██╔══██║██╔══██╗    ██║╚██╗██║██║   ██║╚════██║    ██║  ██║██║     ╚════██║
        ██████╔╝╚██████╔╝███████║╚██████╗██║  ██║██║  ██║    ██║ ╚████║╚██████╔╝███████║    ██████╔╝╚██████╗███████║
        ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝    ╚═════╝  ╚═════╝╚══════╝
        

        [1] BUSCAR UMA MÁQUINA NOS DCS                                                                                                    
        [2] BUSCAR VÁRIAS MÁQUINA NOS DCS

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

function script_01 { 

$computer = Read-Host "Digite o hostname: "

$dcs = Get-ADDomainController -Filter * | Select-Object name

foreach ($dc in $dcs.Name) {
  try {
    $temp = Get-ADComputer $computer -Server $dc | Select Name
    Write-Host "[!] Computer $computer found in $dc" -ForegroundColor Red
  }
  catch {
    Write-Host "[-] Computer does not exist on $dc!" -ForegroundColor Green
  }
}

}
function script_02 { 

# Solicita o caminho para o arquivo de texto com a lista de computadores
$file_path = Read-Host "Digite o caminho do arquivo com a lista de computadores (ex: C:\temp\computadores.txt)"

# Lê a lista de computadores do arquivo de texto, um por linha, e remove espaços em branco
$computers = Get-Content -Path $file_path | Where-Object { $_ -ne "" }

# Pega a lista de todos os Domain Controllers do domínio
$dcs = Get-ADDomainController -Filter * | Select-Object Name

# Itera sobre cada computador na lista
foreach ($computer in $computers) {
    Write-Host "`n--- Verificando o computador $computer ---" -ForegroundColor Yellow
    # Para cada computador, itera sobre cada Domain Controller
    foreach ($dc in $dcs.Name) {
        try {
            # Tenta encontrar o computador no Domain Controller atual
            $temp = Get-ADComputer $computer -Server $dc | Select-Object Name
            Write-Host "[!] Computador $computer encontrado em $dc" -ForegroundColor Red
        }
        catch {
            # Se não encontrar, exibe uma mensagem de erro
            Write-Host "[-] Computador $computer não existe em $dc!" -ForegroundColor Green
        }
    }
}

}