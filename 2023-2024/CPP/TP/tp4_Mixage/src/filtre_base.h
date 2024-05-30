#pragma once
#include "filtre.h"
#include "producteur_base.h"
#include "consommateur_base.h"

class filtre_base : public filtre, public consommateur_base, public producteur_base
{
public :
	filtre_base(unsigned int nbentrees, unsigned int nbsorties): consommateur_base(nbentrees),
	                                                             producteur_base(nbsorties)
	{
	}

	// on override toute les méthodes pour pas avoir de warnings :)

	unsigned int nbSorties() const override
	{
		return producteur_base::nbSorties();
	}

	const std::shared_ptr<flot>& getSortie(unsigned int numsortie) const override
	{
		return producteur_base::getSortie(numsortie);
	}

	unsigned int nbEntrees() const override
	{
		return consommateur_base::nbEntrees();
	}

	const std::shared_ptr<flot>& getEntree(unsigned int numentree) const override
	{
		return consommateur_base::getEntree(numentree);
	}

	void connecterEntree(const std::shared_ptr<flot>& f, unsigned int numentree) override
	{
		consommateur_base::connecterEntree(f, numentree);
	}

	void calculer() override
	{
		producteur_base::calculer();
	}

	bool yaDesEchantillons() const override
	{
		return consommateur_base::yaDesEchantillons();
	}
};
