#pragma once
#include "clamper.h"
#include "filtre_compose.h"
#include "signal_lineaire.h"

enum way
{
	out,in
};

template <way T>
class fade : public filtre_compose
{

public:
	// constructeur prend un tick de début et un de fin
	fade(const double start, const double end) : filtre_compose(1, 1)
	{
		const double val_e = T;
		const double val_s = 1-T;

		const double a = (val_e - val_s) / (end - start);
		const double b = val_s - a * start;

		const unsigned int i1 = addComponent(new signal_lineaire(a, b));

		const unsigned int i2 = addComponent(new clamper(0,1));
		linkEntree(i1, i2, 0, 0);

		const unsigned int i3 = addComponent(new multiplicateur());

		bindEntreeComponent(0, i3, 0);
		linkEntree(i2, i3, 0, 1);
		bindSortieComponent(0, i3, 0);
	}

};
