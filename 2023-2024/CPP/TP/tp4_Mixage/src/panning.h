#pragma once

#include "doubleur.h"
#include "lineariser.h"

// panning
class panning : public filtre_compose
{
public:
	panning() : filtre_compose(3, 2)
	{
		// on double notre signal d'entrée
		const unsigned int i0 = addComponent(new doubleur(2));
		bindEntreeComponent(0, i0, 0);

		// on calcule la gauche

		// on calcule le panning à gauche
		const unsigned int i1 = addComponent(new lineariser(-0.5, 0.5));
		linkEntree(i0, i1, 0, 0);

		// on multiplie le signal à gauche avec le panning
		const unsigned int i3 = addComponent(new multiplicateur());
		linkEntree(i1, i3, 0, 0);
		bindEntreeComponent(1, i3, 1);

		// on bind la sortie
		bindSortieComponent(0, i3, 0);

		// pareil à droite
		const unsigned int i2 = addComponent(new lineariser(+0.5, 0.5));
		linkEntree(i0, i2,1, 0);
		const unsigned int i4 = addComponent(new multiplicateur());
		linkEntree(i2, i4, 0,0);
		bindEntreeComponent(2, i4, 1);
		bindSortieComponent(1, i4, 0);

	}
};
