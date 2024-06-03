#--------------------------------------------- ---------------------------------------------
import doctest
import matplotlib.pyplot as plt

def miroir(n):
    """
    >>> miroir(9)
    9
    >>> miroir(0)
    0
    >>> miroir(10)
    1
    >>> miroir(1204)
    4021
    >>> miroir(2100)
    12
    """
    j = 0
    while n != 0:
        j = j*10 + n%10
        n = n //10
    return j

def palindrome(n):
    """
    >>> palindrome(313)
    True
    """
    if n == miroir(n):
        return True
    return False

def prochain_terme(u):
    if palindrome(u):
        return u
    return u + miroir(u)

def lychrel(u,n):
    """
    >>> lychrel(97,8)
    [97, 176, 847, 1595, 7546, 14003, 44044, 44044, 44044]
    """
    liste = [u]
    for i in range(n):
        liste.append(prochain_terme(liste[-1]))
    return liste

def nb_iteration_lychrel(u,n):
    """
    >>> nb_iteration_lychrel(97,8)
    6
    """
    for i in range(n):
        u1 = prochain_terme(u)
        if u1 == u:
            return i
        u = u1
    return -1

def liste_nb_iteration_lychrel(p):
    return [nb_iteration_lychrel(x,200) for x in range(1,p+1)]

def pltshow(p):
    ly = liste_nb_iteration_lychrel(p)
    lx = [x for x in range(1,len(ly)+1)]
    plt.plot(lx,ly)
    plt.show()

if __name__ == "__main__":
    doctest.testmod(verbose=True)
    print(lychrel(196,30)) #pas l'air de marcher    
    print(liste_nb_iteration_lychrel(20))
    pltshow(200)