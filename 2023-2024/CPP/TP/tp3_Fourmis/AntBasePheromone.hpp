#ifndef _AntBasePheromone_H
#define _AntBasePheromone_H

#include <Agent.h>
#include <Environment.h>
#include <set>
#include <Renderer.h>
#include <AntBase.h>

#include "Pheromone.h"

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
            new Pheromone(getPosition()[0], getPosition()[1], q);
        }
    }

    AntBasePheromone(Environment* env, Anthill* fourmilliere) :
        AntBase(env, fourmilliere, Vector2<float>(MathUtils::random(), MathUtils::random()).normalized())
    {}

    void update() {

        checkAlive();

        if (poids == 0) {

            std::vector<Food*> perceivedObjectsRetour = perceivedObjects();

            if (perceivedObjectsRetour.size() > 0) {

                lookAt(*perceivedObjectsRetour.at(0));

                Vector2<float> d = perceivedObjectsRetour.at(0)->getPosition() - getPosition();

                if (d[0] * d[0] + d[1] * d[1] <= perceivedObjectsRetour.at(0)->getRadius()) {
                    poids += perceivedObjectsRetour.at(0)->collectFood(ptac);
                }

            }
            else
            {
                rotate(MathUtils::random(-MathUtils::pi / 10 * Timer::dt(), MathUtils::pi / 10 * Timer::dt()));
            }

        }
        else {
            lookAt(*fourmilliere);
        }

        checkAndDepose();

        forward();

        render();

        life += Timer::dt();
    }

};

#endif
