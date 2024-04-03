##########################
#    TP Probabilites     #
#TP1 : Aiguille de Buffon#
##########################

import numpy as np
import numpy.random as rd
import matplotlib.pyplot as plt

#Parametres

a = 1 #Ecart entre les lignes
N = 8 #nombre de lignes horizontales
L = a #longueur du baton

#Tracé des lignes
plt.figure()
for i in range(N+1):
    plt.plot([0,N*a],[i*a,i*a],color = 'black')
    plt.plot([i*a,i*a],[0,N*a],color = 'black')
    plt.xlim([0,N*a])
    plt.ylim([0,N*a+1e-2])
    
N_essais = 1000                     # Nombre de lancers
N_realisations = 0                  # Nombre de realisations de l'evenement E
historique = np.zeros(N_essais)     # historique de la proba estimee

for i in range(N_essais):
    
    #Tirer l'angle phi du baton avec l'axe horizontal (utiliser la fonction rand du module random)
    phi = rd.rand(1)*np.pi
    #Tirer la position du centre M (toujours avec la fonction rand)
    XM = rd.rand(1)*N*a
    YM = rd.rand(1)*N*a
    
    #Calcul des coordonnees des extremites du baton (fonction cos et sin de Numpy)
    X1 = L/2*np.cos(phi)+XM
    X2 = 2*XM-X1
    Y1 = L/2*np.sin(phi)+YM
    Y2 = 2*YM-Y1
    
    #test de l'intersection (A l'aide de la fonction floor de Numpy)

    if np.floor(Y1/a) != np.floor(Y2/a): # ligne horizontale
        N_realisations += 1 
        col = "green"
    elif np.floor(X1/(a*2)) != np.floor(X2/(a*2)): # 1 ligne verticale sur 2
        N_realisations += 1
        col = "green"
    else:
        col = "red"
    #Calcul de la proba estimee au i-eme lancer
    historique[i] = N_realisations/(i+1)
    
    #affichage du lancer
    plt.plot([X1,X2],[Y1,Y2],color=col)
    
#Affichage des infos sur la visualisation
ptheo = 2/np.pi*L/a + 2/np.pi*L/(2*a) - 2/np.pi*L/a * 2/np.pi*L/(2*a)

plt.title('Essais = '+str(N_essais)+', Reussites = '+str(N_realisations)+', Pr. estimee = '+str(historique[-1])+', Pr. theo = '+str(np.around( ptheo ,4)))

#Trace de la courbe de l'historique avec la probabilite theorique associee
plt.figure()
plt.plot(historique)
plt.plot([0,historique.size],[ptheo,ptheo])
plt.xlabel('Indice realisation')
plt.title('Probabilite estimee au cours des iterations et theorique')
plt.show()