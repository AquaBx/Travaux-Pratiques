#pragma once
#include "producteur.h"
#include "imp_flot.h"

class producteur_base : public producteur
{
    
protected:
    std::shared_ptr<flot> * m_lesSorties;
    int sorties = 0;

public:
    unsigned int nbSorties() const {
        return sorties;
    }

    producteur_base(unsigned int size)
    {
        m_lesSorties = new std::shared_ptr<flot>[size];
    }

    ~producteur_base() override {
        delete[] m_lesSorties;
    }

    void connecterSortie(const std::shared_ptr<flot>& f, unsigned int numsortie) {
        m_lesSorties[numsortie] = f;
        sorties++;
    }

    const std::shared_ptr<flot>& getSortie(unsigned int numsortie) const override {
        return m_lesSorties[numsortie];
    }
};
