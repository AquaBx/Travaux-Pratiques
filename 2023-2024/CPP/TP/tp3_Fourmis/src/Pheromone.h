#ifndef _Pheromone_H
#define _Pheromone_H

#include <Agent.h>
#include <Environment.h>
#include <Renderer.h>
#include <Timer.h>


class Pheromone : public Agent
{
protected:
	float quantity;

public:
	Pheromone(Environment* env, float x, float y, float quantity)
		: Agent(env, x, y), quantity(quantity)
	{
	}

	float getQuantity()
	{
		return quantity;
	}

	void addQuantity(float q)
	{
		quantity += q;
	}

	void update() override
	{
		if (quantity < 0.01)
		{
			setStatus(destroy);
		}

		auto color = Renderer::Color(0, 128, 128, std::min(static_cast<int>(quantity), 255));
		(Renderer::getInstance())->drawCircle(getPosition(), getRadius(), color);


		quantity -= 0.01f * Timer::dt() * quantity;
	}
};

#endif
