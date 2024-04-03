#!/bin/bash

TACHES=$HOME/.todo_list
TEMP=$HOME/.todo_temp

function todo(){

if ! [ -f $TACHES ]; then
    touch $TACHES
fi

if ! [ $1 ]; then
    echo "Erreur, veuillez entrée une commande"
elif [ $1 = "list" ]; then
    nl -s " - " $TACHES
elif [ $1 = "add" ]; then
    if [ $# -ge "3" ]; then
        min=$[$2-1]
        head --lines $min $TACHES >> $TEMP
        echo ${@:3} >> $TEMP
        tail --lines +$2 $TACHES >> $TEMP
        cat $TEMP > $TACHES
        rm $TEMP
        echo "La tâche (${@:3}) a été ajoutée en position $2"
    else
        echo "Pas assez d'arguments"
    fi
elif [ $1 = "done" ]; then
    min=$[$2-1]
    max=$[$2+1]
    ta=$(head -n $2 $TACHES| tail -n 1)
    head --lines $min $TACHES >> $TEMP
    tail --lines +$max $TACHES >> $TEMP
    cat $TEMP > $TACHES
    rm $TEMP
    echo "La tâche $2 ($ta) est faite"
else
    echo "Commande non reconnu"
fi

}