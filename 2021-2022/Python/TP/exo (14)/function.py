#--------------------------------------------- 14 ---------------------------------------------
def code_correcteur(a1,a2,a3,b,c):
    """
        Code correcteur de l'exercice 14
    """

    if (a1 + a2 + a3 != b and a1 + 2*a2 + 3*a3 == c):
        print("b faux")
        print("b =" , a1+a2+a3)

    elif (a1 + 2*a2 + 3*a3 != c and a1 + a2 + a3 == b):
        print("c faux")
        print("c =" , a1+2*a2+3*a3)
    elif (a1 + 2*a2 + 3*a3 != c and a1 + a2 + a3 != b):
        if (c-b == a2+2*a3):
            print("a1 faux")
            print("a1 =" , b-a2-a3)

        elif (c-2*b == -a1+a3):
            print("a2 faux")
            print("a2 =" , b-a1-a3)

        elif (c-3*b == -2*a1-a2):
            print("a3 faux")
            print("a3 =" , b-a1-a2)
    else:
        print("les cinq sont bons")