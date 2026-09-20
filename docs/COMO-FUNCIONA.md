# Como funciona

O **OHenrique Optimization** foi projetado para automatizar manutenção e ajustes conservadores sem assumir uma configuração específica de hardware.

## 1. Permissões administrativas

Confirma que o PowerShell está elevado antes de usar ferramentas que exigem privilégios administrativos.

## 2. Identificação do sistema

Consulta informações de Windows, CPU, RAM, GPU e armazenamento por CIM/WMI. Esses dados são mostrados na interface e registrados no log.

## 3. Ponto de restauração

Tenta criar um ponto com `Checkpoint-Computer`. A tentativa pode falhar se a Proteção do Sistema estiver desligada ou se o Windows limitar a criação de pontos em um intervalo curto.

## 4. Limpeza de temporários

Processa as pastas temporárias do usuário e do Windows. Arquivos que estiverem em uso são ignorados.

## 5. Manutenção da imagem do Windows

Executa:

```text
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
DISM /Online /Cleanup-Image /StartComponentCleanup
```

O objetivo é detectar corrupção, tentar reparar a imagem e executar manutenção do Component Store.

## 6. System File Checker

```text
sfc /scannow
```

Verifica arquivos protegidos do sistema e tenta reparar arquivos alterados/corrompidos.

## 7. CHKDSK

```text
chkdsk C: /scan
```

Executa uma verificação online da unidade do sistema.

## 8. Otimização de armazenamento

A ferramenta usa `defrag <unidade> /O /U /V`. O parâmetro `/O` pede ao Windows para escolher a otimização adequada à mídia, evitando presumir que todo PC usa HDD ou SSD.

## 9. DNS

`ipconfig /flushdns` limpa o cache do resolvedor DNS. Isso é manutenção de rede, não um “boost de ping”.

## 10. Memória virtual

O script verifica `AutomaticManagedPagefile`. Se estiver `False`, tenta alterar para `True`. O projeto não desativa o pagefile.

## 11. Game Mode

Verifica as chaves do Game Mode no perfil do usuário e tenta ativá-lo quando necessário.

## 12. Modo visual leve

Opcionalmente reduz transparência/animações e diminui o atraso de abertura de menus. Isso melhora sensação de responsividade; não aumenta a potência da GPU.

## 13. Game DVR

A desativação é opcional para quem não usa gravação/captura em segundo plano.

## 14. Energia

O usuário escolhe entre manter o plano atual, Balanceado ou Alto Desempenho. Isso evita impor uma política de energia igual para notebooks e desktops.

## 15. Winget

Quando escolhido, tenta atualizar aplicativos gerenciados pelo Winget. Nem todo aplicativo instalado é administrado por ele.

## Filosofia do projeto

Alterações agressivas não entram por padrão. Toda otimização persistente deve ser explicável, ter benefício plausível e, idealmente, ser reversível.
