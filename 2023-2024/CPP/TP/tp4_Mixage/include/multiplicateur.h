#pragma once

#include "filtre_base.h"
#include "imp_flot.h"

class multiplicateur : public filtre_base {

	protected:
		int i = 0;

	public :
		multiplicateur() : filtre_base( 2, 1 ) {
			connecterSortie(std::make_shared<imp_flot>(), 0);
		}

		void calculer() override {
			if (yaDesEchantillons()) {
				double calcul = m_lesEntrees[0]->extraire() * m_lesEntrees[1]->extraire();
				m_lesSorties[0]->inserer(calcul);
			}
		}

};