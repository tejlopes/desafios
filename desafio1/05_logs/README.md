# Stack de logs das aplicações no cluster

## A stack de logs contará com
- Elastic-operator
- Elasticsearch
- Kibana

## Requisitos
- kubectl

# Instalação


## Instale os CRD's do elastic-operator
```
$ kubectl create -f https://download.elastic.co/downloads/eck/2.3.0/crds.yaml
```

## Crie os recursos do elastic-operator
```
$ kubectl apply -f https://download.elastic.co/downloads/eck/2.3.0/operator.yaml
```

## Faça o deploy do elasticsearch
```
$ cat <<EOF | kubectl apply -f -
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: elasticsearch
  namespace: elastic-system
spec:
  version: 8.3.3
  nodeSets:
  - name: default
    count: 1
    config:
      node.store.allow_mmap: false
EOF
```

## Faça o deploy do kibana
```
$ cat <<EOF | kubectl apply -f -
apiVersion: kibana.k8s.elastic.co/v1
kind: Kibana
metadata:
  name: kibana
  namespace: elastic-system
spec:
  version: 8.3.3
  count: 1
  elasticsearchRef:
    name: elasticsearch
EOF
```

## Faça o deploy do fluentbit
```
$ cd fluentbit
$ kubectl create -f .
```

## Para acessar o kibana, utilize o usuário 'elastic' e o comando abaixo para obter a senha:
```
$ kubectl get secret elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo
```

## Para ter acesso aos logs o index pattern deve ser criado no kibana.