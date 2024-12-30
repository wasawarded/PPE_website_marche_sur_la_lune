#!/bin/sh
n=1
name="en_dump_raw"
contexte="/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/dumps-text/pals/contextes/en_contexte"
while [ $n -lt 51 ];
do
    cat "./$name$n" | grep -A1 -B1 logic > $contexte/"contexte"$n.txt
    n=$(expr $n + 1)
done < "./$name$n"
