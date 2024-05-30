#pragma once
#include "producteur_base.h"

// lecteur de fichier
class lecteur_fichier : public producteur_base
{
protected:
	std::ifstream m_file;

public:
	lecteur_fichier(const char* filename, const int entree) : producteur_base(entree), m_file(std::ifstream(filename, std::ios_base::binary))
	{
	}

	~lecteur_fichier() override
	{
		m_file.close();
	}

	bool isEndFile() const
	{
		return m_file.eof();
	}

	void calculer() override
	{
		if (m_file.good()) // si ça va
		{
			short int m_data = 0; // on alloue 2 bytes

			for (unsigned int i = 0; i < nbSorties(); i++) // on itère sur toutes les sorties
			{
				m_file.read((char*)(& m_data), 2); // on lit 2 bytes, avec un cast pas beau

				const float m_data2 = static_cast<float>(m_data) / 32768.f; 

				m_lesSorties[i]->inserer(m_data2);
			}
		}
	}
};
