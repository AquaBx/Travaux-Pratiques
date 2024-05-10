/*
 * main.cpp
 *
 *  Created on: 8 mars 2013
 *      Author: engel
 */

#include "constantes.h"
#include "enregistreur_fichier.h"
#include "enregistreur_fichier_texte.h"
#include "harmonique.h"
#include "multiplicateur.h"
#include "signal_constant.h"
#include <iostream>

void
q2_signal_constant()
{
	signal_constant constant(0.5);
	enregistreur_fichier_texte enregistreur("02_constant.txt", 1);
	enregistreur.connecterEntree(constant.getSortie(0), 0);
	// générer des valeurs
	for (unsigned int i = 0; i < 50; ++i)
	{
		constant.calculer();
		enregistreur.calculer();
	}
}


void
q4_harmonique()
{

	harmonique la440(440); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)
	harmonique la880(880); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)
	multiplicateur multiplicat;

  enregistreur_fichier enregistreur("04_harmonique.raw", 1);	// fichier mono


  auto sortie1 = la440.getSortie(0);
  multiplicat.connecterEntree(sortie1,0);
  auto sortie2 = la880.getSortie(0);
  multiplicat.connecterEntree(sortie2,1);


  auto sortie = multiplicat.getSortie(0);
  enregistreur.connecterEntree(sortie, 0);
  // produire 2 secondes de son
  for (unsigned long int i = 0; i < 2 * MixageSonore::frequency; ++i) {
    la440.calculer();
	la880.calculer();
	multiplicat.calculer();
    enregistreur.calculer();
  }

}

int
main()
{
	q2_signal_constant();
	q4_harmonique();
	return 0;
}

int
WinMain()
{
	return main();
}
