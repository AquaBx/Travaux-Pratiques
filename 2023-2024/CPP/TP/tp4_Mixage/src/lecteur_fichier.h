#pragma once
#include "producteur.h"
#include "producteur_base.h"

class lecteur_fichier : public producteur_base
{
protected:
	std::ifstream m_file;

public:

	lecteur_fichier(const char* filename, int entree) : producteur_base(entree)	{
		m_file = std::ifstream(filename, std::ios_base::binary);
	}

	~lecteur_fichier() override {
		m_file.close();
	}

	bool isEndFile()
	{
		return m_file.eof();
	}

	void calculer() override {
		if (m_file.good())
		{
			short int m_data;

			for ( int i = 0; i < nbSorties(); i++)
			{
				m_file.read((char*)&m_data, 2);

				float m_data2 = (float)m_data / 32768;

				m_lesSorties[i]->inserer(m_data2);
			}
		}
	}
};
