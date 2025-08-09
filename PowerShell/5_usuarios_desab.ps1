# Importa o módulo do Active Directory
Import-Module ActiveDirectory

# Solicita ao usuário o caminho da OU
$ou = Read-Host "Digite o caminho da OU (ex: OU=Finance,DC=empresa,DC=com)"

# Valida se o caminho da OU foi informado
if ([string]::IsNullOrWhiteSpace($ou)) {
    Write-Host "Caminho da OU não informado. Saindo." -ForegroundColor Red
    exit
}

# Tenta obter os usuários da OU
try {
    $usuarios = Get-ADUser -SearchBase $ou -Filter * -Properties Enabled, Name, SamAccountName, UserPrincipalName
} catch {
    Write-Host "Erro ao acessar a OU. Verifique o caminho e suas permissões." -ForegroundColor Red
    exit
}

# Conta usuários totais, habilitados e desabilitados
$totalUsuarios = $usuarios.Count
$usuariosHabilitados = ($usuarios | Where-Object { $_.Enabled -eq $true }).Count
$usuariosDesabilitados = ($usuarios | Where-Object { $_.Enabled -eq $false })

# Exibe as informações (somente as contagens)
Write-Host "Resumo de usuários na OU: $ou" -ForegroundColor Cyan
Write-Host "Total de usuários: $totalUsuarios" -ForegroundColor Green
Write-Host "Usuários habilitados: $usuariosHabilitados" -ForegroundColor Yellow
Write-Host "Usuários desabilitados: $($usuariosDesabilitados.Count)" -ForegroundColor Magenta # <- correção aqui!

# Pergunta se quer criar arquivo TXT com os usuários desabilitados
$resposta = Read-Host "Deseja exportar a lista de usuários desabilitados para um arquivo TXT? (S/N)"

if ($resposta.ToUpper() -eq "S") {
    # Define caminho para salvar o arquivo TXT
    $caminhoArquivo = Read-Host "Digite o caminho completo para salvar o arquivo TXT (ex: C:\temp\usuarios_desabilitados.txt)"
    
    # Exporta os usuários desabilitados para o arquivo TXT
    try {
        $usuariosDesabilitados | 
            Select-Object Name, SamAccountName, UserPrincipalName |
            Out-File -FilePath $caminhoArquivo -Encoding UTF8
        
        Write-Host "Arquivo salvo em: $caminhoArquivo" -ForegroundColor Green
    } catch {
        Write-Host "Erro ao salvar o arquivo. Verifique o caminho e permissões." -ForegroundColor Red
    }
} else {
    Write-Host "Arquivo TXT não será criado." -ForegroundColor Yellow
}
