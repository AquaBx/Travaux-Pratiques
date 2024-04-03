#include "Liste.h"
#include <stdio.h>
#include <deque>
#include "copier.h"

int main(){
  Liste<double> liste1;
  Liste<double> liste2;
  liste1.push_back(3.14159);

  // Liste<double> * l2 = copierTri(liste1); // ok

  // liste2=*l2; // ok

  // Liste l3(*l2); ok

  // Liste l4 = *l2 + liste1 + *l2; //ok

  delete l2;
}