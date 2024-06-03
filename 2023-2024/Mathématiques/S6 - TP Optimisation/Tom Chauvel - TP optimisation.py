import numpy as np
import matplotlib.pyplot as plt

# déclaration des variables part 1

# matrice A
A = np.array([
   [1,1,1],
   [1,2,2],
   [1,2,3],
])

# matrice k
k = np.array([
   [1],
   [1],
   [1]
])

# valeurs propres positives, donc défini positive
print( np.linalg.eig(A).eigenvalues ) 

def gradient(A,p,k):
    """
    gradient de notre fonction
    """
    return A @ p - k

def GradientConstant(A,k,alpha,tol,itermax):
    """
    algo du gradient à pas constant
    """
    erreur = []
    p = [ np.random.rand(len(k),1) ]

    for i in range(itermax):
        g = gradient(A,p[-1],k)

        p.append( p[-1] - alpha*g )
        erreur.append( np.linalg.norm(p[-1] - p[-2]) )

        if (erreur[-1] < tol) : 
            break
    
    return p,erreur,i+1

def GradientVariable(A,k,tol,itermax):
    """
    algo du gradient à pas variable
    """
    erreur = []
    p = [ np.random.rand(len(k),1) ]

    for i in range(itermax):
        g = gradient(A,p[-1],k)

        a2 = g.transpose() @ A @ g / 2
        a1 = k.transpose() @ g - p[-1].transpose() @ A @ g / 2 - g.transpose() @ A @ p[-1] / 2

        alpha = ( - a1 / 2 / a2)[0,0]

        p.append( p[-1] - alpha*g )

        erreur.append( np.linalg.norm(p[-1] - p[-2]) )

        if (erreur[-1] < tol) : 
            break
    
    return p,erreur,i+1

# déclaration des variables part 2

itermax = 1000
tol = 1e-6

# 4 cas
p1,e1,i1 = GradientConstant(A,k,0.005,tol,itermax)
p2,e2,i2 = GradientConstant(A,k,0.05,tol,itermax)
p3,e3,i3 = GradientConstant(A,k,0.5,tol,itermax)
p4,e4,i4 = GradientVariable(A,k,tol,itermax)

plt.rcParams['figure.figsize'] = [15, 10]
fig, axs = plt.subplots(2,2) # grille pour l'affichage

# affichage des cas
axs[0,0].plot(e1)
axs[0,0].set_title(f'Pas constant 0.005 : {i1} itérations')

axs[0,1].plot(e2)
axs[0,1].set_title(f'Pas constant 0.05 : {i2} itérations')

axs[1,0].plot(e3)
axs[1,0].set_title(f'Pas constant 0.5 : {i3} itérations')

axs[1,1].plot(e4)
axs[1,1].set_title(f'Pas variable : {i4} itérations')

plt.show()

print(p1[-1])
print(p2[-1])
print(p3[-1])
print(p4[-1])