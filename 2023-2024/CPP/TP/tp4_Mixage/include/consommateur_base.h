#pragma once

#include "consommateur.h"


#pragma once
#include "producteur.h"
#include "imp_flot.h"

class consommateur_base : public consommateur {

protected:
    std::shared_ptr<flot>* m_lesEntrees;
    int entrees = 0;

public:
    unsigned int nbEntrees() const {
        return entrees;
    }

    consommateur_base(unsigned int size)
    {
        m_lesEntrees = new std::shared_ptr<flot>[size];
    }

    ~consommateur_base() override {
        delete[] m_lesEntrees;
    }

    void connecterEntree(const std::shared_ptr<flot>& f, unsigned int numentree) {
        m_lesEntrees[numentree] = f;
        entrees++;
    }

    const std::shared_ptr<flot>& getEntree(unsigned int numentree) const override {
        return m_lesEntrees[numentree];
    }

    bool yaDesEchantillons() const {
        return !m_lesEntrees[0]->vide();
    }
};
