#pragma once

#include "signal_constant.h"
#include "multiplicateur.h"

// classe volume héritant du multiplicateur
class volume : public multiplicateur
{
protected:
	signal_constant volumeSignal;

public:
	volume(const double volume) : volumeSignal(volume)
	{
		connecterEntree(volumeSignal.getSortie(0), 0);
	}

	void calculer() override
	{
		volumeSignal.calculer();

		multiplicateur::calculer();
	}
};
