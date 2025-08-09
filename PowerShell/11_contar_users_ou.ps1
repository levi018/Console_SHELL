<# Conta usuários habilitados e desabilitados em uma OU especificada,
   exibindo o resumo colorido: verde (total), azul (habilitados), vermelho (desabilitados) #>

param(
    [string]$OU
)

# Pede o DN se não vier por parâmetro
if ([string]::IsNullOrWhiteSpace($OU)) {
    $OU = Read-Host "Informe o caminho (DN) da OU. Ex.: OU=Vendas,DC=empresa,DC=com"
    if ([string]::IsNullOrWhiteSpace($OU)) {
        Write-Warning "Nenhum DN fornecido. Encerrando o script."
        return
    }
}

try {
    # Busca os usuários na OU (apenas nível atual; troque OneLevel por Subtree se quiser incluir sub-OUs)
    $usuarios = Get-ADUser -Filter * -SearchBase $OU -SearchScope OneLevel -Properties Enabled -ErrorAction Stop

    $total        = $usuarios.Count
    $habilitados  = ($usuarios | Where-Object { $_.Enabled }).Count
    $desabilitados = $total - $habilitados

    Write-Host
    Write-Host "Resumo para a OU '$OU':" -ForegroundColor Magenta
    # --------- Cores solicitadas -------------
    Write-Host "‣ Total de usuários     : $total"        -ForegroundColor Green
    Write-Host "‣ Usuários habilitados  : $habilitados"  -ForegroundColor Cyan
    Write-Host "‣ Usuários desabilitados: $desabilitados" -ForegroundColor Red
}
catch {
    Write-Error "Ocorreu um erro. Verifique se o DN está correto e se você tem permissão: $($_.Exception.Message)"
}
