# Contribuindo

Contribuições são bem-vindas. O objetivo do projeto é manter as otimizações **explicáveis, reversíveis e conservadoras**.

## Antes de enviar uma alteração

1. Explique qual problema o ajuste resolve.
2. Informe em quais versões/builds do Windows você testou.
3. Evite “tweaks milagrosos” sem documentação técnica.
4. Não adicione comandos que desativem Defender, Windows Update ou recursos críticos por padrão.
5. Para mudanças persistentes, documente como desfazer.
6. Prefira comandos nativos e documentados pela Microsoft.
7. Teste em máquina virtual ou computador de teste antes de sugerir uso geral.

## Pull Requests

Inclua:

- versão e build do Windows testadas;
- hardware relevante, quando aplicável;
- comando/chave alterada;
- comportamento antes/depois;
- riscos conhecidos;
- procedimento de reversão.

## Estilo

- mensagens de interface em português;
- nomes de funções claros;
- comentários para alterações de Registro;
- falhas não críticas devem ser tratadas sem encerrar todo o processo.
