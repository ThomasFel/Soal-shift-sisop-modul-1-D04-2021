#!/bin/bash

neko() {
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
    done

    folder=$(date +"%d-%m-%Y")

    mkdir "Kucing_$folder"

    mv Koleksi_* "Kucing_$folder"
    mv Foto.log "Kucing_$folder"
}

usagi() {
    max=23
    file=1

    for ((count=1;count<=max;count=count+1))
    do
        issame=0
        wget "https://loremflickr.com/320/240/bunny" -a Foto.log -O bunny

        if [ $count -eq 1 ]
        then
            mv bunny `printf "Koleksi_%02d" "$file"`
            file=$(($file+1))
        fi

        for ((count2=1;count2<file;count2=count2+1))
        do
            if [ $count -eq 1 ]
            then break
            fi

            nama=`printf "Koleksi_%02d" "$count2"`
            sama=`cmp $nama bunny -b`
            
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
                rm bunny
            else
                mv bunny `printf "Koleksi_%02d" "$file"`
                file=$(($file+1))
            fi
        fi
    done

    folder=$(date +"%d-%m-%Y")

    mkdir "Kelinci_$folder"

    mv Koleksi_* "Kelinci_$folder"
    mv Foto.log "Kelinci_$folder"
}

nekoTotal=$(ls | grep "Kucing_" | wc -l)
usagiTotal=$(ls | grep "Kelinci_" | wc -l)

if [[ $nekoTotal -eq $usagiTotal ]]
then
    usagi

else [[ $nekoTotal -ne $usagiTotal ]]
    neko
fi