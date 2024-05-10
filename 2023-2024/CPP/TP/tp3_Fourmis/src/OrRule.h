#pragma once
#include <vector>

#include "AbstractAntRule.h"

class OrRule : public AbstractRule
{
	std::vector<AbstractAntRule*> rules;

public:
	OrRule(const std::vector<AbstractAntRule*>& vec) : rules(vec)
	{
	}

	void action() override
	{
		for (AbstractAntRule* item : rules)
		{
			if (item->condition())
			{
				item->action();
				return;
			}
		}
	}

	bool condition() override
	{
		for (AbstractAntRule* item : rules)
		{
			if (item->condition())
			{
				return true;
			}
		}
		return false;
	}
};
