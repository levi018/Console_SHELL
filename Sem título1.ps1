﻿# Define o tamanho do buffer (deve ser igual ou maior que a janela)
$host.UI.RawUI.BufferSize = @{width=134; height=3000}

# Define o tamanho da janela
$host.UI.RawUI.WindowSize = @{width=134; height=45}

Write-Host "Pressione Enter para continuar..."
[System.Console]::Read()