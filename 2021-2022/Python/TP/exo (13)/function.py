#--------------------------------------------- 13 ---------------------------------------------
def somme_multiple(n):
    """
        Exo 13 : somme des multiples de 3 ou 5
    """
    s=0
    for i in range(1,n):
        if i%3 == 0 or i%5 == 0:
            s+=i
    return s