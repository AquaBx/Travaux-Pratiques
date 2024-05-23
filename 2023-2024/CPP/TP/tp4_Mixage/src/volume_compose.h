#pragma once

#include "signal_constant.h"
#include "multiplicateur.h"
#include "filtre_compose.h"

class volume_compose : public filtre_compose {


public:
	volume_compose(double volume) : filtre_compose(1,1) {
		unsigned int i1 = addComponent(new signal_constant(volume));
		unsigned int i2 = addComponent(new multiplicateur());

		bindEntreeComponent(0, i2, 0);
		linkEntree(i1, i2,0, 1);

		bindSortieComponent(0, i2, 0);

	}

	void calculer() override {
		filtre_compose::calculer();
	}

};