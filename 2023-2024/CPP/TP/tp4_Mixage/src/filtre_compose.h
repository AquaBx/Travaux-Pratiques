#pragma once
#include <vector>
#include "filtre_base.h"


/*
implémentation douteuse du filtre composé
pour infos, les dynamic_cast c'était mon idée, certe pas la meilleur
 */
class filtre_compose : public filtre_base
{
protected:
	std::vector<composant*> mesComposants;
	// on stocke tout les composants dans un vecteur, ⚠️ ce sont des pointeurs dans le tas

	unsigned int* bindsEntrees1; // le filtre
	unsigned int* bindsEntrees2; // son entree

	unsigned int* bindsSorties1; // le filtre
	unsigned int* bindsSorties2; // sa sortie


public:
	filtre_compose(unsigned int nbentree, unsigned int nbsortie) :
		filtre_base(0, 0), bindsEntrees1(new unsigned int[nbentree]), bindsEntrees2(new unsigned int[nbentree]),
		bindsSorties1(new unsigned int[nbsortie]), bindsSorties2(new unsigned int[nbsortie])
	{
	}

	// le destructeur
	~filtre_compose() override
	{
		delete[] bindsEntrees1;
		delete[] bindsEntrees2;

		delete[] bindsSorties1;
		delete[] bindsSorties2;

		while (mesComposants.size() != 0)
		{
			delete mesComposants.back();
			mesComposants.pop_back();
		}
	}

	// ajoute on ajoute un composant dans le vecteur
	unsigned int addComponent(composant* filtreAdd)
	{
		mesComposants.push_back(filtreAdd);
		return static_cast<unsigned int>(mesComposants.size()) - 1;
	}

	// les trois méthode d'après sont droles ( non )


	// on connecte un composant interne avec une entree
	void bindEntreeComponent(unsigned int entree, unsigned int indexCons, unsigned int entreeCons) const
	{
		bindsEntrees1[entree] = indexCons;
		bindsEntrees2[entree] = entreeCons;
	}

	// on connecte un composant interne avec une sortie
	void bindSortieComponent(unsigned int sortie, unsigned int indexProd, unsigned int sortieProd) const
	{
		bindsSorties1[sortie] = indexProd;
		bindsSorties2[sortie] = sortieProd;
	}

	// on connecte deux composants entre eux
	void linkEntree(unsigned int indexProd, unsigned int indexCons, unsigned int sortieProd, unsigned int entreeCons)
	{
		// dynamic_cast pas propre :(
		auto prod = dynamic_cast<producteur*>(mesComposants[indexProd]);
		auto cons = dynamic_cast<consommateur*>(mesComposants[indexCons]);

		assert(prod != nullptr);

		cons->connecterEntree(prod->getSortie(sortieProd), entreeCons);
	}

	// on connecte un flux en entrée
	void connecterEntree(const std::shared_ptr<flot>& f, unsigned int numentree) override
	{
		// dynamic_cast pas propre :(
		auto cons = dynamic_cast<consommateur*>(mesComposants[bindsEntrees1[numentree]]);

		assert(cons != nullptr);

		cons->connecterEntree(f, bindsEntrees2[numentree]);
	}

	// on récupère une sortie
	const std::shared_ptr<flot>& getSortie(unsigned int numsortie) const override
	{
		// dynamic_cast pas propre :(
		auto prod = dynamic_cast<producteur*>(mesComposants[bindsSorties1[numsortie]]);

		assert(prod != nullptr);

		return prod->getSortie(bindsSorties2[numsortie]);
	}

	// on récupère une entrée
	const std::shared_ptr<flot>& getEntree(unsigned int numentree) const override
	{
		// dynamic_cast pas propre :(
		auto cons = dynamic_cast<consommateur*>(mesComposants[bindsEntrees1[numentree]]);

		assert(cons != nullptr);

		return cons->getEntree(bindsEntrees2[numentree]);
	}

	// on calcule tout les composants
	void calculer() override
	{
		for (auto i = mesComposants.begin(); i != mesComposants.end(); ++i)
		{
			(*i)->calculer();
		}
	}
};
