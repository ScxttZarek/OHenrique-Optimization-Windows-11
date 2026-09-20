<div align="center">

# OHenrique Optimization — Windows 11

**Manutenção e otimização conservadora em PowerShell para notebooks e desktops.**

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?logo=powershell&logoColor=white)
![Windows 11](https://img.shields.io/badge/Windows-11-0078D4?logo=windows&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)

</div>

---

O **OHenrique Optimization** automatiza tarefas de manutenção e alguns ajustes de desempenho usando principalmente ferramentas nativas do Windows. A proposta é ser transparente: nada de “500% mais FPS”, desativação aleatória de serviços ou pacotes obscuros de Registro.

## ✨ Recursos

- interface colorida e progresso por etapas;
- verificação de Administrador;
- identificação de Windows, CPU, RAM, GPU e discos;
- log automático na Área de Trabalho;
- tentativa de criar ponto de restauração;
- limpeza de temporários e Limpeza de Disco;
- DISM `CheckHealth`, `ScanHealth`, `RestoreHealth` e `StartComponentCleanup`;
- `sfc /scannow`;
- `chkdsk /scan`;
- otimização de unidades com `defrag /O`;
- limpeza do cache DNS;
- correção do gerenciamento automático do pagefile se estiver desativado;
- verificação/ativação do Game Mode;
- modo visual leve opcional;
- Game DVR opcional;
- escolha do plano de energia;
- atualização opcional de aplicativos via Winget;
- pergunta antes de reiniciar o computador.

## 🚀 Como usar

1. Baixe `scripts/OHenrique-Optimization-Windows-11.ps1`.
2. Abra **Windows PowerShell/Terminal como Administrador**.
3. Execute:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\OHenrique-Optimization-Windows-11.ps1"
```

Se a política bloquear scripts:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

## 🛡️ O que o projeto evita

Por padrão, o script **não** desativa Defender, Windows Update, SysMain, Windows Search ou pagefile; não altera HPET/BCD; não apaga Prefetch indiscriminadamente; e não executa `DISM /ResetBase`.

## 🧠 Checagens automáticas

- **Pagefile:** se `AutomaticManagedPagefile` estiver `False`, tenta retornar para `True`.
- **Game Mode:** verifica e tenta ativar quando necessário.
- **HDD/SSD:** usa `defrag <unidade> /O /U /V`, deixando o Windows escolher a otimização adequada à mídia.

## ⚙️ Opções interativas

Você escolhe se deseja limpar a Lixeira, aplicar visual mais leve, desativar Game DVR, alterar o plano de energia, atualizar aplicativos via Winget e reiniciar ao finalizar.

## 📁 Estrutura

```text
.
├── .github/
├── docs/
├── scripts/
│   └── OHenrique-Optimization-Windows-11.ps1
├── CHANGELOG.md
├── CONTRIBUTING.md
├── DISCLAIMER.md
├── LICENSE
├── README.md
└── SECURITY.md
```

## 📄 Licença

Distribuído sob a **MIT License**. Consulte [LICENSE](LICENSE).

---

<div align="center">

**OHenrique Optimization • v1.0.0**

</div>
