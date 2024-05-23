#pragma once

#include "signal_constant.h"
#include "multiplicateur.h"
#include "filtre_compose.h"
#include "additionneur.h"

class mixeur : public filtre_compose {

public:
	mixeur(int n, std::vector<float> volumes) : filtre_compose(n,1){

		for (int i = 0 ; i < n; i++)
		{
			unsigned int i1 = addComponent(new signal_constant(volumes[i]));
			unsigned int i2 = addComponent(new multiplicateur());

			bindEntreeComponent(i, i2, 0); // allocation flux user -> multiplicateur
			linkEntree(i1,i2, 0, 1 ); // connection flux signal_constant -> entree multiplicateur

		}

		unsigned int i0 = addComponent(new additionneur(n));

		for (int i = 0; i < n; i++)
		{
			linkEntree(1+i*2, i0, 0, i); // connection flux multiplicateur -> entree additionneur
		}

		bindSortieComponent(0, i0, 0); // allocation additionneur  -> sa sortie

	}

	void calculer() override {
		filtre_compose::calculer();
	}
};
