Import-Module ActiveDirectory

# Solicita o nome de usuário (samAccountName ou distinguishedName)
$userIdentity = Read-Host "Digite o nome de usuário (samAccountName ou DN)"

try {
    # Obtém todos os controladores de domínio
    $dcs = Get-ADDomainController -Filter *

    foreach ($dc in $dcs) {
        Write-Host "Conectando ao DC: $($dc.HostName)" -ForegroundColor Cyan

        # Obtém o usuário do AD a partir do controlador atual
        $user = Get-ADUser -Identity $userIdentity -Server $dc.HostName -Properties mail

        if ($user.mail) {
            Write-Host "Removendo e-mail do usuário em $($dc.HostName): $($user.mail)" -ForegroundColor Yellow

            # Remove o e-mail
            Set-ADUser -Identity $user.DistinguishedName -Clear mail -Server $dc.HostName

            Write-Host "E-mail removido no DC $($dc.HostName)." -ForegroundColor Green
        }
        else {
            Write-Host "O usuário já não possui e-mail neste DC ($($dc.HostName))." -ForegroundColor DarkGray
        }
    }

    Write-Host "`nRemoção de e-mail concluída em todos os controladores." -ForegroundColor Green
}
catch {
    Write-Error "Erro ao processar: $_"
}
