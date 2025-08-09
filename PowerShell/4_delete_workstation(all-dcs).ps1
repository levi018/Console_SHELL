$dcs = Get-ADDomainController -Filter * | Select-Object -ExpandProperty HostName

$computerName = Read-Host -Prompt "Digite o nome da Maquina "


Write-Host "Digite 'del' para confirmar a exclusao da maquina $computerName"
$confirmation = Read-Host -Prompt "Confirmacao"

if ($confirmation -ne "del") {
    Write-Host "Exclusao cancelada."
    exit
}

foreach ($dc in $dcs) {
    
    $computer = Get-ADComputer -Identity $computerName -Server $dc -ErrorAction SilentlyContinue
    if ($null -eq $computer) {
        Write-Host "Computador $computerName não encontrado no DC $dc"
        continue
    }

    
    $childObjects = Get-ADObject -Filter * -SearchBase $computer.DistinguishedName -SearchScope OneLevel -Server $dc
    foreach ($child in $childObjects) {
        
        if ($child.ObjectClass -ne "computer") {
            Remove-ADObject -Identity $child.DistinguishedName -Server $dc -Confirm:$false
            Write-Host "Objeto filho $($child.Name) removido do computador $computerName no DC $dc"
        }
    }

    
    Remove-ADComputer -Identity $computerName -Server $dc -Confirm:$false
    Write-Host "Maquina $computerName removida do DC $dc"

    
}
