#pragma once
#include "AbstractRule.h"
#include "AntBasePheromone.h"

class AbstractAntRule : public AbstractRule
{
protected:
	AntBasePheromone* fourmi;

	AbstractAntRule(AntBasePheromone* fourmi) : fourmi(fourmi)
	{
	}
};
