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
#include "operationBinaire.h"
#include "volume.h"
#include "mixeur.h"
#include <vector>
#include "volume_compose.h"
#include <iostream>
#include "lecteur_fichier.h"


void q2_signal_constant() {
	signal_constant constant(0.5);
	enregistreur_fichier_texte enregistreur("02_constant.txt", 1);
	enregistreur.connecterEntree(constant.getSortie(0), 0);
	// générer des valeurs
	for (unsigned int i = 0; i < 50; ++i) {
		constant.calculer();
		enregistreur.calculer();
	}
}

void q4_harmonique() {
	harmonique la440(440); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)

	enregistreur_fichier enregistreur("04_harmonique.raw", 1);	// fichier mono

	auto sortie = la440.getSortie(0);
	enregistreur.connecterEntree(sortie, 0);

	// produire 2 secondes de son
	for (unsigned long int i = 0; i < 2 * MixageSonore::frequency; ++i) {
		la440.calculer();
		enregistreur.calculer();
	}

}

void q8_harmonique() {

	harmonique la440(440); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)
	harmonique la880(880); // la 880Hz (voir fr.wikipedia.org/wiki/Note_de_musique)
	multiplicateur multiplicat;

	enregistreur_fichier enregistreur("08_multiply.raw", 1);	// fichier mono

	multiplicat.connecterEntree(la440.getSortie(0), 0);
	multiplicat.connecterEntree(la880.getSortie(0), 1);

	enregistreur.connecterEntree(multiplicat.getSortie(0), 0);
	// produire 2 secondes de son
	for (unsigned long int i = 0; i < 2 * MixageSonore::frequency; ++i) {
		la440.calculer();
		la880.calculer();
		multiplicat.calculer();
		enregistreur.calculer();
	}

}

void q10_harmonique() {
	harmonique la440(440); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)
	harmonique la880(880); // la 880Hz (voir fr.wikipedia.org/wiki/Note_de_musique)
	operationBinaire<std::multiplies<double>> multiplicat;

	enregistreur_fichier enregistreur("10_multiply.raw", 1);	// fichier mono

	multiplicat.connecterEntree(la440.getSortie(0), 0);
	multiplicat.connecterEntree(la880.getSortie(0), 1);

	enregistreur.connecterEntree(multiplicat.getSortie(0), 0);
	// produire 2 secondes de son
	for (unsigned long int i = 0; i < 2 * MixageSonore::frequency; ++i) {
		la440.calculer();
		la880.calculer();
		multiplicat.calculer();
		enregistreur.calculer();
	}
}

void q12_harmonique() {
	harmonique la440(440); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)
	volume leVolume(0.1);

	enregistreur_fichier enregistreur("12_harmonique.raw", 1);	// fichier mono

	leVolume.connecterEntree(la440.getSortie(0), 1);
	enregistreur.connecterEntree(leVolume.getSortie(0), 0);

	// produire 2 secondes de son
	for (unsigned long int i = 0; i < 2 * MixageSonore::frequency; ++i) {
		la440.calculer();
		leVolume.calculer();
		enregistreur.calculer();
	}
}

void q14_harmonique() {
	harmonique la440(440); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)

	volume_compose leVolume(0.1);
	leVolume.connecterEntree(la440.getSortie(0), 0);

	enregistreur_fichier enregistreur("14_harmonique.raw", 1);
	enregistreur.connecterEntree(leVolume.getSortie(0), 0);

	// produire 2 secondes de son
	for (unsigned long int i = 0; i < 2 * MixageSonore::frequency; ++i) {
		la440.calculer();
		leVolume.calculer();
		enregistreur.calculer();
	}

}

void q16_harmonique() {
	harmonique la440(440); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)
	harmonique la880(880); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)
	harmonique la900(900); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)

	std::vector<float> les_volumes;
	les_volumes.push_back(0.5);
	les_volumes.push_back(1);
	les_volumes.push_back(0.3);

	mixeur le_mixeur(3, les_volumes);
	le_mixeur.connecterEntree(la440.getSortie(0), 0);
	le_mixeur.connecterEntree(la880.getSortie(0), 1);
	le_mixeur.connecterEntree(la900.getSortie(0), 2);

	enregistreur_fichier enregistreur("16_harmonique.raw", 1);
	enregistreur.connecterEntree(le_mixeur.getSortie(0), 0);

	// produire 2 secondes de son
	for (unsigned long int i = 0; i < 2 * MixageSonore::frequency; ++i) {
		la440.calculer();
		la880.calculer();
		la900.calculer();
		le_mixeur.calculer();
		enregistreur.calculer();
	}
}

void q17_harmonique() {
	lecteur_fichier mon_fichier("./raw/mono.raw",1); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)

	enregistreur_fichier enregistreur("17_harmonique.raw", 1);
	enregistreur.connecterEntree(mon_fichier.getSortie(0), 0);

	// produire 2 secondes de son
	while (!mon_fichier.isEndFile()) {
		mon_fichier.calculer();
		enregistreur.calculer();
	}
}

int main() {

	q2_signal_constant();
	q4_harmonique();
	q8_harmonique();
	q10_harmonique();
	q12_harmonique();
	q14_harmonique();
	q16_harmonique();
	q17_harmonique();
	return 0;
}

int WinMain() {
	return main();
}
