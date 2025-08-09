<#
.SYNOPSIS
    Lista SamAccountName dos usuários de uma OU do AD
    e grava em um arquivo-texto (um login por linha).

.EXAMPLE
    .\Get-OUUserLogins.ps1 `
        -OU "OU=Vendas,DC=contoso,DC=com" `
        -OutFile "D:\Relatorios\logins_vendas.txt"
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$OU,

    [Parameter(Mandatory = $true)]
    [string]$OutFile
)

Write-Host "► Consultando usuários em '$OU' ..." -ForegroundColor Cyan

# 1. Busca só o SamAccountName
try {
    $logins = Get-ADUser -Filter * -SearchBase $OU -Properties SamAccountName |
              Select-Object -ExpandProperty SamAccountName |
              Sort-Object
} catch {
    Write-Error "Falha ao consultar a OU. Erro: $_"
    exit 1
}

if (-not $logins) {
    Write-Warning "Nenhum usuário encontrado."
    exit 0
}

# 2. Garante que a pasta destino exista
$destDir = Split-Path $OutFile
if (-not (Test-Path $destDir)) {
    New-Item -Path $destDir -ItemType Directory -Force | Out-Null
}

# 3. Grava um login por linha (UTF-8)
try {
    $logins | Set-Content -Path $OutFile -Encoding UTF8
    Write-Host "✔ Logins salvos em: $OutFile" -ForegroundColor Green
} catch {
    Write-Error "Falha ao gravar o arquivo. Erro: $_"
    exit 1
}
