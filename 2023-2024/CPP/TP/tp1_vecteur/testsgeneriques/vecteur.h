/** \brief Ce fichier doit contenir la déclaration de la classe vecteur
    Attention, elle ne doit contenir aucune implémentation de méthode / fonction
*/

#ifndef _VECTEUR_H
#define _VECTEUR_H

#include <iostream>
#include <cassert>
// Déclaration de la classe vecteur


template <class T>
class Vecteur {
// T doit avoir un constructeur par défaut



private :
  // attributs
  unsigned int dim;
  T initial;
  T * data;

public :
  // prototypes des constructeurs et autres méthodes publiques

    // constructeurs
    Vecteur(unsigned int dim=3, T initial=T()): dim(dim),initial(initial) {InitData();}

    Vecteur(const Vecteur<T>& old_vector){
    /*
        entrées :
            - un vecteur
        
        comportement:
            - copie old_vecteur dans notre vecteur
        */
        copy(old_vector);
    };

    template <typename U>
    Vecteur(const Vecteur<U>& old_vector){
        /*
        entrées :
            - un vecteur de type U castable en T
        
        comportement:
            - copie old_vecteur dans notre vecteur
        */
        copy(old_vector);
    };

    ~Vecteur(){
        delete[] data; // on supprime le tableau dynamique
    }

    Vecteur &operator=(const Vecteur<T>& old_vector){
        // opérateur d'affectation

        delete[] data; // on supprime l'ancien tableau sinon on perd sa référence
        copy(old_vector); // on copie le contenu du vecteur
        return *this; // on renvoie soit même
    }

    Vecteur operator+(const Vecteur<T> & other_vector){
        // opérateur d'addition
        return add(this,&other_vector); // appelle la fonction add pour faire l'addition
    }

    T & operator[](unsigned int i) const {
        // opérateur []
        return get(i); // renvoie une référence faire une case, ça permet d'affecter et de récupérer la valeur
    }

    T & get(const unsigned int & i) const {
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

    void set(const unsigned int & i, const T & val) {
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

    unsigned int dimensions() const {
        /*
        sorties:
            - un entier non signé
        
        comportement:
            - renvoie la dimension
        */
        return dim;
    }

    T getInitial() const {
        /*
        sorties:
            - un T
        
        comportement:
            - renvoie la valeur par défaut
        */
        return initial;
    }

private :
  // méthodes privées d'implémentation (si besoin)


    template <typename U>
    void copy(const Vecteur<U>& old_vector){
        /*
        entrées :
            - un vecteur
        
        comportement:
            - copie old_vecteur dans notre vecteur
        */
        dim = old_vector.dimensions();
        initial = (T)old_vector.getInitial();
        data = new T[dim]{initial};

        for (unsigned int i = 0 ; i < dim ; i++){
            data[i] = (T)old_vector.get(i);
        }
    }

    // methode pour initialiser mon vecteur
    void InitData(){
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
        
        data = new T[dim];  // allocation du tableau dynamique

        // on met toutes les valeurs à initial
        for (unsigned int i = 0; i<dimensions(); i++){
            data[i] = initial;
        }
    }
    };

// Prototypes des fonctions

template <class T>
void afficherVecteur(const Vecteur<T> * v, std::ostream & out){
    // fonction qui affiche un vecteur à partir de son pointeur
    out << "Vecteur(";
    for (unsigned int i = 0 ; i < v->dimensions(); i++){
        out << " " << v->get(i);
    }
    out << " )" << std::endl;
};

template <class T>
Vecteur<T> * lireVecteur(std::istream & in) {
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
    in >> dim;  // on demande la taille du vecteur

    assert(0 < dim);

    Vecteur<T> * monVecteur = new Vecteur<T>(dim);

    for (unsigned int i = 0; i < dim; i++){
        std::cout << "Entrez la valeur numéro " << i << std::endl;
        in >> val;
        monVecteur->set(i,val);
    }

    return monVecteur;
}

template <class T>
Vecteur<T> add(const Vecteur<T> * v1, const Vecteur<T> * v2){
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

    Vecteur<T> monVecteur(dim);  // nouveau vecteur

    for (unsigned int i = 0; i < dim; i++){
        T val = v1 -> get(i) + v2 -> get(i);  // somme case par case
        monVecteur.set(i,val); // set la valeur dans notre vecteur somme
    }

    return monVecteur;
};

template <class T1,class T2>
T1 operator*(const Vecteur<T1> & v1,const Vecteur<T2> & v2){
    /*
    Fonction qui fait le produit scalaire entre 2 vecteurs
    
    entrée:
      - deuxl!== v2.dimensions()); // vérif les dimensions
    
    T1 s = 0;

    for ( unsigned int i=0;i<v1.dimensions();i++){
        s+=v1.get(i)*v2.get(i); // on multiplie chaque chaque case de même indice, qu'on ajoute à la somme
    }

    return s;
}

template <class T>
std::ostream& operator<<(std::ostream &out,const Vecteur<T> & v){
    /*
    Fonction qui affiche un vecteur avec <<
    */
    afficherVecteur(&v,out);
    return out;
}

template <class T>
std::istream& operator>>(std::istream &in,Vecteur<T> & v){
    /*
    Fonction qui initialise un vecteur avec >>

    condition :
        - le vecteur doit avoir une dimension déjà défini
        - T doit être affichable
    */
    T val;
    
    // tout pareil que le lireVecteur
    for (unsigned int i = 0; i < v.dimensions(); i++){
        std::cout << "Entrez la valeur numéro " << i << std::endl;
        in >> val;
        v.set(i,val);
    }

    return in;
}

#endif