from function import *

print("\n-------- Exo 15 --------\n") 
#Echecs

"""
c1 = "F4" # definition d’une case c1
x1 = c1[0] # abscisse de c1 : attention aux crochets
y1 = c1[1] # ordonnee de c1
print( type (c1) ) # type str (string) : chaine de caracteres
print( x1 )
print( type (x1) )
print( y1 )
print( type (y1) )# encore de type str
c2 = "G2" # definition d’une autre case c2
x2 = c2[0]
y2 = c2[1]
#y1 - y2 # attention : erreur
y1 = int (y1) # convertion en int (integer : entier)
print( type (y1) )# la convertion a bien eu lieu
y2 = int (y2)
print( y1 - y2 )# maintenant ca marche
#x1 - x2 # erreur, bien sur
print( ord (x1) )# code entier du caractere "F"
print( ord (x1) - ord (x2) )# calcul de la difference des ordonnees
print( chr (66) )# reciproque de la fonction ord
print( str (8) )# convertion d’un entier en str
print( chr(67) + str (8) )# concatenation (mise bout-a-bout)


abcisse = [A,B,C,D,E,F,G,H]
ordonnee = range(1,9)

def deplace(case):
    case = case.split("")
    abc = abcisse.index(case[0])
    ord = ordonnee.index(case[1])
    -2 -1 -2 +1 +2 +2 +2 -1

"""