Clear-Host
##LETRAS: Calvin S & ANSI Shadow
#Configurações de Layout
$host.UI.RawUI.WindowTitle = "CONSOLE POWERSHELL V.1.0"
$host.UI.RawUI.BufferSize = @{width=150; height=3000}
$host.UI.RawUI.WindowSize = @{width=150; height=45}
$host.UI.RawUI.ForegroundColor = "white"

#Funções
function Carregamento1 {
    param (
        [string]$Activity = "Processando...",
        [string]$Status = "Aguarde...",
        [int]$TotalSteps = 50,
        [int]$SleepTime = 50 # milissegundos
    )

    for ($i = 1; $i -le $TotalSteps; $i++) {
        $percentComplete = [int](($i / $TotalSteps) * 100)

        # barra de progresso
        Write-Progress -Activity $Activity -Status "$Status - $percentComplete%" -PercentComplete $percentComplete

        Start-Sleep -Milliseconds $SleepTime
    }

    # Limpa a barra de progresso no final
    Write-Progress -Activity $Activity -Completed
}
function Show-Menu {
Write-Host @" 



                                             ██████╗ ██████╗ ███╗   ██╗███████╗ ██████╗ ██╗     ███████╗                   
                                            ██╔════╝██╔═══██╗████╗  ██║██╔════╝██╔═══██╗██║     ██╔════╝                   
                                            ██║     ██║   ██║██╔██╗ ██║███████╗██║   ██║██║     █████╗                     
                                            ██║     ██║   ██║██║╚██╗██║╚════██║██║   ██║██║     ██╔══╝                     
                                            ╚██████╗╚██████╔╝██║ ╚████║███████║╚██████╔╝███████╗███████╗                   
                                             ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝                   
                                                                                       
                                ██████╗  ██████╗ ██╗    ██╗███████╗██████╗     ███████╗██╗  ██╗███████╗██╗     ██╗     
                                ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗    ██╔════╝██║  ██║██╔════╝██║     ██║     
                                ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝    ███████╗███████║█████╗  ██║     ██║     
                                ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗    ╚════██║██╔══██║██╔══╝  ██║     ██║     
                                ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║    ███████║██║  ██║███████╗███████╗███████╗
                                ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝    ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
                                                                                       
                                                            ██╗   ██╗  ██╗    ██████╗                                                              
                                                            ██║   ██║ ███║   ██╔═████╗                                                             
                                                            ██║   ██║ ╚██║   ██║██╔██║                                                             
                                                            ╚██╗ ██╔╝  ██║   ████╔╝██║                                                             
                                                             ╚████╔╝██╗██║██╗╚██████╔╝                                                             
                                                              ╚═══╝ ╚═╝╚═╝╚═╝ ╚═════╝                                                              
                                                                                       
                  

                                                            ┬   ┬ ┬┌─┐┬ ┬┌─┐┬─┐┌─┐         
                                                            │   │ │└─┐│ │├┤ ├┬┘└─┐         
                                                            ┴   └─┘└─┘└─┘└─┘┴└─└─┘       
                                                              
                                                            ┬┬  ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌┬┐┌─┐┬─┐┌─┐
                                                            ││  │  │ ││││├─┘│ │ │ ├┤ ├┬┘└─┐
                                                            ┴┴  └─┘└─┘┴ ┴┴  └─┘ ┴ └─┘┴└─└─┘
                                                                

"@ -ForegroundColor Yellow
    Write-Host ""
    Write-Host "   SELECIONE UMA DAS OPCOES ACIMA E PRESSIONE ENTER" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "" -NoNewline
}
function users {
    do {
        
        Clear-Host
        Write-Host @"



                                                    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗          
                                                    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝          
                                                    ███████╗██║     ██████╔╝██║██████╔╝   ██║             
                                                    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║             
                                                    ███████║╚██████╗██║  ██║██║██║        ██║             
                                                    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝             
                                                              
                                            ██╗   ██╗███████╗██╗   ██╗ █████╗ ██████╗ ██╗ ██████╗ ███████╗
                                            ██║   ██║██╔════╝██║   ██║██╔══██╗██╔══██╗██║██╔═══██╗██╔════╝
                                            ██║   ██║███████╗██║   ██║███████║██████╔╝██║██║   ██║███████╗
                                            ██║   ██║╚════██║██║   ██║██╔══██║██╔══██╗██║██║   ██║╚════██║
                                            ╚██████╔╝███████║╚██████╔╝██║  ██║██║  ██║██║╚██████╔╝███████║
                                             ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚══════╝
                                                              



        ┌─  ┬  ─┐    ┌┬┐┌─┐┬  ┬┌─┐┬─┐  ┬ ┬┌─┐┌─┐┬─┐                ┌─  ┬  ┬  ─┐  ┌─┐┌┬┐┬┌─┐┬┌─┐┌┐┌┌─┐┬─┐  ┌─┐┌─┐  ┌─┐  ┬ ┬┌┬┐  ┬ ┬┌─┐┌─┐┬─┐    
        │   │   │    ││││ │└┐┌┘├┤ ├┬┘  │ │└─┐├┤ ├┬┘                │   └┐┌┘   │  ├─┤ ││││  ││ ││││├─┤├┬┘  └─┐│ ┬  ├─┤  │ ││││  │ │└─┐├┤ ├┬┘    
        └─  ┴  ─┘    ┴ ┴└─┘ └┘ └─┘┴└─  └─┘└─┘└─┘┴└─                └─   └┘   ─┘  ┴ ┴─┴┘┴└─┘┴└─┘┘└┘┴ ┴┴└─  └─┘└─┘  ┴ ┴  └─┘┴ ┴  └─┘└─┘└─┘┴└─    
        ┌─  ┬┬  ─┐  ┌─┐┌┬┐┬┌─┐┬┌─┐┌┐┌┌─┐┬─┐  ┌─┐   ┌┬┐┌─┐┬┬      ┌─  ┬  ┬┬  ─┐  ┌─┐┌┬┐┬┌─┐┬┌─┐┌┐┌┌─┐┬─┐  ┌─┐┌─┐  ┌┬┐┬ ┬┬  ┌┬┐┬  ┬ ┬┌─┐┌─┐┬─┐┌─┐
        │   ││   │  ├─┤ ││││  ││ ││││├─┤├┬┘  ├┤ ───│││├─┤││      │   └┐┌┘│   │  ├─┤ ││││  ││ ││││├─┤├┬┘  └─┐│ ┬  ││││ ││   │ │  │ │└─┐├┤ ├┬┘└─┐
        └─  ┴┴  ─┘  ┴ ┴─┴┘┴└─┘┴└─┘┘└┘┴ ┴┴└─  └─┘   ┴ ┴┴ ┴┴┴─┘    └─   └┘ ┴  ─┘  ┴ ┴─┴┘┴└─┘┴└─┘┘└┘┴ ┴┴└─  └─┘└─┘  ┴ ┴└─┘┴─┘ ┴ ┴  └─┘└─┘└─┘┴└─└─┘
        ┌─  ┬┬┬  ─┐  ┬─┐┌─┐┌┬┐┌─┐┬  ┬┌─┐┬─┐  ┌─┐   ┌┬┐┌─┐┬┬        ┌─  ┬  ┬┬┬  ─┐  ┬  ┬┌─┐┌┬┐┌─┐┬─┐  ┬ ┬┌─┐┌─┐┬─┐┌─┐  ┌┬┐┌─┐  ┬ ┬┌┬┐┌─┐  ┌─┐┬ ┬
        │   │││   │  ├┬┘├┤ ││││ │└┐┌┘├┤ ├┬┘  ├┤ ───│││├─┤││        │   └┐┌┘││   │  │  │└─┐ │ ├─┤├┬┘  │ │└─┐├┤ ├┬┘└─┐   ││├┤   │ ││││├─┤  │ ││ │
        └─  ┴┴┴  ─┘  ┴└─└─┘┴ ┴└─┘ └┘ └─┘┴└─  └─┘   ┴ ┴┴ ┴┴┴─┘      └─   └┘ ┴┴  ─┘  ┴─┘┴└─┘ ┴ ┴ ┴┴└─  └─┘└─┘└─┘┴└─└─┘  ─┴┘└─┘  └─┘┴ ┴┴ ┴  └─┘└─┘
        ┌─  ┬┬  ┬  ─┐  ┬ ┬┌─┐┌┐ ┬┬  ┬┌┬┐┌─┐┬─┐  ┬ ┬┌─┐┌─┐┬─┐        ┌─  ┬  ┬┬┬┬  ─┐  ┬  ┬┌─┐┌┬┐┌─┐┬─┐  ┬ ┬┌─┐┌─┐┬─┐┌─┐  ┌─┐┌─┐┌┬┐  ┌─┐┌─┐      
        │   │└┐┌┘   │  ├─┤├─┤├┴┐││  │ │ ├─┤├┬┘  │ │└─┐├┤ ├┬┘        │   └┐┌┘│││   │  │  │└─┐ │ ├─┤├┬┘  │ │└─┐├┤ ├┬┘└─┐  └─┐├┤ │││  └─┐│ ┬      
        └─  ┴ └┘   ─┘  ┴ ┴┴ ┴└─┘┴┴─┘┴ ┴ ┴ ┴┴└─  └─┘└─┘└─┘┴└─        └─   └┘ ┴┴┴  ─┘  ┴─┘┴└─┘ ┴ ┴ ┴┴└─  └─┘└─┘└─┘┴└─└─┘  └─┘└─┘┴ ┴  └─┘└─┘      
                                                                                                                                       
                                                                                                                                       
                                                                                                                                       
                        ┌─  ┬─┐ ┬  ─┐  ┬ ┬┌─┐┌┐ ┬┬  ┬┌┬┐┌─┐┌┬┐┌─┐┌─┐  ┌─┐  ┌┬┐┌─┐┌─┐┌─┐┌┐ ┬┬  ┬┌┬┐┌─┐┌┬┐┌─┐┌─┐                                 
                        │   │┌┴┬┘   │  ├─┤├─┤├┴┐││  │ │ ├─┤ │││ │└─┐  ├┤    ││├┤ └─┐├─┤├┴┐││  │ │ ├─┤ │││ │└─┐                                 
                        └─  ┴┴ └─  ─┘  ┴ ┴┴ ┴└─┘┴┴─┘┴ ┴ ┴ ┴─┴┘└─┘└─┘  └─┘  ─┴┘└─┘└─┘┴ ┴└─┘┴┴─┘┴ ┴ ┴ ┴─┴┘└─┘└─┘                                 


"@ -ForegroundColor Red
$choice = Read-Host "....INSIRA A OPCAO:"

        switch ($choice) {
            1 {
                # Coloque aqui a lógica para listar 
                Write-Host "Executando: Listar usuários ativos..." -ForegroundColor Green
                Start-Process powershell -ArgumentList "-NoExit", "-File", (Join-Path $PSScriptRoot "Enable-User.ps1")
                Start-Sleep -Seconds 2
            }
            2 {
                # Coloque aqui a lógica para criar um novo usuário
                Write-Host "Executando: Criar novo usuário..." -ForegroundColor Green
                Start-Sleep -Seconds 2
            }
            3 {
                # Coloque aqui a lógica para excluir um usuário
                Write-Host "Executando: Excluir usuário..." -ForegroundColor Green
                Start-Sleep -Seconds 2
            }
            0 {
                return  # O comando 'return' sai desta função e volta para o loop principal
            }
            default {
                Write-Host "Opção inválida. Tente novamente." -ForegroundColor Red
                Start-Sleep -Seconds 2
            }
        }

        Write-Host ""
        Write-Host "Pressione qualquer tecla para continuar..."
        $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    } while ($true)
}
function Invoke-Task {
    param(
        [int]$Selection
    )
    
    switch ($Selection) {
        1 {
            users
            Start-Sleep -Seconds 1
            Write-Host ""
     
        }
        2 {
            computers
            Start-Sleep -Seconds 1
            Write-Host ""
        }
        0 {
            Write-Host "Saindo..."
            Start-Sleep -Seconds 3
            exit
        }
        default {
            Write-Host "Opção inválida. Tente novamente." -ForegroundColor Red
            Start-Sleep -Seconds 3
        }
    }
}
function computers {
    do {
        
        Clear-Host
        Write-Host @"



                                                    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗                  
                                                    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝                  
                                                    ███████╗██║     ██████╔╝██║██████╔╝   ██║                     
                                                    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║                     
                                                    ███████║╚██████╗██║  ██║██║██║        ██║                     
                                                    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝                     
                                                                              
                                     ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗   ██╗████████╗███████╗██████╗ ███████╗
                                    ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║   ██║╚══██╔══╝██╔════╝██╔══██╗██╔════╝
                                    ██║     ██║   ██║██╔████╔██║██████╔╝██║   ██║   ██║   █████╗  ██████╔╝███████╗
                                    ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║   ██║   ██║   ██╔══╝  ██╔══██╗╚════██║
                                    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ╚██████╔╝   ██║   ███████╗██║  ██║███████║
                                     ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝      ╚═════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝╚══════╝
                                                                              


┌─  ┬  ─┐    ┌┬┐┌─┐┌─┐┌─┐┌┐ ┬┬  ┬┌┬┐┌─┐┌┬┐┌─┐┌─┐  ┌─┐┌─┐┬─┐  ┌─┐┬ ┬              ┌─  ┬  ┬  ─┐  ┌┬┐┌─┐┬  ┬┌─┐┬─┐  ┌┬┐┌─┐┌─┐┬ ┬┬┌┐┌┌─┐  ┌┬┐┬ ┬┬  ┌┬┐┬
│   │   │     ││├┤ └─┐├─┤├┴┐││  │ │ ├─┤ ││├─┤└─┐  ├─┘│ │├┬┘  │ ││ │              │   └┐┌┘   │  ││││ │└┐┌┘├┤ ├┬┘  │││├─┤│  ├─┤││││├┤   ││││ ││   │ │
└─  ┴  ─┘    ─┴┘└─┘└─┘┴ ┴└─┘┴┴─┘┴ ┴ ┴ ┴─┴┘┴ ┴└─┘  ┴  └─┘┴└─  └─┘└─┘              └─   └┘   ─┘  ┴ ┴└─┘ └┘ └─┘┴└─  ┴ ┴┴ ┴└─┘┴ ┴┴┘└┘└─┘  ┴ ┴└─┘┴─┘ ┴ ┴
┌─  ┬┬  ─┐  ┬ ┬┌─┐┌┐ ┬┬  ┬┌┬┐┌─┐┬─┐  ┌┬┐┌─┐┌─┐┬ ┬┬┌┐┌┌─┐                          ┌─  ┬  ┬┬  ─┐  ┬  ┌─┐┌─┐┌┬┐   ┬┌─┐┬┌┐┌┌─┐┌┬┐  ┬┌┐┌  ┌─┐┬ ┬       
│   ││   │  ├─┤├─┤├┴┐││  │ │ ├─┤├┬┘  │││├─┤│  ├─┤││││├┤                           │   └┐┌┘│   │  │  ├─┤└─┐ │    ││ │││││├┤  ││  ││││  │ ││ │       
└─  ┴┴  ─┘  ┴ ┴┴ ┴└─┘┴┴─┘┴ ┴ ┴ ┴┴└─  ┴ ┴┴ ┴└─┘┴ ┴┴┘└┘└─┘                          └─   └┘ ┴  ─┘  ┴─┘┴ ┴└─┘ ┴   └┘└─┘┴┘└┘└─┘─┴┘  ┴┘└┘  └─┘└─┘       
┌─  ┬┬┬  ─┐  ┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐  ┬ ┬┌─┐┬─┐┬┌─┌─┐┌┬┐┌─┐┌┐┌┌┬┐┬┌─┐┌┐┌                ┌─  ┬┬  ┬  ─┐  ┌┬┐┌─┐┬  ┬┌─┐┬─┐  ┌┬┐┌─┐┌─┐┬ ┬┬┌┐┌┌─┐            
│   │││   │   ││├┤ │  ├┤  │ ├┤   ││││ │├┬┘├┴┐└─┐ │ ├─┤│││ │ ││ ││││                │   │└┐┌┘   │  ││││ │└┐┌┘├┤ ├┬┘  │││├─┤│  ├─┤││││├┤             
└─  ┴┴┴  ─┘  ─┴┘└─┘┴─┘└─┘ ┴ └─┘  └┴┘└─┘┴└─┴ ┴└─┘ ┴ ┴ ┴┘└┘ ┴ ┴└─┘┘└┘                └─  ┴ └┘   ─┘  ┴ ┴└─┘ └┘ └─┘┴└─  ┴ ┴┴ ┴└─┘┴ ┴┴┘└┘└─┘            
                                                                                                                                                   
                                                                                                                                                   
                                                                                                                                                   
                            ┌─  ┬  ┬┬┬  ─┐  ┬ ┬┬ ┬┌─┐┬─┐┌─┐  ┬┌─┐  ┌┬┐┬ ┬┌─┐  ┌─┐┌─┐┌┬┐┌─┐┬ ┬┌┬┐┌─┐┬─┐┌─┐                                          
                            │   └┐┌┘││   │  │││├─┤├┤ ├┬┘├┤   │└─┐   │ ├─┤├┤   │  │ ││││├─┘│ │ │ ├┤ ├┬┘ ┌┘                                          
                            └─   └┘ ┴┴  ─┘  └┴┘┴ ┴└─┘┴└─└─┘  ┴└─┘   ┴ ┴ ┴└─┘  └─┘└─┘┴ ┴┴  └─┘ ┴ └─┘┴└─ o                                           

"@ -ForegroundColor Green
$choice = Read-Host "....INSIRA A OPCAO:"

        switch ($choice) {
            1 {
                # Coloque aqui a lógica para listar usuários
                Write-Host "Executando: Listar usuários ativos..." -ForegroundColor Green
                Start-Sleep -Seconds 2
            }
            2 {
                # Coloque aqui a lógica para criar um novo usuário
                Write-Host "Executando: Criar novo usuário..." -ForegroundColor Green
                Start-Sleep -Seconds 2
            }
            3 {
                # Coloque aqui a lógica para excluir um usuário
                Write-Host "Executando: Excluir usuário..." -ForegroundColor Green
                Start-Sleep -Seconds 2
            }
            0 {
                return  # O comando 'return' sai desta função e volta para o loop principal
            }
            default {
                Write-Host "Opção inválida. Tente novamente." -ForegroundColor Red
                Start-Sleep -Seconds 2
            }
        }

        Write-Host ""
        Write-Host "Pressione qualquer tecla para continuar..."
        $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    } while ($true)
}
function Invoke-Task {
    param(
        [int]$Selection
    )
    
    switch ($Selection) {
        1 {
            users
            Start-Sleep -Seconds 1
            Write-Host ""
     
        }
        2 {
            computers
            Start-Sleep -Seconds 1
            Write-Host ""
        }
        0 {
            Write-Host "Saindo..."
            Start-Sleep -Seconds 3
            exit
        }
        default {
            Write-Host "Opção inválida. Tente novamente." -ForegroundColor Red
            Start-Sleep -Seconds 3
        }
    }
}

Carregamento1 -Activity "Abrindo CONSOLE POWERSHELL!" -Status "Por favor, aguarde"

# Loop principal do menu
do {
    Show-Menu
    $choice = Read-Host "....INSIRA A OPCAO:"

    if ($choice -notlike '') {
        Invoke-Task -Selection ([int]$choice)
    }

    Write-Host ""
    Write-Host "Pressione qualquer tecla para continuar..."
    $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Clear-Host


} while ($true)
