from function import *

print("\n-------- Exo --------\n") 
#

n = 10000000

liste = list(range(n))

t1 = time.time()
print( recherche(liste,n) )
t2 = time.time()

print("durée normale ",t2-t1)


t1 = time.time()
print( recherche_trie(liste,n) )
t2 = time.time()

print("durée rapide ",t2-t1)