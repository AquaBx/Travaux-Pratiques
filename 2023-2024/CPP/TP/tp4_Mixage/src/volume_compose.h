#pragma once

#include "signal_constant.h"
#include "multiplicateur.h"
#include "filtre_compose.h"

// le volume compose
class volume_compose : public filtre_compose
{
public:
	volume_compose(const double volume) : filtre_compose(1, 1)
	{
		// on ajoute le multiplicateur et le signal constant
		const unsigned int i1 = addComponent(new signal_constant(volume));
		const unsigned int i2 = addComponent(new multiplicateur());

		bindEntreeComponent(0, i2, 0); // on bind l'entrée 0 sur le multiplicateur
		linkEntree(i1, i2, 0, 1); // on link le volume constant et le multiplateur

		bindSortieComponent(0, i2, 0); // on met en sortie le multiplicateur
	}

	void calculer() override
	{
		filtre_compose::calculer();
	}
};
