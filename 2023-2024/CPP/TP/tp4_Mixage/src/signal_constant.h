#pragma once
#include "producteur.h"
#include "imp_flot.h"

class signal_constant : public producteur
{

private:
	std::shared_ptr<flot> flotSortie;
	double entree;

public:

	signal_constant(double entree) : entree(entree)
	{
		flotSortie = std::make_shared<imp_flot>();
	}

	~signal_constant() override = default;

	unsigned int nbSorties() const override
	{
		return 1;
	}

	const std::shared_ptr<flot>& getSortie(unsigned int numsortie) const override
	{
		return flotSortie;
	}

	void calculer() override
	{
		flotSortie->inserer(entree);
	};
};
