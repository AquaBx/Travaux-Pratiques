#pragma once
#include "lineariser.h"

// droite a x + b avec x commençant à 0 jusqu'à l'infini
class signal_lineaire : public lineariser
{
protected:
	double i = 0;
	std::shared_ptr<flot> mon_flot;

public:
	// constructeur
	signal_lineaire(const double a, const double b) : lineariser(a, b)
	{
		mon_flot = std::make_shared<imp_flot>();
		lineariser::connecterEntree(mon_flot, 0);
	}

	void calculer() override
	{
		mon_flot->inserer(i);
		lineariser::calculer();
		i++;
	}
};
