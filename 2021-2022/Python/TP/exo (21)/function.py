#--------------------------------------------- 21 ---------------------------------------------
def double_somme(n):
    """
        Double somme chiante de l'exo 21
    """
    ds=0
    for o in range(1,n+1):
        s=0
        list = [(o+k) / (o**2+k**2) for k in range(1,o+1)]
    
        for item in list:
            s+=item
        ds+=s
    return s