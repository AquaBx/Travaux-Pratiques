// -*- c++ -*-

#ifndef __ENREGISTREUR_FICHIER__H__
#define __ENREGISTREUR_FICHIER__H__

#include <fstream>
#include <memory>
#include <vector>
#include "consommateur.h"
#include "constantes.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
/// \class enregistreur_fichier
///
/// \brief Un consommateur qui enregistre ses entrées dans un fichier binaire ;
///			   44100 Hz, 16bits signé, entrelacé
///
/// \author	Jean Christophe Engel, Fabrice Lamarche, University Of Rennes 1
/// \date	23/04/2010
////////////////////////////////////////////////////////////////////////////////////////////////////
class enregistreur_fichier : public consommateur
{
public:
	////////////////////////////////////////////////////////////////////////////////////////////////////
	/// \fn enregistreur_fichier(std::string nf, unsigned int nbc);
	/// \brief initialise le flux de sortie
	/// \param nf  : nom du fichier de sortie
	/// \param nbc : nombre de canaux (1 = mono, 2 = stéréo)
	////////////////////////////////////////////////////////////////////////////////////////////////////
	enregistreur_fichier(std::string nf, unsigned int nbc);

	////////////////////////////////////////////////////////////////////////////////////////////////////
	/// \fn virtual ~enregistreur_fichier();
	/// \brief	Destructeur virtuel. ; ferme le fichier
	///
	////////////////////////////////////////////////////////////////////////////////////////////////////
	~enregistreur_fichier() override;

	/// \return	Le nombre d'entrees du composant. 
	unsigned int nbEntrees() const override;

	/// \return	L'entrée demandée. 
	const std::shared_ptr<flot>& getEntree(unsigned int numentree) const override;

	/// \brief	Connecte une entrée sur ce composant. 
	///
	/// \param	f		Le flot à connecter en entrée du composant. 
	/// \param	numentree	Le numéro de l'entree sur laquelle connecter le flot.
	///
	/// \pre    0 <= numentree < nbEntrees()
	void connecterEntree(const std::shared_ptr<flot>& f, unsigned int numentree) override;

	/// \return	Vrai si chaque entrée possède au moins un échantillon.
	bool yaDesEchantillons() const override;

	/// \brief	Effectue les calculs associes au composant. 
	void calculer() override;

protected:
	const std::string& getNomFichier() const;
	std::ofstream& getStream();

private:
	// attributs du consommateur
	int m_nbE;
	std::vector<std::shared_ptr<flot>> m_lesEntrees;

	// attributs propres
	std::string m_nomFichier; // fichier de sortie
	std::ofstream m_fluxSortie;
};

#endif // __ENREGISTREUR_FICHIER__H__
