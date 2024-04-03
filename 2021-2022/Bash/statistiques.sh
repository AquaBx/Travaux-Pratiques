#!/bin/bash

function statistiques(){
    dir=$(pwd) # dossier courant
    taille=$(du 2>/dev/null -h | tail -n 1 | cut -d "." -f 1) # taille du dossier courant
    dir=$(find . -type d 2>/dev/null | wc -l) # nombre de dossiers
    files=$(find . -type f 2>/dev/null | wc -l) # nombre de fichiers
    dhide=$(find . -name ".*" -type d 2>/dev/null | wc -l) # nombre de dossiers cachés
    fhide=$(find . -name ".*" -type f 2>/dev/null | wc -l ) # nombre de fichiers cachés
    dempty=$(find . -type d -empty 2>/dev/null | wc -l) # nombre de dossiers vides
    fempty=$(find . -type f -empty 2>/dev/null | wc -l) # nombre de fichiers vides

    if ! [ $1 ] || [ $1 = 1 ] ; then
        echo Nombre de dossiers : $dir
        echo Nombre de fichiers : $files
        echo Taille : $taille
    elif [ $1 = 2 ]; then
        echo Nombre de dossier $dir
        echo "  -"Nombre de dossier cachés : $dhide
        echo "  -"Nombre de dossier vides : $dempty
        echo Nombre de fichier $files
        echo "  -"Nombre de fichier cachés : $fhide
        echo "  -"Nombre de fichiers vides : $fempty
        echo Taille : $taille
    elif [ $1 = 3 ];then

        # cherche les fichiers par extension
        jpeg=$(find . -name "*.jpeg" -type f 2>/dev/null | wc -l)
        png=$(find . -name "*.png" -type f 2>/dev/null | wc -l)
        bmp=$(find . -name "*.bmp" -type f 2>/dev/null | wc -l)
        py=$(find . -name "*.py" -type f 2>/dev/null | wc -l)
        mov=$(find . -name "*.mov" -type f 2>/dev/null | wc -l)
        mp4=$(find . -name "*.mp4" -type f 2>/dev/null | wc -l)
        mkv=$(find . -name "*.mkv" -type f 2>/dev/null | wc -l)
        avi=$(find . -name "*.avi" -type f 2>/dev/null | wc -l)
    
        # cherche les fichier de moins de 512k et de plus de 15M
        lthan=$(find . -type f -size -512k 2>/dev/null | wc -l)
        gthan=$(find . -type f -size +15M 2>/dev/null | wc -l)

        #cherhce le plus gros fichier
        bigfile=$(find . -type f -exec du -a {} + | sort -n -k 1 | tail -n 1 | awk '{print $2}')
        
        # compte les fichiers par catégories
        img=$[$jpeg+$png+$bmp]
        vid=$[$mov+$mp4+$mkv+$avi]


        echo Nombre de dossier $dir
        echo "  -"Nombre de dossier cachés : $dhide
        echo "  -"Nombre de dossier vides : $dempty
        echo Nombre de fichier $files
        echo "  -"Nombre de fichier cachés : $fhide
        echo "  -"Nombre de fichiers vides : $fempty
        echo "  -"Nombre de fichier de moins de 512Kio : $lthan
        echo "  -"Nombre de fichiers de plus de 15Mio : $gthan
        echo "  -"Le plus gros fichier est : $bigfile
        echo Il y a :
        echo "  -"Nombre de fichier python : $py
        echo "  -"Nombre de vidéos : $vid
        echo "  -"Nombre d\'images : $img
        echo Taille $taille
    fi
}