#pragma once


#include "filtre_base.h"

class panning : public filtre_base
{

public:
	panning() : filtre_base(3, 2) {}

	void calculer() override {
		if( yaDesEchantillons())
		{
			double pan = getEntree(0)->extraire();

			double pan_left = 0.5 * (1.0 - pan);
			double pan_right = 0.5 * (1.0 + pan);

			double left = getEntree(1)->extraire() * pan_left;
			double right = getEntree(2)->extraire() * pan_right;

			getSortie(0)->inserer(left);
			getSortie(1)->inserer(right);
		}
	}

	

};