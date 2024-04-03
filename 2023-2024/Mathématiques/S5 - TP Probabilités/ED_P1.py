import numpy as np
from matplotlib import pyplot as plt

tmax = 20  # durée simulation
pas = 0.5 # pas d'Euler
time=np.arange(0, tmax, pas) # Discrétisation

#--------Courbe réelle---------
x_th=np.zeros(len(time))
x_th=np.exp(-time) #solution théorique
#--------------------
x0 = 1 #condition initiale
x = np.zeros(len(x_th))
f1 = np.zeros(len(x_th))
#------------simul Euler-------------------------
for i in range(len(time)):
    if i==0: #vérification condition initiale
        x[i]=x0
    else:
        f1 = ???
        x[i]=x[i-1]+pas*f1

#--------------------------------
plt.figure()
#---------visu ---------
plt.plot(time  ,x_th, label='Theoric')
plt.plot(time  ,x,'-..', label='Euler')
plt.xlabel ('temps')
plt.ylabel('x(t)')
plt.grid()
plt.legend()
plt.show()