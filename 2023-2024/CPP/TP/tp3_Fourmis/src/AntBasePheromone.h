#ifndef _AntBasePheromone_H
#define _AntBasePheromone_H

#include <Agent.h>
#include <Environment.h>
#include <set>
#include <Renderer.h>
#include <AntBase.h>

#include <Pheromone.h>

class AntBasePheromone : public AntBase {


public:

    Pheromone* choosePheromone() const
    {

        std::vector<Pheromone*> pheromones = LocalizedEntity::perceive<Pheromone>(direction, MathUtils::pi / 2, 8.0);

        if (pheromones.size() == 0) return nullptr;

        std::vector<float> weight = std::vector<float>();

        for (auto i = pheromones.begin(); i < pheromones.end(); ++i)
        {
            weight.push_back((*i)->getQuantity());
        }

        int r = MathUtils::randomChoose(weight);

        return pheromones.at(r);
    }

    void putPheromone(float q)
    {
        std::vector<Pheromone*> pheromones = LocalizedEntity::perceive<Pheromone>();

	    if (pheromones.size() > 0)
	    {
		    for ( auto i = pheromones.begin(); i < pheromones.end() ; ++i)
		    {
                (*i)->addQuantity(q);
		    }
	    }
        else
        {

            new Pheromone(getEnvironment(), getPosition()[0], getPosition()[1], q);
        }
    }

    AntBasePheromone(Environment* env, Anthill* fourmilliere) :
        AntBase(env, fourmilliere, Vector2<float>(MathUtils::random(), MathUtils::random()).normalized())
    {}

 

};

#endif
