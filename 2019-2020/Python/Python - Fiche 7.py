#Exercice 1

langue_fr_bzhg = {"bonjour" : "demat", "au revoir" : "kenavo", "bon" : "mat","bonne nuit" : "noz vat", "informatique" : "stlenneg"}

for key in langue_fr_bzhg:
    print(key + " -> " + langue_fr_bzhg[key])


#Exercice 2

dico2 = {}
dico_symbole_bzh = {
    "ajonc" : "Plante qui fleurit sur toutes les landes de la Bretagne",
    "hermine" : "Petit mammifère carnivore qui apparait sur les drapeaux de la Bretagne depuis 1316",
    "devise" : "Plutôt la mort que la souillure",
    "hymne" : "Bro Gozh Ma Zadoù qui signifie Le vieux pays de mes Pères",
    "triskell" : "Symbole celtique à trois branches qui représentent l'eau, la terre et le feu",
    "gwenn-ha-du" : "nom du drapeau breton",
    "bzh" : "abréviation de breizh (<< Bretagne >> en langue bretonne) et l'extension internet .bzh"
}


list_tri = []
for key in dico_symbole_bzh:
    list_tri.append([len(dico_symbole_bzh[key]), key])
    list_tri.sort(reverse=True)

for i in range(len(list_tri)):
    vid = list_tri[i][1]
    print(vid + " : " + dico_symbole_bzh[vid])


#Exercice 3

immat_vendeur = {
    "AB 456 TY": "Erwan",
    "ZZ 852 JJ": "Gwen",
    "DD 563 HH": "Yann"
}

def call(immat):
    if immat in immat_vendeur:
        print(immat_vendeur[immat])
    else :
        print("rien")

def ajouter_vehicule(liste):
    for i in liste:
        immat_vendeur[i[0]] = i[1]

def supprimer_vehicule(immat):
    if immat in immat_vendeur:
        del (immat_vendeur[immat])
    else :
        print("rien")

liste1 = [("lol","loe")]


ajouter_vehicule(liste1)
supprimer_vehicule("lol")
call("lol")

for key in immat_vendeur:
    print("Le véhicule " + key + " est conduit par " + immat_vendeur[key])
