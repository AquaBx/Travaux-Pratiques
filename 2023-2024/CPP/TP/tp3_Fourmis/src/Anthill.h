#ifndef _Antill_H
#define _Antill_H

#include <Agent.h>
#include <Environment.h>
#include <Renderer.h>

class Anthill : public Agent
{
protected:
	float stock = 0;

public:
	Anthill(Environment* env, float x, float y) : Agent(env, x, y)
	{
		setRadius(10);
	}

	void depositFood(float quantity)
	{
		stock += quantity;
	}

	void update() override
	{
		auto color = Renderer::Color(0, 0, 255, 255);
		(Renderer::getInstance())->drawCircle(getPosition(), getRadius(), color);
	}
};

#endif
