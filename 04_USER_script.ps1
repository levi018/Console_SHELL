Import-Module ActiveDirectory

$dcs = @(
    "Azure-dc01.grupoaec.com.br",
    "NUB3.grupoaec.com.br",
    "PALESTRA3.grupoaec.com.br",
    "nub2.grupoaec.com.br",
    "PALESTRA2.grupoaec.com.br",
    "PERILO2.grupoaec.com.br",
    "MINOTAURO2.grupoaec.com.br",
    "ZEFIRO2.grupoaec.com.br",
    "ELO2.grupoaec.com.br",
    "GAVIAO2.grupoaec.com.br",
    "ONDINA2.grupoaec.com.br",
    "JANEIRO2.grupoaec.com.br",
    "STIX2.grupoaec.com.br",
    "FLORA2.grupoaec.com.br",
    "DESTINO2.grupoaec.com.br",
    "TITAS2.grupoaec.com.br",
    "Emily.grupoaec.com.br",
    "aurora.grupoaec.com.br",
    "FREYA.grupoaec.com.br",
    "janeiro3.grupoaec.com.br",
    "flora3.grupoaec.com.br",
    "Azure-dc02.grupoaec.com.br",
    "arion3.grupoaec.com.br",
    "emily2.grupoaec.com.br",
    "ARGES.grupoaec.com.br",
    "GIAS.grupoaec.com.br",
    "ELO3.grupoaec.com.br",
    "TITAS3.grupoaec.com.br",
    "ondina4.grupoaec.com.br",
    "Ondina5.grupoaec.com.br",
    "Zefiro4.grupoaec.com.br",
    "Zefiro5.grupoaec.com.br",
    "gaviao3.grupoaec.com.br"
)
$menu = @" 


                ██╗  ██╗ █████╗ ██████╗ ██╗██╗     ██╗████████╗ █████╗ ██████╗     ██╗   ██╗███████╗██╗   ██╗ █████╗ ██████╗ ██╗ ██████╗ 
                ██║  ██║██╔══██╗██╔══██╗██║██║     ██║╚══██╔══╝██╔══██╗██╔══██╗    ██║   ██║██╔════╝██║   ██║██╔══██╗██╔══██╗██║██╔═══██╗
                ███████║███████║██████╔╝██║██║     ██║   ██║   ███████║██████╔╝    ██║   ██║███████╗██║   ██║███████║██████╔╝██║██║   ██║
                ██╔══██║██╔══██║██╔══██╗██║██║     ██║   ██║   ██╔══██║██╔══██╗    ██║   ██║╚════██║██║   ██║██╔══██║██╔══██╗██║██║   ██║
                ██║  ██║██║  ██║██████╔╝██║███████╗██║   ██║   ██║  ██║██║  ██║    ╚██████╔╝███████║╚██████╔╝██║  ██║██║  ██║██║╚██████╔╝
                ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝╚══════╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝     ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝ 
                                                                                                                         
                                                                                                             

"@

Write-Host $menu -ForegroundColor Yellow

# Inicia um loop para pedir o nome do usuário até que um usuário válido seja encontrado.
$userFound = $false
do {
    Write-Host ""
    Write-Host "Digite o nome do usuário (sAMAccountName ou DistinguishedName): " -ForegroundColor Yellow -NoNewLine
    $username = Read-Host
    Write-Host ""

    try {
        # Tenta encontrar o usuário no Active Directory.
        # Se for encontrado, a variável $user é preenchida e $userFound se torna verdadeira.
        $user = Get-ADUser -Identity $username -ErrorAction Stop
        Start-Sleep 1
        Write-Host "🔍 Validando o usuário $usuario ..." -ForegroundColor Yellow
        Start-Sleep 2
        Write-Host "Usuário '$username' encontrado no Active Directory." -ForegroundColor Green
        $userFound = $true
        Write-Host ""
        Write-Host "✅ Habilitando usuário, aguarde..."
        Start-Sleep 2        
    }
    catch {
        # Se não encontrar o usuário, exibe uma mensagem de erro e o loop se repete.
        Write-Host "🔍 Validando o usuário $usuario..." -ForegroundColor Yellow
        Start-Sleep 2
        Write-Host "❌ Erro: Não foi possível encontrar o usuário '$username' no Active Directory. Por favor, tente novamente." -ForegroundColor Red
        # A variável $userFound permanece falsa, garantindo que o loop continue.
    }
} while (-not $userFound)


# Itera por cada controlador de domínio na lista.
foreach ($dc in $dcs) {
    Write-Host "Tentando habilitar o usuário '$username' em ---> $dc" -ForegroundColor Cyan
    # Usa um bloco try-catch para tratar erros.
    # Isso impede que o script pare se um controlador de domínio não puder ser acessado.
    try {
        Enable-ADAccount -Identity $username -Server $dc -ErrorAction Stop
        Write-Host "✅ Sucesso: O usuário '$username' foi habilitado em '$dc'." -ForegroundColor Green
        Write-Host ""
    }
    catch {
        # Em caso de erro, exibe a mensagem de erro para o usuário.
        Write-Host "❌ Erro: Falha ao habilitar o usuário '$username' em '$dc'." -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
    }
}

Write-Host "--------------------------------------------------------"
Write-Host "Processo concluído." -ForegroundColor Yellow