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

#include "compressor.h"
#include "echo.h"
#include "fadein.h"
#include "fadeout.h"
#include "lecteur_fichier.h"
#include "panning.h"


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
	les_volumes.push_back(0.3f);

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
	lecteur_fichier mon_fichier("./raw/stereo.raw", 2);

	enregistreur_fichier enregistreur("17_harmonique.raw", 2);
	enregistreur.connecterEntree(mon_fichier.getSortie(0), 0);
	enregistreur.connecterEntree(mon_fichier.getSortie(1), 1);

	// produire 2 secondes de son
	while (!mon_fichier.isEndFile()) {
		mon_fichier.calculer();
		enregistreur.calculer();
	}
}

void fade_f() {
	harmonique la440(440); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)

	fadein fade1(0, 24000);
	fadeout fade2(64200,88200);

	enregistreur_fichier enregistreur("fadeinout.raw", 1);	// fichier mono

	fade1.connecterEntree(la440.getSortie(0), 0);
	fade2.connecterEntree(fade1.getSortie(0), 0);
	enregistreur.connecterEntree(fade2.getSortie(0), 0);

	// produire 2 secondes de son
	for (unsigned long int i = 0; i < 2 * MixageSonore::frequency; ++i) {
		la440.calculer();
		fade1.calculer();
		fade2.calculer();
		enregistreur.calculer();
	}
}

void panning_f() {
	harmonique sin(1); // la 440Hz (voir fr.wikipedia.org/wiki/Note_de_musique)
	lecteur_fichier mon_fichier1("./raw/stereo.raw", 2);
	lecteur_fichier mon_fichier2("./raw/stereo.raw", 2);

	panning pan;

	pan.connecterEntree(sin.getSortie(0), 0);
	pan.connecterEntree(mon_fichier1.getSortie(0), 1);
	pan.connecterEntree(mon_fichier2.getSortie(0), 2);

	enregistreur_fichier enregistreur("panning.raw", 2);	// fichier mono

	enregistreur.connecterEntree(pan.getSortie(0), 0);
	enregistreur.connecterEntree(pan.getSortie(1), 1);

	// produire 2 secondes de son
	while (!mon_fichier1.isEndFile()) {
		sin.calculer();
		mon_fichier1.calculer();
		mon_fichier2.calculer();
		pan.calculer();
		enregistreur.calculer();
	}
}

void compressor_f() {
	lecteur_fichier mon_fichier1("./raw/stereo.raw", 2);
	lecteur_fichier mon_fichier2("./raw/stereo.raw", 2);

	enregistreur_fichier enregistreur("compresseur.raw", 2);

	compressor compresseur1(0.5);
	compressor compresseur2(1);

	compresseur1.connecterEntree(mon_fichier1.getSortie(0), 0);
	compresseur2.connecterEntree(mon_fichier2.getSortie(0), 0);

	enregistreur.connecterEntree(compresseur1.getSortie(0), 0);
	enregistreur.connecterEntree(compresseur2.getSortie(0), 1);

	while (!mon_fichier1.isEndFile()) {
		mon_fichier1.calculer();
		mon_fichier2.calculer();
		compresseur1.calculer();
		compresseur2.calculer();
		enregistreur.calculer();
	}
}

void echo_f() {
	lecteur_fichier mon_fichier1("./raw/stereo.raw", 2);
	lecteur_fichier mon_fichier2("./raw/stereo.raw", 2);

	enregistreur_fichier enregistreur("echo.raw", 2);

	echo echo1(2000);
	echo echo2(4000);

	echo1.connecterEntree(mon_fichier1.getSortie(0), 0);
	echo2.connecterEntree(mon_fichier2.getSortie(0), 0);

	enregistreur.connecterEntree(echo1.getSortie(0), 0);
	enregistreur.connecterEntree(echo2.getSortie(0), 1);

	while (!mon_fichier1.isEndFile()) {
		mon_fichier1.calculer();
		mon_fichier2.calculer();
		echo1.calculer();
		echo2.calculer();
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

	fade_f();
	panning_f();
	compressor_f();
	echo_f();

	return 0;
}

int WinMain() {
	return main();
}
