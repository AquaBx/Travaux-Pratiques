import socket
import threading
import json

BALISE_NEW_NAME = " __new_name__ :"
BALISE_MESSAGE = " __play__ :"
BALISE_QUIT = " __quit__ :"

IP = '127.0.0.1'
PORT = 5005
BUFFER = 65536

adresses = {}

m_socket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
m_socket.bind( (IP, PORT) )

def send_entrance_notification(addr,name):
    if addr not in adresses:
        adresses[addr] = {"name":name}
    for addrs in adresses:
        m_socket.sendto( ("\n***#"+name+"#*** vient de rentrer sur le chat !\n").encode("utf-8"), addrs )
    return

def send_message(addr,message):
    name = adresses[addr]["name"]
    print("sended")
    for addrs in adresses:
        #json.dumps([["O","O"],["X","X"]])
        m_socket.sendto( ("zeraze").encode("utf-8"), addrs )
        print(addrs,adresses[addrs])

def send_quit_notification(addr):
    name = adresses[addr]["name"]
    m_socket.sendto( BALISE_QUIT.encode("utf-8"), addr )
    del adresses[addr]
    for addrs in adresses:
        m_socket.sendto( ( "\n***#"+name+"#*** à quitter le chat.\n").encode("utf-8"), addrs )
    return

def traite_data(addr,data):
    if data.startswith(BALISE_NEW_NAME):
        name = data.replace(BALISE_NEW_NAME,"")
        send_entrance_notification(addr,name)
    elif data.startswith(BALISE_MESSAGE):
        msg = data.replace(BALISE_MESSAGE,"")
        send_message(addr,msg)
    elif data == BALISE_QUIT:
        send_quit_notification(addr)

while True:

    data,client = m_socket.recvfrom(BUFFER)

    print(data)

    # client = (IP,PORT)

    traite_data(client,data.decode("utf-8"))





def grille_vide(i):
    """
    Création de la grille de jeu vide

    :param i: int
    :return: list

    >>> grille_vide(3)
    [['.', '.', '.'], ['.', '.', '.'], ['.', '.', '.']]
    """
    return [["." for j in range(i)] for y in range(i)]



def peut_jouer(grille,x,y):
    if y < 0 or y >= len(grille[0]):
        return False
    elif x < 0 or x >= len(grille):
        return False
    else:
        return grille[x][y] == "."

def joue(grille,x,y,joueur):
    grille[x][y] = joueur

def a_gagne_vert(grille,joueur):
    for j in range(len(grille[0])):
        for i in range(len(grille)-4):
            if grille[i][j] == grille[i+1][j] == grille[i+2][j] == grille[i+3][j] == grille[i+4][j] == joueur:
                return True
    return False

def a_gagne_hor(grille,joueur):
    for i in range(len(grille)):
        for j in range(len(grille[0])-4):
            if grille[i][j] == grille[i][j+1] == grille[i][j+2] == grille[i][j+3] == grille[i][j+4] == joueur:
                return True
    return False

def a_gagne_diag1(grille,joueur):
    for i in range(len(grille)-4):
        for j in range(len(grille[0])-4):
            if grille[i][j] == grille[i+1][j+1] == grille[i+2][j+2] == grille[i+3][j+3] == grille[i+4][j+4] == joueur:
                return True
    return False

def a_gagne_diag2(grille,joueur):
    for i in range(len(grille)-4):
        for j in range(len(grille[0])-1,3,-1):
            if grille[i][j] == grille[i+1][j-1] == grille[i+2][j-2] == grille[i+3][j-3] == grille[i+4][j-4] == joueur:
                return True
    return False

def a_gagne(grille,joueur):
    if joueur in ["X","O"]:
        return a_gagne_vert(grille,joueur) or a_gagne_hor(grille,joueur) or a_gagne_diag1(grille,joueur) or a_gagne_diag2(grille,joueur)
    else:
        return False

def grille_pleine(grille):
    for i in range(len(grille)):
        for j in range(len(grille[0])):
            if grille[i][j] == ".":
                return False
    return True

if __name__ == "__main__" :
    doctest.testmod()

    grille = grille_vide(15)
    #grille[4][0] = "X"
    #grille[3][0] = "X"
    #grille[2][0] = "X"
    #grille[1][0] = "X"
    #grille[0][0] = "X"
    #print(a_gagne(grille,"X"))

while True:
    affiche_grille(grille)
    x = int(input("X : "))
    y = int(input("Y : "))
    joueur = input("Joueur : ")
    if peut_jouer(grille,x,y):
        joue(grille,x,y,joueur)
        if a_gagne(grille,joueur):
            print("Gagné !")
            break
        elif grille_pleine(grille):
            print("Match nul !")
            break
    else:
        print("Impossible de jouer ici")