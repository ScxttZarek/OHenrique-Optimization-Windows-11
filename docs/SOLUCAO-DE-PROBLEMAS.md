# Solução de problemas

## “A execução de scripts foi desabilitada”

Use somente para a sessão atual:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

Depois execute o script novamente. Isso não altera permanentemente a política do computador.

## “Acesso negado”

Feche a janela e abra **Windows PowerShell/Terminal como Administrador**.

## DISM parece parado

Algumas porcentagens podem permanecer sem mudança por vários minutos. Evite encerrar o processo apenas porque a porcentagem não avançou imediatamente.

## O ponto de restauração falhou

O restante da ferramenta pode continuar. Verifique se a Proteção do Sistema está ativada. O Windows também pode limitar a frequência de novos pontos de restauração.

## Alguns temporários não foram apagados

Arquivos em uso pelo Windows ou por aplicativos abertos são ignorados. Isso é normal.

## Alto Desempenho não aparece

Nem todos os dispositivos/fabricantes disponibilizam todos os planos tradicionais. Use **Manter atual** ou **Balanceado**.

## Winget não existe

A atualização de aplicativos é opcional; o restante da ferramenta continua funcionando.

## CHKDSK encontrou problemas

Siga a orientação exibida pelo próprio Windows. Uma correção offline pode exigir reinicialização.

## Não ganhei FPS

A ferramenta não aumenta a capacidade física da CPU/GPU. Ela automatiza manutenção e alguns ajustes conservadores. FPS depende principalmente de hardware, drivers, temperaturas, resolução, configurações do jogo e carga em segundo plano.
