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
