#--------------------------------------------- ---------------------------------------------
import doctest


def triangle_haut(n):
    """
    >>> triangle_haut(3)
    *
    **
    ***
    """
    if n>0:
        triangle_haut(n-1)
        print(n*"*")

def triangle_bas(n):
    """
    >>> triangle_bas(3)
    ***
    **
    *
    """
    if n>0:
        print(n*"*")
        triangle_bas(n-1)

def sablier(n):
    """
    >>> sablier(3)
    ***
    **
    *
    **
    ***
    """
    if n > 1:
        print(n*"*")
        sablier(n-1)
        print(n*"*")
    elif n > 0:
        print("*")

def triangle_milieu(n):
    if n > 0:
        triangle_milieu(n-1)
        print(n*"*")
        triangle_milieu(n-1)

if __name__ == "__main__" :
    doctest.testmod(verbose=True)