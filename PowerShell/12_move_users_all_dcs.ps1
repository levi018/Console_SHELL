# Requer o módulo ActiveDirectory
Import-Module ActiveDirectory

# Solicita o nome do usuário
$UserName = Read-Host "Digite o nome do usuário (sAMAccountName ou DistinguishedName)"

# Solicita o caminho da nova OU (DN)
$NewOU = Read-Host "Digite o caminho da nova OU (ex: OU=Usuarios,DC=dominio,DC=local)"

# Obter todos os Controladores de Domínio
$DCs = (Get-ADDomainController -Filter *).Name

# Verifica se o usuário existe
try {
    $User = Get-ADUser -Identity $UserName -Properties DistinguishedName
} catch {
    Write-Host "❌ Usuário '$UserName' não encontrado." -ForegroundColor Red
    exit
}

# Mover o usuário em todos os DCs
foreach ($DC in $DCs) {
    Write-Host "`n➡️  Movendo usuário no DC: $DC..." -ForegroundColor Cyan

    try {
        Move-ADObject -Identity $User.DistinguishedName -TargetPath $NewOU -Server $DC
        Write-Host "✅ Usuário movido com sucesso no DC: $DC" -ForegroundColor Green
    } catch {
        Write-Host "❌ Falha ao mover no DC: $DC" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}
