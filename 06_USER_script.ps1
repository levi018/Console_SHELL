Import-Module ActiveDirectory

$menu = @"


                ██╗     ██╗███████╗████████╗ █████╗ ██████╗     ██╗   ██╗███████╗██╗   ██╗ █████╗ ██████╗ ██╗ ██████╗ ███████╗
                ██║     ██║██╔════╝╚══██╔══╝██╔══██╗██╔══██╗    ██║   ██║██╔════╝██║   ██║██╔══██╗██╔══██╗██║██╔═══██╗██╔════╝
                ██║     ██║███████╗   ██║   ███████║██████╔╝    ██║   ██║███████╗██║   ██║███████║██████╔╝██║██║   ██║███████╗
                ██║     ██║╚════██║   ██║   ██╔══██║██╔══██╗    ██║   ██║╚════██║██║   ██║██╔══██║██╔══██╗██║██║   ██║╚════██║
                ███████╗██║███████║   ██║   ██║  ██║██║  ██║    ╚██████╔╝███████║╚██████╔╝██║  ██║██║  ██║██║╚██████╔╝███████║
                ╚══════╝╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝     ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚══════╝
  


 O que o script faz?

 1 - Lista todos os usuários de uma determinada OU
 2 - Faz um resumo dos usuários habilitados e desabilitados e o total
 3 - Transforma o resultado em txt ou csv 
                                                                                                              
"@

Write-Host $menu -ForegroundColor Yellow
# Define as variáveis do script
$outputFile = ""
$ouPath = ""
$fileType = ""

# --- Seção de Coleta de Entrada do Usuário ---

# Solicita o caminho da OU
Start-Sleep 1.3
while ($true) {
    $ouPath = Read-Host -Prompt "Digite o caminho completo da OU (ex: OU=Marketing,DC=contoso,DC=com)"
    if ($ouPath -match '^OU=.*,DC=.*,DC=.*$') {
        try {
            # Testa se a OU existe
            $ouExists = Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$ouPath'" -ErrorAction Stop
            break
        } catch {
            Write-Host "Caminho da OU não encontrado. Por favor, tente novamente." -ForegroundColor Red
            Write-Host ""
        }
    } else {
        Write-Host "Formato do caminho da OU inválido. O formato deve ser (OU=NomeDaOU,DC=dominio,DC=com)." -ForegroundColor Red
        Write-Host ""
    }
}

# Solicita o tipo de arquivo de saída
while ($true) {
    $fileType = Read-Host -Prompt "Escolha o tipo de arquivo de saída (txt ou csv)"
    if ($fileType -eq "txt" -or $fileType -eq "csv") {
        break
    } else {
        Start-Sleep 1
        Write-Host "Tipo de arquivo inválido. Por favor, digite 'txt' ou 'csv'." -ForegroundColor Red
        Write-Host ""
    }
}

# Define o nome do arquivo de saída
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$fileName = "Users_OU_$(Get-ADOrganizationalUnit -Identity $ouPath).Name"
$outputFile = "$env:USERPROFILE\Desktop\$fileName.$fileType"

Write-Host "`nColetando informações dos usuários. Por favor, aguarde..."
Write-Host "O arquivo será salvo na Área de Trabalho"
Start-Sleep 5

# --- Seção de Listagem e Geração do Arquivo ---

# Obtém a lista de usuários da OU e exporta para o arquivo
try {
    $users = Get-ADUser -Filter * -SearchBase $ouPath -Properties Enabled, SamAccountName, Name | Select-Object Name, SamAccountName, Enabled, @{N='Status';E={if ($_.Enabled) {'Habilitado'} else {'Desabilitado'}}}
    
    if ($fileType -eq "csv") {
        $users | Export-Csv -Path $outputFile -NoTypeInformation -Delimiter ";"
        Write-Host "`nArquivo CSV gerado com sucesso em: $outputFile" -ForegroundColor Green
    } elseif ($fileType -eq "txt") {
        $users | Format-Table -AutoSize | Out-File -FilePath $outputFile
        Write-Host "`nArquivo TXT gerado com sucesso em: $outputFile" -ForegroundColor Green
    }
} catch {
    Write-Host "`nOcorreu um erro ao gerar o arquivo. Verifique o caminho da OU ou as permissões." -ForegroundColor Red
    exit
}

# --- Seção de Resumo e Visualização ---

Write-Host "`n--- Resumo dos Usuários na OU ---"
$totalUsers = $users.Count
$enabledUsers = $users | Where-Object { $_.Enabled -eq $true }
$disabledUsers = $users | Where-Object { $_.Enabled -eq $false }

Write-Host "Total de usuários: $totalUsers" -ForegroundColor Magenta
Write-Host "Usuários Habilitados: $($enabledUsers.Count)" -ForegroundColor Yellow
Write-Host "Usuários Desabilitados: $($disabledUsers.Count)" -ForegroundColor Red

Start-Sleep 1
Write-Host "`nScript concluído."