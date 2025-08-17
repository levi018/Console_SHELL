Import-Module ActiveDirectory
Clear-Host
#mover 10 casas

$opcoes_menu1 = @"

Selecione a OU Desejada: 

[A] ATEDENTE
[S] SUPERVISOR
[O] OUTRO

"@
$menu = @" 



                                         _  _   __   _  _  ____  ____    _  _  ____  _  _  ____  __  __  
                                        ( \/ ) /  \ / )( \(  __)(  _ \  / )( \/ ___)/ )( \(  _ \(  )/  \ 
                                        / \/ \(  O )\ \/ / ) _)  )   /  ) \/ (\___ \) \/ ( )   / )((  O )
                                        \_)(_/ \__/  \__/ (____)(__\_)  \____/(____/\____/(__\_)(__)\__/ 

  
  
  
                                                                                                                                    
"@

$Ou_Atendentes_Array="
OU=JP3_AthenaSaude_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Bradesco_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Bradesco_Cartoes_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Bradesco_Cartoes_Atendentes_Homologacao,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Bradesco_Seguros_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_GrupoSBF_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_MercadoLivre_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_MercadoLivre_Atendentes_Homologacao,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_MercadoLivre_Atendentes_VDI,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Nubank_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Nubank_Atendentes_Homologacao,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Nubank_Atendentes_Homolog_Break,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Nubank_Collections_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_OdontoPrev_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_OdontoPrev_Atendentes_VDI,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Privalia_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_RecargaPay_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Terra_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Vivo_Atendentes,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Vivo_Atendentes_Homologacao,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Vivo_Atendentes_VDI,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Vivo_Atendentes_WDE,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
" -split "`r?`n"
$Ou_Supervisores_Array=@"
OU=JP3_AthenaSaude_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Bradesco_Cartoes_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Bradesco_Seguros_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Bradesco_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_GrupoSBF_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_MercadoLivre_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Nubank_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_OdontoPrev_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Privalia_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_RecargaPay_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Terra_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br
OU=JP3_Vivo_Supervisores,OU=Site_Joao_Pessoa_3,OU=AeC_Contact_Center,OU=Grupo_AeC,DC=grupoaec,DC=com,DC=br

"@ -split "`r?`n"

$Operacoes_Atendes = @"

[01]AthenaSaude                 [12]Nubank_HomologaçãoBreak 
[02]Bradesco                    [13]Nubank_Colletions
[03]BradesCard                  [14]OdontoPrev
[04]BradesCard_Homologação      [15]OdontoPrev_VDI     
[05]BradesSeg                   [16]Privalia
[06]GrupoSBF                    [17]RecargaPay
[07]MercadoLivre                [18]Terra
[08]MercadoLivre_Homologação    [19]Vivo
[09]MercadoLivre_VDI            [20]Vivo_Homologação
[10]Nubank                      [21]Vivo_VDI
[11]Nubank_Homologação          [22]Vivo_WDE         

"@
$Operacoes_Supervisores = @"

[01]AthenaSaude                 [07]OdontoPrev        
[02]Bradesco                    [08]Privalia           
[03]BradesCard                  [09]Nubank                                  
[04]BradesSeg                   [10]RecargaPay  
[05]GrupoSBF                    [11]Terra 
[06]MercadoLivre                [12]Vivo                          

"@

$Operacoes_Atendes_Array = @"

[01]AthenaSaude                 [10]Nubank        
[02]Bradesco                    [11]Nubank_Homologação
[03]BradesCard                  [12]Nubank_HomologaçãoBreak
[04]BradesCard_Homologação      [13]Nubank_Colletions      
[05]BradesSeg                   [14]RecargaPay  
[06]GrupoSBF                    [15]Terra 
[07]MercadoLivre                [16]Vivo 
[08]MercadoLivre_VDI            [17]Vivo_Homologação
[09]OdontoPrev                  [18]Vivo_VDI
[10]Privalia                    [19]Vivo_WDE         

"@ -split "`r?`n"
$Operacoes_Supervisores_Array = @"

[01]AthenaSaude                 [07]OdontoPrev        
[02]Bradesco                    [08]Privalia           
[03]BradesCard                  [09]Nubank                                  
[04]BradesSeg                   [10]RecargaPay  
[05]GrupoSBF                    [11]Terra 
[06]MercadoLivre                [12]Vivo                          

"@ -split "`r?`n"

$DCs = @"
Azure-dc01.grupoaec.com.br
NUB3.grupoaec.com.br
PALESTRA3.grupoaec.com.br
nub2.grupoaec.com.br
PALESTRA2.grupoaec.com.br
PERILO2.grupoaec.com.br
MINOTAURO2.grupoaec.com.br
ZEFIRO2.grupoaec.com.br
ELO2.grupoaec.com.br
GAVIAO2.grupoaec.com.br
ONDINA2.grupoaec.com.br
JANEIRO2.grupoaec.com.br
STIX2.grupoaec.com.br
FLORA2.grupoaec.com.br
DESTINO2.grupoaec.com.br
TITAS2.grupoaec.com.br
Emily.grupoaec.com.br
aurora.grupoaec.com.br
FREYA.grupoaec.com.br
janeiro3.grupoaec.com.br
flora3.grupoaec.com.br
Azure-dc02.grupoaec.com.br
arion3.grupoaec.com.br
emily2.grupoaec.com.br
ARGES.grupoaec.com.br
GIAS.grupoaec.com.br
ELO3.grupoaec.com.br
TITAS3.grupoaec.com.br
ondina4.grupoaec.com.br
Ondina5.grupoaec.com.br
Zefiro4.grupoaec.com.br
Zefiro5.grupoaec.com.br
gaviao3.grupoaec.com.br
"@ -split "`r?`n"

Write-Host $menu -ForegroundColor Yellow


# Inicia um loop 'do...while' que continuará até que um usuário válido seja encontrado
do {
    # Pede ao usuário para digitar o nome de usuário (sAMAccountName ou DistinguishedName)
    Write-Host "Digite o nome do usuário (sAMAccountName ou DistinguishedName): " -ForegroundColor Yellow -NoNewLine
    $username = Read-Host

    # Tenta encontrar o usuário no Active Directory
    try {
        # O cmdlet Get-ADUser procura por um usuário. Se não encontrar, ele gera um erro.
        $user = Get-ADUser -Identity $username -ErrorAction Stop
        # Se o comando acima for bem-sucedido, a variável $user não será nula.
        $userFound = $true
    }
    catch {
        # Se um erro ocorrer (usuário não encontrado), exibe uma mensagem de erro.
        Write-Host "Usuário '$username' não encontrado. Por favor, tente novamente." -ForegroundColor Red
        $userFound = $false
        Start-Sleep -Seconds 2
        Clear-Host
        Write-Host $menu -ForegroundColor Yellow
    }
} while (-not $userFound)

Write-Host "Usuário '$($user.SamAccountName)' encontrado com sucesso!" -ForegroundColor Green

# Inicia o loop para validar a seleção de cargo.
# O loop continua até que o usuário faça uma escolha válida ('A', 'S', 'O' ou 'V').
do {
    # Exibe as opções de menu.
    Start-Sleep -Seconds 2
    Clear-Host
    Write-Host $menu -ForegroundColor Yellow
    Write-Host "Usuário '$($user.SamAccountName)' encontrado com sucesso!" -ForegroundColor Green
    Write-Host $opcoes_menu1
    Write-Host "Digite o cargo do usuário: " -ForegroundColor Yellow -NoNewLine
    $NewOU = Read-Host
    
    # Converte a entrada do usuário para maiúscula para facilitar a comparação.
    $NewOU = $NewOU.ToUpper()

    # Usa um comando 'switch' para avaliar a entrada e definir o status de validação.
    switch ($NewOU) {
        "A" {
            $isValidSelection = $true
            # Define o valor da variável para Atendente.
            $NewOU = "Atendente"
            # Novo loop para validação da opção do Atendente
            do {
                Clear-Host
                Write-Host $menu -ForegroundColor Yellow
                Write-Host "Usuário '$($user.SamAccountName)' encontrado com sucesso!" -ForegroundColor Green
                Write-Host ""
                Write-Host "Selecionado o cargo de Atendente. Agora, selecione a Operação:" -ForegroundColor Green
                Write-Host $Operacoes_Atendes
                Write-Host "Digite a opção desejada (1-22): " -NoNewline -ForegroundColor Yellow
                $escolher_operacao = Read-Host

                # Tenta converter a entrada para um número.
                if ($escolher_operacao -as [int]) {
                    $opcao_numerica = [int]$escolher_operacao
                    
                    # Checa se a opção está dentro do range válido (1 a 22)
                    if ($opcao_numerica -ge 1 -and $opcao_numerica -le $Ou_Atendentes_Array.Length) {
                        # A variável $NewOU_Path agora conterá o caminho da OU selecionada.
                        # Subtraímos 1 porque os índices de array começam em 0.
                        $NewOU_Path = $Ou_Atendentes_Array[$opcao_numerica]
                        Write-Host "OU selecionada: $NewOU_Path" -ForegroundColor Green
                        
                        $isValidOperation = $true
                    } else {
                        Write-Host "Opção inválida. Digite um número entre 1 e $($Ou_Atendentes_Array.Length)." -ForegroundColor Red
                        $isValidOperation = $false
                        Start-Sleep -Seconds 2
                    }
                } else {
                    Write-Host "Opção inválida. Por favor, digite um número." -ForegroundColor Red
                    $isValidOperation = $false
                    Start-Sleep -Seconds 2
                }
            } while (-not $isValidOperation)
            
            
        }
        "S" {
            $isValidSelection = $true
            # Define o valor da variável para Supervisor.
            $NewOU = "Supervisor"
            
            # Novo loop para validação da opção do Supervisor
            do {
                Clear-Host
                Write-Host $menu -ForegroundColor Yellow
                Write-Host "Usuário '$($user.SamAccountName)' encontrado com sucesso!" -ForegroundColor Green
                Write-Host ""
                Write-Host "Selecionado o cargo de Supervisor. Agora, selecione a Operação:" -ForegroundColor Green
                Write-Host $Operacoes_Supervisores
                Write-Host "Digite a opção desejada (1-12): " -NoNewline -ForegroundColor Yellow
                $escolher_operacao = Read-Host
                
                # Tenta converter a entrada para um número.
                if ($escolher_operacao -as [int]) {
                    $opcao_numerica = [int]$escolher_operacao
                    
                    # Checa se a opção está dentro do range válido (1 a 13)
                    if ($opcao_numerica -ge 1 -and $opcao_numerica -le $Ou_Supervisores_Array.Length) {
                        # A variável $NewOU_Path agora conterá o caminho da OU selecionada.
                        # Subtraímos 1 porque os índices de array começam em 0.
                        $NewOU_Path = $Ou_Supervisores_Array[$opcao_numerica]
                        Write-Host "OU selecionada: $NewOU_Path" -ForegroundColor Green
                        
                        $isValidOperation = $true
                    } else {
                        Write-Host "Opção inválida. Digite um número entre 1 e $($Ou_Supervisores_Array.Length)." -ForegroundColor Red
                        $isValidOperation = $false
                        Start-Sleep -Seconds 2
                    }
                } else {
                    Write-Host "Opção inválida. Por favor, digite um número." -ForegroundColor Red
                    $isValidOperation = $false
                    Start-Sleep -Seconds 2
                }
            } while (-not $isValidOperation)
        }
        "O" {
            $isValidSelection = $true
            # Define o valor da variável para Outro.
            $NewOU = "Outro"
            
            # Novo loop para validação da opção "Outro", onde o usuário digita o caminho da OU.
            do {
                Clear-Host
                Write-Host $menu -ForegroundColor Yellow
                Write-Host "Usuário '$($user.SamAccountName)' encontrado com sucesso!" -ForegroundColor Green
                Write-Host ""
                Write-Host "Você selecionou 'Outro'. Digite o caminho completo da OU de destino:" -ForegroundColor Green
                Write-Host "Exemplo: OU=NovaOU,OU=Site,DC=grupoaec,DC=com,DC=br" -ForegroundColor Yellow
                Write-Host "Caminho da OU: " -NoNewline -ForegroundColor Yellow
                $ouPathInput = Read-Host
                
                # Tenta encontrar a OU digitada.
                try {
                    Get-ADOrganizationalUnit -Identity $ouPathInput -ErrorAction Stop | Out-Null
                    $NewOU_Path = $ouPathInput
                    Write-Host "OU '$NewOU_Path' encontrada com sucesso!" -ForegroundColor Green
                    
                    $isValidOperation = $true
                }
                catch {
                    Write-Host "Caminho da OU inválido ou não encontrado. Por favor, tente novamente." -ForegroundColor Red
                    $isValidOperation = $false
                    Start-Sleep -Seconds 2
                }
            } while (-not $isValidOperation)
        }
        default {
            # Se a entrada não corresponder a nenhuma das opções válidas,
            # exibe uma mensagem de erro.
            Write-Host "Opção inválida. Por favor, selecione 'A', 'S', 'O' ou 'V'." -ForegroundColor Red
            $isValidSelection = $false
        }
    }
} while (-not $isValidSelection)

# Exibe a escolha final do usuário, confirmando que a validação foi bem-sucedida.
Write-Host ""
Write-Host "Opção de cargo válida selecionada: $NewOU" -ForegroundColor Green



# Lógica centralizada para mover o usuário
Write-Host ""
Write-Host "Opção de cargo válida selecionada: $NewOU" -ForegroundColor Green
Write-Host "Iniciando a movimentação do usuário para a OU: $NewOU_Path" -ForegroundColor Yellow

# Loop através da lista de Domain Controllers para mover o usuário em cada um
foreach ($DC in $DCs) {
    Write-Host "`n➡️  Movendo usuário no DC: $DC..." -ForegroundColor Cyan
    
    try {
        # Tenta mover o usuário.
        Move-ADObject -Identity $user.DistinguishedName -TargetPath $NewOU_Path -Server $DC -ErrorAction Stop
        Write-Host "✅ Usuário movido com sucesso no DC: $DC" -ForegroundColor Green
    } catch {
        # Se ocorrer um erro, exibe a mensagem.
        Write-Host "❌ Falha ao mover no DC: $DC" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}

Write-Host "`nScript concluído." -ForegroundColor Green






