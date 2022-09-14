1- Crie uma estrutura que rode um processo nginx, servindo o arquivo desafio.tar.
Desejável que o processo esteja rodando em um container. (Crie a estrura de deploy em um cluster k8s)

2- Crie um script que consuma o arquivo desafio.tar da estrutura criada no item 1.

3- Com o "desafio.tar" já baixado, crie um script que imprima a string "ABC".
Como descrito abaixo, cada arquivo possui duas linhas, sendo a segunda uma das letras [A,B,C].
Não é preciso estar ordenado.


Estrutura dos arquivos:

Arquivo.txt
--------
0
A
--------

OutroArquivo.txt
--------
1
B
--------

MaisUmArquivo.txt
--------
2
C
--------


OBS: Os scripts não precisam estar rodando no mesmo container.