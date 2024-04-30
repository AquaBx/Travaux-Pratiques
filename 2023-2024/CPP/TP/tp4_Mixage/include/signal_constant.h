#pragma once
#include "producteur.h"
#include "imp_flot.h"

class signal_constant : public producteur
{

private:
	std::shared_ptr<flot> flotSortie;

public:

	signal_constant(double entree) 
	{
		flotSortie = std::make_shared<imp_flot>();
		flotSortie->inserer(entree);
	}

	~signal_constant() override {}

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
		
	};
};
