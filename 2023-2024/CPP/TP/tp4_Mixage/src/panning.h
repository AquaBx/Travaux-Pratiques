#pragma once


#include "filtre_base.h"

// panning
class panning : public filtre_base
{
public:
	panning() : filtre_base(3, 2)
	{
	}

	void calculer() override
	{
		if (yaDesEchantillons())
		{
			const double pan = getEntree(0)->extraire();

			// équations de droites pour retrouver les coefficients
			const double pan_left = 0.5 * (1.0 - pan);
			const double pan_right = 0.5 * (1.0 + pan);

			const double left = getEntree(1)->extraire() * pan_left;
			const double right = getEntree(2)->extraire() * pan_right;

			getSortie(0)->inserer(left);
			getSortie(1)->inserer(right);
		}
	}
};
