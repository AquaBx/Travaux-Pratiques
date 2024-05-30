#pragma once

#include "filtre_base.h"


/* classe additionneur

elle va prendre n entrées pour les mettre sur une seule sortie

*/
class additionneur : public filtre_base
{
public:
	additionneur(unsigned int n) : filtre_base(n, 1)
	{
	}

	void calculer() override
	{
		if (yaDesEchantillons())
		{
			double s = 0;

			for (unsigned int i = 0; i < nbEntrees(); i++)
			{
				s += getEntree(i)->extraire();
			}

			getSortie(0)->inserer(s);
		}
	}
};
