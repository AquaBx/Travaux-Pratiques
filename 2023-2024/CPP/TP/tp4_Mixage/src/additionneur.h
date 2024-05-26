#pragma once

#include "filtre_base.h"

class additionneur : public filtre_base {

public:
	additionneur(unsigned int n) : filtre_base(n, 1) {}

	void calculer() override {
		if (yaDesEchantillons()) {
			double s = 0;

			for (int i = 0 ; i < nbEntrees(); i++) {
				s+= getEntree(i)->extraire();
			}

			getSortie(0)->inserer(s);
		}
	}

};