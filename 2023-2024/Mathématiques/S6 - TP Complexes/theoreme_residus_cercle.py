from sympy import *

z = symbols('z', complex=True)
num = eval(input('Donner le numerateur: '))
denom = eval(input('Donner le denominateur: '))

R = float(input('Donner le rayon du contour: '))

f = num/denom
D = solve(denom)
Factorization = str(factor(denom))
Res = 0

for i in range(len(D)):
    ## Voir si la racine est entourée par le contour
    if(Abs(D[i]) < R):
        ## Detecter l'ordre des racines autre que 0
        if(D[i] < 0):
            idc = Factorization.find('+ ' + str(abs(D[0])) + ')')
        else:
            idc = Factorization.find('- ' + str(abs(D[0])) + ')')
        
        if(Factorization[idc+4:idc+6] == '**'):
            m = int(Factorization[idc+6])
        else:
            m = 1
            
        ## Detecter si la racine est nulle
        if(D[i] == 0):
            if(Factorization[1:3] == '**'):
                m = int(Factorization(3))
            else:
                m = 1
        
        ## Calculer les residus
        Res_temp = (1/factorial(m-1))
        fct_to_derive = ((z-D[i])**m)*f
        for j in range(m-1):
            fct_to_derive = diff(fct_to_derive)
        fct_to_derive = fct_to_derive.replace(z, D[i])
        Res_temp = Res_temp*fct_to_derive
        Res = Res + Res_temp

result = 2*I*pi*Res
print('Résultat = ', result)