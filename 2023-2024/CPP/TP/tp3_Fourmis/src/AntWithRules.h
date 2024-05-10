#pragma once
#include "AbstractAntRule.h"
#include "AntBasePheromone.h"
#include "OrRule.h"


/*
 * Honnêtement, j'aime pas trop comment c'est fait,
 * normalement elle a le même comportement que la Ant en moins clair et optimisé, à mon avis
 */
class AntWithRules : public AntBasePheromone
{
	class EmptyOnFoodRule : public AbstractAntRule
	{
		friend AntWithRules;

	protected:
		bool condition() override
		{
			Food* food = fourmi->chooseFood();

			if (food == nullptr) return false;

			return fourmi->getPoids() == 0.0 && fourmi->onAgent(food);
		}

		void action() override
		{
			Food* food = fourmi->chooseFood();
			fourmi->collectFromFood(food);
		}

		EmptyOnFoodRule(AntWithRules* fourmi) : AbstractAntRule(fourmi)
		{
		}
	};

	class EmptySeeingFoodRule : public AbstractAntRule
	{
		friend AntWithRules;

	public:
		bool condition() override
		{
			Food* food = fourmi->chooseFood();

			if (food == nullptr) return false;

			return fourmi->getPoids() == 0.0;
		}

		void action() override
		{
			Food* food = fourmi->chooseFood();
			fourmi->lookAt(*food);
		}

	protected:
		EmptySeeingFoodRule(AntWithRules* fourmi) : AbstractAntRule(fourmi)
		{
		}
	};

	class EmptySeeingPheromoneRule : public AbstractAntRule
	{
		friend AntWithRules;

	public:
		bool condition() override
		{
			Pheromone* pheromone = fourmi->choosePheromone();


			if (fourmi->getPoids() != 0.0) return false;
			if (pheromone == nullptr) return false;

			return true;
		}

		void action() override
		{
			Pheromone* pheromone = fourmi->choosePheromone();
			fourmi->lookAt(*pheromone);
		}

	protected:
		EmptySeeingPheromoneRule(AntWithRules* fourmi) : AbstractAntRule(fourmi)
		{
		}
	};

	class EmptyNotSeeingPheromoneAndEmptyRule : public AbstractAntRule
	{
		friend AntWithRules;

	public:
		bool condition() override
		{
			Pheromone* pheromone = fourmi->choosePheromone();
			Food* food = fourmi->chooseFood();

			return fourmi->getPoids() == 0.0 and pheromone == nullptr && food == nullptr;
		}

		void action() override
		{
			fourmi->rotateRandom();
		}

	protected:
		EmptyNotSeeingPheromoneAndEmptyRule(AntWithRules* fourmi) : AbstractAntRule(fourmi)
		{
		}
	};

	class NotEmptyOnAntHillRule : public AbstractAntRule
	{
		friend AntWithRules;

	public:
		bool condition() override
		{
			return fourmi->getPoids() != 0.0 && fourmi->onAgent(fourmi->getFourmilliere());
		}

		void action() override
		{
			fourmi->deposit();
			fourmi->resetLife();
		}

	protected:
		NotEmptyOnAntHillRule(AntWithRules* fourmi) : AbstractAntRule(fourmi)
		{
		}
	};

	class NotEmptyAndNowhereRule : public AbstractAntRule
	{
		friend AntWithRules;

	public:
		bool condition() override
		{
			return true;
		}

		void action() override
		{
			Pheromone* pheromone = fourmi->choosePheromone();

			if (pheromone != nullptr)
			{
				fourmi->lookAt(*pheromone);
			}
			else
			{
				fourmi->lookAt(*(fourmi->getFourmilliere()));
			}
		}

	protected:
		NotEmptyAndNowhereRule(AntWithRules* fourmi) : AbstractAntRule(fourmi)
		{
		}
	};

	std::vector<AbstractAntRule*> rules;

public:
	AntWithRules(Environment* env, Anthill* fourmilliere) : AntBasePheromone(env, fourmilliere)
	{
		rules.push_back(new EmptyOnFoodRule(this));
		rules.push_back(new EmptySeeingFoodRule(this));
		rules.push_back(new EmptySeeingPheromoneRule(this));
		rules.push_back(new EmptyNotSeeingPheromoneAndEmptyRule(this));
		rules.push_back(new NotEmptyOnAntHillRule(this));
		rules.push_back(new NotEmptyAndNowhereRule(this));
	}

	void update() override
	{
		checkAlive();

		auto AntRules = OrRule(rules);

		if (AntRules.condition())
		{
			AntRules.action();
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

	~AntWithRules() override
	{
		for (AbstractAntRule* item : rules)
		{
			delete item;
		}
	}

};
