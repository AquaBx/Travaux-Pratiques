/** \brief Ce fichier doit contenir la déclaration de la classe vecteur
    Attention, elle ne doit contenir aucune implémentation de méthode / fonction
*/


#ifndef _VECTEUR_H
#define _VECTEUR_H

#include <iostream>
// Déclaration de la classe vecteur
class Vecteur {
private :
  // attributs
  unsigned int dim;
  float initial;
  float * data;


public :
  // prototypes des constructeurs et autres méthodes publiques

  Vecteur(unsigned int dim=3, float initial=0.0);

  Vecteur(const Vecteur& old_vector);
  ~Vecteur();
  Vecteur &operator=(const Vecteur& old_vector);
  Vecteur operator+(const Vecteur & other_vector);

  float & operator[](unsigned int i) const;

  float & get(const unsigned int & i) const;
  
  void set(const unsigned int & i, const float & val);

  unsigned int dimensions() const;

private :
  // méthodes privées d'implémentation (si besoin)

  // methode pour la copie et l'affectation  
  void copy(const Vecteur& old_vector);


  // methode pour initialiser mon vecteur
  void InitData();
};

// Prototypes des fonctions

void afficherVecteur(const Vecteur * v, std::ostream & out = std::cout);
std::ostream& operator<<(std::ostream & out, const Vecteur & v);

Vecteur * lireVecteur(std::istream & in = std::cin);
std::istream& operator>>(std::istream &in, Vecteur & v);

Vecteur add(const Vecteur * v1, const Vecteur * v2);

float operator*(const Vecteur & v1,const Vecteur & v2);

#endif
