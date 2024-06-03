from function import *

print("\n-------- Exo 29 --------\n")
#Exo 29:

reseau = {
"Arthur" : ["Benjamin", "Emmanuel"],
"Benjamin" : ["Arthur", "Gwenael", "Chloé"],
"Chloé" : ["Benjamin", "Gwenael"],
"Delphine" : ["Emmanuel", "Florian"],
"Emmanuel" : ["Arthur", "Gwenael", "Delphine"],
"Florian" : ["Delphine", "Gwenael"],
"Gwenael" : ["Florian", "Benjamin", "Emmanuel", "Chloé"],
"Hervé" : ["Inès"],
"Inès" : ["Hervé"]
}

def plus_damis(reseau):
    max = 0
    indice = 0
    for key in reseau:
        if len(reseau[key])>max:
            indice = key
            max = len(reseau[key])
    return indice

def amis_commun(reseau,n1,n2):
    l1 = reseau[n1]
    l2 = reseau[n2]
    return [a for a in l1 if a in l2]

def amis_des_amis(reseau,nom):
    res = []
    marque = {}
    aTraiter = [n for n in reseau[nom]]
    for n in reseau:
        marque[n] = False
    marque[nom] = True
    while aTraiter != []:
        n = aTraiter.pop()
        if not marque[n]:
            res.append(n)
            marque[n] = True
            aTraiter += reseau[n]
    return res

print('plus_damis(reseau)',plus_damis(reseau))
print('amis_commun(reseau,"Florian","Emmanuel")',amis_commun(reseau,"Florian","Emmanuel"))
print('amis_des_amis(reseau,"Arthur")',amis_des_amis(reseau,"Arthur"))

def affinite(reseau,nom,nom2):
    aTraiter = [n for n in reseau[nom]]
    i=1
    marque = {}
    
    for n in reseau:
        marque[n] = False
    marque[nom] = True

    while aTraiter != [] and nom2 not in aTraiter:
        nlist = []
        for item in aTraiter:
            marque[item] = True
        for item in aTraiter:
            nlist += [x for x in reseau[item] if not marque[x] and x not in nlist]
        aTraiter = nlist.copy()
        i+=1
    if nom2 in aTraiter:
        return i
    else :
        return "inf"

print('affinite(reseau,"Arthur","Florian")',affinite(reseau,"Arthur","Florian"))
print('affinite(reseau,"Gwenael","Inès")',affinite(reseau,"Gwenael","Inès"))