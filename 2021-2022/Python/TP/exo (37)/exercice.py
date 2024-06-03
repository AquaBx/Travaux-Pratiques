from function import *

print("\n-------- Exo --------\n") 
#

x=10
n=100000

t1 = time.time()
expo_normale(x,n)
t2 = time.time()

print("durée normale ",t2-t1)


t1 = time.time()
expo_rapide(x,n)
t2 = time.time()

print("durée rapide ",t2-t1)