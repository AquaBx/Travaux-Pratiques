#ifndef _SillyAnt_H
#define _SillyAnt_H

#include <Agent.h>
#include <Environment.h>
#include <AntBase.h>

class SillyAnt : public AntBase
{
public:
	SillyAnt(Environment* env, Anthill* fourmilliere):
		AntBase(env, fourmilliere, Vector2<float>(MathUtils::random(), MathUtils::random()).normalized())
	{
	}

	void update() override
	{
		checkAlive();

		if (poids == 0)
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
			else
			{
				lookAt(*fourmilliere);
			}
		}

		forward();

		render();

		life += Timer::dt();
	}
};

#endif
