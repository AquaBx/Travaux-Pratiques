#ifndef _AntBase_H
#define _AntBase_H

#include <Agent.h>
#include <Environment.h>
#include <set>
#include <Renderer.h>
#include <Timer.h>
#include <MathUtils.h>
#include <Food.h>
#include <Anthill.h>


class AntBase : public Agent {

	protected:
	    Anthill * const fourmilliere;
	    float vitesse;
	    float lifetime;
	    float ptac=5;

	    float life=0;
	    float poids=0;

	    Vector2<float> direction;

    public:

        AntBase(Environment * env, Anthill * fourmilliere,Vector2<float> direction,float vitesse=1)
            : Agent( env, fourmilliere->getPosition()[0], fourmilliere->getPosition()[1]), fourmilliere(fourmilliere) , vitesse(vitesse) , direction(direction)
        {
        	lifetime = MathUtils::random(1000, 2500);
        }


        void forward() {
            setPosition(getPosition() + direction * vitesse * Timer::dt());
        }

        void rotate(float angle) {
            direction = direction.rotate(angle);
        }

        void demitour() {
            rotate(180);
        }

        void lookAt(Agent & obj) {
            direction = (obj.getPosition() - getPosition()).normalized();
        }

        void deposit() {
            fourmilliere->depositFood(poids);
            poids = 0;
        }

        std::vector<Food*> perceivedObjects() const {
            return LocalizedEntity::perceive<Food>(direction, MathUtils::pi / 2, 3.0);
        }

        void checkAndDepose()
        {
            Vector2<float> d = fourmilliere->getPosition() - getPosition();

            if (d[0] * d[0] + d[1] * d[1] <= fourmilliere->getRadius()) {
                deposit();
                life = 0;
            }
        }

		void render()
        {
            Renderer::Color color = poids == 0 ? Renderer::Color(255, 255, 255, 255) : Renderer::Color(128, 255, 128, 255);
            (Renderer::getInstance())->drawCircle(getPosition(), getRadius(), color);
        }

		void checkAlive()
        {
	        if (lifetime <= life) {
	            this->setStatus(destroy);
	        }
        }
};

#endif