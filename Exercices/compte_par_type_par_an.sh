#!/bin/bash

# Script qui affiche le compte d'un type d'entité pour chaque année
# Usage: ./compte_par_type_par_an.sh TYPE
# Exemple: ./compte_par_type_par_an.sh Location

# Validation du nombre d'arguments
if [ $# -ne 1 ]; then
    echo "Erreur: Il faut exactement 1 argument" >&2
    echo "Usage: $0 TYPE" >&2
    exit 1
fi

type=$1

# Validation du type (non vide)
if [ -z "$type" ]; then
    echo "Erreur: Le type d'entité ne peut pas être vide" >&2
    exit 1
fi

# Boucle sur les trois années
for annee in 2016 2017 2018; do
    compte=$(bash ~/PPE1-2025/Exercices/compte_par_type.sh "$annee" "$type")
    echo "$annee\t$compte\t$type"
done
