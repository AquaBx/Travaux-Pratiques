from function import *
import matplotlib.pyplot as plt

print("\n-------- Exo 32 --------\n")
#Exo 32

x = np.linspace(-3,2,100)
y=3*x**4+8*x**3-6*x
plt.plot(x,y,"b:",linewidth=5)
plt.show()