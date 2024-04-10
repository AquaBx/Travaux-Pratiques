#ifndef _Agent_H
#define _Agent_H

#include <Environment.h>
#include <set>

class Agent : public Environment::LocalizedEntity {


    public:
        typedef enum { running, destroy } Status;

        Agent(Environment * env, float x, float y) : Environment::LocalizedEntity( env,Vector2<float>(x,y) ){           
            setRadius( defaultRadius() );
            mesAgents.insert(this);
        }

        // abstract méthode
        virtual void update() = 0;

        void setStatus(Status new_status){
            status = new_status;
        }

        Status getStatus() const{
            return status;
        }

        static void simulate(){
            std::set<Agent *>::iterator begin = mesAgents.begin();
            std::set<Agent *>::iterator end = mesAgents.end();
            
            while (begin != end) {
                if ( (*begin)->getStatus() == running ) {
                    (*begin)->update();
                    ++begin;
                }
                else if ((*begin)->getStatus() == destroy)
                {
                    delete *begin;
                    begin = mesAgents.erase(begin);
                }
            }
        }

        static void finalize(){
            std::set<Agent *>::iterator begin = mesAgents.begin();
            std::set<Agent *>::iterator end = mesAgents.end();

            while (begin != end) {
                delete *begin;
                begin = mesAgents.erase(begin);
            }
        }

    private:
        Status status = running;

        static std::set<Agent*> mesAgents;
};

#endif