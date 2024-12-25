#!/bin/sh
nombre_de_ligne=1
url_path="./logic_english.txt"
dump_path="/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/dumps-text/logique_anglais/en_raw"

html_path="/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/aspirations/en_html/en_"

while read -r line;
do
	if [[ $line =~ ^https?:// ]]
	then
		# -I que les entêtes, pas besoin de -i les html
		# -o les médadonnées et les textes
		file=$html_path$nombre_de_ligne.html
		reponse=$(curl --connect-timeout 10 -s -L -w "%{http_code}\t%{content_type}" -o $file $line)
		code_http=$(echo $reponse | cut -d " " -f1)
		content_type=$(echo $reponse | cut  -f2)
		encodage=$(echo $content_type | grep -E -o -i "charset\S+" | sed -E 's/charset=(.*)/\1/')
		# vérification de ne pas avoir des url répétés : create a no repetition list
		if [[ $encodage =~ [uU][tT][fF]-8 ]] && [ $code_http -eq 200 ]
		then
			nombre_mots=$(lynx -dump -nolist $file | wc -w)
			echo -e "$nombre_de_ligne\t$line\t$code_http\t$encodage\t$nombre_mots" >> "/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/tableaux/en_table.txt"

			file=$html_path$nombre_de_ligne.html
			# file here is a html file
			lynx -dump -nolist $file > $dump_path/en_dump_raw$nombre_de_ligne

		elif [ $code_http -ne 200 ]
		then
		# even if the code is not 200, we need to write a information in our html
			echo -e "$nombre_de_ligne\t$line\tNULL\tNULL\tNULL" >> "/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/tableaux/en_table.txt"

		elif [[ ! $encodage =~ [uU][tT][fF]-8 ]] && [ $code_http -eq 200 ]
		then
			echo -e "$nombre_de_ligne\t$line\t$code_http\t$encodage\t$nombre_mots" >> "/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/tableaux/en_table.txt"
			file=$html_path$nombre_de_ligne.html
			iconv -f $encodage -t utf-8 $file -o $file # transformation en UTF-8
			lynx -dump -nolist $file > $dump_path/en_dump_raw$nombre_de_ligne
		fi
	else
		echo -e "$nombre_de_ligne\t$line\tformat non conforme\tNULL\tNULL"
	fi
	nombre_de_ligne=$(expr $nombre_de_ligne + 1)
done < $url_path
