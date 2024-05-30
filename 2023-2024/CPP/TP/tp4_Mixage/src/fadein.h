#pragma once
#include "filtre_base.h"

class fadein : public filtre_base
{protected:
	float i=0;
	float s;
	float e;

	virtual double getmult() {
		return i <= e ? (i) / (e - s) : 1;
	}

public:
	fadein(float start, float end) : filtre_base(1, 1), s(start), e(end) {}


	void calculer() override {
		if (yaDesEchantillons()) {
			getSortie(0)->inserer(getmult() * getEntree(0)->extraire());

			i++;
		}
	}

};