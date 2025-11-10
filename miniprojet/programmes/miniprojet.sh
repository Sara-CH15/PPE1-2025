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

# Début du document HTML
echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo "    <meta charset=\"UTF-8\">"
echo "    <title>Tableau des URLs - Projet Robot</title>"
echo "</head>"
echo "<body>"
echo "    <h1>Tableau des URLs analysées</h1>"
echo "    <table border=\"1\">"
echo "        <tr>"
echo "            <th>Numéro</th>"
echo "            <th>URL</th>"
echo "            <th>Code HTTP</th>"
echo "            <th>Encodage</th>"
echo "            <th>Nombre de mots</th>"
echo "        </tr>"

NUMERO_LIGNE=1

while read -r URL;
do
    # Récupérer le code HTTP
    HTTP_CODE=$(curl -I -L -s -o /dev/null -w "%{http_code}" "$URL")
    
    # Récupérer l'encodage
    ENCODAGE=$(curl -I -L -s "$URL" | grep -i "content-type" | grep -o "charset=[^;]*" | cut -d= -f2 | tr -d '\r\n' | head -n 1)
    
    # Si pas d'encodage trouvé, mettre "N/A"
    if [ -z "$ENCODAGE" ]; then
        ENCODAGE="N/A"
    fi
    
    # Compter les mots
    NB_MOTS=$(lynx -dump -nolist "$URL" 2>/dev/null | wc -w)
    
    # Afficher une ligne du tableau HTML
    echo "        <tr>"
    echo "            <td>${NUMERO_LIGNE}</td>"
    echo "            <td>${URL}</td>"
    echo "            <td>${HTTP_CODE}</td>"
    echo "            <td>${ENCODAGE}</td>"
    echo "            <td>${NB_MOTS}</td>"
    echo "        </tr>"
    
    NUMERO_LIGNE=$((NUMERO_LIGNE + 1))
    
done < "$FICHIER_URLS"

# Fin du document HTML
echo "    </table>"
echo "</body>"
echo "</html>"
