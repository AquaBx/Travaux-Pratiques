#--------------------------------------------- ---------------------------------------------
import doctest
def somme_cube_chiffre(n):
    """
    >>> somme_cube_chiffre(643)
    307
    """
    if n > 0:
        return (n%10) ** 3 + somme_cube_chiffre(n//10)
    else:
        return 0

def iterer_somme_cube_chiffre(n):
    a=somme_cube_chiffre(n)
    #print(a)
    if a != n:
        return [a] + iterer_somme_cube_chiffre(a)
    else :
        return [a]

def list_mul(n,max):
    return [x for x in range(1,max) if x%n]


if __name__ == "__main__" :
    doctest.testmod(verbose=True)
    somme_cube_chiffre(643)
    print(iterer_somme_cube_chiffre(633))
    print(iterer_somme_cube_chiffre(3)) # multiple de 3 finis toujours par 153
    
    for item in range(3,10000,3):
        mul = iterer_somme_cube_chiffre(item)
        if mul[-1] != 153:
            print(item,False)

