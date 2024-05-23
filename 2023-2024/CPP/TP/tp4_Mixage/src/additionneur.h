#pragma once

#include "filtre_base.h"
#include "imp_flot.h"

class additionneur : public filtre_base {

public:
	additionneur(unsigned int n) : filtre_base(n, 1) {
		connecterSortie(std::make_shared<imp_flot>(), 0);
	}

	void calculer() override {
		if (yaDesEchantillons()) {
			double s = 0;

			for (int i = 0 ; i < nbEntrees(); i++) {
				s+= m_lesEntrees[i]->extraire();
			}

			m_lesSorties[0]->inserer(s);
		}
	}

};