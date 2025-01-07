#!/bin/bash

# Définition des chemins
# Chemin relatif vers le dossier parent principal
base_dir=".."

# Définition des chemins relatifs basés sur le dossier parent
url_file="$base_dir/URLs/fr_url/fr_url.txt"
dumps_dir="$base_dir/dumps-text/logique_français"
contextes_dir="$base_dir/contextes/fr_contexte/context_txt"
concordances_dir="$base_dir/tableaux/concordances/fr_concordances"
tableaux_dir="$base_dir/tableaux"
output_html="$tableaux_dir/fr_table.html"
word="logique|Logique|logiques|Logiques"

# Vérification des dossiers
mkdir -p "$contextes_dir" "$concordances_dir" "$tableaux_dir"

# Initialisation du tableau HTML
cat <<EOT > "$output_html"
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau des résultats</title>
    <link rel="stylesheet" type="text/css" href="./ar_table.css">
</head>
<body>
<div style="width: 80%; margin: 0 auto; padding-top: 15px;">
<table border="1" width="100%">
    <caption style="padding-bottom:20px;">
        <strong><u><center>Résultats du traitement des dumps pour le mot logique en français</center></u></strong>
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

# Traitement des URLs
number=1
while read -r url; do
    if [[ -z "$url" ]]; then
        echo "Ligne vide détectée, passage à la suivante."
        continue
    fi

    echo "Traitement de l'URL numéro $number ..."

    # Définition des fichiers associés
    dump_file="$dumps_dir/dump_fr_$number.txt"
    context_file="$contextes_dir/logique_français-$number-context.txt"
    concordance_file="$concordances_dir/logique_français-$number-concordance.html"

    # Vérification de l'existence du dump
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

 

    # Comptage des tokens
    token_count=$(wc -w < "$dump_file")

    # Comptage des occurrences du mot étudié
    word_count=$(grep -o -E "$word" "$dump_file" | wc -l)

    # Extraction des contextes
    grep -C 2 -E "$word" "$dump_file" > "$context_file"

    # Génération des concordances
    grep -o -E ".{0,30}($word).{0,30}" "$dump_file" | \
    sed -E "s/(.*)($word)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" > "$concordance_file"

    # Génération des concordances
grep -o -E ".{0,30}($word).{0,30}" "$dump_file" | \
sed -E "s/(.{0,30})($word)(.{0,30})/<tr><td>\1<\/td><td><strong>\2<\/strong><\/td><td>\3<\/td><\/tr>/" > "$concordance_file"

# Encapsulation dans un fichier HTML
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

# Ajout des résultats au tableau HTML
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

# Finalisation du tableau HTML
cat <<EOT >> "$output_html"
    </tbody>
</table>
</div>
</body>
</html>
EOT

echo "Tableau HTML généré avec succès : $output_html"
