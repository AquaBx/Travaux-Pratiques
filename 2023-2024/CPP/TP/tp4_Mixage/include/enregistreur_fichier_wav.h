// -*- c++ -*-

#ifndef __ENREGISTREUR_FICHIER_WAV__H__
#define __ENREGISTREUR_FICHIER_WAV__H__

#include "enregistreur_fichier.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef _WIN32
#  ifdef BUILD_DLL
#    define DLL_EXPORT __declspec(dllexport)
#  else
#     define DLL_EXPORT __declspec(dllimport)
#  endif
#else
#  define DLL_EXPORT
#endif

////////////////////////////////////////////////////////////////////////////////////////////////////
/// \class enregistreur_fichier_wav
///
/// \brief Un consommateur qui enregistre ses entrées dans un fichier binaire ;
///			   44100 Hz, 16bits signé, entrelacé, fichier wav
///
/// \author	Jean Christophe Engel, Fabrice Lamarche, University Of Rennes 1
/// \date	23/04/2010
////////////////////////////////////////////////////////////////////////////////////////////////////
class enregistreur_fichier_wav : public enregistreur_fichier
{
public:
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// \fn enregistreur_fichier_wav(std::string nf, unsigned int nbc);
  /// \brief initialise le flux de sortie
  /// \param nf  : nom du fichier de sortie
  /// \param nbc : nombre de canaux (1 = mono, 2 = stéréo)
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  DLL_EXPORT enregistreur_fichier_wav(std::string nf, unsigned int nbc);

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// \fn virtual ~enregistreur_fichier_wav();
  /// \brief	Destructeur virtuel. ; ferme le fichier
  ///
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  virtual DLL_EXPORT ~enregistreur_fichier_wav();
};

#ifdef __cplusplus
}
#endif

#endif // __ENREGISTREUR_FICHIER_WAV__H__
