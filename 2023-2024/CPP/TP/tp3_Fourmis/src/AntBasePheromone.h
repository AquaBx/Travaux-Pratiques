#ifndef _AntBasePheromone_H
#define _AntBasePheromone_H

#include <Agent.h>
#include <Environment.h>
#include <Renderer.h>
#include <AntBase.h>

#include <Pheromone.h>

class AntBasePheromone : public AntBase
{
public:
	// choix d'une pheromone
	Pheromone* choosePheromone() const
	{
		std::vector<Pheromone*> pheromones = perceive<Pheromone>(direction, MathUtils::pi / 2, 8.0);

		if (pheromones.size() == 0) return nullptr;

		auto weight = std::vector<float>();

		for (auto i = pheromones.begin(); i < pheromones.end(); ++i)
		{
			weight.push_back((*i)->getQuantity());
		}

		int r = MathUtils::randomChoose(weight);

		return pheromones.at(r);
	}

	// pose de phéromone
	void putPheromone(float q)
	{
		std::vector<Pheromone*> pheromones = perceive<Pheromone>();

		if (pheromones.size() > 0)
		{
			for (auto i = pheromones.begin(); i < pheromones.end(); ++i)
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
		AntBase(env, fourmilliere, Vector2<float>(MathUtils::random(-1, 1), MathUtils::random(-1, 1)).normalized())
	{
	}
};

#endif
