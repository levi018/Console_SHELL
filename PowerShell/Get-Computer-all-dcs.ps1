$computer = Read-Host "Enter the computer name: "

$dcs = Get-ADDomainController -Filter * | Select-Object name

foreach ($dc in $dcs.Name) {
  try {
    $temp = Get-ADComputer $computer -Server $dc | Select Name
    Write-Host "[!] Computer $computer found in $dc"
  }
  catch {
    Write-Host "[-] Computer does not exist on $dc!"
  }
}
