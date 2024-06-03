#--------------------------------------------- ---------------------------------------------

import doctest
import matplotlib.pyplot as plt


def prochain_terme(u):
    if u%2==0:
        return u/2
    else:
        return 3*u + 1

def syracuse(u0,n):
    if n >= 0:
        next = prochain_terme(u0)
        return [u0] + syracuse(next,n-1)
    else :
        return []

def duree_de_vol(u0,n=0):
    if u0==1:
        return n
    else:
        return duree_de_vol(prochain_terme(u0),n+1)

def liste_durees_de_vol(n):
    return [duree_de_vol(x) for x in range(1,n+1)]

def graf(tab):
    plt.plot(list(range(1,len(tab)+1)),tab)
    plt.show()

if __name__ == "__main__" :
    doctest.testmod(verbose=True)
    print(syracuse(25,10))
    print(syracuse(25,23))
    print(duree_de_vol(25))
    print(liste_durees_de_vol(11))
    graf(liste_durees_de_vol(100))