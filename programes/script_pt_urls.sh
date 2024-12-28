#!/bin/bash

# Fichier contenant les URLs
url_file="/home/ines/PPE_website_marche_sur_la_lune/URLs/pt_url/pt_url.txt"  # Chemin complet
# Fichier de sortie HTML
output_html="output.html"

# Initialisation du tableau HTML
cat <<EOT > "$output_html"
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau des URLs</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
<h2>Tableau des URLs</h2>
<table>
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

number=1  # Initialisation du numéro

while read -r url; do
    if [[ -z "$url" ]]; then
        echo "Ligne vide détectée, passage à la suivante."
        continue
    fi

    echo "Traitement de l'URL numéro $number : $url"

    # Vérification du code HTTP
    http_code=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")

    if [[ "$http_code" -ne 200 ]]; then
        echo "Erreur : Code HTTP $http_code pour l'URL $url"
        echo "<tr><td>$number</td><td><a href=\"$url\">$url</a></td><td>$http_code</td><td>NULL</td><td>NULL</td><td>NULL</td><td>NULL</td><td>NULL</td></tr>" >> "$output_html"
        number=$((number + 1))
        continue
    fi

    # Récupération du contenu de la page
    content=$(curl -s "$url")

    # Vérification de l'encodage
    encoding=$(echo "$content" | grep -oP 'charset=\K[^"]+')
    if [[ -z "$encoding" ]]; then
        encoding="Inconnu"
    fi

    # Compte des tokens (mots)
    token_count=$(echo "$content" | wc -w)

    # Ajout des informations au tableau HTML
    echo "<tr><td>$number</td><td><a href=\"$url\">$url</a></td><td>$http_code</td><td>$encoding</td><td>$token_count</td><td>NULL</td><td>NULL</td><td>NULL</td></tr>" >> "$output_html"

    number=$((number + 1))
done < "$url_file"

# Fin du tableau HTML
cat <<EOT >> "$output_html"
    </tbody>
</table>
</body>
</html>
EOT

echo "Tableau HTML généré avec succès : $output_html"
