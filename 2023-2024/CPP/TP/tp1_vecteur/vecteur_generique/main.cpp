#include "vecteur.h"
#include <iostream>

void modifierVecteur(){
  /* fait un assert si l'indice est en dehors des bornes*/
  Vecteur<float> monVecteur;

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
  Vecteur<float> v1(1);
  v1[0] = 1;

  Vecteur<float> v2(1);
  v2[0] = 2;

  Vecteur<float> v3(1);
  v3[0] = 3;

  Vecteur<float> somme( v1 + v2 + v3 ) ;

  std::cout << v1 ;
  std::cout << v2 ;
  std::cout << v3 ;
  std::cout << somme;

}

void sommeInputDifferents(){
  // sommes des coordonnées

  int dim;
  std::cin >> dim;

  Vecteur<int> v1(dim);
  std::cin >> v1;

  Vecteur<float> v2(dim);
  std::cin >> v2;

  Vecteur somme = v1 + v2 ;

  std::cout << v1 ;
  std::cout << v2 ;
  std::cout << somme;

}

void sommeInput(){
  // sommes des coordonnées

  int dim;
  std::cin >> dim;

  Vecteur<float> v1(dim);
  std::cin >> v1;

  Vecteur<float> v2(dim);
  std::cin >> v2;

  Vecteur somme( v1+v2 );

  std::cout << v1 ;
  std::cout << v2 ;
  std::cout << somme;

}

void sommeInput2(){
  // concaténation de deux string
  int dim;
  std::cin >> dim;

  Vecteur<std::string> v1(dim);
  std::cin >> v1;

  Vecteur<std::string> v2(dim);
  std::cin >> v2;

  Vecteur<std::string> somme( v1 + v2 ) ;

  std::cout << v1 ;
  std::cout << v2 ;
  std::cout << somme;

}

void prodScal(){
  Vecteur<float> v1(3);
  v1[0] = 1;
  v1[1] = 2;
  v1[2] = 3;
  
  std::cout << v1;

  float scal = v1*v1;
  std::cout << scal << std::endl;
}

/* 
  void prodScalString(){
   Vecteur<std::string> v1(3);
   v1[0] = "1";
   v1[1] = "2";
   v1[2] = "3";

   std::cout << v1;
   float scal = v1*v1; // erreur
   std::cout << scal << std::endl;
 }
*/

void prodScalIntFloat(){
  /*
  va soit cast le float en entier ou l'entier en float
  */

  Vecteur<int> v1(3);
  Vecteur<float> v2(3);
  v1[0] = 1;
  v1[1] = 2;

  v2[0] = 1.6;
  v2[1] = 10.33;

  
  std::cout << v1;
  std::cout << v2;

  float scal1 = v1*v2;
  std::cout << scal1 << std::endl;

  float scal2 = v2*v1;
  std::cout << scal2 << std::endl;
}



/** \brief Programme principal */
int main()
{
  /** Insérez votre code ici... */

  // modifierVecteur();
  // somme3vecteurs();
  // prodScal();
  // prodScalString();

  // prodScalIntFloat();

  // sommeInput();
  // sommeInput2();

  sommeInputDifferents();

  return 0 ;
}
