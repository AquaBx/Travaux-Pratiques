#pragma once

#include "filtre_compose.h"
#include "additionneur.h"
#include "volume_compose.h"

// le mixeur
class mixeur : public filtre_compose
{
public:
	// un beau désordre
	mixeur(const int n, const std::vector<float>& volumes) : filtre_compose(n, 1)
	{
		for (int i = 0; i < n; i++) // on crée les multiplicateurs et les volumes
		{
			const unsigned int i1 = addComponent(new volume_compose(volumes[i]));

			bindEntreeComponent(i, i1, 0); // allocation flux user -> volume_compose
		}

		const unsigned int i0 = addComponent(new additionneur(n)); // on crée l'additionneur

		for (int i = 0; i < n; i++)
		{
			linkEntree(i, i0, 0, i); // connection flux volume_compose -> entree additionneur
		}

		bindSortieComponent(0, i0, 0); // allocation additionneur  -> sa sortie
	}

	void calculer() override
	{
		filtre_compose::calculer();
	}
};
