#pragma once
#include "producteur.h"
#include "imp_flot.h"

class producteur_base : public virtual producteur
{
    
protected:
    std::shared_ptr<flot> * m_lesSorties;
    unsigned int sorties = 0;

public:
    unsigned int nbSorties() const override {
        return sorties;
    }

    producteur_base(unsigned int size): sorties(size)
    {
        m_lesSorties = new std::shared_ptr<flot>[size];

        for (int i = 0; i < size; i++) {
            connecterSortie(std::make_shared<imp_flot>(), i);
        }
    }

    producteur_base(const producteur_base & old )
    {
        this->m_lesSorties = old.m_lesSorties; 
    }

    producteur_base & operator= (const producteur_base& old)
    {
        if ( this == &old ) {
            return (*this);
        }

        this->m_lesSorties = old.m_lesSorties;

        return (*this);
    }

    ~producteur_base() override {
        delete[] m_lesSorties;
    }

    void connecterSortie(const std::shared_ptr<flot>& f, unsigned int numsortie)  {
        m_lesSorties[numsortie] = f;
    }

    const std::shared_ptr<flot>& getSortie(unsigned int numsortie) const override {
        return m_lesSorties[numsortie];
    }

    void calculer() override {
	    
    }
};
