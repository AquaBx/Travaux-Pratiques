#!/bin/bash

# arguments d'entrée : file pour le csv et folder pour le dossier des comptes

file=$1
folder=$2

if [ -f $file ]; then
if  [ -d $folder ]; then # on vérifie que le dossier et le fichier existe
cat $file | while read LINE; do
    # on prend la 1ere valeur ( le nom ), on lui enlève les caractères spéciaux et on garde 8 caractères
    name1=$(echo "$LINE" | cut -d ";" -f 1)
    name2=$(echo $name1 | tr -d "'")
    name3=$(echo $name2 | tr -d " ")
    name=$(echo "$name3" | cut -c 1,2,3,4,5,6,7)

    # on prend la 2eme valeur (prenom), on lui enlève les caractères spéciaux et on garde 2 caractères
    pre1=$(echo "$LINE" | cut -d ";" -f 2)
    pre2=$(echo $pre1 | tr -d "'")
    pre3=$(echo $pre2 | tr -d " ")
    pre=$(echo "$pre3" | cut -c 1,2)

    pseudo=$pre$name #on crée le pseudo

    #création des dossiers et sous-dossiers
    mkdir "$folder/$pseudo"
    mkdir "$folder/$pseudo/Documents"
    mkdir "$folder/$pseudo/Images"

    # génération du mot de passe: on charge urandom, on garde que les lettres et on en garde une, on fait ça 4 fois et on les concatènes
    l0=$(head /dev/urandom | tr -dc zrtpqsdfghjklmwxcvbn | cut -c 1)
    l1=$(head /dev/urandom | tr -dc aeyuio | cut -c 1)
    l2=$(head /dev/urandom | tr -dc zrtpqsdfghjklmwxcvbn | cut -c 1)
    l3=$(head /dev/urandom | tr -dc aeyuio | cut -c 1)
    num=$(head /dev/urandom | tr -dc 0-9 | cut -c 1,2,3,4)
    mdp="$l0$l1$l2$l3$num"
    echo $mdp > "$folder/$pseudo/mot_de_passe.txt"
done
else
    echo "Veuillez rentrer un dossier existant"
fi
else
    echo "Veuillez rentrer un fichier csv existant"
fi