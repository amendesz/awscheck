# Script AWS para listar instâncias EC2 e RDS em várias regiões

Este é um script em bash que utiliza o AWS CLI para listar informações sobre as instâncias EC2 e RDS em todas as regiões disponíveis na conta da AWS. Ele exibirá o nome, o ID da instância e o IP público das instâncias EC2, e o nome e o status das instâncias RDS em cada região.

## Requisitos

- [AWS CLI](https://aws.amazon.com/cli/) instalado e configurado com as credenciais da sua conta AWS.

## Como usar o script

1. Clone o repositório ou copie o conteúdo do script `list_instances.sh` para o seu ambiente.

2. Dê permissão de execução ao script:

   ```bash
   chmod +x list_instances.sh

Rode: ./list_instances.sh

## Descrição do resultado
O resultado será organizado em seções para cada região e listará as instâncias EC2 e RDS disponíveis em cada uma. As instâncias EC2 serão marcadas em vermelho se estiverem desligadas e em verde se estiverem ligadas. As instâncias RDS serão listadas com seus respectivos nomes e status.
## Exemplos

```bash
# Resultado das instâncias EC2 e RDS nas regiões da AWS

Região: us-east-1
Nome: Instance-1
ID da Instância: i-0a1b2c3d4e5f67890
IP Público: 54.123.45.67
-------------------------------------
Nome: Instance-2
ID da Instância: i-1a2b3c4d5e6f78901
IP Público: 54.890.12.34
-------------------------------------
Nome: 
ID da Instância: i-9a8b7c6d5e4f3210
IP Público: 
-------------------------------------



## Contribuição
Sinta-se à vontade para abrir um problema (issue) ou enviar uma solicitação de pull (pull request) para melhorias ou correções neste script.

## Notas
O script foi testado no ambiente Linux e pode funcionar em outros sistemas Unix-like.
Certifique-se de ter permissões adequadas para executar o script e que as credenciais do AWS CLI estejam configuradas corretamente em seu sistema.
## Licença
Este projeto está licenciado sob a MIT License.
