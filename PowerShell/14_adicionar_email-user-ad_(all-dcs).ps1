Import-Module ActiveDirectory

# Solicita o nome do usuário e o novo e-mail
$userIdentity = Read-Host "Digite o nome de usuário (samAccountName ou DistinguishedName)"
$newEmail = Read-Host "Digite o novo endereço de e-mail (ex: usuario@dominio.com)"

try {
    # Lista todos os DCs do domínio
    $dcs = Get-ADDomainController -Filter *

    foreach ($dc in $dcs) {
        Write-Host "Conectando ao DC: $($dc.HostName)" -ForegroundColor Cyan

        # Obtém o usuário no DC atual
        $user = Get-ADUser -Identity $userIdentity -Server $dc.HostName -Properties mail

        # Atualiza o campo "mail"
        Set-ADUser -Identity $user.DistinguishedName -EmailAddress $newEmail -Server $dc.HostName

        Write-Host "E-mail atualizado para '$newEmail' no DC $($dc.HostName)." -ForegroundColor Green
    }

    Write-Host "`nAtribuição de e-mail concluída em todos os controladores de domínio." -ForegroundColor Green
}
catch {
    Write-Error "Erro ao processar: $_"
}
