#!/bin/sh
# ce script est utilisé pour ajouter d'autter d'autre collonnes dans le tableaux
global=".."
tableaux="./en_table.txt"
nb=1
dump="/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/dumps-text/logique_anglais/en_raw/en_dump_raw"
contexte="$global/contextes/en_contexte/contexte_html" # two lines relatives, how to do ?
concordance="$global/tableaux/concordance/en_concordances/logic_en_concordance"
# tokenization="/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/dumps-text/pals/logique_anglais/en_raw/en_dump_raw"
echo "<!DOCTYPE html>
<html lang=\"fr\">
<head>
    <meta charset=\"UTF-8\">
    <title>Tableau des résultats</title>
</head>
<body>
<div style=\"width: 80%; margin: 0 auto; padding-top: 15px;\">
<table border=\"1\" width=\"100%\">
    <caption style=\"padding-bottom:20px;\">
        <strong><u><center>Résultats du traitement des dumps pour le mot logique en anglais</center></u></strong>
    </caption>
    <thead>
        <tr>
            <th>Numéro</th>
            <th>URL</th>
            <th>Code HTTP</th>
            <th>Encodage HTML</th>
            <th>Nombre de Tokens</th>
            <th>Compte</th>
            <th>Lien Contexte</th>
            <th>Lien Concordance</th>
        </tr>
    </thead>
    <tbody>" > "/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/tableaux/en_tableaux/en_table.html"
while read -r line; # we only need thoses token is not null and code is 200
do
    numero=$(echo $line | awk '{print $1}')
    http=$(echo $line | awk '{print $2}')
    code=$(echo $line | awk '{print $3}')
    encodage=$(echo $line | awk '{print $4}')
    # make sur that the dump file exits
    if [ -f $dump$numero ] # we read the dump file not empty
    then
        token=$(cat $dump$numero | wc -w)
        compte=$(cat $dump$numero | grep -io -e logic | wc -w)
        if [ $token -gt 100 ] && [ $code -eq 200 ] && [ $nb -lt 51 ] && [ $compte -gt 2 ] &&  [[ $encodage =~ [uU][tT][fF]-8 ]] # make sur we have tokens
        then
#             cat $dump$numero > $tokenization$nb
            echo "<tr>
            <td>$nb</td>
            <td><a href=\"$http\">$http</a></td>
            <td>200</td>
            <td>utf-8</td>
            <td>$token</td>
            <td>$compte</td>
            <td><a href=\"$contexte$numero.html\">Contexte</a></td>
            <td><a href=\"$concordance$numero.html\">Concordance</a></td>
            </tr>" >> "/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/tableaux/en_tableaux/en_table.html"
            nb=$(expr $nb + 1)
        elif [ $token -gt 100 ] && [ $code -eq 200 ] && [ $nb -lt 51 ] && [ $compte -gt 5 ] &&  [[ ! $encodage =~ [uU][tT][fF]-8 ]]
        then
#             cat $dump$numero > $tokenization$nb
            echo "<tr>
            <td>$nb</td>
            <td><a href=\"$http\">$http</a></td>
            <td>200</td>
            <td>utf-8(transformed)</td>
            <td>$token</td>
            <td>$compte</td>
            <td><a href=\"$contexte$numero.html\">Contexte</a></td>
            <td><a href=\"$concordance$numero.html\">Concordance</a></td>
            </tr>" >> "/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/tableaux/en_tableaux/en_table.html"
            nb=$(expr $nb + 1)
        fi
    fi
done < $tableaux
echo "</tbody>
</table>
</div>
</body>
</html>" >> "/home/xingyuchen/Desktop/PPE_website/PPE_website_marche_dans_la_lune/tableaux/en_tableaux/en_table.html"
