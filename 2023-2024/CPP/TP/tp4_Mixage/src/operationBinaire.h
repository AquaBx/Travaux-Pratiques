#pragma once

#include "filtre_base.h"
#include "imp_flot.h"

template <class T>
class operationBinaire : public filtre_base {

protected:
	int i = 0;

public:
	operationBinaire() : filtre_base(2, 1) {
	}

	void calculer() override {
		if (yaDesEchantillons()) {
			double a = m_lesEntrees[0]->extraire();
			double b = m_lesEntrees[1]->extraire();

			T operateur;

			double c = operateur(a,b);

			m_lesSorties[0]->inserer(c);
		}
	}
};
