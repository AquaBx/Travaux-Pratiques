import doctest
import random
import time
import sympy
import sys

def exponentiation_rapide(x,n) :
    """
    Calcul de x**n

    >>> exponentiation_rapide(3,4)
    81
    >>> exponentiation_rapide(2,10)
    1024
    """

    if n==0:
        return 1
    elif n == 1:
        return x
    elif ( n%2 ==1 ):
        a = exponentiation_rapide(x,n//2)
        return x * a * a
    elif (n%2) == 0:
        a = exponentiation_rapide(x,n//2)
        return a*a

def exponentiation_rapide_modulaire(x, n, m):
    """
    Calcul de x**n mod m

    >>> exponentiation_rapide_modulaire(2,10,10)
    4
    >>> exponentiation_rapide_modulaire(3,6,7)
    1
    """

    x %= m

    if n==0:
        return 1
    elif n == 1:
        return x%m
    elif (n%2) == 0:
        a = exponentiation_rapide_modulaire(x,n//2,m)%m
        return (a*a)%m
    else:
        a = exponentiation_rapide_modulaire(x,(n-1)//2,m)
        return (x * a * a)%m


def pgcd(p,q):
    while q != 0:
        p,q = q,p%q
    return p

def est_inversible(p,n) :
    """
    Renvoie True si p est inversible modulo n
    
    >>> est_inversible(4,16)
    False
    >>> est_inversible(13,28)
    True
    """
    return pgcd(p,n) == 1

def calcul_inverse(p,n) :
    """
    Calcul de l'inverse de p modulo n
    (on suppose que p est inversible modulo n)
    >>> calcul_inverse(13,101)*13 % 101 == 1
    True
    """

    r , u , v , rp, up , vp = p,1,0,n,0,1

    q = 0

    r = p*u+n*v
    rp = p*up+n*vp

    while rp != 0:
        q = r//rp 
        r, u, v, rp, up, vp = rp, up, vp, r - q *rp, u - q*up, v - q*vp
    
    return u%n

def convert_message_to_numbers(message,n) :
    """
    Convertit un message textuel en suite de nombres possédant au maximum n chiffres (en décimal)
    
    (La fonction s'assure que les coupures ne produisent pas d'entiers tronqués)
    """
    data = message.encode()
    data_str = "".join([str(1000+int(i)) for i in data])
    res = []
    j=0
    while j+n < len(data_str) :
        k=j+n
        while data_str[k] == "0" :
            k-=1
        res.append(int(data_str[j:k]))
        j = k
    res.append(int(data_str[j:]))
    return res

def convert_numbers_to_message(numbers) :
    """
    Convertit une suite de nombres en un message textuel.
    """
    data_str = "".join([str(i) for i in numbers])
    data = []
    for k in range(0,len(data_str),4) :
        data.append(int(data_str[k:k+4])-1000)
    return bytes(data).decode()

def generer_cle_publique_privee(n1,n2) :
    """
    Prend en paramètre deux nombres premiers n1 et n2 et
    génère un triplet n,d,e vérifiant :
        - n = n1*n2
        - ed = 1 mod phi(n)
    """

    n = n1*n2

    phin = (n1-1)*(n2-1)

    e=random.randint(0,phin-1)

    while pgcd(phin, e) != 1:
        e=random.randint(2,phin-1)

    d = calcul_inverse(e,phin)

    return n,d,e

def chiffrement_RSA(message, cle_publique) :
    """
    Applique l'algorithme de chiffrement RSA avec la clé publique (n,d)

    >>> chiffrement_RSA("coucou",(3281309, 1556897)) == [3031416, 755249, 1486542, 2067531, 3031416, 755249, 1486542, 2067531]
    True
    """
    n,d = cle_publique

    encoded = convert_message_to_numbers(message,len(str(n))//2)
    return [ exponentiation_rapide_modulaire(x,d,n) for x in encoded]

def dechiffrement_RSA(numbers,cle_privee) :
    """
    Applique l'algorithme de déchiffrement RSA avec la clé privée (n,e)

    >>> dechiffrement_RSA(chiffrement_RSA("coucou",(3281309, 1556897)),(3281309, 3033677)) == "coucou"
    True
    """    
    n,e = cle_privee

    return convert_numbers_to_message([ exponentiation_rapide_modulaire(x,e,n) for x in numbers])

def test_miller_rabin_unitaire(n,a) :
    """
    >>> test_miller_rabin_unitaire(21,8)
    False
    >>> test_miller_rabin_unitaire(561,50)
    True
    """

    d = n-1
    r = 0

    while d%2 == 0:
        d//=2
        r+=1

    for i in range(0,r):
        if exponentiation_rapide_modulaire(a,r**i*d,n) == n-1 :
            return True
        
    return exponentiation_rapide_modulaire(a,d,n) == 1

def test_miller_rabin(n) :

    # Ecrivez une fonction ´ test miller rabin(n) qui effectue le test de MillerRabin pour n avec k entiers tir´es al´eatoirement entre 2 et n − 2, avec k le nombre
    # de chiffre de n (pour n < 100, on prendra k = 3)

    k =  max(3,len(str(n)))

    for _ in range(k):
        a = random.randint(2,n-2)
        if not test_miller_rabin_unitaire(n,a):
            return False

    return True

def gererer_nombre_premier(nb_chiffre) :
    n = random.randint(exponentiation_rapide(10,nb_chiffre-1),exponentiation_rapide(10,nb_chiffre)-1) | 1

    while not test_miller_rabin(n):
        n = random.randint(exponentiation_rapide(10,nb_chiffre-1),exponentiation_rapide(10,nb_chiffre)-1) | 1

    return n

if __name__ == "__main__" :
    ###### tests unitaires
    doctest.testmod()
    
    ###### Préliminaires
    x,n,m = 1_039_538,234_761,91_234
    t1 = time.time()
    a = exponentiation_rapide(x, n) % m
    t2 = time.time()
    print("durée du calcul de : exponentiation_rapide("+str(x)+", "+str(n)+") % "+str(m)+" :",t2-t1)
    t1 = time.time()
    a = exponentiation_rapide_modulaire(x, n, m)
    t2 = time.time()
    print("durée du calcul de : exponentiation_rapide_modulaire("+str(x)+", "+str(n)+", "+str(m)+") :",t2-t1)

    m1,m2 = 173452, 105763221
    t1 = time.time()
    calcul_inverse(m1, m2)
    t2 = time.time()
    print("durée du calcul de : calcul_inverse("+str(m1)+", "+str(m2)+") :",t2-t1)

    ###### Algorithme RSA
    n_premier1 = 52_300_003_631
    n_premier2 = 27_100_002_169

    n_cle_publique,d_cle_publique,e_cle_privee = generer_cle_publique_privee(n_premier1, n_premier2)

    print(generer_cle_publique_privee(1223, 2683))

    message_clair = "Ce message a été codé en utilisant la méthode RSA !"

    message_chiffre = chiffrement_RSA(message_clair, (n_cle_publique,d_cle_publique) )
    print(message_chiffre)

    message_dechiffre = dechiffrement_RSA(message_chiffre, (n_cle_publique,e_cle_privee))
    print(message_dechiffre)

    ###### Génération de nombres premiers
    a = gererer_nombre_premier(250)
    print("nombre premier généré :",a)

    ###### Le calcul suivant nécessite l'installation de sympy (à décommenter dans les imports)
    print("sympy.isprime(a) :",sympy.isprime(a))
