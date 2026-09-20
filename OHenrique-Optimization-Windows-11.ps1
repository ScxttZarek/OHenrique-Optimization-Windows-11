# SPDX-License-Identifier: MIT
# Copyright (c) 2026 OHenrique
# OHenrique Optimization - Windows 11
# Version: 1.0.0

& {

# ============================================================
# OHenrique Optimization
# Windows 11 Universal Edition
# Notebooks & Desktops
# ============================================================

$ErrorActionPreference = "Continue"
$Host.UI.RawUI.WindowTitle = "OHenrique Optimization | Windows 11 Universal"

function Banner {
    Clear-Host
    Write-Host ""
    Write-Host " =====================================================================" -ForegroundColor DarkMagenta
    Write-Host ""
    Write-Host "          O H E N R I Q U E   O P T I M I Z A T I O N" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "                 WINDOWS 11 | UNIVERSAL EDITION" -ForegroundColor White
    Write-Host "                    NOTEBOOKS & DESKTOPS" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host " =====================================================================" -ForegroundColor DarkMagenta
    Write-Host ""
}

function Info($Texto) {
    Write-Host " [INFO] " -ForegroundColor Cyan -NoNewline
    Write-Host $Texto -ForegroundColor White
}
function OK($Texto) {
    Write-Host " [ OK ] " -ForegroundColor Green -NoNewline
    Write-Host $Texto -ForegroundColor White
}
function Warn($Texto) {
    Write-Host " [ !! ] " -ForegroundColor Yellow -NoNewline
    Write-Host $Texto -ForegroundColor White
}
function Fail($Texto) {
    Write-Host " [ERRO] " -ForegroundColor Red -NoNewline
    Write-Host $Texto -ForegroundColor White
}
function Separator {
    Write-Host ""
    Write-Host " ---------------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host ""
}

Banner

$Admin = (
    New-Object Security.Principal.WindowsPrincipal(
        [Security.Principal.WindowsIdentity]::GetCurrent()
    )
).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)

if (-not $Admin) {
    Fail "PowerShell nao esta sendo executado como Administrador."
    Write-Host ""
    Write-Host " Abra Terminal/PowerShell como Administrador e execute novamente." -ForegroundColor Yellow
    Read-Host "Pressione ENTER para sair"
    return
}

OK "Permissao de Administrador confirmada."

try {
    $OS = Get-CimInstance Win32_OperatingSystem
    if ($OS.Caption -notlike "*Windows 11*") {
        Warn "Este sistema parece ser: $($OS.Caption)"
        Warn "Esta edicao foi preparada especificamente para Windows 11."
        $Continuar = Read-Host "Continuar mesmo assim? [S/N]"
        if ($Continuar -notmatch "^[SsYy]") { return }
    } else {
        OK "Windows 11 detectado."
    }
}
catch {
    Warn "Nao consegui confirmar automaticamente a versao do Windows."
}

$Desktop = [Environment]::GetFolderPath("Desktop")
$Log = Join-Path $Desktop ("OHenrique_Windows11_" + (Get-Date -Format "yyyy-MM-dd_HH-mm-ss") + ".log")

try { Start-Transcript -Path $Log -Force | Out-Null; OK "Log iniciado." }
catch { Warn "Nao foi possivel iniciar o log." }

Separator
Write-Host " INFORMACOES DO COMPUTADOR" -ForegroundColor Magenta
Write-Host ""

try {
    $PC  = Get-CimInstance Win32_ComputerSystem
    $CPU = Get-CimInstance Win32_Processor | Select-Object -First 1
    $GPU = Get-CimInstance Win32_VideoController
    $RAM = [math]::Round($PC.TotalPhysicalMemory / 1GB, 1)

    Info "Sistema : $($OS.Caption)"
    Info "Versao  : $($OS.Version)"
    Info "Build   : $($OS.BuildNumber)"
    Info "CPU     : $($CPU.Name)"
    Info "RAM     : $RAM GB"
    foreach ($G in $GPU) { Info "GPU     : $($G.Name)" }

    try {
        $PhysicalDisks = Get-PhysicalDisk -ErrorAction Stop
        foreach ($Disk in $PhysicalDisks) {
            $Size = [math]::Round($Disk.Size / 1GB)
            Info "Disco   : $($Disk.FriendlyName) | $($Disk.MediaType) | $Size GB"
        }
    } catch {
        foreach ($Disk in (Get-CimInstance Win32_DiskDrive)) {
            $Size = [math]::Round($Disk.Size / 1GB)
            Info "Disco   : $($Disk.Model) | $Size GB"
        }
    }
} catch {
    Warn "Algumas informacoes de hardware nao puderam ser obtidas."
}

try {
    $SystemDriveName = $env:SystemDrive.TrimEnd(":")
    $FreeBefore = (Get-PSDrive -Name $SystemDriveName).Free
} catch { $FreeBefore = 0 }

Separator
Write-Host " CONFIGURACAO DA OTIMIZACAO" -ForegroundColor Magenta
Write-Host ""

$LimparLixeira = (Read-Host " Limpar a Lixeira? [S/N]") -match "^[SsYy]"
$VisualLeve = (Read-Host " Aplicar modo visual leve? [S/N]") -match "^[SsYy]"
$DesativarDVR = (Read-Host " Desativar gravacao Xbox/Game DVR em segundo plano? [S/N]") -match "^[SsYy]"

Write-Host ""
Write-Host " Perfil de energia:" -ForegroundColor White
Write-Host " [1] Manter atual"
Write-Host " [2] Balanceado"
Write-Host " [3] Alto desempenho"
$EnergyChoice = Read-Host " Escolha [1/2/3]"
if ($EnergyChoice -notmatch "^[123]$") { $EnergyChoice = "1" }

$AtualizarApps = (Read-Host " Atualizar programas usando Winget no final? [S/N]") -match "^[SsYy]"

$Total = 17
$Atual = 0

function Etapa {
    param([string]$Nome,[scriptblock]$Acao)
    $script:Atual++
    $Percent = [math]::Round(($script:Atual / $script:Total) * 100)

    Write-Progress -Activity "OHenrique Optimization | Windows 11" `
        -Status "Etapa $script:Atual de $script:Total - $Nome" `
        -PercentComplete $Percent

    Separator
    Write-Host " [$script:Atual/$script:Total] $Nome" -ForegroundColor Magenta
    Write-Host ""

    try {
        & $Acao
        Write-Host ""
        OK "$Nome concluido."
    } catch {
        Write-Host ""
        Warn "$Nome encontrou um problema."
        Warn $_.Exception.Message
    }
}

Etapa "Criando ponto de restauracao" {
    try {
        Checkpoint-Computer -Description "OHenrique Optimization Windows 11" `
            -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
        OK "Ponto de restauracao criado."
    } catch {
        Warn "Nao foi possivel criar o ponto de restauracao."
        Info "A Protecao do Sistema pode estar desativada ou ja existir um ponto recente."
    }
}

Etapa "Limpando temporarios do usuario" {
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
}

Etapa "Limpando temporarios do Windows" {
    Remove-Item "$env:WINDIR\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
}

Etapa "Executando limpeza nativa do Windows" {
    $CleanMgr = "$env:SystemRoot\System32\cleanmgr.exe"
    if (Test-Path $CleanMgr) {
        Start-Process $CleanMgr -ArgumentList "/VERYLOWDISK" -Wait
    } else {
        Warn "CleanMgr nao encontrado."
    }
}

Etapa "Limpando cache do Delivery Optimization" {
    try {
        Import-Module DeliveryOptimization -ErrorAction SilentlyContinue

        if (Get-Command Delete-DeliveryOptimizationCache -ErrorAction SilentlyContinue) {
            Delete-DeliveryOptimizationCache -Force -ErrorAction Stop
            OK "Cache do Delivery Optimization removido."
        } else {
            Info "Funcao nao disponivel. Etapa ignorada."
        }

        if (Get-Command Set-DODownloadMode -ErrorAction SilentlyContinue) {
            Set-DODownloadMode -DownloadMode CdnOnly -ErrorAction SilentlyContinue
            OK "Delivery Optimization configurado para CdnOnly."
        }
    } catch {
        Warn "Delivery Optimization nao pode ser ajustado."
    }
}

Etapa "Verificando estado da imagem do Windows" { & DISM.exe /Online /Cleanup-Image /CheckHealth }
Etapa "Escaneando componentes do Windows" { & DISM.exe /Online /Cleanup-Image /ScanHealth }
Etapa "Reparando imagem do Windows" { & DISM.exe /Online /Cleanup-Image /RestoreHealth }
Etapa "Limpando componentes antigos do Windows" { & DISM.exe /Online /Cleanup-Image /StartComponentCleanup }
Etapa "Verificando arquivos protegidos do Windows" { & sfc.exe /scannow }
Etapa "Verificando unidade do sistema" { & chkdsk.exe $env:SystemDrive /scan }

Etapa "Otimizando unidades locais" {
    $LocalDisks = Get-CimInstance Win32_LogicalDisk |
        Where-Object { $_.DriveType -eq 3 -and $_.FileSystem }

    foreach ($Disk in $LocalDisks) {
        Info "Otimizando $($Disk.DeviceID)"
        & defrag.exe $Disk.DeviceID /O /U /V
    }
}

Etapa "Limpando cache DNS" { & ipconfig.exe /flushdns }

Etapa "Verificando memoria virtual" {
    $System = Get-CimInstance Win32_ComputerSystem
    Info "AutomaticManagedPagefile = $($System.AutomaticManagedPagefile)"

    if ($System.AutomaticManagedPagefile -ne $true) {
        Warn "Gerenciamento automatico estava FALSE."
        Info "Alterando para TRUE..."
        Set-CimInstance -InputObject $System -Property @{ AutomaticManagedPagefile = $true } | Out-Null
        Start-Sleep -Seconds 1
        $System = Get-CimInstance Win32_ComputerSystem
    }

    if ($System.AutomaticManagedPagefile -eq $true) {
        OK "AutomaticManagedPagefile = TRUE"
    } else {
        Warn "Nao foi possivel ativar o gerenciamento automatico."
    }
}

Etapa "Verificando Game Mode" {
    $GameBar = "HKCU:\Software\Microsoft\GameBar"
    if (-not (Test-Path $GameBar)) { New-Item $GameBar -Force | Out-Null }

    $Current = (Get-ItemProperty $GameBar -Name AutoGameModeEnabled -ErrorAction SilentlyContinue).AutoGameModeEnabled
    Info "AutoGameModeEnabled = $Current"

    if ($Current -ne 1) {
        Warn "Game Mode estava FALSE/desativado."
        Info "Alterando para TRUE..."
        New-ItemProperty -Path $GameBar -Name AutoGameModeEnabled -PropertyType DWord -Value 1 -Force | Out-Null
    }

    $Allow = (Get-ItemProperty $GameBar -Name AllowAutoGameMode -ErrorAction SilentlyContinue).AllowAutoGameMode
    if ($Allow -ne 1) {
        New-ItemProperty -Path $GameBar -Name AllowAutoGameMode -PropertyType DWord -Value 1 -Force | Out-Null
    }

    $Final = (Get-ItemProperty $GameBar -Name AutoGameModeEnabled -ErrorAction SilentlyContinue).AutoGameModeEnabled
    if ($Final -eq 1) { OK "Game Mode = TRUE" } else { Warn "Nao foi possivel confirmar o Game Mode." }
}

Etapa "Configurando interface e recursos de jogos" {
    if ($VisualLeve) {
        $Personalize = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
        if (-not (Test-Path $Personalize)) { New-Item $Personalize -Force | Out-Null }

        New-ItemProperty -Path $Personalize -Name EnableTransparency -PropertyType DWord -Value 0 -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name MinAnimate -Value "0"
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name MenuShowDelay -Value "100"

        OK "Transparencia = OFF"
        OK "Animacoes de janela = REDUZIDAS"
        OK "MenuShowDelay = 100 ms"
    } else {
        Info "Configuracoes visuais preservadas."
    }

    if ($DesativarDVR) {
        $GameConfigStore = "HKCU:\System\GameConfigStore"
        if (-not (Test-Path $GameConfigStore)) { New-Item $GameConfigStore -Force | Out-Null }
        New-ItemProperty -Path $GameConfigStore -Name GameDVR_Enabled -PropertyType DWord -Value 0 -Force | Out-Null

        $GameDVR = "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR"
        if (-not (Test-Path $GameDVR)) { New-Item $GameDVR -Force | Out-Null }
        New-ItemProperty -Path $GameDVR -Name AppCaptureEnabled -PropertyType DWord -Value 0 -Force | Out-Null
        OK "Game DVR = OFF"
    } else {
        Info "Game DVR preservado."
    }
}

Etapa "Configurando perfil de energia" {
    Info "Plano atual:"
    powercfg.exe /getactivescheme

    switch ($EnergyChoice) {
        "1" { Info "Plano atual mantido." }
        "2" { powercfg.exe /setactive SCHEME_BALANCED }
        "3" {
            powercfg.exe /setactive SCHEME_MIN
            if ($LASTEXITCODE -ne 0) { Warn "Alto Desempenho nao esta disponivel neste computador." }
        }
    }

    Info "Plano final:"
    powercfg.exe /getactivescheme
}

Separator
Write-Host " EXTRA | LIXEIRA" -ForegroundColor Magenta
if ($LimparLixeira) {
    try { Clear-RecycleBin -Force -ErrorAction Stop; OK "Lixeira limpa." }
    catch { Warn "Lixeira vazia ou nao pode ser limpa." }
} else {
    Info "Lixeira preservada."
}

Separator
Write-Host " EXTRA | ATUALIZACAO DE APLICATIVOS" -ForegroundColor Magenta
if ($AtualizarApps) {
    if (Get-Command winget.exe -ErrorAction SilentlyContinue) {
        winget.exe upgrade --all --accept-package-agreements --accept-source-agreements
    } else {
        Warn "Winget nao esta instalado neste computador."
    }
} else {
    Info "Atualizacao de aplicativos ignorada."
}

try {
    $FreeAfter = (Get-PSDrive -Name $SystemDriveName).Free
    $LiberadoGB = [math]::Round(($FreeAfter - $FreeBefore) / 1GB, 2)
} catch { $LiberadoGB = 0 }

Write-Progress -Activity "OHenrique Optimization | Windows 11" -Completed

Clear-Host
Banner
Write-Host "                         FINALIZADO" -ForegroundColor Green
Write-Host ""

OK "Limpeza concluida."
OK "DISM e SFC executados."
OK "Discos verificados e otimizados."
OK "DNS limpo."
OK "Memoria virtual verificada."
OK "Game Mode verificado."
OK "Plano de energia verificado."

if ($LiberadoGB -gt 0) {
    Write-Host ""
    Write-Host " Espaco recuperado aproximadamente: " -NoNewline
    Write-Host "$LiberadoGB GB" -ForegroundColor Green
}

Write-Host ""
Write-Host " Log completo:" -ForegroundColor Gray
Write-Host " $Log" -ForegroundColor Cyan

try { Stop-Transcript | Out-Null } catch {}

$Restart = Read-Host " Reiniciar o computador agora? [S/N]"
if ($Restart -match "^[SsYy]") {
    shutdown.exe /r /t 5
} else {
    OK "Finalizado. Reinicie manualmente quando puder."
}

Read-Host "Pressione ENTER para fechar"

}