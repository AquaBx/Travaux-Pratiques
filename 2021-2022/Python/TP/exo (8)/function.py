#--------------------------------------------- 08 ---------------------------------------------

def calculimpot1(revenu):
    if revenu < 5875:
        return 0
    else:
        return 5.5/100*(revenu-5875)

def calculimpot2(revenu):
    if revenu < 5875:
        return 0
    elif revenu < 11720:
        return 5.5/100*(revenu-5875)
    else:
        return 14/100*revenu-1319.33

def calculimpot3(revenu):
    if revenu < 5875:
        return 0
    else :
        if revenu < 11720:
            return 5.5/100*(revenu-5875)
        else:
            return 14/100*revenu-1319.33

def calculimpot4(revenu):
    if revenu < 5875:
        return 0
    elif revenu < 11720:
        return 5.5/100*(revenu-5875)
    elif revenu < 26030:
        return 14/100*revenu-1319.33
    elif revenu < 69783:
        return 30/100*revenu-5484.13
    else:
        return 40/100*revenu-12462.43

def calculimpotsmars(revenu,cratere):
    if cratere:
        if revenu < 4800:
            return 0.12*revenu
        else:
            return 0.25*revenu-624
    else:
        if revenu < 4800:
            return 0
        else:
            return 0.12*revenu-576