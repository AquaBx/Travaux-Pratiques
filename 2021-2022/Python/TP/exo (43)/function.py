#--------------------------------------------- ---------------------------------------------
import matplotlib.pyplot as plt

def draw_points_from_file(fichier:str):
    with open(fichier) as file:
        liste = file.read().split("\n")[:-1]

        x = []
        y = []

        for item in liste:
            points = item.split(" ")
            x.append(float(points[0]))
            y.append(float(points[1]))

        plt.plot(x,y)
        plt.show()


draw_points_from_file("points.dat")
