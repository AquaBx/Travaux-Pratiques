#-------------------------------------------- 28 --------------------------------------------

def traduire_texte_vers_morse(texte,dict):
    te = ""
    for le in texte:
        if le == " ":
            te+=" "
        else:
            te += dict[le]
            te+=" "
    return te

def reverse_dict(dict):
    dict2 = {}
    for key in dict:
        val = dict[key]
        dict2[val] = key
    return dict2

def traduire_morse_vers_texte(text,dict):
    dict = reverse_dict(dict)
    text = text.split(' ')
    for i in range(len(text)):
        if text[i] == "":
            text[i] = " "
        else:
            text[i] = dict[text[i]]
    return "".join(text)