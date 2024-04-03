/** \brief Ce fichier doit contenir l'ensemble des implémentations
relatives à la classe vecteur et aux fonctionnalités la concernant */

#include <cassert>
#include <iostream>
#include "vecteur.h"

// constructeurs
Vecteur::Vecteur(unsigned int dim, float initial): dim(dim),initial(initial) {InitData();}

// get
float & Vecteur::get(const unsigned int & i) const {
    /*
    entrées :
        - un entier non signé, donc positif

    conditions
        - i est dans la plage autorisé

    sorties:
        - un flottant
    
    comportement:
        - renvoie le nombre associé à l'indice
    */
    assert(i < dimensions());

    return *(data + i);
}

void Vecteur::set(const unsigned int & i, const float & val) {
    /*
    entrées :
        - un entier non signé
        - une valeur

    conditions
        - i est dans la plage autorisé
    
    comportement:
        - assigne la valeur à l'indice
    */
    assert(i < dimensions());

    *(data + i) = val;
}

unsigned int Vecteur::dimensions() const {
    /*
    sorties:
        - un entier non signé
    
    comportement:
        - renvoie la dimension
    */
    return dim;
}

void Vecteur::InitData(){
    /*
    conditions
        - dimension est strictement supérieur à 0
    
    comportement:
        - crée un tableau dynamique ⚠️
        - initialise toutes les cases du tableau
    */
    assert(0 < dimensions());

    // affichage des informations du tableau
    std::cout << "Initialisation du vecteur" << std::endl;
    std::cout << "Dimension      : " << dimensions() << std::endl;
    std::cout << "Valeur de base : " << initial << std::endl;
    
    data = new float[dim]; // allocation du tableau dynamique

    // on met toutes les valeurs à initial
    for (unsigned int i = 0; i<dimensions(); i++){
        data[i] = initial;
    }
}

void Vecteur::copy(const Vecteur& old_vector){
    /*
    entrées :
        - un vecteur
    
    comportement:
        - copie old_vecteur dans notre vecteur
    */
    dim = old_vector.dim;
    initial = old_vector.initial;
    data = new float[dim]{initial};

    for (unsigned int i = 0 ; i < dim ; i++){
        data[i] = old_vector.get(i);
    }
}

Vecteur::Vecteur(const Vecteur& old_vector){
    // constructeur de copie qui appelle la methode de copie
    copy(old_vector);
}


Vecteur &Vecteur::operator=(const Vecteur& old_vector){
    // opérateur d'affectation

    delete[] data; // on supprime l'ancien tableau sinon on perd sa référence
    copy(old_vector); // on copie le contenu du vecteur
    return *this; // on renvoie soit même
}

Vecteur Vecteur::operator+(const Vecteur & other_vector){
    // opérateur d'addition
    return add(this,&other_vector); // appelle la fonction add pour faire l'addition
}

float & Vecteur::operator[](unsigned int i) const {
    // opérateur []
    return get(i); // renvoie une référence faire une case, ça permet d'affecter et de récupérer la valeur
}

void afficherVecteur(const Vecteur * v, std::ostream & out){
    // fonction qui affiche un vecteur à partir de son pointeur
    out << "Vecteur(";
    for (unsigned int i = 0 ; i < v->dimensions(); i++){
        out << " " << v->get(i);
    }
    out << " )" << std::endl;
};

Vecteur * lireVecteur(std::istream & in) {
    /*
    condition:
        - dimension > 0

    comportement:
        - crée un vecteur en fonction de l'entrée standard
        - on demande la taille du vecteur
        - on demande toutes les valeurs

    sortie:
        - renvoie le pointeur du vecteur
    */
    std::cout << "Entrez la dimension du vecteur" << std::endl;
    
    unsigned int dim = 1;
    float val;
    in >> dim; // on demande la taille du vecteur

    assert(0 < dim);

    Vecteur * monVecteur = new Vecteur(dim);

    for (unsigned int i = 0; i < dim; i++){
        std::cout << "Entrez la valeur numéro " << i << std::endl; // on demande une valeur pour chaque indice
        in >> val;
        monVecteur->set(i,val);
    }

    return monVecteur;
}

Vecteur add(const Vecteur * v1, const Vecteur * v2){
    /*
    Fonction qui addition deux vecteurs

    entrées:
        - deux pointeurs de vecteurs 
    
    conditions:
        - dimensions similaires des vecteurs

    sorties:
        - un vecteur contenant la somme des deux vecteurs

    comportement:
        - crée un vecteur, et on additionne case par case chaque vecteur

    */
    assert( v1 -> dimensions() == v2 -> dimensions() );

    unsigned int dim = v1 -> dimensions();

    Vecteur monVecteur(dim); // nouveau vecteur

    for (unsigned int i = 0; i < dim; i++){
        float val = v1 -> get(i) + v2 -> get(i); // somme case par case
        monVecteur.set(i,val); // set la valeur dans notre vecteur somme
    }

    return monVecteur;
};

Vecteur::~Vecteur(){
    delete[] data; // on supprime le tableau dynamique
}

float operator*(const Vecteur & v1,const Vecteur & v2){
    /*
    Fonction qui fait le produit scalaire entre 2 vecteurs
    
    entrée:
        - deux références de vecteurs

    sortie:
        - renvoie un flottant
    */
    assert(v1.dimensions() == v2.dimensions()); // vérif les dimensions
    
    float s = 0.0;

    for ( unsigned int i=0;i<v1.dimensions();i++){
        s+=v1.get(i)*v2.get(i); // on multiplie chaque chaque case de même indice, qu'on ajoute à la somme
    }

    return s;
}

std::ostream& operator<<(std::ostream &out,const Vecteur & v){
    /*
    Fonction qui affiche un vecteur avec <<
    */
    afficherVecteur(&v,out);
    return out;
}

std::istream& operator>>(std::istream &in,Vecteur & v){
    /*
    Fonction qui initialise un vecteur avec >>

    condition :
        - le vecteur doit avoir une dimension déjà défini
    */
    float val;

    // tout pareil que le lireVecteur
    for (unsigned int i = 0; i < v.dimensions(); i++){
        std::cout << "Entrez la valeur numéro " << i << std::endl;
        in >> val;
        v.set(i,val);
    }

    return in;
}