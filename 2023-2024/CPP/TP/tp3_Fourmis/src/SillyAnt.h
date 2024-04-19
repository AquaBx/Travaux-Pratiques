#ifndef _SillyAnt_H
#define _SillyAnt_H

#include <Agent.h>
#include <Environment.h>
#include <set>
#include <Renderer.h>
#include <AntBase.h>

class SillyAnt : public AntBase {


public:
    
    SillyAnt(Environment* env, Anthill * fourmilliere):
        AntBase(env, fourmilliere, Vector2<float>(MathUtils::random(), MathUtils::random()).normalized() )
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
