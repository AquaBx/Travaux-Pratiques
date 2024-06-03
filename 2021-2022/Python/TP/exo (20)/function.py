#--------------------------------------------- 20 ---------------------------------------------
def jean_petit_parole(list):
    """
        list : liste des parties du corps de Jean Petit qui danse
    """
    for i in range(len(list)):
        print("Jean Petit qui danse (bis)")    
        print("De", list[i] ,"il danse (bis)")
        for y in range(i,-1,-1) :
            print("De", list[y] , "," , list[y].split(" ")[1] , "," , list[y].split(" ")[1])
        print("Ainsi danse Jean Petit.")
        print("\n")