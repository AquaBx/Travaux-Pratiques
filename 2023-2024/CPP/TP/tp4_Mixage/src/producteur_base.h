#pragma once
#include "producteur.h"
#include "imp_flot.h"

class producteur_base : public virtual producteur
{
protected:
	unsigned int sorties = 0;

	std::shared_ptr<flot>* m_lesSorties;

public:
	//renvoie le nombre de sorties
	unsigned int nbSorties() const override
	{
		return sorties;
	}

	// constructeur
	producteur_base(const unsigned int size): sorties(size), m_lesSorties(new std::shared_ptr<flot>[size])
	{
		for (unsigned int i = 0; i < size; i++)
		{
			connecterSortie(std::make_shared<imp_flot>(), i);
		}
	}

	// constructeur de copie
	producteur_base(const producteur_base& old)
	{
		m_lesSorties = new std::shared_ptr<flot>[old.sorties];

		sorties = old.nbSorties();

		for (unsigned int i = 0; i < old.nbSorties(); i++)
		{
			this->m_lesSorties[i] = old.m_lesSorties[i];
		}
	}

	// operateur d'affectation
	producteur_base& operator=(const producteur_base& old)
	{
		if (this == &old)
		{
			return (*this);
		}

		sorties = old.nbSorties();

		for (unsigned int i = 0; i < old.nbSorties(); i++)
		{
			this->m_lesSorties[i] = old.m_lesSorties[i];
		}

		return (*this);
	}

	//destructeur
	~producteur_base() override
	{
		delete[] m_lesSorties;
	}

	//connecte un flot à l'indice demandé
	void connecterSortie(const std::shared_ptr<flot>& f, const unsigned int numsortie) const
	{
		m_lesSorties[numsortie] = f;
	}

	//renvoie le s_ptr de la sortie à l'indice demandé
	const std::shared_ptr<flot>& getSortie(const unsigned int numsortie) const override
	{
		return m_lesSorties[numsortie];
	}

	// methode calculer qui devra être implémenté
	void calculer() override 
	{
	}
};
