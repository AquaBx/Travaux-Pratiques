#pragma once
#include "filtre.h"
#include "producteur_base.h"
#include "consommateur_base.h"

class filtre_base : public filtre, public producteur_base, public consommateur_base {
public :
	filtre_base(unsigned entrees, unsigned sorties): consommateur_base(entrees), producteur_base(sorties) {}
	
	unsigned int nbSorties() const {
		return producteur_base::nbSorties();
	}

	const std::shared_ptr<flot>& getSortie(unsigned int numsortie) const {
		return producteur_base::getSortie(numsortie);
	}

	unsigned int nbEntrees() const {
		return consommateur_base::nbEntrees();
	}

	const std::shared_ptr<flot>& getEntree(unsigned int numentree) const {
		return consommateur_base::getEntree(numentree);
	}
	void connecterEntree(const std::shared_ptr<flot>& f, unsigned int numentree) {
		return consommateur_base::connecterEntree(f,numentree);
	}

	bool yaDesEchantillons() const {
		return consommateur_base::yaDesEchantillons();
	}

};