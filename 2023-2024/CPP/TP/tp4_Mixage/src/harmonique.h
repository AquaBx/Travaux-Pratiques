#pragma once
#include "producteur_base.h"
#include "constantes.h"


// classe harmonique, banal
class harmonique : public producteur_base
{
protected:
	double phi_;
	double f_;
	int i_ = 0;

public:
	harmonique(const double f, const double phi = 0) : producteur_base(1), phi_(phi), f_(f)
	{}

	void calculer() override
	{
		const double calcul = sin(
			static_cast<double>(i_) / MixageSonore::frequency * 2.0 * MixageSonore::pi * f_ + phi_);
		m_lesSorties[0]->inserer(calcul);
		i_ += 1;
	}
};