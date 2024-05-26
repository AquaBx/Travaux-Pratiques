#pragma once

#include "filtre_base.h"

class multiplicateur : public filtre_base {

	public :
		multiplicateur() : filtre_base( 2, 1 ) {
		}

		void calculer() override {
			if (yaDesEchantillons()) {
				double a = m_lesEntrees[0]->extraire();
				double b = m_lesEntrees[1]->extraire();

				double c = a * b;

				m_lesSorties[0]->inserer(c);
			}
		}

};