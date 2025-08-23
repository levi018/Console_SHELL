Import-Module ActiveDirectory

$menu = @" 


                ██████╗ ███████╗███╗   ███╗ ██████╗ ██╗   ██╗███████╗██████╗     ███████╗    ███╗   ███╗ █████╗ ██╗██╗     
                ██╔══██╗██╔════╝████╗ ████║██╔═══██╗██║   ██║██╔════╝██╔══██╗    ██╔════╝    ████╗ ████║██╔══██╗██║██║     
                ██████╔╝█████╗  ██╔████╔██║██║   ██║██║   ██║█████╗  ██████╔╝    █████╗█████╗██╔████╔██║███████║██║██║     
                ██╔══██╗██╔══╝  ██║╚██╔╝██║██║   ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗    ██╔══╝╚════╝██║╚██╔╝██║██╔══██║██║██║     
                ██║  ██║███████╗██║ ╚═╝ ██║╚██████╔╝ ╚████╔╝ ███████╗██║  ██║    ███████╗    ██║ ╚═╝ ██║██║  ██║██║███████╗
                ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝   ╚═══╝  ╚══════╝╚═╝  ╚═╝    ╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚══════╝
    
                                                                                                           

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

# A partir daqui, o script irá remover o e-mail, por isso não é necessário pedir um novo endereço.
Write-Host ""
Start-Sleep 3
try {
    # Lista todos os DCs do domínio
    $dcs = Get-ADDomainController -Filter *

    foreach ($dc in $dcs) {
        Write-Host ""
        Write-Host "Conectando ao DC: $($dc.HostName)" -ForegroundColor Cyan

        # Obtém o usuário no DC atual
        $user = Get-ADUser -Identity $username -Server $dc.HostName -Properties mail

        # Verifica se o usuário tem um e-mail para remover
        if (-not [string]::IsNullOrEmpty($user.mail)) {
            # Remove o campo "mail" usando o parâmetro -Clear
            Set-ADUser -Identity $user.DistinguishedName -Clear "mail" -Server $dc.HostName
            Write-Host "✅ E-mail removido para '$($user.DistinguishedName)' no DC $($dc.HostName)." -ForegroundColor Green
        }
        else {
            Write-Host "❗ Usuário '$($user.DistinguishedName)' não tinha e-mail para remover no DC $($dc.HostName)." -ForegroundColor Yellow
        }
    }

    Write-Host "`nRemoção de e-mail concluída em todos os controladores de domínio." -ForegroundColor Green
}
catch {
    Write-Error "❌ Erro ao processar: $_"
}

Write-Host "Script Finalizado" -ForegroundColor Green
Start-Sleep 5