/*
 * main.cpp
 *
 *  Created on: 8 mars 2013
 *      Author: engel
 */

#include "constantes.h"
#include "enregistreur_fichier.h"
#include "enregistreur_fichier_texte.h"
//#include "harmonique.h"
#include "signal_constant.h"

void
q2_signal_constant()
{
  signal_constant constant(0.5);
  enregistreur_fichier_texte enregistreur("02_constant.txt", 1);
  enregistreur.connecterEntree(constant.getSortie(0), 0);
  // générer des valeurs
  for (unsigned int i = 0; i < 50; ++i) {
    constant.calculer();
    enregistreur.calculer();
  }
}
/*
void
q4_harmonique()
{
  harmonique la440(440); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)
  enregistreur_fichier enregistreur("04_harmonique.raw", 1);	// fichier mono
  enregistreur.connecterEntree(la440.getSortie(0), 0);
  // produire 2 secondes de son
  for (unsigned long int i = 0; i < 2 * MixageSonore::frequency; ++i) {
    la440.calculer();
    enregistreur.calculer();
  }
}
*/
int
main()
{
  q2_signal_constant();
  //  q4_harmonique();
  return 0;
}
