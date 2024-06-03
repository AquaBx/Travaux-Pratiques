from function import *

print("\n-------- Exo 24 --------\n")
#Exo 24:

personne = [0,1,2,3,4,5,6,7,8]
parent = [-1,6,8,0,8,7,0,6,6]

def premiere_generation(p,i):
    if p[i] == 0 :
        return True
    else:
        return False
def nb_enfant(p,i):
    return p.count(i)

def cheveux_roses(p):
    return len([i for i in range(len(p)) if p[i]%2 == 0 or p[i] == -1])

def generation(i):
    parent = [0]
    p = [-1,6,8,0,8,7,0,6,6]
    for gen in range(i):
        npar = []
        for par in parent:
            npar += [x for x in range(len(p)) if p[x] == par]
        parent = npar.copy()
    return len(parent),parent


print(premiere_generation([-1,6,8,0,8,7,0,6,6],6))
print(premiere_generation([-1,6,8,0,8,7,0,6,6],5))
print(nb_enfant([-1,6,8,0,8,7,0,6,6],6))
print(cheveux_roses([-1,6,8,0,8,7,0,6,6]))
print(generation(3))

def descendant(i,j,p):
    """si j est un descendant de i"""
    
    list = [j]

    while p[list[-1]] != -1:
        list.append(p[list[-1]])

    return i in list

print(descendant(6,2,[-1,6,8,0,8,7,0,6,6]))
print(descendant(3,1,[-1,6,8,0,8,7,0,6,6]))


def nb_descendant(i,p):
    """si j est un descendant de i"""
    
    """à faire"""