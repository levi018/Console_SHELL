# Parâmetros (edite conforme necessário)
$groupName = "SG - VDI_MercadoLivre"
$userSamAccountName = "s.antonie.pereira"  # Ex: jdoe

# Obtém os controladores de domínio do domínio atual
$domain = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$dcs = $domain.DomainControllers

Write-Host "`n🔍 Verificando se o grupo '$groupName' existe e se o usuário '$userSamAccountName' é membro em todos os DCs..." -ForegroundColor Cyan

foreach ($dc in $dcs) {
    $dcName = $dc.Name
    Write-Host "`n🖥️  Consultando DC: ${dcName}" -ForegroundColor Yellow

    try {
        # Conecta ao DC
        $groupSearcher = New-Object System.DirectoryServices.DirectorySearcher
        $groupSearcher.SearchRoot = "LDAP://${dcName}"
        $groupSearcher.Filter = "(&(objectClass=group)(cn=$groupName))"
        $groupSearcher.PropertiesToLoad.Add("distinguishedName") | Out-Null
        $groupSearcher.PropertiesToLoad.Add("member") | Out-Null

        $groupResult = $groupSearcher.FindOne()

        if ($groupResult) {
            $groupDN = $groupResult.Properties["distinguishedName"]
            Write-Host "✅ Grupo '$groupName' encontrado em ${dcName}: $groupDN" -ForegroundColor Green

            # Procurar o DN do usuário
            $userSearcher = New-Object System.DirectoryServices.DirectorySearcher
            $userSearcher.SearchRoot = "LDAP://${dcName}"
            $userSearcher.Filter = "(&(objectClass=user)(sAMAccountName=$userSamAccountName))"
            $userSearcher.PropertiesToLoad.Add("distinguishedName") | Out-Null

            $userResult = $userSearcher.FindOne()

            if ($userResult) {
                $userDN = $userResult.Properties["distinguishedName"]

                if ($groupResult.Properties["member"] -contains $userDN) {
                    Write-Host "👤 Usuário é MEMBRO do grupo neste DC." -ForegroundColor Green
                } else {
                    Write-Host "🚫 Usuário NÃO é membro do grupo neste DC." -ForegroundColor Red
                }
            } else {
                Write-Host "❓ Usuário '$userSamAccountName' não encontrado neste DC." -ForegroundColor Magenta
            }

        } else {
            Write-Host "❌ Grupo '$groupName' NÃO encontrado em ${dcName}" -ForegroundColor Red
        }
    } catch {
        Write-Host "⚠️ Erro ao consultar ${dcName}: $($_.Exception.Message)" -ForegroundColor Magenta
    }
}