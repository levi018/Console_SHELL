# Solicita que o usuário digite o login
$usuario = Read-Host "Digite o nome de usuário do AD (ex: jp3.viv)"

# Executa o comando Get-ADUser com base na entrada e exibe apenas o SID
Get-ADUser -Identity $usuario | Select-Object SID 