
# **Ce fichier est consacré aux suivis du projet**
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

## Du 23/12/2024 au 28/12/2024
### Arabe et Français
    - Récupération des URLs et uniformisation des contenus des pages en arabe et en français.
    - Création de scripts Bash pour le traitement des deux langues.
    - Analyse textométrique des fichiers dumps à l'aide de Voyant Tools (génération de nuages de mots, graphes, collocations, etc.), avec tentative d'intégration de ces résultats dans les sections dédiées à l'arabe et au français.
    - Développement du script make_pals_corpus.sh pour la tokenisation des fichiers dumps et des fichiers contextuels. Cependant, un doute subsiste car les instructions de l'exercice semblent indiquer l'utilisation de fichiers Python, tandis que mon script génère des fichiers au format TXT.
    - Création d'un fichier HTML pour intégrer les données partagées, sous réserve de validation par les autres membres du groupe.
    - Réflexion sur la présentation du site afin de concilier ergonomie, utilité et esthétique.

## Du 28/12/2024 au 29/12/2024
### Arabe et Français

- Réogranisatioin du dépôt afin de respecter l'aoborescence demandé dans les exercices;
- Verification de l'exactitude de mon travail;
- Gestion de conflis git; ce que je trouve le plus dificile à faire algré la simplicité de la tâche; 

## Du 26/12/2024 au 31/12/2024
### Portugais
- recuperation des URLS
- uniformization des pages web (aspirations aussi)
- creation du script pour génerer le tableaux (il génere directement les concordances et les contextes et les dumps)
- en bref j 'ai fait la premier feuille d'exercices pendant cette semaine , le script m'a pris beaucoup de temps à tout génerer bien.  

## 30/12/2024
### anglais
- la tokenization de dump et de contexte, création du script make pals
- problèmes : au début j'ai récupéré plus de 50 url et j'ai fais les dumps et les contextes mais sur le tableaux je n'utilise que 50, il faut que je modifie les dumps et les contextes ainsi que leur html

## Du 25/12/2024 au 31/12/2024
### chinois
- Création de scripts shell pour sauvegarder le contenu des URL en chinois sous forme de dump-text et d’aspiration 
- Extraction d’informations (comme les codes HTTP) à partir des scripts, sauvegarde dans un fichier CSV et conversion en tableau HTML 
- Modification d’un script Python fourni par le professeur pour effectuer la segmentation des textes chinois et segmentation de tout le contenu 
- Analyse des textes segmentés pour calculer la fréquence des mots et créer un document de contexte 
- Développement d’un script pour établir des concordances 
- Implémentation d’un script pour la PALS (Pattern Analysis and Linguistic Search) 

## Du 02/01/2024 au 07/01/2025
### portugais
- j'ai commencé à faire la feuille d'exercices 2:
- j'ai fais des scripts pour mettre les concordances et les dumps tous dans un seul fichier pour chaque.
- j'ai nettoyé le fichier dumps pour retirer choses inutiles (links ...).
- j'ai fais le nuage, les coocurrents et les partitions en adaptent le script python de Yifan MIAO pour le portugais et mes besoins.

## 07/01/2025
### anglais
- Réunion de groupe pour résoudre les problèmes de structure et discuter sur la philosophie de notre page groupe, les possible d'outils d'analyse de textométrie comme worldcloud.
- Réger les liens absolus en relatifs. **attention** Pour utiliser les liens relatifs `..`, il faut assurer que le fichier ne se situe pas dans un sous dossier d'un dossier. Sinon il faut ajouter des `.`

## 08/01/2025
### anglais
- Création du dossier sites_groupe pour mettre les html et les css pour la page groupe

## 11/01/2025
### anglais
- fini des html ainsi les redirections. Pour notre page chaque langue a un index.html qui propose de naviguer dans les langues différentes à travers la navigation langues, et si l'utilisateur clique Acceuil, il va être redirigé vers la page de la langue correspondante, par défaut, notre site affiche la langue française. Cette séparation de langue a le but de faciliter les travaux et d'éviter des conflits de chemins.
<<<<<<< HEAD


##29/12/24 au 12/01/25

## Travail accompli

### 1. Création et structuration des fichiers et dossiers
- Mise en place de l'arborescence de projet conformément aux exigences du projet :
  - Dossiers : `aspirations`, `dumps-text`, `contextes`, `programmes`, `tableaux`, etc.
  - 
### 2. Développement des sites web
- Création de deux sites web en **HTML** avec une interface en **CSS**.
- Implémentation d'une navigation intuitive et d'un design adapté aux cinq langues : **anglais** **arabe**  **chinois** **français** et **portugais**
- Collaboration avec les autres groupes pour discuter et harmoniser la mise en forme des sites.

### 3. Gestion des scripts Bash
- Écriture de scripts Bash pour :
  - Aspirer les pages HTML à partir des URL fournies.
  - Extraire et traiter les dumps textuels avec `lynx`.
  - Automatiser le formatage des fichiers pour l'analyse textométrique.
- **Refonte du script Bash** : Le premier script ne respectait pas les consignes des exercices, j'ai donc dû tout refaire en respectant les attentes précisées.

### 4. Analyse linguistique
- Analyse approfondie des corpus en **arabe** et **français** à l'aide de VoyantTools :
  - Extraction et comptage des occurrences des termes étudiés.
  - Récupération des contextes d’apparition avec `grep`.
  - Création de concordanciers en HTML via `sed`, avec un tableau structuré en trois colonnes.

### 5. Collaboration et résolution de problèmes
- **Gestion des chemins de fichiers :** Avec l’aide de notre camarade **Xingyu CHEN**, qui a su garder son calme face aux conflits sur notre dépôt Git, nous avons résolu les problèmes liés aux chemins relatifs et absolus dans le projet.
- **Discussions en groupe :** Organisation d'appels avec les autres membres du groupes pour coordonner la mise en forme du site et résoudre des problèmes techniques.

### 6. Textométrie avec PALS
- Prétraitement des données pour les adapter au format attendu par PALS.
- Création et exécution de scripts Bash dédiés (`make_pals_corpus.sh`) pour générer les fichiers nécessaires (dumps et contextes) dans les deux langues.

---

## Problèmes rencontrés et solutions
- **Encodage des fichiers en arabe :** Conversion en UTF-8 pour éviter les erreurs d’affichage.
- **URLs non valides :** Ajout de messages d'erreur pour les requêtes échouées et exclusion automatique des pages invalides.
- **Tokenisation :** Adaptation manuelle des méthodes pour respecter les spécificités des deux langues.
- **Conflits Git :** Résolution efficace des conflits grâce à des discussions d'équipe et une bonne gestion des rôles.

---

## Étapes suivantes
1. Finaliser , paufiner et amélioer les analyses lingustiques de la langue arabe et du français.
2. Tester et valider les chemins à nouveau.
=======
### Git Strucutre
- La conversion de notre git en page web a echoué et stucked la main branche, donc j'ai créé une nouvelle branche nommée new_main pour les futurs travaux. Pour la documentation :  https://github.com/orgs/community/discussions/49074
- Pas de dossier contenant un environement virtuel dans dans git si on veut le convertir en une page web.

## Du 08/01/2025 au 11/01/2025
### portugais
- j'ai commencé à travailler sur le site web du portugais (j'ai fais tous les pages : accueil, tableaux, script, analyse et à propos).

>>>>>>> new_main
