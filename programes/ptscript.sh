#!/bin/bash

# Fichier contenant les URLs
INPUT_FILE="/home/ines/PPE_website_marche_sur_la_lune/URLs/pt_url/pt_url.txt"
OUTPUT_HTML="pt_tableau_contexte.html"
CONTEXT_DIR="/home/ines/PPE_website_marche_sur_la_lune/contextes/pt_contexte/pt_context_txt"

# Créer le répertoire pour les fichiers de contexte (s'il n'existe pas déjà)
mkdir -p "$CONTEXT_DIR"

# Fonction pour compter les tokens (mots)
function count_tokens() {
    echo "$1" | wc -w
}

# Fonction pour extraire un extrait (contexte) de la page (ici les 500 premiers caractères)
function get_context() {
    echo "$1" | head -c 500
}

# Début du tableau HTML
echo "<!DOCTYPE html>
<html lang=\"fr\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Résultats du traitement avec contexte</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #f8f9fa; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        a { color: #007BFF; text-decoration: none; }
    </style>
</head>
<body>
    <h1>Résultats du traitement des dumps pour le mot logique en portugais avec contexte</h1>
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
        <tbody>" > "$OUTPUT_HTML"

# Initialisation du compteur
COUNTER=1

# Lire chaque URL du fichier
while IFS= read -r url; do
    if [[ -z "$url" ]]; then
        continue
    fi

    # Récupérer le contenu avec curl
    RESPONSE=$(curl -s -I "$url" | head -n 1)
    HTTP_CODE=$(echo "$RESPONSE" | awk '{print $2}')
    CONTENT=$(curl -s "$url")
    ENCODING=$(echo "$CONTENT" | file -bi - | sed -n 's/.*charset=//p')

    # Compter les tokens
    TOKENS=$(count_tokens "$CONTENT")

    # Calculer un exemple de compte (ici, basé sur le nombre de paragraphes HTML trouvés)
    COMPTE=$(echo "$CONTENT" | grep -o "<p" | wc -l)

    # Extraire un contexte de la page (les premiers 500 caractères)
    CONTEXTE=$(get_context "$CONTENT")

    # Créer un fichier HTML pour le contexte dans le répertoire "contextes"
    FILENAME=$(echo "$url" | sed 's/[^a-zA-Z0-9]/_/g').html
    CONTEXT_FILE="$CONTEXT_DIR/context_$FILENAME"

    # Générer le fichier HTML de contexte
    echo "<!DOCTYPE html>
<html lang=\"fr\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Contexte de la page : $url</title>
</head>
<body>
    <h1>Contexte de la page : $url</h1>
    <p>$CONTEXTE...</p>
    <a href=\"$url\" target=\"_blank\">Voir la page complète</a>
</body>
</html>" > "$CONTEXT_FILE"

    # Ajouter une ligne dans le tableau HTML avec un lien vers le contexte
    echo "        <tr>
        <td>$COUNTER</td>
        <td><a href=\"$url\" target=\"_blank\">$url</a></td>
        <td>$HTTP_CODE</td>
        <td>${ENCODING:-Inconnu}</td>
        <td>$TOKENS</td>
        <td>$COMPTE</td>
        <td><a href=\"$CONTEXT_DIR/context_$FILENAME\" target=\"_blank\">Contexte</a></td>
        <td><a href=\"#\">Concordance</a></td>
    </tr>" >> "$OUTPUT_HTML"

    COUNTER=$((COUNTER + 1))
done < "$INPUT_FILE"

# Fin du tableau HTML
echo "    </tbody>
    </table>
</body>
</html>" >> "$OUTPUT_HTML"

echo "Tableau HTML généré dans $OUTPUT_HTML"
echo "Fichiers de contexte générés dans le répertoire \"$CONTEXT_DIR\"."

