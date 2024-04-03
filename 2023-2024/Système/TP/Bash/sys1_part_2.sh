#!/bin/bash



if [ $# -eq 0 ]; then
echo "Veuillez fournir un fichier"
exit
fi

image=$1

if [ ! -f $image ]; then
echo "Le fichier n'existe pas"
exit
fi



echo "Extraction du nom du fichier"
size=$(identify -format "%[fx:min(w,h)]" "$image")


echo "Création des noms des fichiers"
filename=${image%.jpg}"_square.jpg"
filename2=${filename%.jpg}".pdf"

echo "Croping de l'image"
convert -gravity center -crop ${size}X${size}+0+0! "$image" "$filename"

if [ ! -f $filename ]; then
echo "Le fichier intermédiaire n'a pas été créé"
exit
fi

echo "Conversion en PDF"
img2pdf -o "$filename2" --pagesize 10cmx10cm "$filename" 

if [ ! -f $filename2 ]; then
echo "Le fichier final n'a pas été créé"
exit
fi

echo "Fini"