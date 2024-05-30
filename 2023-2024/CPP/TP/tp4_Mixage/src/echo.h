#pragma once

#include "filtre_base.h"

class echo : public filtre_base
{
	int start;
	int i = 0;
	imp_flot monflot;

public:
	// constructeur, start nombre de tick après lequel l'echo commence
	echo(int start) : filtre_base(1, 1), start(start)
	{
	}

	void calculer() override
	{
		if (yaDesEchantillons())
		{
			double sig = getEntree(0)->extraire();

			monflot.inserer(sig); // on insère dans notre buffer

			if (i >= start)
			{
				// si on a atteint le décalage souhaité on ajoute au signal
				sig += monflot.extraire();
			}

			getSortie(0)->inserer(sig);
			i++;
		}
	}
};
