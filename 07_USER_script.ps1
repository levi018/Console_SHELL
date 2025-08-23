Import-Module ActiveDirectory -ErrorAction Stop

$menu = @"


        ██╗   ██╗███████╗██╗   ██╗ █████╗ ██████╗ ██╗ ██████╗ ███████╗    ███████╗███████╗███╗   ███╗    ███████╗ ██████╗ 
        ██║   ██║██╔════╝██║   ██║██╔══██╗██╔══██╗██║██╔═══██╗██╔════╝    ██╔════╝██╔════╝████╗ ████║    ██╔════╝██╔════╝ 
        ██║   ██║███████╗██║   ██║███████║██████╔╝██║██║   ██║███████╗    ███████╗█████╗  ██╔████╔██║    ███████╗██║  ███╗
        ██║   ██║╚════██║██║   ██║██╔══██║██╔══██╗██║██║   ██║╚════██║    ╚════██║██╔══╝  ██║╚██╔╝██║    ╚════██║██║   ██║
        ╚██████╔╝███████║╚██████╔╝██║  ██║██║  ██║██║╚██████╔╝███████║    ███████║███████╗██║ ╚═╝ ██║    ███████║╚██████╔╝
         ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚══════╝    ╚══════╝╚══════╝╚═╝     ╚═╝    ╚══════╝ ╚═════╝ 
          
                                                                                                                  

O que o script faz?

1 - Lista usuários sem uma determinada SG em uma OU específica
2 - Basta inserir a SG e o caminho da OU


"@

Write-Host $menu -ForegroundColor Yellow

# --- Coleta e validação do Distinguished Name (DN) da OU ---
# Use um loop para garantir que o usuário insira uma OU válida
do {
    $ouDN = Read-Host "Informe o Distinguished Name (DN) da OU (ex.: OU=Vendas,DC=contoso,DC=com)"
    $ouValid = $false
    Start-Sleep 2
    try {
        # Tenta encontrar a OU. Se não encontrar, o comando falha e a exceção é capturada.
        $ou = Get-ADOrganizationalUnit -Identity $ouDN -ErrorAction Stop
        Write-Host ""
        Write-Host "OU: $($ou.Name)' encontrada com sucesso." -ForegroundColor Green
        Write-Host "DN: $($ou.DistinguishedName)" -ForegroundColor Green
        $ouValid = $true
    }
    catch {
        Write-Host "A OU '$ouDN' não foi encontrada. Por favor, tente novamente." -ForegroundColor Red
        Write-Host ""
    }
} while ($ouValid -eq $false)
# --- Coleta e validação do Security Group (SG) ---
# Use um loop para garantir que o usuário insira um grupo válido
do {
    $groupName = Read-Host "Informe o nome da Security Group (SG) de referência"
    $groupValid = $false
    Start-Sleep 2
    try {
        # Tenta encontrar o grupo. Se não encontrar, o comando falha e a exceção é capturada.
        $group = Get-ADGroup -Identity $groupName -ErrorAction Stop
        $groupValid = $true
    }
    catch {
        Write-Host "Grupo '$groupName' não encontrado. Por favor, tente novamente." -ForegroundColor Red
        Write-Host ""
    }
} while ($groupValid -eq $false)

Write-Host "Procurando usuários na OU '$ouDN' que NÃO pertencem ao grupo '$($group.SamAccountName)' …`n"
Start-Sleep 3

# --- Busca dos usuários na OU ---
$usersInOU = Get-ADUser -SearchBase $ouDN -Filter * -Properties MemberOf

# --- Filtra quem não é membro do grupo ---
$usersNotInGroup = $usersInOU |
    Where-Object {
        # MemberOf pode vir vazio; padroniza para array para evitar erros
        $memberof = @($_.MemberOf)
        # Se o DN do grupo NÃO estiver na lista, mantém o usuário na saída
        ($group.DistinguishedName -notin $memberof)
    }

# --- Saída ---
$scriptPath = $PSScriptRoot  # pasta onde o script está
$outFile    = Join-Path $scriptPath "Usuarios_Sem_$($group.SamAccountName).txt"

# Exporta os SamAccountName para o arquivo de saída
$usersNotInGroup |
    Select-Object -ExpandProperty SamAccountName |
    Sort-Object |
    Out-File -Encoding UTF8 -FilePath $outFile

Write-Host "Concluído! Foram encontrados $($usersNotInGroup.Count) usuário(s) fora do grupo."
Start-Sleep 0.5
Write-Host "Arquivo gerado: $outFile"