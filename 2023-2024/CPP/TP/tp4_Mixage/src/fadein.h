#pragma once
#include "fade.h"

class fadein : public fade< way::in>
{

public:
	// constructeur prend un tick de début et un de fin
	fadein(float start, float end) : fade(start, end)
	{}
};
