Import-Module ActiveDirectory

$computador = Read-Host "Digite o nome da máquina (ex: PC-001)"
$novaOU = Read-Host "Digite o caminho da nova OU (ex: OU=Computadores,DC=dominio,DC=local)"

# Obtém todos os controladores de domínio
$DCs = Get-ADDomainController -Filter *

foreach ($dc in $DCs) {
    Write-Host "`n🔄 Conectando ao DC: $($dc.HostName)" -ForegroundColor Cyan

    try {
        # Verifica se a conta de computador existe nesse DC
        $objComputador = Get-ADComputer -Server $dc.HostName -Identity $computador -ErrorAction Stop

        # Move o objeto de computador
        Move-ADObject -Server $dc.HostName -Identity $objComputador.DistinguishedName -TargetPath $novaOU -ErrorAction Stop

        Write-Host "✅ Máquina '$computador' movida para '$novaOU' no DC $($dc.HostName)" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Erro ao mover no DC $($dc.HostName): $_" -ForegroundColor Red
    }
}
