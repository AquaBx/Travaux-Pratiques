import numpy as np
from matplotlib import pyplot as plt

#--Simul modèle Lotka-Voltterra--------------

a= 0.4 # taux de croissance proies en absence prédateurs
h= 0.4 # taux décès prédateurs en l'absence de proies
b= 0.01 # influence prédateurs sur proies
c= 0.01 # influence proies sur prédateurs


tmax = 40  # durée simulation
pas = 0.2             # pas d'Euler
nmax=round(tmax/pas) # nombre échantillons simulés
#--------initialisations---------
R=np.zeros(nmax)
L=np.zeros(nmax)

L[0]=80 #Initialisation Lapins
R[0]=12 #Initialisation Renards

#------------simul Euler-------------------------
for i in range(nmax-1):
    f1=???
    f2=???
    L[i+1]=L[i]+pas*f1
    R[i+1]=R[i]+pas*f2

#--------------------------------
plt.figure()
time = np.arange(nmax)
plt.subplot (2,1,1)
#---------visu Nbre Gentils (proies)---------
plt.plot(time  ,L)
plt.title(algo)
limit1 = plt.axis()
plt.xlabel('temps')
plt.ylabel('Nbre de proies')
plt.grid()

plt.legend('Proies')
#---------visu Nbre Méchants (prédateurs)--------
plt.subplot(2,1,2)
plt.plot(time  ,R,'-..')
plt.xlabel('temps')
plt.ylabel('Nbre de Prédateurs')
plt.grid()
plt.legend('Prédateurs')

plt.show()