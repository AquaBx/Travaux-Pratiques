#include "Liste.h"

/**
   3.2.1 chercher une valeur dans une liste triée, nom de la fonction fonction : chercherTri
   @param premier : itérateur positionné sur le premier élément
   @param dernier : itérateur positionné après le dernier élément
   @param x : valeur à chercher
   @return position du premier élément de valeur >= x
   ou end() si un tel élément n'existe pas
 */
// TODO
template<class InputIterator , class T>
InputIterator chercherTri(InputIterator premier, InputIterator dernier, T x){
   while (premier != dernier){
      if (*premier >= x) {
         return premier;
      }
      ++premier;
   }
   return premier;
}

/**
   3.2.2 créer une copie triée par valeurs croissantes d'une liste, nom de la fonction fonction : copierTri
   @param l : liste à copier
   @return liste triée
*/
// TODO
template<class T>
Liste<T> * copierTri(Liste<T> l){
   Liste<T> * newliste = new Liste<T>();
   for (auto ptr = l.begin(); ptr != l.end(); ++ptr) {
      auto wheretoinsert = chercherTri(newliste->begin(),newliste->end(),*ptr);
      newliste->insert(wheretoinsert,*ptr);
   }

   return newliste;
}