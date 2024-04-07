#include "Liste.h"

/**
   3.2.1 chercher une valeur dans une liste triée, nom de la fonction fonction : chercherTri
   @param premier : itérateur positionné sur le premier élément
   @param dernier : itérateur positionné après le dernier élément
   @param x : valeur à chercher
   @return position du premier élément de valeur >= x
   ou end() si un tel élément n'existe pas
 */
template<class InputIterator , class T>
InputIterator chercherTri(InputIterator premier, InputIterator dernier, T x){
   while (premier != dernier){ // on itère sur tout
      if (*premier >= x) {
         return premier; // si on trouve un supérieur on sort
      }
      ++premier; // sinon on incrémente
   }
   return premier; // on retourne premier = dernier
}

/**
   3.2.2 créer une copie triée par valeurs croissantes d'une liste, nom de la fonction fonction : copierTri
   @param l : liste à copier
   @return liste triée, ⚠️ il faut la delete après utilisation
*/
template<class T>
Liste<T> * copierTri(Liste<T> l){
   Liste<T> * newliste = new Liste<T>(); // on créer une liste
   for (auto ptr = l.begin(); ptr != l.end(); ++ptr) {
      // désolé pour les auto, mais ça m'énervait :)
      auto wheretoinsert = chercherTri(newliste->begin(),newliste->end(),*ptr); // on cherche où est premier nombre supérieur à x
      newliste->insert(wheretoinsert,*ptr); // on insert le nombre juste avant wheretoinsert
   }

   return newliste;
}