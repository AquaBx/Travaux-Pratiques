import doctest


def generer_grille_vide(nb_col,nb_lig):
    """
    entrées : (nom, type)
    - nb_col , integer
    - nb_lig , integer

    sortie : (type)
    - liste de listes d'entier

    test :
    >>> generer_grille_vide(7,6)
    [[0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0]]
    >>> generer_grille_vide(8,4)
    [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]]
    >>> generer_grille_vide(2,6)
    [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]
    """
    return [[0 for x in range(nb_col)] for y in range(nb_lig)]

def affiche_grille(grille):
    """
    entrées : (nom, type)
    - grille , liste

    sortie : (type)
    - none

    test :
    >>> affiche_grille([[1,1,2,1,2,1,1],[2,1,2,2,1,2,2],[0,2,1,1,0,1,2],[0,1,2,2,0,0,0],[0,1,2,1,0,0,0],[0,0,0,0,0,0,0]])
    +-+-+-+-+-+-+-+
    | | | | | | | |
    +-+-+-+-+-+-+-+
    | |X|O|X| | | |
    +-+-+-+-+-+-+-+
    | |X|O|O| | | |
    +-+-+-+-+-+-+-+
    | |O|X|X| |X|O|
    +-+-+-+-+-+-+-+
    |O|X|O|O|X|O|O|
    +-+-+-+-+-+-+-+
    |X|X|O|X|O|X|X|
    +-+-+-+-+-+-+-+
     0 1 2 3 4 5 6
    >>> affiche_grille([[0,1,2,2],[0,1,2,1],[0,0,0,0]])
    +-+-+-+-+
    | | | | |
    +-+-+-+-+
    | |X|O|X|
    +-+-+-+-+
    | |X|O|O|
    +-+-+-+-+
     0 1 2 3
    >>> affiche_grille([[2,1,0,2],[2,1,0,2],[2,1,0,2]])
    +-+-+-+-+
    |O|X| |O|
    +-+-+-+-+
    |O|X| |O|
    +-+-+-+-+
    |O|X| |O|
    +-+-+-+-+
     0 1 2 3
    """

    nb_col = len(grille[0])
    sep = "+-"*nb_col+"+"
    for i in range(len(grille)-1,-1,-1):
        print(sep)
        l = "|"
        for col in grille[i]:
            if col == 1:
                l += "X|"
            elif col == 2:
                l += "O|"
            else:
                l += " |"
        print(l)
    print(sep)
    print(" " + " ".join([str(x) for x in range(nb_col)]))

def peut_jouer(grille,colonne):
    """
    entrées : (nom, type)
    - grille , liste de listes d'entier
    - colonne, integer

    sortie : (type)
    - booléen

    test :
    >>> peut_jouer([[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],7)
    False
    >>> peut_jouer([[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],2)
    True
    >>> peut_jouer([[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0]],3)
    False
    >>> peut_jouer([[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0]],-1)
    False
    >>> peut_jouer([[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],0)
    True
    """
    if colonne < 0 or colonne >= len(grille[0]):
        return False
    else:
        return grille[-1][colonne] == 0

def joue(grille,colonne,joueur):
    """
    entrées : (nom, type)
    - grille , liste de listes d'entier
    - colonne, integer
    - joueur, integer

    sortie : (type)
    - none
    """
    for line in grille:
        if line[colonne] == 0:
            line[colonne] = joueur
            return

def a_gagne_vert(grille,joueur):
    """
    entrées : (nom, type)
    - grille , liste de listes d'entier
    - joueur, integer

    sortie : (type)
    - booléen

    test:
    >>> a_gagne_vert([[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],1) #Vertical
    True
    >>> a_gagne_vert([[0,0,0,0,0],[0,1,1,1,1],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]],1) #Horizontal
    False
    >>> a_gagne_vert([[0,1,0,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,0,0,0,1],[0,0,0,0,0]],1) #Diagonale1
    False
    >>> a_gagne_vert([[0,0,0,0,1],[0,0,0,1,0],[0,0,1,0,0],[0,1,0,0,0],[0,0,0,0,0]],1) #Diagonale2
    False

    >>> a_gagne_vert([[1,0,0,0,0],[0,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0]],1)
    False

    >>> a_gagne_vert([[0,0,0,0,1],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],1)
    False
    >>> a_gagne_vert([[0,0,1,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,0,0,0,1],[0,0,0,0,0]],1)
    False
    >>> a_gagne_vert([[1,0,0,0,0],[0,0,0,0,1],[1,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0]],1) #Diagonale2
    False
    """
    for j in range(len(grille[0])):
        for i in range(len(grille)-3):
            if grille[i][j] == grille[i+1][j] == grille[i+2][j] == grille[i+3][j] == joueur:
                return True
    return False

def a_gagne_hor(grille,joueur):
    """
    entrées : (nom, type)
    - grille , liste de listes d'entier
    - joueur, integer

    sortie : (type)
    - booléen

    test:
    >>> a_gagne_hor([[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],1) #Vertical
    False
    >>> a_gagne_hor([[0,0,0,0,0],[0,1,1,1,1],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]],1) #Horizontal
    True
    >>> a_gagne_hor([[0,1,0,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,0,0,0,1],[0,0,0,0,0]],1) #Diagonale1
    False
    >>> a_gagne_hor([[0,0,0,0,1],[0,0,0,1,0],[0,0,1,0,0],[0,1,0,0,0],[0,0,0,0,0]],1) #Diagonale2
    False

    >>> a_gagne_hor([[1,0,1,1,1],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]],1)
    False

    >>> a_gagne_hor([[0,0,0,0,1],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],1)
    False
    >>> a_gagne_hor([[0,0,1,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,0,0,0,1],[0,0,0,0,0]],1)
    False
    """
    for i in range(len(grille)):
        for j in range(len(grille[0])-3):
            if grille[i][j] == grille[i][j+1] == grille[i][j+2] == grille[i][j+3] == joueur:
                return True
    return False

def a_gagne_diag1(grille,joueur):
    """
    entrées : (nom, type)
    - grille , liste de listes d'entier
    - joueur, integer

    sortie : (type)
    - booléen

    test:
    >>> a_gagne_diag1([[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],1) #Vertical
    False
    >>> a_gagne_diag1([[0,0,0,0,0],[0,1,1,1,1],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]],1) #Horizontal
    False
    >>> a_gagne_diag1([[0,1,0,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,0,0,0,1],[0,0,0,0,0]],1) #Diagonale1
    True
    >>> a_gagne_diag1([[0,0,0,0,1],[0,0,0,1,0],[0,0,1,0,0],[0,1,0,0,0],[0,0,0,0,0]],1) #Diagonale2
    False

    >>> a_gagne_diag1([[0,0,0,0,1],[1,0,0,0,0],[0,1,0,0,0],[0,0,1,0,0]],1)
    False

    >>> a_gagne_diag1([[0,0,0,0,1],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],1)
    False
    >>> a_gagne_diag1([[0,0,1,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,0,0,0,1],[0,0,0,0,0]],1)
    False
    """
    for i in range(len(grille)-3):
        for j in range(len(grille[0])-3):
            if grille[i][j] == grille[i+1][j+1] == grille[i+2][j+2] == grille[i+3][j+3] == joueur:
                return True
    return False

def a_gagne_diag2(grille,joueur):
    """
    entrées : (nom, type)
    - grille , liste de listes d'entier
    - joueur, integer

    sortie : (type)
    - booléen

    test:
    >>> a_gagne_diag2([[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],1) #Vertical
    False
    >>> a_gagne_diag2([[0,0,0,0,0],[0,1,1,1,1],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]],1) #Horizontal
    False
    >>> a_gagne_diag2([[0,1,0,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,0,0,0,1],[0,0,0,0,0]],1) #Diagonale1
    False
    >>> a_gagne_diag2([[0,0,0,0,1],[0,0,0,1,0],[0,0,1,0,0],[0,1,0,0,0],[0,0,0,0,0]],1) #Diagonale2
    True

    >>> a_gagne_diag2([[1,2,2,1,2],[2,1,1,2,1],[1,1,2,1,2],[1,2,0,0,0]],1)
    True

    >>> a_gagne_diag2([[1,0,0,0,0],[0,0,0,0,1],[0,0,0,1,0],[0,0,1,0,0]],1)
    False

    >>> a_gagne_diag2([[0,0,0,0,1],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],1)
    False
    >>> a_gagne_diag2([[0,0,1,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,0,0,0,1],[0,0,0,0,0]],1)
    False
    """
    for i in range(len(grille)-3):
        for j in range(len(grille[0])-1,2,-1):
            if grille[i][j] == grille[i+1][j-1] == grille[i+2][j-2] == grille[i+3][j-3] == joueur:
                return True
    return False

def a_gagne(grille,joueur):
    """
    entrées : (nom, type)
    - grille , liste de listes d'entier
    - joueur, integer

    sortie : (type)
    - booléen

    test:
    >>> a_gagne([[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],1) #Vertical
    True
    >>> a_gagne([[0,0,0,0,0],[0,1,1,1,1],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]],1) #Horizontal
    True
    >>> a_gagne([[0,1,0,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,0,0,0,1],[0,0,0,0,0]],1) #Diagonale1
    True
    >>> a_gagne([[0,0,0,0,1],[0,0,0,1,0],[0,0,1,0,0],[0,1,0,0,0],[0,0,0,0,0]],1) #Diagonale2
    True

    >>> a_gagne([[0,0,0,0,1],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,1,0],[0,0,0,0,0]],1)
    False
    >>> a_gagne([[0,0,1,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,0,0,0,1],[0,0,0,0,0]],1)
    False

    >>> a_gagne([[1,0,0,0,0],[0,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0]],1)
    False
    >>> a_gagne([[1,0,1,1,1],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]],1)
    False
    >>> a_gagne([[0,0,0,0,1],[1,0,0,0,0],[0,1,0,0,0],[0,0,1,0,0]],1)
    False
    >>> a_gagne([[1,0,0,0,0],[0,0,0,0,1],[0,0,0,1,0],[0,0,1,0,0]],1)
    False
    """
    if joueur in [1,2]:
        return a_gagne_vert(grille,joueur) or a_gagne_hor(grille,joueur) or a_gagne_diag1(grille,joueur) or a_gagne_diag2(grille,joueur)
    else:
        return False

def grille_pleine(grille):
    """
    entrées : (nom, type)
    - grille , liste de listes d'entier

    sortie : (type)
    - booléen

    test:
    >>> grille_pleine([[1,1,2,1,1],[2,2,1,2,2]])
    True
    >>> grille_pleine([[1,1,2,1,1],[2,2,1,0,2]])
    False
    >>> grille_pleine([[1,0,1,2,1],[1,0,1,0,2]])
    False
    """
    return 0 not in grille[-1]

def boucle_principale():
    grille = generer_grille_vide(7,6)
    joueur_courant = 1
    while not grille_pleine(grille):
        affiche_grille(grille)
        pro_coup = int(input("Prochain coup : "))
        while not peut_jouer(grille,pro_coup):
            print("Le coup n'est pas valable, veuillez rejouer")
            affiche_grille(grille)
            pro_coup = int(input("Prochain coup : "))
        joue(grille,pro_coup,joueur_courant)
        if a_gagne(grille,joueur_courant):
            print("Le joueur " + str(joueur_courant) + " à gagner")
            return 0
        if joueur_courant == 1 :
            joueur_courant = 2
        else:
            joueur_courant = 1
    print("Match Nul")

if __name__ == "__main__" :
    doctest.testmod()
    boucle_principale()