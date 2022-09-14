# Deploy da stack de monitoria do cluster

##  Requisitos
- Um cluster em execução
- helm

## Para monitoria utlizaremos a stack prometheus + grafana. O helm abaixo criará os recursos: alertmanager, prometheus-server, grafana, operator, state-metrics e node-exporters
```
$ helm install prometheus-stack prometheus-community/kube-prometheus-stack --namespace=monitoring --create-namespace
```
