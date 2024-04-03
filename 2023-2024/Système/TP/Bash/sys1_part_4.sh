#!/bin/bash

tmpDir="./img_tmp"
album="./album.pdf"

function imageTraitement
{
    if [ $# -eq 0 ]; then
    echo "Veuillez fournir un fichier"
    exit
    fi

    local image=$1

    if [ ! -f $image ]; then
    echo "Le fichier n'existe pas"
    exit
    fi

    echo "Extraction du nom du fichier"
    local size=$(identify -format "%[fx:min(w,h)]" "$image")

    echo "Création des noms des fichiers"

    local tmpfn=$( echo $image | rev | cut -d '/' -f 1 | rev)


    local filename=${tmpfn%.jpg}"_square.jpg"
    local filename2=${filename%.jpg}".pdf"

    echo $tmpfn

    echo "Croping de l'image"
    convert -gravity center -crop ${size}X${size}+0+0! "$image" "$tmpDir/$filename"

    if [ ! -f $tmpDir/$filename ]; then
    echo "Le fichier intermédiaire n'a pas été créé"
    exit
    fi

    echo "Conversion en PDF"
    img2pdf -o "$tmpDir/$filename2" --pagesize 10cmx10cm "$tmpDir/$filename" 

    if [ ! -f $tmpDir/$filename2 ]; then
    echo "Le fichier final n'a pas été créé"
    exit
    fi

    echo "Fini"
}

function boucle
{
    local images="$@"

    if [ -d $tmpDir ]; then
        echo "Le dossier temporaire existe déjà"
        exit
    fi

    echo "Création du dossier temporaire"
    mkdir $tmpDir

    for image in $images; do
        echo Traitement de "$image"
        imageTraitement "$image"
        echo ""
    done

    echo "Création de l'album"

    if [ -f $album ]; then
        echo "Un album existe déjà"
    else
        pdfunite $tmpDir/*.pdf $album
    fi

    echo "Supression du dossier temporaire"
    rm -fr $tmpDir
}

boucle "$@"