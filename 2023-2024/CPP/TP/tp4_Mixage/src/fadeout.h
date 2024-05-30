#pragma once
#include "fadein.h"

class fadeout : public fadein
{
protected:

	double getmult() override
	{
		return i >= s ? (e - i) / (e - s) : 1;
	}

public:
	fadeout(float start, float end) : fadein(start, end) {}

	void calculer() override {
		fadein::calculer();
	}

};