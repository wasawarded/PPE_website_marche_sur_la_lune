#!/bin/bash

# Fichier contenant les URLs
INPUT_FILE="/home/ines/PPE_website_marche_sur_la_lune/URLs/pt_url/pt_url.txt"
OUTPUT_HTML="pt_tableux.html"

# Fonction pour compter les tokens (mots)
function count_tokens() {
    echo "$1" | wc -w
}

# Début du tableau HTML
echo "<!DOCTYPE html>
<html lang=\"fr\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Résultats du traitement</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #f8f9fa; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        a { color: #007BFF; text-decoration: none; }
    </style>
</head>
<body>
    <h1>Résultats du traitement des dumps pour le mot logique en portugais</h1>
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

    # Journalisation de l'URL traitée
    echo "Traitement de l'URL numéro $COUNTER : $url"

    # Récupérer le code HTTP avec curl
    RESPONSE=$(curl -s -I --max-time 10 "$url")
    HTTP_CODE=$(echo "$RESPONSE" | head -n 1 | awk '{print $2}')

    # Vérification si HTTP_CODE est vide ou invalide
    if [[ -z "$HTTP_CODE" ]]; then
        HTTP_CODE="Erreur"
    fi

    # Récupérer le contenu HTML de la page
    CONTENT=$(curl -s --max-time 10 "$url")
    if [[ $? -ne 0 || -z "$CONTENT" ]]; then
        CONTENT=""
        echo "Erreur lors de la récupération du contenu de $url"
    fi

    # Déterminer l'encodage HTML de la page
    ENCODING=$(echo "$CONTENT" | file -bi - | sed -n 's/.*charset=//p')
    if [[ -z "$ENCODING" ]]; then
        ENCODING="Inconnu"
    fi

    # Compter le nombre de tokens dans le contenu
    TOKENS=$(count_tokens "$CONTENT")
    if [[ -z "$TOKENS" || "$TOKENS" -eq 0 ]]; then
        TOKENS="0"
    fi

    # Compter le nombre de paragraphes dans le contenu (compte d'exemple)
    COMPTE=$(echo "$CONTENT" | grep -o "<p" | wc -l)
    if [[ -z "$COMPTE" || "$COMPTE" -eq 0 ]]; then
        COMPTE="0"
    fi

    # Journalisation pour vérifier les valeurs
    echo "Code HTTP: $HTTP_CODE, Encodage: $ENCODING, Tokens: $TOKENS, Compte: $COMPTE"

    # Ajouter les résultats au tableau HTML
    echo "        <tr>
            <td>$COUNTER</td>
            <td><a href=\"$url\" target=\"_blank\">$url</a></td>
            <td>$HTTP_CODE</td>
            <td>$ENCODING</td>
            <td>$TOKENS</td>
            <td>$COMPTE</td>
            <td><a href=\"#\">Contexte</a></td>
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
