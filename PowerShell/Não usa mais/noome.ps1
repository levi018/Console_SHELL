Import-Module ActiveDirectory

# Solicita o nome do usuário
$nomeUsuario = Read-Host "Digite o nome completo do usuário"

# Busca no Active Directory
$usuario = Get-ADUser -Filter "Name -like '*$nomeUsuario*'" -Property SamAccountName

# Exibe o resultado
if ($usuario) {
    Write-Output "O nome de login do usuário é: $($usuario.SamAccountName)"
} else {
    Write-Output "Usuário não encontrado no Active Directory."
}