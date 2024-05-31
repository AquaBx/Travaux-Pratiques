#pragma once

#include "filtre_base.h"


/* classe doubleur

elle va mettre sur n pistes le même signal
*/
class doubleur : public filtre_base
{
public:
	doubleur(unsigned int n) : filtre_base(1, n)
	{
	}

	void calculer() override
	{
		if (yaDesEchantillons())
		{
			double s = getEntree(0)->extraire();

			for (unsigned int i = 0; i < nbSorties(); i++)
			{
				getSortie(i)->inserer(s);
			}

			
		}
	}
};
