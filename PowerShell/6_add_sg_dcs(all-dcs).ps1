Import-Module ActiveDirectory

$usuario = Read-Host "Digite o SamAccountName do usuário"
$grupo = Read-Host "Digite o nome da Security Group (SG)"

# Obtém todos os controladores de domínio no domínio atual
$DCs = Get-ADDomainController -Filter *

foreach ($dc in $DCs) {
    Write-Host "`n🔄 Conectando ao DC: $($dc.HostName)" -ForegroundColor Cyan

    try {
        # Verifica se usuário e grupo existem no DC
        $user = Get-ADUser -Server $dc.HostName -Identity $usuario -ErrorAction Stop
        $grp  = Get-ADGroup -Server $dc.HostName -Identity $grupo -ErrorAction Stop

        # Adiciona o usuário ao grupo usando o DC específico
        Add-ADGroupMember -Server $dc.HostName -Identity $grupo -Members $usuario -ErrorAction Stop

        Write-Host "✅ Usuário '$usuario' adicionado ao grupo '$grupo' no DC $($dc.HostName)" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Erro no DC $($dc.HostName): $_" -ForegroundColor Red
    }
}
