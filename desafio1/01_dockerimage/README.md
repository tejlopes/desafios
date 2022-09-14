# Criação de um app simples utilizando docker.

## Requisitos
- docker

## Crie a imagem a partir do dockerfile
```
docker build -t simpleapp-python .
```

## Faça o login no dockerhub
```
docker login --username tejlopes
```

## Crie uma nova tag com base na imagem local
```
docker tag simpleapp-python:latest tejlopes/desafio1:1.0.0
```

## Faça o push da nova tag
```
docker push tejlopes/desafio1:1.0.0
```