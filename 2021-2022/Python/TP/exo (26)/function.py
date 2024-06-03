#-------------------------------------------- 26 --------------------------------------------

def get_nom(dict,num):
    if num in dict:
        return dict[num]
    else: 
        return 0


def get_num(dict,nom):
    for key,item in dict.items():
        if item == nom:
            return key
    return 0

def multi(dict,multi):
    liste = []
    for key,item in dict.items():
        if key%multi == 0:
            liste.append(item)
    return liste

def commence_par(dict,lettre):
    liste = []
    for key,item in dict.items():
        if item[0] == lettre:
            liste.append(key)
    return liste