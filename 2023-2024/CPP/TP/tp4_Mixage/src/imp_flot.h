#pragma once
#include "flot.h"
#include <deque>
#include <cassert>

// implémentation du flot
class imp_flot : public flot
{
	std::deque<double> echantillons; // une queue
	int length;

public:
	imp_flot() : length(0)
	{
	}

	~imp_flot() override
	{
		echantillons.clear();
	}

	int getLength() const
	{
		return length;
	}

	// on pop le premier élément
	double extraire() override
	{
		assert(!vide());

		double end = echantillons.front();
		echantillons.pop_front();

		length -= 1;

		return end;
	}

	bool vide() const override
	{
		return length == 0;
	}

	// on insère à la fin
	void inserer(double echantillon) override
	{
		echantillons.push_back(echantillon);
		length += 1;
	}
};
