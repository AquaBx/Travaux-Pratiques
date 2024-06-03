#--------------------------------------------- 23 ---------------------------------------------

def diviseur_plus(n): 
    list = [x for x in range(n-1,0,-1) if n%x == 0]
    
    if len(list) == 0:
        return 1
    else:
        return list[0]    

def diviseur_petit_commun(n,p):
    s = int(n**0.5) + 1
    l = int(p**0.5) + 1

    if l>s:
        s=l

    for i in range(2,s+1):
        if n%i == 0 and p%i == 0:
            k = int(i)
            break
        else : 
            k = str(n) + " et " + str(p) + " sont Premiers entre eux"
    
    return k

def liste_diviseur(n):
    return [x for x in range(1,n+1) if n%x == 0]


def somme_div(n):
    return sum([x for x in range(1,n) if n%x == 0])

def parfait(n):
    if sum([x for x in range(1,n) if n%x == 0]) == n:
        return True
    else :
        return False

def list_parfait(p,q):
    return [y for y in range(p,q+1) if sum([x for x in range(1,y) if y%x == 0]) == y]