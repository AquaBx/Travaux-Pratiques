#!/bin/bash


# vérification du dictionnaire
dict=$1
if ! [ $# = 1 ]; then
    echo veuillez rentrer seulement un dictionnaire en argument
    exit 0
elif ! [ -f $dict ] ; then
    echo veuillez rentrer un vrai dictionnaire en argument
    exit 0
fi

# on génère le mot aléatoire : max pour le nombre de ligne du dico, index le numéro de ligne tiré au hasard
max=$(wc -l < $dict);
index=$[($RANDOM % $max) + 1 ];
mot=$(head -n $index $dict | tail -n 1)

# variables globales avec "alpha" les lettres non testées et "test" les testées
alpha="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
test=""
i=1

function show(){
    # affiche le mot avec des -------
    mot2=$(echo $mot | tr $alpha "-")
    echo $mot2
}

function draw(){
    # fonction qui affiche le dessin en fonction du nombre de pénalités
    if [ $1 -eq 1 ]; then
        echo -e "\n\n\n\n\n___ ___";
    elif [ $1 -eq 2 ]; then
        echo -e "\n   |\n   |\n   |\n   |\n___|___"
    elif [ $1 -eq 3 ]; then
        echo -e "    _____\n   |\n   |\n   |\n   |\n___|___"
    elif [ $1 -eq 4 ]; then
        echo -e "    _____\n   |     |\n   |\n   |\n   |\n___|___"
    elif [ $1 -eq 5 ]; then
        echo -e "    _____\n   |     |\n   |     O\n   |\n   |\n___|___"
    elif [ $1 -eq 6 ]; then
        echo -e "    _____\n   |     |\n   |     O\n   |     |\n   |\n___|___"
    elif [ $1 -eq 7 ]; then
        echo -e "    _____\n   |     |\n   |     O\n   |    /|\n   |\n___|___"
    elif [ $1 -eq 8 ]; then
        echo -e "    _____\n   |     |\n   |     O\n   |    /|\ \n   |\n___|___"
    elif [ $1 -eq 9 ]; then
        echo -e "    _____\n   |     |\n   |     O\n   |    /|\ \n   |    /\n___|___"
    elif [ $1 -eq 10 ]; then
        echo -e "    _____\n   |     |\n   |     O\n   |    /|\ \n   |    / \ \n___|___"
    fi
}

function guess(){
    # fonction qui fait plein de vérification avant de jouer la lettre entrée

    plus=$(echo $1| wc -m); # nombre de caractères entrées
    if [ $plus = "1" ]; then
        echo "Veuillez rentrer une lettre"
    elif [ $plus -gt "2" ]; then
        echo "Veuillez rentrer une seule lettre"
    elif [ "$(echo $test | grep $1)" ]; then # vérifie qu'elle n'est pas testée
        echo "Veuillez rentrer une lettre non donnée précedemment";
    elif ! [ "$(echo $alpha | grep $1)" ]; then # comme elle est ni dans test ni dans alpha alors c'est un caractère non valable
        echo "Veuillez rentrer une lettre qui existe";
    elif ! [ $(echo $mot | grep $1) ]; then # si la lettre n'est pas dans le mot
        i=$[$i+1]  # on rajoute 1 au score et on rajoute la lettre aux testées
        test="$test $1"
    else # sinon on affiche la lettre du mot caché
        alpha=$(echo $alpha | tr -d $1)
        mot2=$(echo $mot | tr $alpha "-")
        test="$test $1"
    fi
}

echo "*****************************************"

while [ $i -le 9 ]; do
    # boucle du jeu
    draw $i; # on affiche le dessin
    echo ""
    echo "Lettres testés : $test"
    echo ""
    show;
    echo ""
    echo "Choisir une lettre :"
    read nlettre; # on attend une lettre
    guess $nlettre; # on fait les vérifications

    if [ $mot = $mot2 ]; then 
        echo "Vous avez gagné"
        i="11"
    elif [ $i = 10 ]; then # 10 correspond à la pendaison
        draw $i;
        echo "Vous avez perdu"
        echo "le mot était $mot"
    fi
    echo "*****************************************"
done