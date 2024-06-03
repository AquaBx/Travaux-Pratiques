#--------------------------------------------- ---------------------------------------------

with open("fichier.txt","r") as file:
    print(file.read())

with open("lol.txt","w") as file:
    file.write("Voici le nouveau\ncontenu du fichier !")

with open("lol.txt","r") as file:
    print(file.read())