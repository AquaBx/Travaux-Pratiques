#pragma once

class AbstractRule
{
public:
	virtual bool condition() = 0;
	virtual void action() = 0;
};
