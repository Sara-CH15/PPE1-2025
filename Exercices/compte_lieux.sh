#!/bin/bash

# Script qui établit le classement des lieux les plus cités
# Usage: ./compte_lieux.sh ANNEE MOIS NOMBRE
# Exemple: ./compte_lieux.sh 2016 01 10
# Utiliser * pour année ou mois : ./compte_lieux.sh "*" "*" 10

# Validation du nombre d'arguments
if [ $# -ne 3 ]; then
    echo "Erreur: Il faut exactement 3 arguments" >&2
    echo "Usage: $0 ANNEE MOIS NOMBRE" >&2
    exit 1
fi

annee=$1
mois=$2
nombre=$3

# Validation de l'année
if [ "$annee" != "*" ] && ! [[ "$annee" =~ ^(2016|2017|2018)$ ]]; then
    echo "Erreur: L'année doit être 2016, 2017, 2018 ou *" >&2
    exit 1
fi

# Validation du mois
if [ "$mois" != "*" ] && ! [[ "$mois" =~ ^(0[1-9]|1[0-2])$ ]]; then
    echo "Erreur: Le mois doit être entre 01 et 12 ou *" >&2
    exit 1
fi

# Validation du nombre (doit être un entier positif)
if ! [[ "$nombre" =~ ^[0-9]+$ ]] || [ "$nombre" -le 0 ]; then
    echo "Erreur: Le nombre doit être un entier positif" >&2
    exit 1
fi

# Construire le chemin en fonction des arguments
if [ "$annee" = "*" ] && [ "$mois" = "*" ]; then
    chemin=~/exercice1/ann/*/*/*.ann
elif [ "$annee" = "*" ]; then
    chemin=~/exercice1/ann/*/"$mois"*.ann
elif [ "$mois" = "*" ]; then
    chemin=~/exercice1/ann/"$annee"/*.ann
else
    chemin=~/exercice1/ann/"$annee"/"$mois"*.ann
fi

# Extraire les locations, les compter et afficher le top N
grep -h "Location" $chemin 2>/dev/null | \
    cut -f3 | \
    sort | \
    uniq -c | \
    sort -nr | \
    head -n "$nombre"
