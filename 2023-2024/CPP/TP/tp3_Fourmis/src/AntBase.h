#ifndef _AntBase_H
#define _AntBase_H

#include <Agent.h>
#include <Environment.h>
#include <Renderer.h>
#include <Timer.h>
#include <MathUtils.h>
#include <Food.h>
#include <Anthill.h>


class AntBase : public Agent
{
protected:
	Anthill* const fourmilliere;
	float vitesse;
	float lifetime;
	float ptac = 5;

	float life = 0;
	float poids = 0;

	Vector2<float> direction;

public:
	AntBase(Environment* env, Anthill* fourmilliere, Vector2<float> direction, float vitesse = 1)
		: Agent(env, fourmilliere->getPosition()[0], fourmilliere->getPosition()[1]), fourmilliere(fourmilliere),
		  vitesse(vitesse), direction(direction)
	{
		lifetime = MathUtils::random(1000, 2500);
	}

	// retourne le poids actuel
	float getPoids()
	{
		return poids;
	}

	// avancer
	void forward()
	{
		setPosition(getPosition() + direction * vitesse * Timer::dt());
	}

	// rotate d'un angle
	void rotate(float angle)
	{
		direction = direction.rotate(angle);
	}

	// un demi tour x)
	void demitour()
	{
		rotate(180);
	}

	// regarde vers un agent
	void lookAt(Agent& obj)
	{
		direction = (obj.getPosition() - getPosition()).normalized();
	}

	// depose dans la fourmillière
	// ⚠️ il faut vérifier que la fourmi est bien sur la fourmillère
	void deposit()
	{
		fourmilliere->depositFood(poids);
		poids = 0;
	}

	// affiche le cercle de la fourmi
	void render()
	{
		Renderer::Color color = poids == 0 ? Renderer::Color(255, 255, 255, 255) : Renderer::Color(128, 255, 128, 255);
		(Renderer::getInstance())->drawCircle(getPosition(), getRadius(), color);
	}

	// vérifie si la fourmi, est vivante, sinon ça la tue
	void checkAlive()
	{
		if (lifetime <= life)
		{
			this->setStatus(destroy);
		}
	}

	// cherche une food en face de la fourmi
	Food* chooseFood() const
	{
		std::vector<Food*> foods = perceive<Food>(direction, MathUtils::pi / 2, 3.0);

		if (foods.size() == 0) return nullptr;

		return foods.at(0);
	}

	// vérifie si la fourmi est sur un agent
	bool onAgent(Agent* agent) const
	{
		float d = agent->getPosition().distance(getPosition());
		return d < agent->getRadius();
	}

	// collecte de la nourriture sur l'agent mis en paramètre
	void collectFromFood(Food* food)
	{
		poids += food->collectFood(ptac);
	}

	// rotate random	
	void rotateRandom()
	{
		rotate(MathUtils::random(-MathUtils::pi / 10 * Timer::dt(), MathUtils::pi / 10 * Timer::dt()));
	}

	// récupère la fourmillère
	Anthill* getFourmilliere()
	{
		return fourmilliere;
	}

	// reset de la vie de la fourmi
	void resetLife()
	{
		life = 0;
	}
};

#endif
