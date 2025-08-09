$ou = Read-Host "Insira o DN da OU, e possivel coletar pelo editor de atributo, quando selecionar a OU. `nOBS: Inserir o caminho completo (ex -> OU=,OU=,DC=com,DC=br)"

$days = Read-Host "Apartir de quantos dias: `n(ex. 10 -> para ultimos 10 dias)"
$dateCut = (get-date).AddDays(-$days)

Get-Adcomputer -SearchBase $ou -Filter { whenCreated -ge $dateCut } -Properties whenCreated | Sort-Object whenCreated -Descending | Select-Object Name, whenCreated