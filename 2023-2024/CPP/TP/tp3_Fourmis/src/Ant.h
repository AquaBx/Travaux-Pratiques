#ifndef _Ant_H
#define _Ant_H

#include <AntBasePheromone.h>
#include <Anthill.h>
#include <Environment.h>

class Ant : public AntBasePheromone
{
public:
	Ant(Environment* env, Anthill* fourmilliere) : AntBasePheromone(env, fourmilliere)
	{
	}

	void update() override
	{
		checkAlive();

		Pheromone* choosed = choosePheromone();

		if (poids == 0.0)
		{
			Food* food = chooseFood();

			if (food != nullptr)
			{
				lookAt(*food);

				if (onAgent(food))
				{
					collectFromFood(food);
				}
			}
			else if (choosed != nullptr)
			{
				lookAt(*choosed);
			}
			else
			{
				rotateRandom();
			}
		}
		else
		{
			if (onAgent(fourmilliere))
			{
				deposit();
			}
			else if (choosed != nullptr)
			{
				lookAt(*choosed);
			}
			else
			{
				lookAt(*fourmilliere);
			}
		}

		forward();

		if (getPoids() == 0.0)
		{
			putPheromone(10);
		}
		else
		{
			putPheromone(100);
		}

		render();

		life += Timer::dt();
	}
};

#endif
