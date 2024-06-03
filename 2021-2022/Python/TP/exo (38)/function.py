#--------------------------------------------- ---------------------------------------------
import doctest
import time
def recherche(tab,el):
    """
    >>> recherche([1,2,3],1)
    True

    >>> recherche([1,2,3],7)
    False
    """
    for item in tab:
        if item == el:
            return True
    return False

def recherche_trie_aux(tab,el,i,j):
    if j-i==1:
        return el == tab[i]
        
    else:
        m = (i+j)//2
        
        if tab[m]>el:
            return recherche_trie_aux(tab,el,i,m)
        else:
            return recherche_trie_aux(tab,el,m,j)
    
def recherche_trie(tab,el):
    """
    >>> recherche_trie([1,2,3],1)
    True

    >>> recherche_trie([1,2,3],7)
    False
    """
    return recherche_trie_aux(tab,el,0,len(tab))

if __name__ == "__main__" :
    doctest.testmod(verbose=True)