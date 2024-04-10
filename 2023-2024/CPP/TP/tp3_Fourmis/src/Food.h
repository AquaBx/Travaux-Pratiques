#include <Agent.h>
#include <Environment.h>
#include <MathUtils.h>
#include <Renderer.h>

#ifndef _Food_H
#define _Food_H

class Food : public Agent {

    float last_quantite;
    float quantite;

    public:
        Food(Environment * env, float x, float y, float quantite ) : Agent(env,x,y ), quantite(quantite){           
            setRadius(MathUtils::circleRadius(quantite));
        }

        float getFoodQuantity() const {
            return quantite;
        }

        float collectFood(float quantity){

            float retour = quantity > getFoodQuantity() ? 
                            getFoodQuantity() : quantity
            ;

            quantite -= retour;

            return retour;
        }

        void update(){

            if (quantite == 0){
                setStatus(destroy);
            }

            if ( last_quantite != quantite ){
                setRadius(MathUtils::circleRadius(quantite));
            }

            Renderer::Color color = Renderer::Color(154,235,38,255);
            (Renderer::getInstance()) -> drawCircle(getPosition(),getRadius(),color);

            last_quantite = quantite;
        }
};

#endif