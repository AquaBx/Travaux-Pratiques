#pragma once

#include "filtre_base.h"

// opération binaire
template <class T>
class operationBinaire : public filtre_base
{
protected:
	int i = 0;

public:
	operationBinaire() : filtre_base(2, 1)
	{
	}

	void calculer() override
	{
		if (yaDesEchantillons())
		{
			const double a = m_lesEntrees[0]->extraire();
			const double b = m_lesEntrees[1]->extraire();

			T operateur; // ça peut etre un std::multiply par exemple

			const double c = operateur(a, b);

			m_lesSorties[0]->inserer(c);
		}
	}
};
