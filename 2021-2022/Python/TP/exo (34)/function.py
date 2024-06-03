import doctest

"""
    Plein de fonction cool
"""

def recherche_maximum(self):
    """
        Fonction qui prend en paramètre une liste supposée non vide
        Fonction qui retourne le maximum de la liste entrée

        >>> recherche_maximum([1,2,5])
        5
    """

    m = self[0]
    for i in self:
        if i > m:
            m = i
    return m

if __name__ == "__main__" :
    doctest.testmod(verbose=True)