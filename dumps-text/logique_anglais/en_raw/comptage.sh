#!/bin/sh
name="en_dump_raw"
a=1
table="/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/tableaux/en_table.txt"
while read raw;
do
	if [ -f $name$a ]
	then
		comptage=$(grep -i -o logic $name$a | wc -w)
		echo -e $raw"\t"$comptage # pour utiliser le wildcard, il faut utiliser les ""
	else
		echo -e $raw"\terror"
	fi
	a=$(expr $a + 1)
done < $table
