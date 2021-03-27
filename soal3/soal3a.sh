#!/bin/bash

max=23
file=1
for ((count=1;count<=max;count=count+1))
do
   issame=0
   wget "https://loremflickr.com/320/240/kitten" -a Foto.log -O kitten

   if [ $count -eq 1 ]
   then
     mv kitten `printf "Koleksi_%02d" "$file"`
     file=$(($file+1)) 
   fi

   for ((count2=1;count2<file;count2=count2+1))
   do
      if [ $count -eq 1 ]
      then break
      fi

      nama=`printf "Koleksi_%02d" "$count2"`
      sama=`cmp $nama kitten -b`

      if [ -z "$sama" ]
      then
        issame=1
        break
      else
        issame=0
      fi
   done

   if [ $count -gt 1 ]
   then
     if [ $issame -eq 1 ]
     then
       rm kitten
     else
       mv kitten `printf "Koleksi_%02d" "$file"`
       file=$(($file+1))
     fi
   fi
doney
