#ifndef _Constantes_H
#define _Constantes_H

namespace MixageSonore
{
	//! Constante définissant la valeur de PI.
	static constexpr double pi = 3.14159265358979323846;

	//! Constante représentant la fréquence d'échantillonnage des samples sonores.
	static constexpr unsigned int frequency = 44100;

	//! taille en octets d'un échantillon (entrées/sorties fichier)
	static constexpr unsigned int tailleEchantillon = 2;
}
#endif
