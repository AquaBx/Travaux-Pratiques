#--------------------------------------------- ---------------------------------------------

def moyenne(fichier:str):
    dico = {}
    with open(fichier) as file:
        eleves = file.read().split("\n")[:-1]
        for item in eleves:
            items = item.split(";")
            num = int(items[0])
            i=0
            tot = 0
            for note in items[1:]:
                tot += float(note)
                i+=1
            dico[num] = tot/i
    return dico

def exporte_moyenne(dict_moyennes,nom_fichier):
    with open(nom_fichier,"w") as file:
        file.writelines([str(cle) + ";" + str(dict_moyennes[cle]) + "\n" for cle in dict_moyennes])
        

exporte_moyenne(moyenne("notes_etudiants.csv"),"lol.csv")