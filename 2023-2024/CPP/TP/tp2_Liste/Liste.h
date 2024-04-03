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

    
    void nettoyer(){
        taille=0;
        Chainon * cp = sentinelle.next();

        while (cp != &sentinelle) {
            Chainon * cp2 = cp -> next();
            delete cp;
            cp = cp2;       
        } ;
    }

public:
    class const_iterator {
        private :
            const Chainon * pointer;
            const Chainon * sentinelle;

            friend class Liste;

            const_iterator(const Chainon *sentinelle,const Chainon *ptr) : pointer(ptr),sentinelle(sentinelle) {}

        public:
            ~const_iterator() {}

            const_iterator &operator++() {
                assert(pointer->next() != pointer);

                pointer = pointer->next();
                return *this;
            }

            const_iterator &operator--() {
                assert(pointer->previous() != pointer);

                pointer = pointer->previous();
                return *this;
            }

            const T &operator*() const {
                assert(sentinelle!=pointer);
                return pointer->data();
            }

            const T *operator->() const {
                assert(sentinelle!=pointer);
                return &(pointer->data());
            }

            bool operator==(const_iterator droite) const {
                return pointer == droite.pointer;
            }

            bool operator!=(const_iterator droite) const {
                return pointer != droite.pointer;
            }
    };

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

    Liste() {}

    Liste(const Liste<T> & old) {
        const_iterator ptr = old.begin();

        while (ptr != old.end()){
            push_back(*ptr);
            ++ptr;
        }
    }

    Liste & operator=(const Liste<T> & old) {

        if (this == &old) return *this;

        nettoyer();

        const_iterator ptr = old.begin();

        while (ptr != old.end()){
            push_back(*ptr);
            ++ptr;

        }

        return *this;
    }

    Liste<T> operator+(const Liste<T> & old) {

        Liste<T> nlist = Liste(*this);

        const_iterator ptr = old.begin();

        while ( ptr != old.end() ) {
            nlist.push_back(*ptr);
            ++ptr;
        }

        return nlist;
        // return *this;
    }

    ~Liste() {
        nettoyer();
    }

    unsigned int size() const {
        return taille;
    }

    bool empty() const {
        return size() == 0;
    }

    T &front() {
        assert(!empty());
        return sentinelle.next()->data();
    }

    const T &front() const {
        assert(!empty());
        return sentinelle.next()->data();
    }

    T &back() {
        assert(!empty());
        return sentinelle.previous()->data();
    }

    const T &back() const {
        assert(!empty());
        return sentinelle.previous()->data();
    }

    void push_front(T data) {
        Chainon * temp = new Chainon();
        sentinelle.insertAfter(temp);
        temp->data() = data;
        taille++;
    }

    void push_back(T data) {
        Chainon * temp = new Chainon();

        sentinelle.insertBefore(temp);
        temp -> data() = data;
        taille++;
    }

    void pop_front() {
        assert(size() > 0);

        sentinelle.next()->detach();
        taille--;
    }

    void pop_back() {
        assert(size() > 0);

        sentinelle.previous()->detach();
        taille--;
    }

    const_iterator begin() const {
        Chainon *pt = sentinelle.next();
        return const_iterator(&sentinelle,pt);
    }

    const_iterator end() const {
        return const_iterator(&sentinelle,&sentinelle);
    }

    iterator begin() {
        Chainon * pt = sentinelle.next();
        return iterator(&sentinelle,pt);
    }

    iterator end() {
        return iterator(&sentinelle,&sentinelle);
    }
    
    iterator insert( iterator position , const T & x ){
        assert(&sentinelle == position.sentinelle);

        Chainon * temp = new Chainon();
        position.pointer -> insertBefore(temp);
        temp->data() = x;
        taille++;
        
        return iterator(&sentinelle,temp);
    }

    iterator erase ( iterator position ){
        assert(!empty());
        assert(&sentinelle==position.sentinelle);

        iterator temp = iterator(&sentinelle,position.getPointer() -> next());

        position.getPointer() -> detach();

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