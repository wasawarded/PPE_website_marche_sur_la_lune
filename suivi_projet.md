# Ce fichier est consacré aux suivis du projet
## 18/12/2024
### text anglais
- Transformer les textes dumps non utf-8 en utf-8 : curl permet de récupérer à la fois les métadonnées et les textes, avec l'option -o on peut les enregistrer dans notre ordinateur, puis utiliser lynx to récupérer les informations qui nous intéressent avec les html récupérés, au lieu de naviguer encore une fois avec les urls
- la fonction de lynx avec option -o. syntave lynx -f xx -t xx path -o path pas à mélanger avec les `< >`
- la fonction de curl avec l'option -o, cette option va sauvegarder tout ce que le curl a récupéré au début, si par exemple, on veut les entếtes l'expression soit curl -i -o path, si on ne veut pas, curl -o path
- Création des folders et les textes vides
- n'oublie pas de mettre les suffixes après les file html, sinon navigateur comme lynx ne peut pas reconnaitre qu'il s'agit d'un fichier html
- pour 18/12/2024 : fini de script pour lire les url, récupère les codes http  et enregistre les dump files en anglais
- en dump 80, ce fichier est en forma pdf
## 24/12/2024
### anglais
- Pour le tableau, j'ai pas compris quelle sera sa structure 
- commence le comptage du mot logic pour chaque page. fini le script comptage 
- attention à la syntaxe de grep : `grep -e pattern path`, après -e ce qui suit doit être le pattern, si on écrit `grep -e -o pattern path`, on aura une erreur
- pour chercher les lignes : `grep -x`, -x signifie line regexp. Option `-A=` permet de délimiter combien de lignes arpès notre pattern, et `-B=` signigie avant. 
- pour 24/12/2024 fini de contexte script et de comptage script, pour construire les concordances, il faut suivre le pals exercice