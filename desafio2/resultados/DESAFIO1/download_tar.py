#!/usr/bin/env python3
import wget
output = "/tmp"
url = "http://URL/desafio/desafio.tar"
filename = wget.download(url, out = output)
