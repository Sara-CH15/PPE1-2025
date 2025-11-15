#!/bin/bash

# Vérifier qu'on a un argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <fichier_urls>" >&2
    exit 1
fi

FICHIER_URLS=$1

# Vérifier que le fichier existe
if [ ! -f "$FICHIER_URLS" ]; then
    echo "Erreur: le fichier $FICHIER_URLS n'existe pas" >&2
    exit 1
fi

# En-tête du tableau TSV
echo -e "NUMERO\tURL\tCODE_HTTP\tENCODAGE\tNB_MOTS"

NUMERO_LIGNE=1

while read -r URL;
do
    # Récupérer les en-têtes HTTP avec curl
    # -I : seulement les en-têtes
    # -L : suivre les redirections
    # -s : mode silencieux (pas de barre de progression)
    # -o /dev/null : on ne garde pas le contenu
    # -w : format de sortie personnalisé
    HTTP_CODE=$(curl -I -L -s -o /dev/null -w "%{http_code}" "$URL")
    
    # Récupérer l'encodage depuis les en-têtes
    ENCODAGE=$(curl -I -L -s "$URL" | grep -i "content-type" | grep -o "charset=[^;]*" | cut -d= -f2 | tr -d '\r\n' | head -n 1)
    
    # Si pas d'encodage trouvé, mettre "N/A"
    if [ -z "$ENCODAGE" ]; then
        ENCODAGE="N/A"
    fi
    
    # Récupérer le contenu textuel avec lynx et compter les mots
    NB_MOTS=$(lynx -dump -nolist "$URL" 2>/dev/null | wc -w)
    
    # Afficher la ligne du tableau
    echo -e "${NUMERO_LIGNE}\t${URL}\t${HTTP_CODE}\t${ENCODAGE}\t${NB_MOTS}"
    
    NUMERO_LIGNE=$((NUMERO_LIGNE + 1))
    
done < "$FICHIER_URLS"
