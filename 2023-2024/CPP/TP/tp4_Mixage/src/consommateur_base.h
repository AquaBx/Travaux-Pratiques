#pragma once

#include "consommateur.h"

/*

implémentation de consommateur

 */
class consommateur_base : public virtual consommateur
{
protected:
	unsigned int entrees = 0;
	std::shared_ptr<flot>* m_lesEntrees;

public:
	//renvoie le nombre d'entrées
	unsigned int nbEntrees() const override
	{
		return entrees;
	}

	//constructeur
	consommateur_base(unsigned int size): entrees(size), m_lesEntrees(new std::shared_ptr<flot>[size])
	{
	}

	// constructeur de copie
	consommateur_base(const consommateur_base& old)
	{
		m_lesEntrees = new std::shared_ptr<flot>[old.entrees];

		entrees = old.nbEntrees();

		for (unsigned int i = 0; i < old.nbEntrees(); i++)
		{
			this->m_lesEntrees[i] = old.m_lesEntrees[i];
		}
	}

	// operateur d'affectation
	consommateur_base& operator=(const consommateur_base& old)
	{
		if (this == &old)
		{
			return (*this);
		}

		entrees = old.nbEntrees();

		for (unsigned int i = 0; i < old.nbEntrees(); i++)
		{
			this->m_lesEntrees[i] = old.m_lesEntrees[i];
		}

		return *this;
	}

	//destructeur
	~consommateur_base() override
	{
		delete[] m_lesEntrees;
	}

	//connecte un flot à l'indice demandé
	void connecterEntree(const std::shared_ptr<flot>& f, unsigned int numentree) override
	{
		m_lesEntrees[numentree] = f;
	}

	//renvoie le s_ptr de l'entree à l'indice demandé
	const std::shared_ptr<flot>& getEntree(unsigned int numentree) const override
	{
		return m_lesEntrees[numentree];
	}

	// regarde si mon premier est vide, si oui, renvoie faux, sinon renvoie vrai
	bool yaDesEchantillons() const override
	{
		return !m_lesEntrees[0]->vide();
	}
};
