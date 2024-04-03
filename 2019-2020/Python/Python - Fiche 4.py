def triangle(nb):
    nb_etoile=0
    nb_space=nb
    etoile = "*"
    space=' '

    for i in range(0,nb):
        print(nb_space*space + 2*nb_etoile*etoile+etoile)
        nb_etoile+=1
        nb_space-=1


triangle(46)
