# Importa o módulo do Active Directory (certifique-se de que o RSAT esteja instalado)
Import-Module ActiveDirectory

# Lista de usuários a serem desativados (utilize o SamAccountName)
$usuarios = @(
    "JP3.ODP",
    "JP3.NUB"
    "JP3.MCL"
    "JP3.CNU"
    "JP3.BDC"
    "JP3.BDB",
    "JP3.BDS"
    "JP3.ATS"
    "JP3.VTM"
    "JP3.VIV"
    "JP3.TER",
    "JP3.RCP"
    "JP3.SBF"
)

foreach ($usuario in $usuarios) {
    try {
        # Busca o usuário no AD e desativa a conta
        Disable-ADAccount -Identity $usuario -ErrorAction Stop
        Write-Host "Usuário '$usuario' desativado com sucesso." -ForegroundColor Green
    }
    catch {
        Write-Host "Erro ao desativar o usuário '$usuario': $_" -ForegroundColor Red
    }
}