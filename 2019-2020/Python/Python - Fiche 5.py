#Exercice 1
L=[10,20,30,10,20,60,100]

def moyenne():
    tot=0
    for i in L:
        tot +=i
    tot /= len(L)
    print(tot)

def add():
    tot=0
    for i in L:
        tot +=i
    print(tot)

add()
moyenne()
#Exercice 2

L = [20,41,52,41,20,78,41,63,52,20]

for item in L:
    nb= L.count(item)
    for i in range(nb-1):
        L.remove(item)

print(L)

#Exercice 3

L = [10,20,30,10,20,60,100]
comprehension = []

for item in L:
    while item < 50 :
        item *= 2
    comprehension.append(item)

print(comprehension)

#Exercice 4
tuple=(40,20)

def augmenter_taille():
    v1= tuple[0]*1.1
    v2= tuple[1]*0.85
    print(v1,v2)
augmenter_taille()

#Exercice 5

#il donne la longueur des var ds la liste

#Exercice 6

# pour chaque var il attribue un chiffre et l'affiche en vertical.
