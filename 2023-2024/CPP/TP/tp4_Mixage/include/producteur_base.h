#pragma once
#include "producteur.h"
#include "imp_flot.h"

class producteur_base : public producteur
{

protected:
    virtual void connecterEntree(const std::shared_ptr<flot> & f, unsigned int numentree) = 0;

};
