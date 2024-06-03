from function import *
import numpy as np
import math

print("\n-------- Exo 31 --------\n")
#Exo 31

print("np.zeros(7)","\n",np.zeros(7))
print("np.ones(6)","\n",np.ones(6))
print("np.identity(3)","\n",np.identity(3))
print("np.array([3,7,-1,2])","\n",np.array([3,7,-1,2]))
print("np.array([[3,7],[-1,2]])","\n",np.array([[3,7],[-1,2]]))
print("np.arange(10,30,5)","\n",np.arange(10,30,5))
print("np.linspace(0,2,9)","\n",np.linspace(0,2,9))
print("np.sin(np.linspace(0,2*np.pi,20))","\n",np.sin(np.linspace(0,2*np.pi,20)))
#print("math.sin(np.linspace(0,2*np.pi,20))","\n",math.sin(np.linspace(0,2*np.pi,20))) marche pas car liste en param

a = np.array([[1,3],[0,4]])
b = np.array([[4,0],[-1,1]])

print("a+b","\n",a+b)
print("a+4","\n",a+4)
print("a*b","\n",a*b)
print("3*a","\n",3*a)
print("a*3","\n",a*3)
print("np.add(a,b)","\n",np.add(a,b))
print("a.dot(b)","\n",a.dot(b)) # A x B
print("a @ b","\n",a @ b) # A * B
print("a.transpose()","\n",a.transpose())
print("np.linalg.matrix_power(a,2)","\n",np.linalg.matrix_power(a,2)) # A x A
print("a.shape","\n",a.shape)

print("a.sum()","\n",a.sum())
print("a.sum(axis=0)","\n",a.sum(axis=0))
print("a.sum(axis=1)","\n",a.sum(axis=1))
print("a.min()","\n",a.min())
print("a.max()","\n",a.max())
print("a[1]","\n",a[1])
print("a[0,1]","\n",a[0,1])
print("a[0][1]","\n",a[0][1])

print("u(11)",u(11))