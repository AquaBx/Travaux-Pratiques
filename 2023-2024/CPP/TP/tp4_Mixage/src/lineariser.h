#pragma once

#include "filtre_base.h"

// créer une droite a x + b avec les x en entrée
class lineariser : public filtre_base
{
protected:
	double a_;
	double b_;

public:
	
	lineariser(const double a, const double b) : filtre_base(1, 1), a_(a), b_(b) {}

	void calculer() override
	{
		if (yaDesEchantillons())
		{
			getSortie(0)->inserer(a_ * getEntree(0)->extraire() + b_);
		}
	}
};