# Pergunta qual Security Group será consultado
$SG = Read-Host "Digite o nome da SG"

# Pergunta o caminho completo (incluindo o nome do arquivo .csv) onde o relatório será salvo
$CaminhoCsv = Read-Host `
  "Digite o caminho completo onde deseja salvar o arquivo (ex.: C:\Relatorios\UsuariosSG.csv)"

# Busca membros do grupo, coleta os atributos desejados e exporta para o local informado
Get-ADGroupMember -Identity $SG |
    Get-ADUser -Properties SamAccountName,GivenName,Surname,EmailAddress |
    Select-Object SamAccountName,GivenName,Surname,EmailAddress |
    Export-Csv -Path $CaminhoCsv -NoTypeInformation -Encoding UTF8

Write-Host "Relatório gerado em: $CaminhoCsv"
