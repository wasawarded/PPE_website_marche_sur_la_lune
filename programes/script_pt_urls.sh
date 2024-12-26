#!/bin/bash

base_dir=".."


url_file="$base_dir/URLs/pt_url/pt_url.txt"
dumps_dir="$base_dir/dumps-text/logique_portugais"
contextes_dir="$base_dir/contextes/pt_contexte/pt_context_txt"
concordances_dir="$base_dir/tableaux/concordances/pt_concordances"
tableaux_dir="$base_dir/tableaux"
output_html="$tableaux_dir/pt_table.html"
word="lógica/o"


mkdir -p "$contextes_dir" "$concordances_dir" "$tableaux_dir"


cat <<EOT > "$output_html"
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau des résultats</title>
    <link rel="stylesheet" type="text/css" href="./pt_table.css">
</head>
<body>
<div style="width: 80%; margin: 0 auto; padding-top: 15px;">
<table border="1" width="100%">
    <caption style="padding-bottom:20px;">
        <strong><u><center>Résultats du traitement des dumps pour le mot logique en portugais</center></u></strong>
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
    <tbody>
EOT


number=1
while read -r url; do
    if [[ -z "$url" ]]; then
        echo "Ligne vide détectée, passage à la suivante."
        continue
    fi

    echo "Traitement de l'URL numéro $number ..."

    
    dump_file="$dumps_dir/dump_pt_$number.txt"
    context_file="$contextes_dir/logique_portugais-$number-context.html"
    concordance_file="$concordances_dir/logique_portugais-$number-concordance.html"

    
    if [[ ! -f "$dump_file" ]]; then
        echo "Erreur : Le fichier dump $dump_file n'existe pas." >&2
        cat <<EOL >> "$output_html"
        <tr>
            <td>$number</td>
            <td><a href="$url">$url</a></td>
            <td>Erreur</td>
            <td>NULL</td>
            <td>NULL</td>
            <td>NULL</td>
            <td>NULL</td>
            <td>NULL</td>
        </tr>
EOL
        number=$((number + 1))
        continue
    fi

   
    token_count=$(wc -w < "$dump_file")

    
    word_count=$(grep -o -E "$word" "$dump_file" | wc -l)

    
    grep -C 2 -E "$word" "$dump_file" > "$context_file"

    
    grep -o -E ".{0,30}($word).{0,30}" "$dump_file" | \
    sed -E "s/(.*)($word)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" > "$concordance_file"

    
grep -o -E ".{0,30}($word).{0,30}" "$dump_file" | \
sed -E "s/(.{0,30})($word)(.{0,30})/<tr><td>\1<\/td><td><strong>\2<\/strong><\/td><td>\3<\/td><\/tr>/" > "$concordance_file"


cat <<EOC > "$concordance_file"
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Concordance pour $word</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
<h2>Concordance pour le mot : $word</h2>
<table>
    <thead>
        <tr>
            <th>Contexte gauche</th>
            <th>Mot</th>
            <th>Contexte droit</th>
        </tr>
    </thead>
    <tbody>
$(cat "$concordance_file")
    </tbody>
</table>
</body>
</html>
EOC


    cat <<EOL >> "$output_html"
        <tr>
            <td>$number</td>
            <td><a href="$url">$url</a></td>
            <td>200</td>
            <td>UTF-8</td>
            <td>$token_count</td>
            <td>$word_count</td>
            <td><a href="$context_file">Contexte</a></td>
            <td><a href="$concordance_file">Concordance</a></td>
        </tr>
EOL

    number=$((number + 1))
done < "$url_file"


cat <<EOT >> "$output_html"
    </tbody>
</table>
</div>
</body>
</html>
EOT

echo "Tableau HTML généré avec succès : $output_html"

