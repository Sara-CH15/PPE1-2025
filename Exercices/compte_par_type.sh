#!/bin/bash

# Script qui compte les entités d'un type donné pour une année donnée
# Usage: ./compte_par_type.sh ANNEE TYPE
# Exemple: ./compte_par_type.sh 2016 Location

# Validation du nombre d'arguments
if [ $# -ne 2 ]; then
    echo "Erreur: Il faut exactement 2 arguments" >&2
    echo "Usage: $0 ANNEE TYPE" >&2
    exit 1
fi

annee=$1
type=$2

# Validation de l'année
if ! [[ "$annee" =~ ^(2016|2017|2018)$ ]]; then
    echo "Erreur: L'année doit être 2016, 2017 ou 2018" >&2
    exit 1
fi

# Validation du type (non vide)
if [ -z "$type" ]; then
    echo "Erreur: Le type d'entité ne peut pas être vide" >&2
    exit 1
fi

# Compter les occurrences du type dans les fichiers .ann de l'année
grep -h "$type" ~/exercice1/ann/"$annee"/*.ann 2>/dev/null | wc -l
