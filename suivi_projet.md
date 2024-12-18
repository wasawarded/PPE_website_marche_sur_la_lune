# Ce fichier est consacré aux suivis du projet
## 18/12/2024
### text anglais
- Transformer les textes dumps non utf-8 en utf-8 : curl permet de récupérer à la fois les métadonnées et les textes, avec l'option -o on peut les enregistrer dans notre ordinateur, puis utiliser lynx to récupérer les informations qui nous intéressent avec les html récupérés, au lieu de naviguer encore une fois avec les urls
- la fonction de lynx avec option -o. syntave lynx -f xx -t xx path -o path pas à mélanger avec les `< >`
- la fonction de curl avec l'option -o, cette option va sauvegarder tout ce que le curl a récupéré au début, si par exemple, on veut les entếtes l'expression soit curl -i -o path, si on ne veut pas, curl -o path
- Création des folders et les textes vides
- n'oublie pas de mettre les suffixes après les file html, sinon navigateur comme lynx ne peut pas reconnaitre qu'il s'agit d'un fichier html
- fini pour 18/12/2024 : fini de script pour lire les url, récupère les urls et enregistre les dump files en anglais
