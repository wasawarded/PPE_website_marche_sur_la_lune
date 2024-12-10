#!/bin/sh
# this is a dump generation script using local url file to generate txt file for each url
# how to find something to replace my own path ?
dump_path="/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/dumps-text/logic_anglais/en_raw"
number=1
# this script is saved in url folder where we have our url txt file
url_path="$(pwd)/logic_english.txt"
while read -r LINE;
do
# make sure line is a url
    if [[ $LINE =~ ^https?.+ ]]
    then
        name="en_dump_raw$number"
        # texte to make sure the texte is not empty
        texte=$(lynx -nolist -dump "$LINE" | head -n 15)
        # in bash, && means and, || means or
        if [ -n "$texte" ] || [[ ! $texte =~ [eE]rror.* ]];
        then
            lynx -nolist -dump "$LINE" > $dump_path/en_dump_raw$number
        else
            echo en_dump_raw$number has problem
        fi
        number=$(expr $number + 1)
    else
        echo $LINE not a url
    fi
done < $url_path
