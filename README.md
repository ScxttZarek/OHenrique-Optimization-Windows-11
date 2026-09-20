<div align="center">

# OHenrique Optimization — Windows 11

**Otimização e manutenção do Windows em PowerShell.**

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?logo=powershell&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)

</div>

---


## 🚀 Como usar

### 1. Baixe o arquivo principal

👉 **[OHenrique-Optimization-Windows-11.ps1](OHenrique-Optimization-Windows-11.ps1)**

No GitHub, abra o arquivo e use **Download raw file**.

### 2. Abra o PowerShell como Administrador

Pesquise por **PowerShell** ou **Terminal**, clique com o botão direito e escolha **Executar como administrador**.

### 3. Execute o arquivo

Entre na pasta onde ele foi baixado e rode:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\OHenrique-Optimization-Windows-11.ps1"
```

Pronto. A ferramenta abre sua própria interface e pergunta quais opções você deseja aplicar.

## 🔧 O que ele faz

- limpa arquivos temporários;
- executa manutenção e reparo com DISM;
- executa SFC e CHKDSK;
- otimiza HDD/SSD usando o método apropriado do Windows;
- limpa o cache DNS;
- verifica a memória virtual;
- verifica/ativa o Game Mode;
- oferece modo visual mais leve;
- permite desativar Game DVR;
- permite escolher o plano de energia;
- pode atualizar aplicativos pelo Winget;
- cria log da execução na Área de Trabalho.

## 🛡️ O que ele NÃO faz

O script não desativa Defender, Windows Update, SysMain, Windows Search ou o arquivo de paginação. Também não aplica tweaks de HPET/BCD, não apaga Prefetch indiscriminadamente e não usa `DISM /ResetBase`.

## 📁 Este repositório tem só 3 arquivos

```text
README.md
LICENSE
OHenrique-Optimization-Windows-11.ps1
```

Assim não tem pasta escondendo o arquivo que realmente importa.

## 📄 Licença

MIT License — Copyright © 2026 OHenrique.

Leia o script antes de executar alterações administrativas em uma máquina importante.
