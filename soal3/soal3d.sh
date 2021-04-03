#!/bin/bash

pass=$(date +"%m%d%Y")
file=$(ls | grep -E "Kelinci_|Kucing_|-|Foto.log|Koleksi_")

zip -r -P $pass Koleksi.zip $file
rm -r $file
