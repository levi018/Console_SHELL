<#
.SYNOPSIS
Move vários computadores para uma nova OU em todos os DCs.

.DESCRIPTION
• Lê nomes de computadores a partir de:
  – Entrada interativa (um por linha) **OU**
  – Arquivo .txt (um nome por linha).
• Executa o Move-ADObject em cada DC encontrado por Get-ADDomainController.
• Gera log em CSV (data, DC, computador, resultado, mensagem).
• Mostra resumo final.

.NOTES
© 2025 – Exemplo demonstrativo
#>

Import-Module ActiveDirectory

# ---------- PARÂMETROS ---------- #
$targetOU = Read-Host "Digite o caminho da nova OU (ex: OU=Computadores,DC=dominio,DC=local)"

$opcao = Read-Host "Computadores via (D)igitação manual ou (A)rquivo txt? [D/A]"
if ($opcao -eq 'A') {
    $arquivo = Read-Host "Caminho completo do arquivo .txt"
    $computadores = Get-Content -Path $arquivo | Where-Object { $_.Trim() -ne '' }
}
else {
    Write-Host "Digite os nomes dos PCs (ENTER em branco para terminar):"
    $lista = @()
    do {
        $pc = Read-Host "PC"
        if ($pc.Trim()) { $lista += $pc.Trim() }
    } until ([string]::IsNullOrWhiteSpace($pc))
    $computadores = $lista
}

if (-not $computadores) {
    Write-Warning "Nenhum computador informado. Encerrando."
    return
}

# ---------- PREPARO ---------- #
$DCs = Get-ADDomainController -Filter *
$logPath = Join-Path $env:TEMP ("MoveComputadores_{0:yyyyMMdd_HHmmss}.csv" -f (Get-Date))

# Estrutura de dados para estatísticas
$sucesso = 0
$falha   = 0
$naoEncontrado = 0

# ---------- PROCESSO ---------- #
foreach ($dc in $DCs) {
    Write-Host "`n🔄 Conectando ao DC: $($dc.HostName)" -ForegroundColor Cyan

    foreach ($pc in $computadores) {
        try {
            $obj = Get-ADComputer -Server $dc.HostName -Identity $pc -ErrorAction Stop

            # Evita mover se já está na OU destino
            if ($obj.DistinguishedName -like "*$targetOU") {
                $msg = "Já está na OU destino"
                $resultado = "Ignorado"
                $sucesso++
            }
            else {
                Move-ADObject -Server $dc.HostName -Identity $obj.DistinguishedName -TargetPath $targetOU -ErrorAction Stop
                $msg = "Movido com sucesso"
                $resultado = "Sucesso"
                $sucesso++
            }
        }
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
            $msg = "Não encontrado"
            $resultado = "Não encontrado"
            $naoEncontrado++
        }
        catch {
            $msg = $_.Exception.Message
            $resultado = "Falha"
            $falha++
        }

        # Grava linha de log
        "{0},{1},{2},{3},{4}" -f (Get-Date),$dc.HostName,$pc,$resultado,$msg | Out-File -FilePath $logPath -Append -Encoding UTF8

        # Feedback ao console
        switch ($resultado) {
            "Sucesso"      { Write-Host "✅ $pc → $targetOU" -ForegroundColor Green }
            "Ignorado"     { Write-Host "ℹ️  $pc já na OU destino" -ForegroundColor Yellow }
            "Não encontrado"{ Write-Host "❔ $pc não encontrado" -ForegroundColor DarkYellow }
            default        { Write-Host "❌ $pc falhou: $msg" -ForegroundColor Red }
        }
    }
}

# ---------- RESUMO ---------- #
Write-Host "`n===== RESUMO ====="
Write-Host "Sucessos       : $sucesso"  -ForegroundColor Green
Write-Host "Não encontrados: $naoEncontrado" -ForegroundColor DarkYellow
Write-Host "Falhas         : $falha"    -ForegroundColor Red
Write-Host "Log detalhado  : $logPath"
