# Importa o módulo do Active Directory
Import-Module ActiveDirectory

# Solicita a OU onde será feita a busca
$ou = Read-Host "Digite o caminho da OU (ex: OU=Workstations,DC=empresa,DC=com)"

# Valida entrada
if ([string]::IsNullOrWhiteSpace($ou)) {
    Write-Host "Caminho da OU não informado. Saindo." -ForegroundColor Red
    exit
}

# Tenta buscar computadores na OU
try {
    $computadores = Get-ADComputer -SearchBase $ou -Filter * -Properties Enabled, LastLogonDate
} catch {
    Write-Host "Erro ao acessar a OU. Verifique o caminho e suas permissões." -ForegroundColor Red
    exit
}

# Se não houver computadores, encerra
if ($computadores.Count -eq 0) {
    Write-Host "Nenhum computador encontrado na OU especificada." -ForegroundColor Yellow
    exit
}

# Separa habilitados e desabilitados
$computadoresHabilitados   = $computadores | Where-Object { $_.Enabled -eq $true  }
$computadoresDesabilitados = $computadores | Where-Object { $_.Enabled -eq $false }

# Mostra apenas as contagens
Write-Host ""
Write-Host "Resumo de computadores na OU: $ou" -ForegroundColor Cyan
Write-Host "Total de computadores.............: $($computadores.Count)" -ForegroundColor Green
Write-Host "Computadores habilitados..........: $($computadoresHabilitados.Count)" -ForegroundColor Yellow
Write-Host "Computadores desabilitados........: $($computadoresDesabilitados.Count)" -ForegroundColor Magenta

# Pergunta se quer exportar para TXT
$resposta = Read-Host "`nDeseja exportar a lista de computadores desabilitados para um arquivo TXT? (S/N)"

if ($resposta.ToUpper() -eq "S") {

    # Caminho completo do arquivo destino
    $caminhoArquivo = Read-Host "Digite o caminho completo (ex: C:\Temp\pc_desabilitados.txt)"

    # Pasta de destino
    $pastaDestino = Split-Path $caminhoArquivo

    # Cria a pasta se não existir
    if (-not (Test-Path $pastaDestino)) {
        try {
            New-Item -Path $pastaDestino -ItemType Directory -Force | Out-Null
            Write-Host "Pasta criada: $pastaDestino" -ForegroundColor Green
        } catch {
            Write-Host "Não foi possível criar a pasta: $pastaDestino. Verifique permissões." -ForegroundColor Red
            exit
        }
    }

    # Tenta salvar o arquivo
    try {
        $computadoresDesabilitados |
            Select-Object Name, Enabled, LastLogonDate |
            Out-File -FilePath $caminhoArquivo -Encoding UTF8

        Write-Host "Arquivo salvo com sucesso em: $caminhoArquivo" -ForegroundColor Green
    } catch {
        Write-Host "Erro ao salvar o arquivo. Verifique o caminho e permissões." -ForegroundColor Red
    }

} else {
    Write-Host "Arquivo TXT não será criado." -ForegroundColor Yellow
}
