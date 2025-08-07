Clear-Host
#Configurações de Layout
$host.UI.RawUI.WindowTitle = "CONSOLE POWERSHELL V.1.0"
#$host.UI.RawUI.BufferSize = @{width=150; height=3000}
$host.UI.RawUI.WindowSize = @{width=150; height=45}

$host.UI.RawUI.ForegroundColor = "white"

function Show-Menu {
     Write-Host ""
     Write-Host ""
     Write-Host ""
 Write-Host "   _____  ____   _   _   _____   ____   _       ______     _____    ____ __          __ ______  _____       _____  _    _  ______  _       _      " 
    Write-Host "  / ____|/ __ \ | \ | | / ____| / __ \ | |     |  ____|   |  __ \  / __ \\ \        / /|  ____||  __ \     / ____|| |  | ||  ____|| |     | |     " 
    Write-Host " | |    | |  | ||  \| || (___  | |  | || |     | |__      | |__) || |  | |\ \  /\  / / | |__   | |__) |    |(___  | |__| || |__   | |     | |     " 
    Write-Host " | |    | |  | || .  ` | \___ \ | |  | || |     |  __|     |  ___/ | |  | | \ \/  \/ /  |  __|  |  _  /     \___ \ |  __  ||  __|  | |     | |     " 
    Write-Host " | |____| |__| || |\  | ____) || |__| || |____ | |____    | |     | |__| |  \  /\  /   | |____ | | \ \     ____) || |  | || |____ | |____ | |____ " 
    Write-Host "  \_____|\____/ |_| \_||_____/  \____/ |______||______|   |_|      \____/    \/  \/    |______||_|  \_\   |_____/ |_|  |_||______||______||______|" 
    Write-Host "                                                                                                                                                  " 
    Write-Host "                                                                                                                                                  " 
    Write-Host "                                                                                                                                                  " 
    Write-Host "                                                               __      __ __       ____                                                           " 
    Write-Host "                                                               \ \    / //_ |     / __ \                                                          " 
    Write-Host "                                                                \ \  / /  | |    | |  | |                                                         " 
    Write-Host "                                                                 \ \/ /__ | | __ | |  | |                                                         " 
    Write-Host "                                                                  \  /(__)| |(__)| |__| |                                                         " 
    Write-Host "                                                                   \/     |_|     \____/                                                          " 
    Write-Host ""
    Write-Host ""
    Write-Host "   [1]  Apagar 1(uma) máquina do active directory em todos os DCS"-ForegroundColor Green
    Write-Host "   [2]  Apagar várias máquina do active directory em todos os DCS"-ForegroundColor Green
    Write-Host "   [3]  Habilitar máquina em todos em todos os DCS"-ForegroundColor Green
    Write-Host "   [4]  Mover uma máquina de OU em todos os DCS"-ForegroundColor Green
    Write-Host "   [5]  Adicionar SG em um usuário em todos os DCS" -ForegroundColor Green
    Write-Host "   [6]  Adicionar SG EM VÁRIOS usuários em todos os DCS a partir de um arquivo .txt"-ForegroundColor Green
    Write-Host "   [7]  Remover E-mail de um usuário em todos os DCS"-ForegroundColor Green
    Write-Host "   [8]  Adicionar E-mail para um usuário em todos os DCS"-ForegroundColor Green
    Write-Host "   [9]  Listar em ordem decrescente as ultimas máquinas criadas de uma OU" -ForegroundColor Green
    Write-Host "   [10] Conta usuários habilitados e desabilitados em uma OU especificada" -ForegroundColor Green
    Write-Host "   [11] Procurar em uma OU usuários que não possuem tal SG" -ForegroundColor Green
    Write-Host "   [12] Listar todos os usuários de uma determianda OU" -ForegroundColor Green
    Write-Host "   [13] Contar usuários Habilitados e Desabilitados de um OU" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [0] Sair" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   SELECIONE UMA DAS OPCOES ACIMA E PRESSIONE ENTER"
    Write-Host ""
    Write-Host "" -NoNewline
}

function Invoke-Task {
    param(
        [int]$Selection
    )
    
    switch ($Selection) {
        1 {
            Write-Host "Executando script ..."
            Start-Sleep -Seconds 3
            Write-Host ""
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\4_delete_workstation(all-dcs).ps1"
        }
        2 {
            Write-Host "Executando script ...."
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\4_1_delete_all_workstation(all-dcs).ps1"
        }
        3 {
            Write-Host "Executando script ..." 
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\3_habilita_maqs_ad(all-dcs)..ps1"
        }
        4 {
            Write-Host "Executando script ..." 
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\7.1_mover_maqs_dcs.ps1"
        }
        5 {
            Write-Host "Executando script ..." 
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\6_add_sg_dcs(all-dcs).ps1"
        }
        6 {
            Write-Host "Executando script ..." 
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\8_add_users_sg_dcs(all-dcs).ps1"
        }
        7 {
            Write-Host "Executando script ..." 
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\13_remove_email-user-ad_(all-dcs).ps1"
        }
        8 {
            Write-Host "Executando script ..." 
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\14_adicionar_email-user-ad_(all-dcs).ps1"
        }
        9 {
            Write-Host "Executando script ..."  
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\12_last_maq_joined_in_ou.ps1"
        }
        10 {
            Write-Host "Executando script ..." 
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\5_usuarios_desab.ps1"
        }
        11 {
            Write-Host "Executando script ..."
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\10_users_ou_sem_sg.ps1"
        }
        12 {
            Write-Host "Executando script ..."
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\9_get_users_ou.ps1"
        }
        13 {
            Write-Host "Executando script ..."
            & "C:\Users\c.levi.oliveira\Desktop\SCRIPTS\PowerShell\11_contar_users_ou.ps1"
        }
        0 {
            Write-Host "Saindo..."
            exit
        }
        default {
            Write-Host "Opção inválida. Tente novamente." -ForegroundColor Red
            Start-Sleep -Seconds 3
        }
    }
}

# Loop principal do menu
do {
    Show-Menu
    $choice = Read-Host "....INSIRA A OPCAO:"

    if ($choice -notlike '') {
        Invoke-Task -Selection ([int]$choice)
    }

    Write-Host "Pressione qualquer tecla para continuar..."
    $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Clear-Host

} while ($true)
