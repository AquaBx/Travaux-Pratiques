#pragma once
#include "producteur_base.h"
#include "imp_flot.h"
#include "constantes.h"

class harmonique : public producteur_base
{

	protected:
		double phi;
		double f;
		int i = 0;

	public:
		harmonique(double f, double phi = 0) : producteur_base(1), phi(phi), f(f)
		{
			connecterSortie(std::make_shared<imp_flot>(),0);
		}

		void calculer() override
		{
			double calcul = sin(static_cast<double>(i) / MixageSonore::frequency * 2.0 * MixageSonore::pi * f + phi);
			m_lesSorties[0]->inserer(calcul);
			i += 1;
		}

};