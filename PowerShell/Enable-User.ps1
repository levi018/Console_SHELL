$dcs = "NUB3.grupoaec.com.br",
"PALESTRA3.grupoaec.com.br",
"PERILO2.grupoaec.com.br",
"MINOTAURO2.grupoaec.com.br",
"ZEFIRO2.grupoaec.com.br",
"ELO2.grupoaec.com.br",
"GAVIAO2.grupoaec.com.br",
"ONDINA2.grupoaec.com.br",
"JANEIRO2.grupoaec.com.br",
"nub2.grupoaec.com.br",
"STIX2.grupoaec.com.br",
"FLORA2.grupoaec.com.br",
"DESTINO2.grupoaec.com.br",
"PALESTRA2.grupoaec.com.br",
"TITAS2.grupoaec.com.br",
"Azure-dc01.grupoaec.com.br",
"Emily.grupoaec.com.br",
"aurora.grupoaec.com.br",
"FREYA.grupoaec.com.br",
"ondina3.grupoaec.com.br",
"janeiro3.grupoaec.com.br",
"perilo3.grupoaec.com.br",
"flora3.grupoaec.com.br",
"Azure-dc02.grupoaec.com.br",
"zefiro3.grupoaec.com.br",
"minotauro3.grupoaec.com.br",
"arion3.grupoaec.com.br",
"emily2.grupoaec.com.br"


$username = Read-Host -Prompt "Enter username to enable"


foreach ($dc in $dcs) {

	Enable-ADAccount -Identity $username -Server $dc
	Write-Host "Enabling in ---> " $dc 
}