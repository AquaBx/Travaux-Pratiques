#ifndef _Ant_H
#define _Ant_H

#include <AntBasePheromone.h>
#include <Anthill.h>
#include <Environment.h>
#include <Renderer.h>
#include <set>

class Ant : public AntBasePheromone {

    float stock = 0;


public:

    Ant(Environment* env, Anthill * fourmilliere) : AntBasePheromone(env, fourmilliere) {}

    void update() {

        checkAlive();

        Pheromone* choosed = choosePheromone();


        if (poids == 0) {
            putPheromone(10);

            std::vector<Food*> perceivedObjectsRetour = perceivedObjects();

            if (perceivedObjectsRetour.size() > 0) {

                lookAt(*perceivedObjectsRetour.at(0));

                Vector2<float> d = perceivedObjectsRetour.at(0)->getPosition() - getPosition();

                if (d[0] * d[0] + d[1] * d[1] <= perceivedObjectsRetour.at(0)->getRadius()) {
                    poids += perceivedObjectsRetour.at(0)->collectFood(ptac);
                }
            }
            else if (choosed != nullptr) {
                lookAt(*choosed);
            }
            else
            {
                rotate(MathUtils::random(-MathUtils::pi / 10 * Timer::dt(), MathUtils::pi / 10 * Timer::dt()));
            }
        }
        else {
            putPheromone(100);

            if (choosed != nullptr) {
                lookAt(*choosed);
            }
            else
            {
                lookAt(*fourmilliere);
            }

        }

        checkAndDepose();

        forward();

        render();

        life += Timer::dt();
    }
};

#endif
