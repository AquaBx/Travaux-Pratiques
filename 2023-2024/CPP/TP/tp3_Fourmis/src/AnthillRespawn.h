#pragma once
#include "Anthill.h"
#include <Environment.h>

#include <AntWithRules.h>
#include <Ant.h>
#include <SillyAnt.h>


class AnthillRespawn : public Anthill
{
public:
	AnthillRespawn(Environment* env, float x, float y) : Anthill(env, x, y)
	{
		for (int i = 0; i < 100; i++)
		{
			new AntWithRules(getEnvironment(), this);
			//new Ant(getEnvironment(), this);
			//new SillyAnt(getEnvironment(), this);
		}
	}


	void update() override
	{
		if (stock >= 20)
		{
			stock -= 20;
			new AntWithRules(getEnvironment(), this);
			//new Ant(getEnvironment(), this);
			//new SillyAnt(getEnvironment(), this);
		}

		Anthill::update();
	}
};
