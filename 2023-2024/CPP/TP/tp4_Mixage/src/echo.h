#pragma once

#include "delai.h"
#include "doubleur.h"

class echo : public filtre_compose
{

public:
	// constructeur, phi nombre de tick après lequel l'echo commence
	echo(const double phi) : filtre_compose(1, 1)
	{
		const unsigned int i0 = addComponent(new doubleur(2));
		const unsigned int i1 = addComponent(new delai(phi));
		const unsigned int i2 = addComponent(new additionneur(2));

		bindEntreeComponent(0, i0, 0);
		linkEntree(i0, i1, 0, 0);

		linkEntree(i1, i2, 0, 0);
		linkEntree(i0, i2, 1, 1);

		bindSortieComponent(0, i2, 0);
	}
};