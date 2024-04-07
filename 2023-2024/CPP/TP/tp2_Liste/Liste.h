#include "cyclicNode.h"
#include <cassert>
#include <iostream>

#ifndef _LISTE_H_
#define _LISTE_H_

template<class T>
class Liste {
    typedef DataStructure::cyclicNode<T> Chainon;

protected:
    Chainon sentinelle = Chainon();
    unsigned int taille = 0;

    // méthode qui va nettoyer la liste, il va supprimer chaque chainon en boucle
    void nettoyer(){
        taille=0;
        Chainon * cp = sentinelle.next();

        while (cp != &sentinelle) {
            Chainon * cp2 = cp -> next();
            delete cp;
            cp = cp2;       
        } ;
    }

    // méthode qui va ajouter tout les éléments de begin à end dans liste
    template<class Iter>
    void copy(Liste & liste , Iter begin, Iter end ){
        while (begin != end){
            liste.push_back(*begin);
            ++begin;
        }
    }

public:
    class const_iterator {
        private :
            const Chainon * pointer;
            const Chainon * sentinelle;

            friend class Liste; // notre liste peut accéder aux attributs de l'itérator

            // constructeur privé
            const_iterator(const Chainon *sentinelle,const Chainon *ptr) : pointer(ptr),sentinelle(sentinelle) {}

        public:
            // destructeur, très utile
            ~const_iterator() {}

            // opérateur d'incrémentation, on pointe sur le suivant
            const_iterator &operator++() {
                assert(pointer->next() != pointer);

                pointer = pointer->next();
                return *this;
            }

            // opérateur de décrémentation, on pointe sur le previous
            const_iterator &operator--() {
                assert(pointer->previous() != pointer);

                pointer = pointer->previous();
                return *this;
            }

            // opérator de déréférencement, on déréférence la donnée
            const T &operator*() const {
                assert(sentinelle!=pointer);
                return pointer->data();
            }

            // opérator de flèche, on revnoie l'adresse de la donnée
            const T *operator->() const {
                assert(sentinelle!=pointer);
                return &(pointer->data());
            }

            // opérateur égalité, on compare si les iterator pointe sur la meme chose
            bool operator==(const_iterator droite) const {
                return pointer == droite.pointer;
            }

            // opérateur non égalité, on compare si les iterator pointe pas sur la meme chose
            bool operator!=(const_iterator droite) const {
                return pointer != droite.pointer;
            }
    };

    // tout pareil que const_iterator, mais en non constant
    class iterator {
        private :
            Chainon * pointer;
            Chainon * sentinelle;

            friend class Liste;

            iterator(Chainon *sentinelle,Chainon *ptr) : pointer(ptr),sentinelle(sentinelle) {}

            Chainon * getPointer(){
                return pointer;
            } 

        public:
            ~iterator() {}

            iterator &operator++() {
                assert(pointer->next() != pointer);

                pointer = pointer->next();
                return *this;
            }

            iterator &operator--() {
                assert(pointer->previous() != pointer);

                pointer = pointer->previous();
                return *this;
            }

            T &operator*() const {
                assert(sentinelle!=pointer);
                return pointer->data();
            }

            T *operator->() const {
                assert(sentinelle!=pointer);
                return &(pointer->data());
            }

            bool operator==(iterator droite) const {
                return pointer == droite.pointer;
            }

            bool operator!=(iterator droite) const {
                return pointer != droite.pointer;
            }
    };

    /* Constructeur très utile :) */
    Liste() {}

    /* Constructeur de copie */
    Liste(const Liste<T> & old) {
        copy(*this,old.begin(),old.end());
    }

    /* Opérateur d'affectation */
    Liste & operator=(const Liste<T> & old) {

        if (this == &old) return *this; // on vérifie qu'on est pas nous même

        nettoyer(); // on nettoie nos chainons

        copy(*this,old.begin(),old.end()); // on copie

        return *this;
    }

    /* Opérateur de concaténation */
    Liste<T> operator+(const Liste<T> & old) {

        Liste<T> nlist = Liste(*this); // on copie nous même

        copy(nlist,old.begin(),old.end()); // ajoute copie tout de old dans nlist

        return nlist;
    }

    // Destructeur
    ~Liste() {
        nettoyer();
    }

    // méthode pour récupérer la taille
    unsigned int size() const {
        return taille;
    }

    // méthode pour savoir si la liste est vide
    bool empty() const {
        return size() == 0;
    }

    // méthode pour get le premier élément
    T &front() {
        assert(!empty());
        return sentinelle.next()->data();
    }

    // méthode pour get le premier élément en readonly
    const T &front() const {
        assert(!empty());
        return sentinelle.next()->data();
    }

    // méthode pour get le dernier élément
    T &back() {
        assert(!empty());
        return sentinelle.previous()->data();
    }

    // méthode pour get le dernier élément en readonly
    const T &back() const {
        assert(!empty());
        return sentinelle.previous()->data();
    }

    // méthode pour ajouté un élément au début de la liste
    void push_front(T data) {
        Chainon * temp = new Chainon();
        sentinelle.insertAfter(temp);
        temp->data() = data;
        taille++;
    }

    // méthode pour ajouté un élément à la fin de la liste
    void push_back(T data) {
        Chainon * temp = new Chainon();

        sentinelle.insertBefore(temp);
        temp -> data() = data;
        taille++;
    }

    // méthode pour supprimer le premier élément
    void pop_front() {
        assert(size() > 0);

        delete sentinelle.next();
        taille--;
    }

    // méthode pour supprimer le dernier élément
    void pop_back() {
        assert(size() > 0);

        delete sentinelle.previous();
        taille--;
    }

    // renvoie un const itérator sur le premier élément
    const_iterator begin() const {
        Chainon *pt = sentinelle.next();
        return const_iterator(&sentinelle,pt);
    }

    // renvoie un const itérator sur la fin de liste (sentinelle)
    const_iterator end() const {
        return const_iterator(&sentinelle,&sentinelle);
    }

    // renvoie un itérator sur le premier élément
    iterator begin() {
        Chainon * pt = sentinelle.next();
        return iterator(&sentinelle,pt);
    }

    // renvoie un itérator sur la fin de liste (sentinelle)
    iterator end() {
        return iterator(&sentinelle,&sentinelle);
    }
    
    // méthode pour inserer une donnée juste avant l'itérator donnée
    iterator insert( iterator position , const T & x ){
        assert(&sentinelle == position.sentinelle);

        Chainon * temp = new Chainon();
        position.pointer -> insertBefore(temp);
        temp->data() = x;
        taille++;
        
        return iterator(&sentinelle,temp);
    }

    // méthode pour supprimer le chainon où l'iterator pointe
    iterator erase ( iterator position ){
        assert(!empty());
        assert(&sentinelle==position.sentinelle);

        iterator temp = iterator(&sentinelle,position.getPointer() -> next());

        delete position.getPointer();

        taille--;

        return temp;
    }
};

template<class T>
std::ostream & operator<<(std::ostream & os, const Liste<T> & old) {
    os << "<";
    for (auto ptr = old.begin(); ptr != old.end(); ++ptr) {
        os << *ptr << " ";
    }
    os << ">";

    return os;
}

template<class InputIterator , class T>
InputIterator find( InputIterator premier, InputIterator dernier , const T & x ){
    while (premier != dernier){
        if (*premier == x) {
            return premier;
        }
        ++premier;
    }
    return dernier;
}

#endif