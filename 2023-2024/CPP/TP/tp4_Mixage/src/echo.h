#pragma once

#include "filtre_base.h"

class echo : public filtre_base
{
	int start;
	int i=0;
	imp_flot monflot;
public:
	echo(int start) : filtre_base(1, 1), start(start) {}

	void calculer() override {
		if (yaDesEchantillons())
		{
			double sig = getEntree(0)->extraire();

			monflot.inserer(sig);

			if ( i >= start )
			{
				sig += monflot.extraire();
			}

			getSortie(0)->inserer(sig);
			i++;
		}
	}
};