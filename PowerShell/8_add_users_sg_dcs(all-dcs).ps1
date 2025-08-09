###############################################################
# Adicionar lista de usuários (TXT) a um grupo de segurança SG AD
#     • Pede ao operador: caminho do arquivo e nome do grupo
#     • Processa todos os controladores de domínio
#     • Exibe feedback colorido de sucesso/erro
###############################################################

Import-Module ActiveDirectory

# ─── 1. Entrada interativa ───────────────────────────────────
$arquivoUsuarios = Read-Host "Informe o caminho completo do arquivo TXT com os usuários"
while (-not (Test-Path $arquivoUsuarios)) {
    Write-Host "Arquivo não encontrado. Tente novamente." -ForegroundColor Yellow
    $arquivoUsuarios = Read-Host "Informe o caminho COMPLETO do arquivo TXT com os usuários"
}

$nomeDoGrupo = Read-Host "Informe o **nome exato** do grupo de segurança (SG) no AD"
while ([string]::IsNullOrWhiteSpace($nomeDoGrupo)) {
    Write-Host "Nome do grupo não pode estar vazio." -ForegroundColor Yellow
    $nomeDoGrupo = Read-Host "Informe o **nome exato** do grupo de segurança (SG) no AD"
}

# ─── 2. Preparar dados ───────────────────────────────────────
$usuarios = Get-Content -Path $arquivoUsuarios
if ($usuarios.Count -eq 0) {
    Write-Error "O arquivo '$arquivoUsuarios' está vazio. Encerrando script."
    exit
}

# ─── 3. Obter todos os controladores de domínio ──────────────
$controladores = Get-ADDomainController -Filter *

# ─── 4. Loop principal ───────────────────────────────────────
foreach ($dc in $controladores) {
    Write-Host "`nConectando ao DC: $($dc.HostName)" -ForegroundColor Cyan

    foreach ($usuario in $usuarios) {
        try {
            # Obter objeto de usuário
            $objUsuario = Get-ADUser -Server $dc.HostName -Identity $usuario -ErrorAction Stop

            # Adicionar ao grupo
            Add-ADGroupMember -Server $dc.HostName -Identity $nomeDoGrupo -Members $objUsuario -ErrorAction Stop

            Write-Host "Usuário $usuario adicionado ao grupo '$nomeDoGrupo' no DC $($dc.HostName)" -ForegroundColor Green
        }
        catch {
            Write-Host "Erro ao adicionar '$usuario' no DC $($dc.HostName): $_" -ForegroundColor Red
        }
    }
}

Write-Host "`nProcesso concluído." -ForegroundColor Cyan
