Journal de bord du Projet encadré
Séance 1: introduction à Git 
Date : 05/10/2025
travail réalisé : 
  création du compte GitHub
  création du dépôt PPE1-2025
  Configuration de SSH pour la connexion sécurisée
  Clonage du dépôt en local
  Découverte des commandes de base : git status, git pull, git log
  Création et modification du journal de bord.
Difficultés rencontrées: 
  -manque de connaissance en informatique.
Solutions : 
  -j'ai demandé de l'aide de mes amis, et j'ai fais des recherches personnelles.
 #Ces derniers jours, j’ai rencontré plusieurs difficultés avec mon système Linux. En effet, mon ordinateur ne détecte pas la carte Wi-Fi intégrée, ce qui m’a empêché de me connecter à Internet. La seule solution que j’ai trouvée a été d’acheter une clé Wi-Fi externe pour pouvoir continuer à travailler.

Un autre problème que je rencontre est lié à mon niveau en informatique : comme je ne suis pas encore très à l’aise avec certains outils et commandes, je prends souvent du retard par rapport à mes camarades. Par exemple, lors de la séance du 8/10, je n’ai pas pu suivre le cours en temps réel, car je devais encore terminer les exercices de la séance précédente.

J’espère progressivement combler mon retard et mieux comprendre le fonctionnement de Linux et des outils que nous utilisons. Avec un peu de pratique et d’aide, je suis sûr(e) que je vais finir par m’en sortir !
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

