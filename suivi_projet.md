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
## 26/12/2024
### anglais
- création des contextes en html
- création de script pour générer les concordance en html, pour le sed, j'ai pas très bien compris sa fonction
- création de tableaux mais pour les liens contexte et les liens Concordances, ce sont les liens locaux, les autres ne peuvent pas y avoir access

##Du 23/12/2024 au 28/12/2024
###arabe et français
- Récupérations des urls, uniformatisation des contenus des pages en arbe et en français;
- création de script bash pour les deux langues;
- analyse textométrique des fichiers dumps par voyant tools (créations, de nuage de mot, graphe, collocations,..) que j'essaye d'intégrer à la partie réserser à là l'arabe et au français;
- création du script make_pals_corpus.sh pour la tokinisation des fichiers dumps et context.Mais j'ai un doute car les indications de la feuille d'exercie font allusions des fichiers python or, le script que j'ai génère des fichiers txt.
- création d'un html afin d'fintégrer nos données en communs si le html a l'aval des autres membres du groupe;
- réfléchir à la maninière de présenter notre site pour allier érognomie, utilité, et élégance.
