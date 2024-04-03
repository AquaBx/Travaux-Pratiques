#!/bin/bash

image=$1

echo "Extraction du nom du fichier"
size=$(identify -format "%[fx:min(w,h)]" "$image")

echo "Création des noms des fichiers"
filename=${image%.jpg}"_square.jpg"
filename2=${filename%.jpg}".pdf"

echo "Croping de l'image"
convert -gravity center -crop ${size}X${size}+0+0! "$image" "$filename"

echo "Conversion en PDF"
img2pdf -o "$filename2" --pagesize 10cmx10cm "$filename" 

echo "Fini"