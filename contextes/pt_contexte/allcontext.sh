#!/bin/bash

# Chemin vers le dossier contenant les contexte
context_FOLDER="/home/ines/PPE_website_marche_sur_la_lune/contextes/pt_contexte"

# Fichier de sortie unique
OUTPUT_FILE="all_context.txt"

# Fusionner tous les fichiers texte dans un seul fichier
cat "$context_FOLDER"/*.txt > "$OUTPUT_FILE"

echo "Tous les contextes ont été fusionnés dans $OUTPUT_FILE"
