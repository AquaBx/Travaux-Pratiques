#-------------------------------------------- 27 --------------------------------------------

def occurrences_lettre(texte):
    dict = {}

    for lettre in texte:
        if lettre in dict:
            dict[lettre] +=1
        else:
            dict[lettre] = 1
    
    return dict
def pourcent_lettre(texte):
    dict = {}
    l = len(texte)

    for lettre in texte:
        if lettre in dict:
            dict[lettre] +=1
        else:
            dict[lettre] = 1
    
    for key,val in dict.items():
        dict[key] = val/l*100

    return dict