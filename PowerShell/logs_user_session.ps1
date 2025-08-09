# Caminho para o arquivo de log
$logPath = "C:\Logs\acessos.log"

# Garante que o diretório existe
if (!(Test-Path -Path (Split-Path $logPath))) {
    New-Item -Path (Split-Path $logPath) -ItemType Directory -Force
}

# Dados do acesso
$dataHora = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$usuario = $env:USERNAME
$maquina = $env:COMPUTERNAME

# Tenta obter IP local
$ip = (Get-NetIPAddress -AddressFamily IPv4 |
       Where-Object { $_.InterfaceAlias -notlike "*Loopback*" -and $_.IPAddress -notlike "169.*" } |
       Select-Object -First 1 -ExpandProperty IPAddress)

if (-not $ip) { $ip = "Desconhecido" }

# Escreve no log
"$dataHora - Usuário: $usuario - Máquina: $maquina - IP: $ip" | Out-File -Append -Encoding UTF8 $logPath
