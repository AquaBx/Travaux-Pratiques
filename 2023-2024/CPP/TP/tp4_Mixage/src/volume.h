#pragma once

#include "signal_constant.h"
#include "multiplicateur.h"

class volume : public multiplicateur {

protected:
	signal_constant volumeSignal;
public:
	volume(double volume) : volumeSignal(volume) {
		connecterEntree(volumeSignal.getSortie(0), 0);
	}

	void calculer() override {
		volumeSignal.calculer();

		multiplicateur::calculer();
	}

};