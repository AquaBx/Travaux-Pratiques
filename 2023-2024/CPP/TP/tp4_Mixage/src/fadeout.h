#pragma once
#include "fadein.h"

class fadeout : public fadein
{
protected:
	// override du getmult du fade in
	double getmult() override
	{
		return i >= s ? (e - i) / (e - s) : 1;
	}

public:
	//constructeur qui prend un début et une fin en tick
	fadeout(float start, float end) : fadein(start, end)
	{
	}

	void calculer() override
	{
		fadein::calculer();
	}
};
