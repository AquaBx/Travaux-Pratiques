#pragma once

#include "consommateur.h"
#include "imp_flot.h"

class consommateur_base : public virtual consommateur {

protected:
    std::shared_ptr<flot>* m_lesEntrees;
    unsigned int entrees = 0;

public:
    unsigned int nbEntrees() const override {
        return entrees;
    }

    consommateur_base(unsigned int size): entrees(size)
    {
        m_lesEntrees = new std::shared_ptr<flot>[size];

    }

    consommateur_base(const consommateur_base& old)
    {
        this->m_lesEntrees = old.m_lesEntrees;
    }

    consommateur_base& operator= (const consommateur_base& old)
    {
        if (this == &old) {
            return (*this);
        }

        this->m_lesEntrees = old.m_lesEntrees;

        return (*this);
    }

    ~consommateur_base() override {
        delete[] m_lesEntrees;
    }

    void connecterEntree(const std::shared_ptr<flot>& f, unsigned int numentree) override {
        m_lesEntrees[numentree] = f;
    }

    const std::shared_ptr<flot>& getEntree(unsigned int numentree) const override {
        return m_lesEntrees[numentree];
    }

    bool yaDesEchantillons() const {
        return !m_lesEntrees[0]->vide();
    }
};
