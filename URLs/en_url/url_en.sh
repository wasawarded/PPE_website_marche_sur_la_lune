#!/bin/sh
nombre_de_ligne=1
url_path="./logic_english.txt"
while read -r line;
do
	if [[ $line =~ ^https?:// ]]
	then
		# -I que les entêtes, pas besoin de -i les html
		# -o le reste, les texte 
		reponse=$(curl --connect-timeout 10 -s -L -i -w "%{http_code}\t%{content_type}" -o /home/xingyuchen/Desktop/test.html $line)
		code_http=$(echo $reponse | cut -d " " -f1)
		content_type=$(echo $reponse | cut  -f2)
		encodage=$(echo $content_type | grep -E -o -i "charset\S+" | sed -E 's/charset=(.*)/\1/')
		if [[ $encodage =~ [uU][tT][fF]-8 ]]
		then
			# store our information ? but how to do file by file
			nombre_mots=$(lynx -dump -nolist $line | wc -w)
			echo -e "$nombre_de_ligne\t$line\t$code_http\t$encodage\t$nombre_mots"
		else
			echo -e "$nombre_de_ligne\t$line\t$code_http\tencodage non UTF-8\tNULL"
		fi
	else
		echo -e "$nombre_de_ligne\t$line\tformat non conforme\tNULL\tNULL"
	fi
	nombre_de_ligne=$(expr $nombre_de_ligne + 1)
done < $url_path
