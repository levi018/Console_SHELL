Import-Module ActiveDirectory

## muda logica de 20-08-2025

$dcs = @(
    "Azure-dc01.grupoaec.com.br",
    "NUB3.grupoaec.com.br",
    "PALESTRA3.grupoaec.com.br",
    "nub2.grupoaec.com.br",
    "PALESTRA2.grupoaec.com.br",
    "PERILO2.grupoaec.com.br",
    "MINOTAURO2.grupoaec.com.br",
    "ZEFIRO2.grupoaec.com.br",
    "ELO2.grupoaec.com.br",
    "GAVIAO2.grupoaec.com.br",
    "ONDINA2.grupoaec.com.br",
    "JANEIRO2.grupoaec.com.br",
    "STIX2.grupoaec.com.br",
    "FLORA2.grupoaec.com.br",
    "DESTINO2.grupoaec.com.br",
    "TITAS2.grupoaec.com.br",
    "Emily.grupoaec.com.br",
    "aurora.grupoaec.com.br",
    "FREYA.grupoaec.com.br",
    "janeiro3.grupoaec.com.br",
    "flora3.grupoaec.com.br",
    "Azure-dc02.grupoaec.com.br",
    "arion3.grupoaec.com.br",
    "emily2.grupoaec.com.br",
    "ARGES.grupoaec.com.br",
    "GIAS.grupoaec.com.br",
    "ELO3.grupoaec.com.br",
    "TITAS3.grupoaec.com.br",
    "ondina4.grupoaec.com.br",
    "Ondina5.grupoaec.com.br",
    "Zefiro4.grupoaec.com.br",
    "Zefiro5.grupoaec.com.br",
    "gaviao3.grupoaec.com.br"
)
$menu = @" 


                 █████╗ ██████╗ ██╗ ██████╗██╗ ██████╗ ███╗   ██╗ █████╗ ██████╗     ███████╗ ██████╗ 
                ██╔══██╗██╔══██╗██║██╔════╝██║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗    ██╔════╝██╔════╝ 
                ███████║██║  ██║██║██║     ██║██║   ██║██╔██╗ ██║███████║██████╔╝    ███████╗██║  ███╗
                ██╔══██║██║  ██║██║██║     ██║██║   ██║██║╚██╗██║██╔══██║██╔══██╗    ╚════██║██║   ██║
                ██║  ██║██████╔╝██║╚██████╗██║╚██████╔╝██║ ╚████║██║  ██║██║  ██║    ███████║╚██████╔╝
                ╚═╝  ╚═╝╚═════╝ ╚═╝ ╚═════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝ 
                                                                                                                         
                                                                                                             
"@

$opcoes = @"

[1] Adicionar SG a 1 usuário                [3] Adicionar uma lista de SG's a um usuário
[2] Adicionar SG a uma lista de usuários    [4] Adicionar uma lista de SG's a uma lista de usuário

[0] SAIR

"@

Write-Host $menu -ForegroundColor Yellow
Write-Host $opcoes -ForegroundColor Yellow

$escolha = ""
$validaEscolha = $false

# Loop para garantir que o usuário digite uma opção válida
do {
    Write-Host "Digite a opção desejada: " -NoNewline
    $escolha = Read-Host
    if (($escolha -eq "1") -or ($escolha -eq "2") -or ($escolha -eq "3") -or ($escolha -eq "4") -or ($escolha -eq "0")) {
        $validaEscolha = $true
    } else {
        Write-Host "❌ Opção inválida. Por favor, digite 1, 2, 3, 4 ou 0 para sair." -ForegroundColor Red
        Start-Sleep 2
        Clear-Host
        Write-Host $menu -ForegroundColor Yellow
        Write-Host $opcoes -ForegroundColor Yellow

    }
} until ($validaEscolha -eq $true)

# Se o usuário escolher 0, o script é encerrado
if ($escolha -eq "0") {
    Write-Host "👋 Encerrando o script. Até a próxima!" -ForegroundColor Yellow
    Start-Sleep 4
    exit
}

$usuarios = @() # Array para armazenar os usuários
$usuariosValidos = @() # Array para armazenar os usuários válidos
$grupos = @() # Array para armazenar os grupos
$gruposValidos = @() # Array para armazenar os grupos válidos

if ($escolha -eq "1") {
    # Opção 1: Adicionar 1 usuário a 1 grupo
    $usuarioValido = $false
    do {
        $usuario = Read-Host "Digite o usuário"
        Write-Host "`n🔍 Validando o usuário '$usuario'..." -ForegroundColor Yellow
        Start-Sleep 2
        try {
            Get-ADUser -Identity $usuario -ErrorAction Stop | Out-Null
            $usuariosValidos += $usuario
            Write-Host "✅ Usuário '$usuario' encontrado." -ForegroundColor Green
            $usuarioValido = $true
            Write-Host ""
        } catch {
            Write-Host "❌ Usuário '$usuario' não encontrado. Por favor, tente novamente." -ForegroundColor Red
            Write-Host""
        }
    } while ($usuarioValido -eq $false)

    # Loop para garantir que o usuário digite um nome de grupo válido
    $sgValida = $false
    do {
        $grupo = Read-Host "Digite o nome da Security Group (SG)"
        Write-Host "`n🔍 Validando o grupo '$grupo'..." -ForegroundColor Yellow
        Start-Sleep 2
        try {
            Get-ADGroup -Identity $grupo -ErrorAction Stop | Out-Null
            $gruposValidos += $grupo
            Write-Host "✅ Grupo '$grupo' encontrado." -ForegroundColor Green
            $sgValida = $true
            Start-Sleep 2
            Write-Host "✅ Adicionando SG, aguarde..." -ForegroundColor Green
            Start-Sleep 2
        } catch {
            Write-Host "❌ O grupo '$grupo' não foi encontrado. Por favor, verifique o nome e tente novamente." -ForegroundColor Red
            Write-Host ""
        }
    } while ($sgValida -eq $false)

} elseif ($escolha -eq "2") {
    # Opção 2: Adicionar uma lista de usuários a 1 grupo
    $listaUsuariosValida = $false
    do {
        $caminhoValido = $false
        do {
            $caminhoArquivo = Read-Host "Digite o caminho completo para o arquivo .txt com os usuários (ex: C:\temp\usuarios.txt)"
            Write-Host ""
            Write-Host "🔍 Validando caminho ..." -ForegroundColor Yellow
            Start-Sleep 2
            if (Test-Path $caminhoArquivo) {
                $caminhoValido = $true
            } else {
                Write-Host "❌ O arquivo não foi encontrado. Por favor, verifique o caminho e tente novamente." -ForegroundColor Red
            }
        } while ($caminhoValido -eq $false)

        $usuarios = Get-Content $caminhoArquivo | Where-Object { $_ -ne '' }
        $usuariosValidos = @() # Limpa a lista para a nova validação
        Write-Host "`n🔍 Validando a lista de usuários..." -ForegroundColor Yellow
        Start-Sleep 2
        foreach ($usuario in $usuarios) {
            try {
                Get-ADUser -Identity $usuario -ErrorAction Stop | Out-Null
                $usuariosValidos += $usuario
                Write-Host "✅ Usuário '$usuario' encontrado." -ForegroundColor Green
            } catch {
                Write-Host "❌ Usuário '$usuario' não encontrado. Ele será ignorado." -ForegroundColor Red
            }
        }

        # Verifica se a lista de usuários válidos não está vazia
        if ($usuariosValidos.Count -gt 0) {
            $listaUsuariosValida = $true
        } else {
            Write-Host "`n⛔ Nenhum usuário válido foi encontrado na lista. Por favor, insira um arquivo com usuários válidos." -ForegroundColor Red
            Write-Host ""
            Start-Sleep 2
        }
    } while ($listaUsuariosValida -eq $false)


    $sgValida = $false
    do {
        Write-Host ""
        $grupo = Read-Host "Digite o nome da Security Group (SG)"
        Write-Host "`n🔍 Validando o grupo '$grupo'..." -ForegroundColor Yellow
        start-sleep 2
        try {
            Get-ADGroup -Identity $grupo -ErrorAction Stop | Out-Null
            $gruposValidos += $grupo
            Write-Host "✅ Grupo '$grupo' encontrado." -ForegroundColor Green
            Start-Sleep 2
            Write-Host "✅ Acionando SG, aguarde ..."
            Start-Sleep 2
            $sgValida = $true
        } catch {
            Write-Host "❌ O grupo '$grupo' não foi encontrado. Por favor, verifique o nome e tente novamente." -ForegroundColor Red
        }
    } while ($sgValida -eq $false)

} elseif ($escolha -eq "3") {
    # Opção 3: Adicionar 1 usuário a uma lista de grupos
    $usuarioValido = $false
    do {
        $usuario = Read-Host "Digite o SamAccountName do usuário"
        Write-Host "`n🔍 Validando o usuário '$usuario'..." -ForegroundColor Yellow
        Start-Sleep 2
        try {
            Get-ADUser -Identity $usuario -ErrorAction Stop | Out-Null
            $usuariosValidos += $usuario
            Write-Host "✅ Usuário '$usuario' encontrado." -ForegroundColor Green
            Write-Host ""
            $usuarioValido = $true
        } catch {
            Write-Host "❌ Usuário '$usuario' não encontrado. Por favor, tente novamente." -ForegroundColor Red
        }
    } while ($usuarioValido -eq $false)
    
    $listaGruposValida = $false
    do {
        $caminhoValido = $false
        do {
            $caminhoArquivo = Read-Host "Digite o caminho completo para o arquivo .txt com os grupos (ex: C:\temp\grupos.txt)"
            if (Test-Path $caminhoArquivo) {
                $caminhoValido = $true
            } else {
                Write-Host "❌ O arquivo não foi encontrado. Por favor, verifique o caminho e tente novamente." -ForegroundColor Red
                Write-Host ""
            }
        } while ($caminhoValido -eq $false)

        $grupos = Get-Content $caminhoArquivo | Where-Object { $_ -ne '' }
        $gruposValidos = @() # Limpa a lista para a nova validação
        Write-Host "`n🔍 Validando a lista de grupos..." -ForegroundColor Yellow
        Start-Sleep 2
        foreach ($grupo in $grupos) {
            try {
                Get-ADGroup -Identity $grupo -ErrorAction Stop | Out-Null
                $gruposValidos += $grupo
                Write-Host "✅ Grupo '$grupo' encontrado." -ForegroundColor Green
            } catch {
                Write-Host "❌ Grupo '$grupo' não encontrado. Ele será ignorado." -ForegroundColor Red
            }
        }
        
        # Verifica se a lista de grupos válidos não está vazia
        if ($gruposValidos.Count -gt 0) {
            $listaGruposValida = $true
        } else {
            Write-Host "`n⛔ Nenhum grupo válido foi encontrado na lista. Por favor, insira um arquivo com grupos válidos." -ForegroundColor Red
        }
    } while ($listaGruposValida -eq $false)
    
} elseif ($escolha -eq "4") {
    # Opção 4: Adicionar uma lista de usuários a uma lista de grupos
    $listaUsuariosValida = $false
    do {
        $caminhoValido = $false
        do {
            Write-Host ""
            $caminhoArquivo = Read-Host "Digite o caminho completo para o arquivo .txt com os usuários (ex: C:\temp\usuarios.txt)"
            Write-Host ""
            Write-Host "`n🔍 Validando a caminho..." -ForegroundColor Yellow
            Start-Sleep 2
            if (Test-Path $caminhoArquivo) {
                $caminhoValido = $true
            } else {
                Write-Host "❌ O arquivo não foi encontrado. Por favor, verifique o caminho e tente novamente." -ForegroundColor Red
            }
        } while ($caminhoValido -eq $false)

        $usuarios = Get-Content $caminhoArquivo | Where-Object { $_ -ne '' }
        $usuariosValidos = @()
        Write-Host "`n🔍 Validando a lista de usuários..." -ForegroundColor Yellow
        foreach ($usuario in $usuarios) {
            try {
                Get-ADUser -Identity $usuario -ErrorAction Stop | Out-Null
                $usuariosValidos += $usuario
                Write-Host "✅ Usuário '$usuario' encontrado." -ForegroundColor Green
            } catch {
                Write-Host "❌ Usuário '$usuario' não encontrado. Ele será ignorado." -ForegroundColor Red
            }
        }
        
        # Se a lista de usuários válidos estiver vazia, repete o loop
        if ($usuariosValidos.Count -gt 0) {
            $listaUsuariosValida = $true
        } else {
            Write-Host "`n⛔ Nenhum usuário válido foi encontrado na lista. Por favor, insira um arquivo com usuários válidos." -ForegroundColor Red
        }
    } while ($listaUsuariosValida -eq $false)

    $listaGruposValida = $false
    do {
        $caminhoValido = $false
        do {
            $caminhoArquivo = Read-Host "Digite o caminho completo para o arquivo .txt com os grupos (ex: C:\temp\grupos.txt)"
            if (Test-Path $caminhoArquivo) {
                $caminhoValido = $true
            } else {
                Write-Host "❌ O arquivo não foi encontrado. Por favor, verifique o caminho e tente novamente." -ForegroundColor Red
            }
        } while ($caminhoValido -eq $false)
    
        $grupos = Get-Content $caminhoArquivo | Where-Object { $_ -ne '' }
        $gruposValidos = @()
        Write-Host "`n🔍 Validando a lista de grupos..." -ForegroundColor Yellow
        foreach ($grupo in $grupos) {
            try {
                Get-ADGroup -Identity $grupo -ErrorAction Stop | Out-Null
                $gruposValidos += $grupo
                Write-Host "✅ Grupo '$grupo' encontrado." -ForegroundColor Green
            } catch {
                Write-Host "❌ Grupo '$grupo' não encontrado. Ele será ignorado." -ForegroundColor Red
            }
        }

        # Se a lista de grupos válidos estiver vazia, repete o loop
        if ($gruposValidos.Count -gt 0) {
            $listaGruposValida = $true
        } else {
            Write-Host "`n⛔ Nenhum grupo válido foi encontrado na lista. Por favor, insira um arquivo com grupos válidos." -ForegroundColor Red
        }
    } while ($listaGruposValida -eq $false)
    
} else {
    Write-Host "❌ Opção inválida. Por favor, reinicie o script." -ForegroundColor Red
    exit
}

# Se a lista de grupos válidos estiver vazia, encerra o script
if ($gruposValidos.Count -eq 0) {
    Write-Host "`n⛔ Nenhum grupo válido foi encontrado. O script será encerrado." -ForegroundColor Red
    exit
}

# Loop principal para adicionar os usuários aos grupos em cada DC
foreach ($dc in $dcs) {
    Write-Host "`n---"
    Write-Host "🔄 Conectando ao DC: $($dc)" -ForegroundColor Cyan
    foreach ($usuario in $usuariosValidos) {
        foreach ($grupo in $gruposValidos) {
            try {
                # Adiciona o usuário ao grupo usando o DC específico
                Add-ADGroupMember -Server $dc -Identity $grupo -Members $usuario -ErrorAction Stop
                Write-Host "✅ Usuário '$usuario' adicionado ao grupo '$grupo' no DC $($dc)" -ForegroundColor Green
            } catch {
                Write-Host "❌ Erro ao adicionar '$usuario' no grupo '$grupo' no DC $($dc): $_" -ForegroundColor Red
            }
        }
    }
}

Write-Host "`n🎉 Processo concluído!" -ForegroundColor Yellow
