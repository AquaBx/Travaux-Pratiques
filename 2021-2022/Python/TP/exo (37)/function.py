#--------------------------------------------- ---------------------------------------------
import doctest
import time

def expo_normale(x,n):
    """
    >>> expo_normale(10,0)
    1
    >>> expo_normale(0,0)
    1
    >>> expo_normale(10,3)
    1000
    """
    res = 1
    for i in range(n):
        res *= x
    return res
    
def expo_rapide(x,n):
    """
    >>> expo_normale(10,0)
    1
    >>> expo_normale(0,0)
    1
    >>> expo_normale(10,3)
    1000
    """
    if n==0:
        return 1
    elif n%2 == 0:
        a = expo_rapide(x,n/2)
        return a*a
    else:
        a = expo_rapide(x,(n-1)/2)
        return x*a*a

if __name__ == "__main__" :
    doctest.testmod(verbose=True)