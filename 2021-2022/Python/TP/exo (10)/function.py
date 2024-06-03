#--------------------------------------------- 10 ---------------------------------------------
def somme(n):
    """
        Exo 10
    """
    s = 0
    k = 0

    while k < n:
        k += 1
        s += 1/k
    return s

def plus_petit(r):
    """
        Exo 10
    """
    n = 0
    s = 0
    while s < r:
        n += 1
        s += 1/n
    return n

def produit(n):
    """
        Exo 10
    """
    k = 1
    p = 1

    while k < n:
        k += 1
        p *= 1 - 1/k**2
    return p

def borne(e):
    """
        Exo 10
    """
    n = 0
    s = 0
    while s < 1/2:
        n += 1
        s += e
    return n

def borne2(e):
    """
        Exo 10
    """
    k = 1
    p = 1

    while p > 1/2+e:
        k += 1
        p *= 1 - 1/k**2
    return k