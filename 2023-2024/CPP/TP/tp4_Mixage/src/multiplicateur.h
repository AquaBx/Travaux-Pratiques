#pragma once

#include "filtre_base.h"

// multiplicateur
class multiplicateur : public filtre_base
{
public :
	multiplicateur() : filtre_base(2, 1)
	{
	}

	void calculer() override
	{
		if (yaDesEchantillons())
		{

			const double c = m_lesEntrees[0]->extraire() * m_lesEntrees[1]->extraire();

			m_lesSorties[0]->inserer(c);
		}
	}
};
