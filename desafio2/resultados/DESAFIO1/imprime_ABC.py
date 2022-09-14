#!/usr/bin/env python3
import tarfile
import os

path = "/tmp/desafio"
files_txt = os.listdir(path)
tar_desafio = "/tmp/desafio.tar"
list_ABC_temp = []
list_ABC = []

tar = tarfile.open(tar_desafio)
tar.extractall(path="/tmp")
tar.close()


for file in files_txt:
    if ".txt" in file and "._" not in file and "README" not in file:
        with open("{}/{}".format(path, file)) as f:
            contents = f.read()
            if "a" in contents or "b" in contents or "c" in contents:
                list_ABC_temp.append(contents)

for letter in list_ABC_temp:
    size = len(letter)
    last = letter[size-1]
    if last.upper() not in list_ABC:
        list_ABC.append(last.upper())

# If you want order
# list_ABC.sort()
print("{}".format("".join(list_ABC)))
