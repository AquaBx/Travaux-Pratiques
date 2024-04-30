#pragma once
#include "flot.h"
#include <deque>
#include <cassert>

class imp_flot : public flot
{

private:
	std::deque<double> echantillons;
	int length;

public:
	imp_flot() : length(0){}

	~imp_flot()
	{
		echantillons.clear();
	}

	double extraire() override
	{
		assert(!vide());

		double end = echantillons.front();
		echantillons.pop_front();

		length -= 1;

		return end;
	};

	bool vide() const override
	{
		return length == 0;
	};

	void inserer(double echantillon) override
	{
		echantillons.push_back(echantillon);
		length += 1;
	};

};
