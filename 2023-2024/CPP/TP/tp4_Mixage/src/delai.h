#pragma once

#include "filtre_base.h"

/* classe delai */
class delai : public filtre_base
{
	double phi;
	double i=0;

public:
	delai(double phi) : filtre_base(1, 1), phi(phi)
	{
	}

	void calculer() override
	{
		if (yaDesEchantillons())
		{
			double sig = i < phi ? 0 : getEntree(0)->extraire();
			getSortie(0)->inserer(sig);
			i++;
		}
	}
};
