#pragma once

#include "filtre_base.h"

class compressor : public filtre_base
{
	double  c;
public:
	compressor(double force) : filtre_base(1, 1), c(force) {}

	void calculer() override {
		if (yaDesEchantillons())
		{
			double sig = getEntree(0)->extraire();

			double signe = sig < 0 ? -1 : 1;

			double traitement = signe * pow(abs(sig), c);

			getSortie(0)->inserer(traitement);
		}
	}
};