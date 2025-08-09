<#
.SYNOPSIS
Gera um TXT com todos os usuários de uma OU que **não** pertencem a um determinado Security Group.

.DESCRIÇÃO
– Pergunta ao operador:
  • DistinguishedName (DN) da OU-alvo  
  • Nome (sAMAccountName, CN ou DN) do Security Group de referência

– Busca todos os usuários dentro da OU
– Verifica se cada usuário é membro do SG informado
– Mantém somente quem **não** pertence ao grupo
– Salva a lista de usuários em um arquivo TXT no diretório onde o script for executado

.REQUISITOS
– RSAT ou ActiveDirectory module carregado (Import-Module ActiveDirectory)
– Permissão de leitura nos objetos da OU e do grupo
#>

# Garante que o módulo Active Directory esteja carregado
Import-Module ActiveDirectory -ErrorAction Stop

# --- Coleta de parâmetros do operador ---
$ouDN      = Read-Host "Informe o Distinguished Name (DN) da OU, ex.: OU=Vendas,DC=contoso,DC=com"
$groupName = Read-Host "Informe o nome ou DN do Security Group (SG) de referência"

# Resolve o objeto do grupo (aceita nome, SamAccountName, CN ou DN)
try {
    $group = Get-ADGroup -Identity $groupName -ErrorAction Stop
} catch {
    Write-Error "Grupo '$groupName' não encontrado. Encerrando."
    exit 1
}

Write-Host "Procurando usuários na OU '$ouDN' que NÃO pertencem ao grupo '$($group.SamAccountName)' …`n"

# --- Busca dos usuários na OU ---
$usersInOU = Get-ADUser -SearchBase $ouDN -Filter * -Properties MemberOf

# --- Filtra quem não é membro do grupo ---
$usersNotInGroup = $usersInOU |
    Where-Object {
        # MemberOf pode vir vazio; padroniza para array
        $memberof = @($_.MemberOf)
        # Se o DN do grupo NÃO estiver na lista, mantém
        ($group.DistinguishedName -notin $memberof)
    }

# --- Saída ---
$scriptPath = $PSScriptRoot   # pasta onde o script está
$outFile    = Join-Path $scriptPath "Usuarios_Sem_$($group.SamAccountName).txt"

$usersNotInGroup |
    Select-Object -ExpandProperty SamAccountName |
    Sort-Object |
    Out-File -Encoding UTF8 -FilePath $outFile

Write-Host "Concluído! Foram encontrados $($usersNotInGroup.Count) usuário(s) fora do grupo."
Write-Host "Arquivo gerado: $outFile"
