#--------------------------------------------- 19 ---------------------------------------------
def simplifie_coord(coords):
    """
        Exo 19 : Simplifie coordonnées 
    """

    coords_fin = [[0,"n"],[0,"e"]]

    for item in coords:
        if item[1] == "n":
            coords_fin[0][0] += item[0]
        elif item[1] == "e":
            coords_fin[1][0] += item[0]
        elif item[1] == "o":
            coords_fin[1][0] -= item[0]
        elif item[1] == "s":
            coords_fin[0][0] -= item[0]
    
    return coords_fin