#pragma once
#include "filtre_base.h"


// clamp le signal entre un min et un max
class clamper : public filtre_base
{
	double min, max;

	public:
	
	clamper(const double min, const double max) : filtre_base(1,1), min(min), max(max) {}

	void calculer() override
	{
		double val_i = getEntree(0) -> extraire();
		double val = std::min(std::max(val_i, min), max);
		getSortie(0) -> inserer(val);
	}
};
