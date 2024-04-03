#!/bin/bash

# j'ai rajouté une condition plûtot utile dans un cas
# si on a un raccourci "test1" un raccourci "test12" et qu'on veut supprimé le premier 
# c'est plus pratique de demandé à l'utiliser laquelle supprimer avec un input (ligne 75 à 99)
# j'ai fait de même pour la commande C (change directory) (ligne 41 à 59)

# Variables globales

FAV=$HOME/.favoris_bash
FAVTEMP=$HOME/.favoris_temp


# vérifie que le fichier fav existe sinon il le crée
function init(){
    if ! [ -f $FAV ]; then
        touch $FAV
    fi
}

function S(){
    init;
    dir=$(pwd); # récupération du dossier courant
    if [ "$(grep "^$1" $FAV)" ]; then
        echo "nom déjà attribué"
    elif [ $# -ge 1 ]; then # on vérifie qu'un nom a été donné
        alias=$(echo ${@:1} | tr " " "-") # si un plusieurs sont donnés il les fusionne (optionnel)
        echo $alias "- >" $dir >> $FAV # sauvegarde
        echo "Le raccouri à été créer"
    fi
}

function C(){
    init;
    file=$(grep "^$1" $FAV) # énumère les raccourcis compatibles
    count=$(grep "^$1" $FAV | wc -l) # compte ces raccourcis
    if ! [ $1 ]; then 
        echo "Veuillez renseigner le nom du raccourci" # s'il n'y a pas d'arguments on demande d'en rentrer un
    elif [ $count -lt 1 ]; then
        echo "Le raccourci n'existe pas" # si count = 0 ça veut dire que le grep à trouver 0 raccourci
    elif [ $count -gt 1 ]; then # ce truc est bonus +++++++++++ ( cas où on veut supprimer une commande "test1" et que "test12" existe aussi)
        echo "Plusieurs raccourcis correspondent à la demande" # si count > 1, il affiche les raccourcis possibles
        grep "^$1" $FAV | nl # on liste les commandes avec des numéros
        count=$(grep "^$1" $FAV | wc -l)
        echo "entrer le numéro de la commande où se téléporter"
        read input
        if [ -n "$input" ] && [ "$input" -eq "$input" ] 2> /dev/null; then 
            if [ $input -le $count ] && [ $input -gt 0 ]; then # si l'entrée est un nombre et est dans la range des commandes compatibles
                line=$(grep "^$1" $FAV | head -n $input | tail -n 1) # on récupère toute la ligne et pas juste le nom

                dir=$(echo $line | cut -d ">" -f 2) # récupère le chemin
                echo "Vous avez été redirigé ici : $dir" 
                cd $dir # on redirige
            else
                echo "le $input n'est pas défini ..."
            fi
        else
            echo "tu aurais dû rentrer un nombre -_-'"
        fi
    else
        dir=$(echo $file | cut -d ">" -f 2) # récupère le chemin
        echo "Vous avez été redirigé ici : $dir" 
        cd $dir # on redirige
    fi
}

function R(){
    init;
    file=$(grep "^$1" $FAV) # liste les raccourcis compatibles
    count=$(grep "^$1" $FAV | wc -l) # les comptes
    if ! [ "$1" ]; then 
        echo "Veuillez renseigner le nom du raccourci" # aucun argument n'est rentré
    elif ! [ "$file" ]; then 
        echo "Le raccourci n'existe pas" # le grep est vide
    elif [ $count -gt 1 ]; then # ce truc est bonus +++++++++++ ( cas où on veut supprimer une commande "test1" et que "test12" existe aussi)
        echo "Plusieurs raccourcis correspondent à la demande" # si count > 1, il affiche les raccourcis possibles
        grep "^$1" $FAV | nl # on liste les commandes avec des numéros
        count=$(grep "^$1" $FAV | wc -l)
        echo "entrer lu numéro de la commande à supprimer"
        read input
        if [ -n "$input" ] && [ "$input" -eq "$input" ] 2> /dev/null; then 
            if [ $input -le $count ] && [ $input -gt 0 ]; then # si l'entrée est un nombre et est dans la range des commandes compatibles
                line=$(grep "^$1" $FAV | head -n $input | tail -n 1) # on récupère toute la ligne et pas juste le nom

                touch $FAVTEMP # je crée un temp
                n=$(grep "$line" $FAV -n | cut -d ":" -f 1) # récupère la ligne 
                min=$[$n-1] # on récupère les indices autour de la ligne
                max=$[$n+1]
                cat $FAV | head -n $min > $FAVTEMP  # on réécrit sans la ligne
                cat $FAV | tail -n +$max >> $FAVTEMP
                mv $FAVTEMP $FAV # on sauvegarde

                echo "Le raccourci à été supprimé"
            else
                echo "le $input n'est pas défini ..."
            fi
        else
            echo "tu aurais dû rentrer un nombre -_-'"
        fi
    else
        touch $FAVTEMP # je crée un temp
        n=$(grep "^$1" $FAV -n | cut -d ":" -f 1) # récupère la ligne 
        min=$[$n-1] # on récupère les indices autour de la ligne 
        max=$[$n+1]
        cat $FAV | head -n $min > $FAVTEMP # on réécrit sans la ligne
        cat $FAV | tail -n +$max >> $FAVTEMP
        mv $FAVTEMP $FAV # on sauvegarde

        echo "Le raccourci à été supprimé"
    fi
}

function L(){
    # commande qui vérifie si un argument est donnée et qui envoie les raccourcis correspondants
   init;
   if [ "$1" ]; then
        grep "^$1" $FAV; # renvoie filtré
   else
        cat $FAV # renvoie tout
   fi
}