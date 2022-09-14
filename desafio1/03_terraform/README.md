# Criação de um cluster kubernetes utilizando terraform e realizando o deploy do helm desenvolvido no item anterior

## Requisitos
- terraform
- aws-cli
- helm
- kubectl
- curl
- Variáveis de ambiente definidas para execução do terraform: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION e opcionalmente AWS_PROFILE.

## Esse terraform faz a criação de:
- Módulo de rede (vpc, subnets, natgateway, elasticIp, etc.)
- Um cluster eks com 1 nodegroup composto de 1 instancia e todas as roles necessárias para o funcionamento do cluster. 

## Validação
```
$ cd 03_terraform
# Altere o profile no arquivo main.tf
$ terraform init
$ terraform plan
$ terraform apply -auto-approve
```

## Para acessar o cluster é necessário executar o comando que atualiza o seu kubeconfig com as informações do novo cluster
```
$ aws --profile PROFILE_USADO_NO_MAIN.TF eks --region us-east-1 update-kubeconfig --name eks_desafio
```

## Faça o deploy da aplicação usando o helm criado no passo anteriormente (02_helm)
```
$ helm upgrade desafio ./02_helm/desafio1/ --install --namespace desafio --create-namespace
```

## Valide o funcionamento da simple app. Em um terminal exponha a porta do serviço criado
```
$ kubectl port-forward svc/desafio-desafio1 8080:80 -n desafio
```

## Em outro terminal realize as 2 chamadas que a aplicação aceita
```
$ curl http://localhost:8080 $ curl http://localhost:8080/health
```

## Limpe o ambiente
```
$ helm uninstall desafio -n desafio
$ cd 03_terraform
$ terraform destroy -auto-approve
```

## Observação
```
- Esse passo a passo assume que o config e credentials estão configurados corretamente no caminho default (~/.aws/)
- O profile deve ser alterado no arquivo main.tf
```