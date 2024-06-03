#--------------------------------------------- ---------------------------------------------
import doctest
import time
def chiffrement_cesar(message,cle):
    """
    >>> chiffrement_cesar("BONJOUR",3)
    'ERQMRXU'
    """

    translate = ""
    for lettre in message:
        if lettre >= 'A' and lettre <= 'Z':
            key = ord(lettre) + cle
            if chr(key) > 'Z':
                key -= 26
            translate += chr(key)
        else:
            translate += lettre
    return translate

def dechiffrement_cesar(message,cle):
    """
    >>> dechiffrement_cesar("ERQMRXU",3)
    'BONJOUR'
    """

    translate = ""
    for lettre in message:
        if lettre >= 'A' and lettre <= 'Z':
            key = ord(lettre) - cle
            if chr(key) < 'A':
                key += 26
            translate += chr(key)
        else:
            translate += lettre
    return translate

def chiffrement_vigenere(message,cle):
    """
    >>> chiffrement_vigenere("BONJOUR TOUT LE MONDE","CHAT")
    'DVNCQBR MQBT EG TOGFL'
    """
    c = 0
    translate = ""
    for lettre in message:
        if lettre >= 'A' and lettre <= 'Z':
            key = ord(cle[c]) - 65
            translate += chiffrement_cesar(lettre,key)
            c = (c+1)%len(cle)
        else:
            translate += lettre
    return translate

def dechiffrement_vigenere(message,cle):
    """
    >>> dechiffrement_vigenere("DVNCQBR MQBT EG TOGFL","CHAT")
    'BONJOUR TOUT LE MONDE'
    """
    c = 0
    translate = ""
    for lettre in message:
        if lettre >= 'A' and lettre <= 'Z':
            key = ord(cle[c]) - 65
            translate += dechiffrement_cesar(lettre,key)
            c = c+1

        else:
            translate += lettre
        c = c%len(cle)
    return translate

def decrypt_cesar(code,indice):
    key = (ord(code[0]) - ord(indice))%26
    return dechiffrement_cesar(code,key)

def cherche_key(mot,mot_len):
    for mot_t in mot_len:
        keys = [(ord(mot_t[i]) - ord(mot[i]))%26 for i in range(len(mot_t))]
        boolean = True
        for i in range(len(keys)):
            if keys[i] != keys[i-1] and boolean == True:
                boolean = False
        if boolean == True:
            return keys[0]

def decrypt_cesar_2(code,mot):
    mot_len = [m for m in code.split(" ") if len(m) == len(mot)]
    key = cherche_key(mot,mot_len)
    return dechiffrement_cesar(code,key)

def lire_dico(lang):
    with open("\TP-Algo\exo-45\dic_" + lang + ".txt","r") as file:
        return file.read().split("\n")

def recherche_trie_aux(tab,el,i,j):
    if j-i==1:
        return el == tab[i]
    else:
        m = (i+j)//2
        if tab[m]>el:
            return recherche_trie_aux(tab,el,i,m)
        else:
            return recherche_trie_aux(tab,el,m,j)

def recherche(mot,dico):
    return recherche_trie_aux(dico,mot,0,len(dico))

def score(get,dico):
    c=0
    for mot in get.split(" "):
        if recherche(mot,dico):
            c+=1
    return c

def brute_cesar(code):
    max = ["",0]
    dico = lire_dico("fr")
    for i in range(26):
        get = dechiffrement_cesar(code,i)
        c = score(get,dico)
        if max[1]<c:
            max = [get,c]
    return max[0]

def brute_vigenere(code):
    max = ["",0]
    dico = lire_dico("fr")
    for a in range(65,92):
        for b in range(65,92):
            for c in range(65,92):
                key = chr(a)+chr(b)+chr(c)
                get = dechiffrement_vigenere(code,key)
                c = score(get,dico)
                if max[1]<c:
                    max = [get,c]
    return max[0]

if __name__ == "__main__":
    doctest.testmod(verbose=False)
    #print(chiffrement_cesar("BONJOUR",3))
    #print(dechiffrement_cesar("ERQMRXU",3))

    #print(chiffrement_vigenere("BONJOUR TOUT LE MONDE","CHAT"))
    #print(dechiffrement_vigenere("DVNCQBR MQBT EG TOGFL","CHAT"))

    #print(dechiffrement_vigenere("DFDVU ZQIV ABIB FHUYWK O GEIVADWEX GG AHSYEIS","CODAGE"))

    #print(decrypt_cesar("KM UMAAIOM I MBM KPQNNZM IDMK CV LMKITIOM LM PCQB","C"))
    #print(decrypt_cesar_2("JCQ OSCQRGMLQ BC ACR CVCPAGAC MLR CRC RPGCCQ NYP MPBPC BCQ BGDDGASJRCQ","ONT"))
    #print(brute_cesar("JCQ OSCQRGMLQ BC ACR CVCPAGAC MLR CRC RPGCCQ NYP MPBPC BCQ BGDDGASJRCQ"))
    moy= 0
    rng = 10
    for i in range(rng):
        t1 = time.time()
        brute_vigenere("CP VRZMRLSMP KSE ZRPY LZTG L KXPIUEKR TR Y L J AFZRPY MZEEYY PZAR OKCCEPEKR OA VTMEYKRP")
        print(i)
        t2 = time.time()
        moy += t2-t1
    print(int(moy)/rng)