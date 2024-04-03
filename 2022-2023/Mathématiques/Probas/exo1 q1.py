import numpy as np
import numpy.random as rd
import matplotlib.pyplot as plt

####################################

x = rd.normal(0,1,100) 

print(x) 

####################################

mat = rd.normal(10,0.1,(5,5)) 

print(mat.size,mat.shape) 

####################################

x = rd.normal(0,1,100) 

plt.figure() 

plt.plot(x) 

plt.title('Représentation du vecteur aléatoire x') 

plt.xlabel('Indice du vecteur') 

plt.ylabel('Valeur') 

plt.show() 

####################################

x = rd.normal(0,1,100) 

M=20 

plt.figure() 

plt.hist(x,M) 

plt.show() 

####################################

x = rd.normal(0,1,100) 

pas = 0.1 

bins = np.arange(-3,3,pas) 

plt.figure() 

plt.hist(x,bins) 

plt.show() 

####################################


x = rd.normal(0,1,100) 
m = 0
sigma = 1
pas = 0.05

x_px = np.arange(-3,3,pas)
px = 1 / (sigma * np.sqrt(2*np.pi)) * np.exp(-1/(2*sigma**2)*(x_px-m)**2)

# px2 = np.zeros(px.size)
# for i in range(px.size) :
#     px2[i] = 1 / (sigma * np.sqrt(2*np.pi)) * np.exp(-1/(2*sigma**2)*(x_px[i]-m)**2)

plt.plot(x_px,px)
plt.show()
