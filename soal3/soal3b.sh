#!/bin/bash

folder=/home/thomasfelix/PRAKTIKUM1/SOAL3/soal3a.sh
file=$(date +"%d-%m-%Y")

bash $folder

mkdir $file

mv Koleksi_* $file
mv Foto.log $file