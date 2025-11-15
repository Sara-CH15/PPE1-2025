##Journal de bord du Projet encadré
##Séance 1: introduction à Git 
##Date : 05/10/2025
##travail réalisé : 
  - création du compte GitHub
  - création du dépôt PPE1-2025 - Configuration de SSH pour la connexion sécurisée
  - Clonage du dépôt en local
  - Découverte des commandes de base : git status, git pull, git log
  - Création et modification du journal de bord.
##Difficultés rencontrées: 
  - manque de connaissance en informatique.
##Solutions : 
  - j'ai demandé de l'aide de mes amis, et j'ai fais des recherches personnelles.
##Problèmes rencontrés:
- Ces derniers jours, j’ai rencontré plusieurs difficultés avec mon système Linux. En effet, mon ordinateur ne détecte pas la carte Wi-Fi intégrée, ce qui m’a empêché de me connecter à Internet.
- La seule solution que j’ai trouvée a été d’acheter une clé Wi-Fi externe pour pouvoir continuer à travailler.
- Un autre problème que je rencontre est lié à mon niveau en informatique : comme je ne suis pas encore très à l’aise avec certains outils et commandes, je prends souvent du retard par rapport à mes camarades.
- Par exemple, lors de la séance du 8/10, je n’ai pas pu suivre le cours en temps réel, car je devais encore terminer les exercices de la séance précédente.
- J’espère progressivement combler mon retard et mieux comprendre le fonctionnement de Linux et des outils que nous utilisons. Avec un peu de pratique et d’aide, je suis sûr(e) que je vais finir par m’en sortir !
## les exercices à la maison ! - Exercices 2 et 3 : Scripts avec arguments et validation

### Objectifs
- Créer des scripts bash acceptant des arguments
- Implémenter la validation des arguments
- Utiliser les scripts de manière modulaire (un script qui appelle un autre)

### Travail accompli

#### Exercice 2.a : Comptes par type d'entité
J'ai créé deux scripts :
1. **compte_par_type.sh** : Compte les entités d'un type donné pour une année spécifique
   - Prend 2 arguments : année et type d'entité
   - Retourne simplement un nombre
   
2. **compte_par_type_par_an.sh** : Affiche les comptes pour les trois années
   - Prend 1 argument : le type d'entité
   - Appelle compte_par_type.sh trois fois (pour 2016, 2017, 2018)
   - Produit un formatage similaire à l'exercice 1

#### Exercice 2.b : Classement des lieux
J'ai créé le script **compte_lieux.sh** qui :
- Prend 3 arguments : année, mois et nombre de lieux à afficher
- Accepte le wildcard "*" pour l'année et le mois
- Établit un classement des lieux les plus cités

#### Exercice 3 : Validation des arguments
J'ai ajouté des validations à tous les scripts :
- Vérification du nombre d'arguments
- Validation des valeurs (années entre 2016-2018, mois entre 01-12)
- Messages d'erreur clairs envoyés sur stderr
- Code de sortie approprié (exit 1) en cas d'erreur

### Problèmes rencontrés et solutions

#### Problème 1 : Chemins des fichiers
**Problème** : Initialement, mes scripts retournaient 0 pour tous les comptes car ils ne trouvaient pas les fichiers .ann
**Cause** : Les scripts utilisaient des chemins relatifs (*/"$annee"/*.ann) alors que mes données sont dans ~/exercice1/ann/
**Solution** : J'ai modifié tous les scripts pour utiliser le chemin absolu ~/exercice1/ann/"$annee"/*.ann

#### Problème 2 : Appel de script depuis un autre script
**Problème** : Le script compte_par_type_par_an.sh ne trouvait pas compte_par_type.sh
**Erreur** : "./compte_par_type.sh: No such file or directory"
**Cause** : Le script utilisait un chemin relatif ./compte_par_type.sh qui ne fonctionnait pas depuis le dossier parent
**Solution** : J'ai utilisé le chemin absolu : bash ~/PPE1-2025/Exercices/compte_par_type.sh

##Analyse du code de la diapositive du cours
- Le script est un fichier avec une liste d'URL il vérifie s'il commence par "//http" ou "//https"
1. Vérifier qu'on a un argument:
if [ $# -ne 1 ]
then
    echo "ce programme demande un argument"
    exit
fi
- Cela signifie si le nombre d'argument n'est pas 1, affiche une erreur.
2. Initialiser les compteurs
FICHIER_URLS=$1
OK=0
NOK=0
- FICHIER_URLS=$1 veut dire: je stocke le nom du fichier qu'on m'a donné
- OK=0 et NOK=0 signifie: je crée deux compteurs à 0 pour compter les bonnes et mauvaises URLs
3. La boucle while
while read -r LINE;
do
    echo "la ligne: $LINE"
    ...
done < $FICHIER_URLS
- C'est la partie que j'ai trouvée un peu compliquée au début.

- while read -r LINE: lis le fichier ligne par ligne, chaque ligne va dans la variable LINE
- -r: ignore les backslashes (pour pas les interpréter)
- done < $FICHIER_URLS:  dit à bash de lire depuis ce fichier.
4. Tester si c'est une URL valide
if [[ $LINE =~ ^https?:// ]]
then
    echo "ressemble à une URL valide"
    OK=$(expr $OK + 1)
else
    echo "ne ressemble pas à une URL valide"
    NOK=$(expr $NOK + 1)
fi
- Ici on teste avec une expression régulière : ^https?://
- Je crois que c'est un peu comme un pattern, un modèle à reconnaître :

- ^ = début de la ligne
- https? = "http" suivi peut-être d'un "s" (c'est ce que fait le ?)
- :// = les vrais caractères "://"

- Si c'est bon, on ajoute 1 à OK sinon à NOK.
5. Afficher le résultat
echo "$OK URLs et $NOK lignes douteuses"
- À la fin il dit combien d'URLs valides et invalides il a trouvées.

## Mini-projet 1 : Collecte d'URLs

#### Exercice 1 - Question 1 : Pourquoi ne pas utiliser cat ?

- Nous utilisons une boucle `while read` plutôt que la commande `cat` pour plusieurs raisons :

1. **Traitement ligne par ligne** : `cat` affiche tout le contenu d'un fichier en une seule fois, sans possibilité de traiter chaque ligne individuellement. Avec `while read`, nous pouvons traiter chaque URL une par une.

2. **Ajout d'informations** : Notre script doit ajouter des métadonnées pour chaque URL (numéro de ligne, code HTTP, encodage, nombre de mots). Cela nécessite de traiter chaque ligne séparément.

3. **Construction du tableau** : La boucle `while read` nous permet de construire progressivement notre tableau TSV en ajoutant les colonnes nécessaires pour chaque URL.

- En résumé, `cat` sert à afficher un fichier, tandis que `while read` permet de traiter et transformer les données ligne par ligne.

#### Script réalisé

Le script `miniprojet.sh` permet de :
- Lire un fichier d'URLs passé en paramètre
- Valider que le fichier existe
- Pour chaque URL, récupérer : le code HTTP, l'encodage, et le nombre de mots
- Générer un tableau au format TSV avec toutes ces informations
## Mini-projet 2 : Transformation en HTML

### Objectif
Transformer la sortie tabulaire TSV en tableau HTML pour une visualisation dans un navigateur web.

### Travail réalisé
- Modification du script `miniprojet.sh` pour générer du HTML au lieu de TSV
- Ajout de la structure HTML complète (DOCTYPE, head, body)
- Création d'un tableau HTML avec :
  - En-tête avec les colonnes : Numéro, URL, Code HTTP, Encodage, Nombre de mots
  - Une ligne par URL analysée
- Suppression du fichier TSV du dépôt
- Le fichier généré est `tableau-fr.html` et peut être ouvert dans n'importe quel navigateur

### Changements par rapport au mini-projet 1
- Remplacement de `echo -e "...\t..."` par des balises HTML `<tr>`, `<td>`
- Ajout de l'en-tête HTML avec charset UTF-8
- Ajout d'un titre H1 pour le tableau
- Attribut `border="1"` pour visualiser les bordures du tableau
## Mini-projet 3 : Création d'un site GitHub Pages

### Objectif
Créer un site web avec une page d'accueil et publier le projet sur GitHub Pages.

### Travail réalisé
- Création d'une page d'accueil `index.html` à la racine du dépôt
- Présentation du projet avec description claire
- Lien vers le tableau des résultats
- Amélioration du tableau HTML avec style personnalisé
- Déploiement du site sur GitHub Pages
- Résolution de problèmes techniques (submodule Git)

### Site web
Le site est accessible à : https://Sara-CH15.github.io/PPE1-2025

### Difficultés rencontrées
- Erreur de submodule Git (dossier PPE1-2025 dans PPE1-2025)
- Solution : suppression du dossier en double avec `git rm`
