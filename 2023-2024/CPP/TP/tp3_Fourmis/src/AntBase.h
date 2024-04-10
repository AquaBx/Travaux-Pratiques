#ifndef _Antill_H
#define _Antill_H

#include <Agent.h>
#include <Environment.h>
#include <set>
#include <Renderer.h>
#include <Timer.h>

class AntBase : public Agent {


    AntBase * fourmilliere;
    float vitesse;
    float lifetime;
    float ptac;
    Vector2<float> direction;

    public:

        AntBase(Environment * env, float x , float y, AntBase * fourmilliere,Vector2<float> direction, float lifetime, float ptac, float vitesse=1.0)
            : Agent( env, x,y ), fourmilliere(fourmilliere) , vitesse(vitesse) , direction(direction), lifetime(lifetime) , ptac(ptac) {}


        void update(){
            setPosition( direction * vitesse * Timer::dt() );

            Renderer::Color color = Renderer::Color(0,0,255,255);
            (Renderer::getInstance()) -> drawCircle(getPosition(),getRadius(),color);
        }
};

#endif