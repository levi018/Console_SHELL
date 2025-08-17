Import-Module ActiveDirectory

$menu = @" 


               _____       .___.__       .__                             ___________                        .__.__   
              /  _  \    __| _/|__| ____ |__| ____   ____ _____ _______  \_   _____/           _____ _____  |__|  |  
             /  /_\  \  / __ | |  |/ ___\|  |/  _ \ /    \\__  \\_  __ \  |    __)_   ______  /     \\__  \ |  |  |  
            /    |    \/ /_/ | |  \  \___|  (  <_> )   |  \/ __ \|  | \/  |        \ /_____/ |  Y Y  \/ __ \|  |  |__
            \____|__  /\____ | |__|\___  >__|\____/|___|  (____  /__|    /_______  /         |__|_|  (____  /__|____/
                    \/      \/         \/               \/     \/                \/                \/     \/         


"@

Write-Host $menu -ForegroundColor Yellow

# Inicia um loop 'do...while' que continuará até que um usuário válido seja encontrado
do {
    # Pede ao usuário para digitar o nome de usuário (sAMAccountName ou DistinguishedName)
    Write-Host "Digite o nome do usuário (sAMAccountName ou DistinguishedName): " -ForegroundColor Yellow -NoNewLine
    $username = Read-Host

    # Tenta encontrar o usuário no Active Directory
    try {
        # O cmdlet Get-ADUser procura por um usuário. Se não encontrar, ele gera um erro.
        $user = Get-ADUser -Identity $username -ErrorAction Stop
        # Se o comando acima for bem-sucedido, a variável $user não será nula.
        $userFound = $true
    }
    catch {
        # Se um erro ocorrer (usuário não encontrado), exibe uma mensagem de erro.
        Write-Host "Usuário '$username' não encontrado. Por favor, tente novamente." -ForegroundColor Red
        $userFound = $false
        Start-Sleep -Seconds 2
        Clear-Host
        Write-Host $menu -ForegroundColor Yellow
    }
} while (-not $userFound)

# Solicita o novo e-mail
Write-Host "Digite o novo endereço de e-mail (ex: usuario@dominio.com): " -NoNewline -ForegroundColor Yellow
$newEmail = Read-Host

try {
    # Lista todos os DCs do domínio
    $dcs = Get-ADDomainController -Filter *

    foreach ($dc in $dcs) {
        Write-Host "Conectando ao DC: $($dc.HostName)" -ForegroundColor Cyan

        # Obtém o usuário no DC atual
        $user = Get-ADUser -Identity $username -Server $dc.HostName -Properties mail

        # Atualiza o campo "mail"
        Set-ADUser -Identity $user.DistinguishedName -EmailAddress $newEmail -Server $dc.HostName

        Write-Host "E-mail atualizado para '$newEmail' no DC $($dc.HostName)." -ForegroundColor Green
    }

    Write-Host "`nAtribuição de e-mail concluída em todos os controladores de domínio." -ForegroundColor Green
}
catch {
    Write-Error "Erro ao processar: $_"
}
