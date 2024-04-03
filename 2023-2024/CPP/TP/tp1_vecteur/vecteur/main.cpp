#include "vecteur.h"
#include <iostream>

void modifierVecteur(){
  /* fait un assert si l'indice est en dehors des bornes*/
  Vecteur monVecteur;

  std::cin >> monVecteur;

  std::cout << monVecteur;


  int i,val;
  std::cout << "Entrez l'indice à modifier " << std::endl;
  std::cin >> i;
  std::cout << "Entrez la nouvelle valeur " << std::endl;

  std::cin >> val;
  monVecteur[i] = val;

  std::cout << monVecteur;

}

void somme3vecteurs(){
  Vecteur v1(1);
  v1[0] = 1;

  Vecteur v2(1);
  v2[0] = 2;

  Vecteur v3(1);
  v3[0] = 3;

  Vecteur somme( v1 + v2 + v3 ) ;

  std::cout << v1 ;
  std::cout << v2 ;
  std::cout << v3 ;
  std::cout << somme;

}

void prodScal(){
  Vecteur v1(3);
  v1[0] = 1;
  v1[1] = 2;
  v1[2] = 3;
  
  std::cout << v1;

  float scal = v1*v1;
  std::cout << scal << std::endl;
}


/** \brief Programme principal */
int main()
{
  /** Insérez votre code ici... */

  // modifierVecteur();
  // somme3vecteurs();
  // prodScal();



  return 0 ;
}
