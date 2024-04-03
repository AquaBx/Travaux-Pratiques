##########################
#    TP Probabilites     #
#TP1 : Aiguille de Buffon#
##########################

import numpy as np
import numpy.random as rd
import matplotlib.pyplot as plt

#Parametres

a = 1 #Ecart entre les lignes
N = 7 #nombre de lignes horizontales
L = a #longueur du baton

#Tracé des lignes
fig, ax = plt.subplots()

for i in range(N+1):
    plt.plot([0,N*a],[i*a,i*a],color = 'black')
    plt.plot([i*a,i*a],[0,N*a],color = 'black')
    plt.xlim([0,N*a])
    plt.ylim([0,N*a+1e-2])
    
N_essais = 100                      # Nombre de lancers
N_realisations = 0                  # Nombre de realisations de l'evenement E
historique = np.zeros(N_essais)     # historique de la proba estimee

for i in range(N_essais):
    
    #Tirer la position du centre M (toujours avec la fonction rand)
    XM = N*a/2
    YM = rd.rand(1)*N*a
    
    #Calcul des coordonnees des extremites du baton (fonction cos et sin de Numpy)
    
    #test de l'intersection (A l'aide de la fonction floor de Numpy)
    if np.floor((YM+L/2)/a) != np.floor((YM-L/2)/a) :
        N_realisations += 1
        col="green"
    else:
        col="red"
    
    circle = plt.Circle((XM,YM),L/2,color=col,fill = False)
    ax.add_patch(circle)
        
    #Calcul de la proba estimee au i-eme lancer
    historique[i] = N_realisations/(i+1)
    
    #affichage du lancer
    
    
#Affichage des infos sur la visualisation
plt.title('Essais = '+str(N_essais)+', Reussites = '+str(N_realisations)+', Pr. estimee = '+str(historique[-1])+', Pr. theo = '+str( 1 ))

#Trace de la courbe de l'historique avec la probabilite theorique associee
plt.figure()
plt.plot(historique)
plt.plot([0,historique.size],[1,1])
plt.xlabel('Indice realisation')
plt.title('Probabilite estimee au cours des iterations et theorique')
plt.show()