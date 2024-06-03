#--------------------------------------------- 12 ---------------------------------------------
def match(n):
    """
        Exo 12 : Génère le tableau des matchs sans restrictions budgétaires
    """
    for i in range(1,n+1):
        for j in range(1,n):
            if j!=i:
                print("L’equipe",i,"se deplace contre l’equipe",j)

def match_restrict(n):
    """
        Exo 12 : Génère le tableau des matchs avec restrictions budgétaires
    """
    x=1
    for i in range(1,n+1):
        for j in range(1,x):
            if j!=i:
                print("L’equipe",i,"se deplace contre l’equipe",j)
        x+=1