# Script que lista os resources criados na aws

##  Requisitos
- Python3
- Biblioteca boto3 do python
- Acesso ao ambiente da AWS

## Execute o script e siga as intruções nos inputs
```
$ python3 ./06_list_resources/list_resources.py
```

## Esse script simples lista os clusters eks existentes na região selecionada e lista os nodegroups no cluster escolhido. Também existe uma validação de região e de cluster existentes.