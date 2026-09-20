# Segurança

Este projeto executa comandos administrativos no Windows. Leia o código antes de executar em uma máquina importante.

## Recomendações

- execute somente uma versão obtida deste repositório ou de uma cópia em que você confie;
- feche trabalhos importantes antes de iniciar;
- mantenha backup dos arquivos importantes;
- não interrompa DISM, SFC ou operações de disco sem necessidade;
- revise o arquivo de log antes de compartilhá-lo publicamente.

## O que o projeto evita por padrão

- desativar Microsoft Defender;
- desativar Windows Update;
- remover drivers;
- desativar permanentemente o arquivo de paginação;
- alterar BCD/HPET;
- apagar Prefetch indiscriminadamente;
- remover componentes essenciais;
- executar `DISM /ResetBase`;
- aplicar pacotes obscuros de Registro sem explicação.

## Relatando uma vulnerabilidade

Abra uma issue somente se ela não expuser dados sensíveis. Para logs, remova nomes de usuário, caminhos pessoais, nomes de máquina e outras informações privadas.
