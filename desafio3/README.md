# Desafio

Esse terraform cria: 
- O módulo de rede (vpc, subnets, natgateway, elasticIp, etc.)
- Um security group que libera a porta 80 e 443 para acesso ao apache.
- Uma instancia ec2 t2.micro com um userdata que faz a instalação, subida e configuração básica do apache e cloudwatch-agent. Também adiciona o arquivo de configuraçao do cloudwatch-agent, que monitora CPU, memória, disco e swap (vide files/cw_agent-config.json). Essa instância recebe um ip público para acesso ao apache.
- Alarmes no cloudwatch para monitorar uso de CPU, memória e Swap.

Validação:

$ terraform init
$ terraform plan
$ terraform apply -auto-approve

Validação: Ao final da execução do terraform o IP público será mostrado. Basta colá-lo na URL e verificar o funcionamento.

Destruição do ambiente:
$ terraform destroy -auto-approve

Obs:
- Esse passo a passo assume que o config e credentials estão configurados corretamente no caminho default (~/.aws/)
- O profile deve ser alterado no arquivo main.tf