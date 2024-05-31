#pragma once
#include "fade.h"

class fadeout : public fade< way::out>
{

public:
	// constructeur prend un tick de début et un de fin
	fadeout(float start, float end) : fade(start, end)
	{}
};
