#pragma once
#include "producteur_base.h"
#include "imp_flot.h"

class harmonique : public producteur_base
{

protected:
    void connecterEntree(const std::shared_ptr<flot> & f, unsigned int numentree) override{

    };

public:

	harmonique(double entree) 
	{
		flotSortie = std::make_shared<imp_flot>();
		flotSortie->inserer(entree);
	}

	~harmonique() override {}

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
