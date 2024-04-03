import doctest
import os
import socket
import threading
import json

BALISE_NEW_NAME = " __new_name__ :"
BALISE_MESSAGE = " __play__ :"
BALISE_QUIT = " __quit__ :"

IP = '127.0.0.1'
PORT = 5005
BUFFER = 65536

m_socket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

def affiche_grille(grille):
    """
    Affiche la grille de jeu
    
    :param grille: list
    :return: void

    >>> grille = [['X', 'O', 'X'], ['O', 'X', 'O'], ['X', 'O', 'X']]
    >>> affiche_grille(grille)
     0 | X O X\n     1 | O X O\n     2 | X O X\n        ------\n         A B C
    """
    for i in range(len(grille)):
        ligne = grille[i]
        key = str(i)
        if i < 10:
            key = " " + str(i)
        print(key + " | " + " ".join(ligne))
    len_raw = len(grille[0])
    print("    " + "--"*(len_raw))
    print("     " + " ".join([chr(i) for i in range(65,65+len_raw)]))

def send():
    while True:
        message = input()
        if message == "quit":
            m_socket.sendto(BALISE_QUIT.encode("utf-8"), (IP,PORT))
            return
        else:
            m_socket.sendto((BALISE_MESSAGE + message).encode("utf-8"), (IP,PORT))

def receive():
    while True:
        data,addr = m_socket.recvfrom(BUFFER)
        if data.decode("utf-8") == BALISE_QUIT:
            m_socket.close()
            return
        print(data.decode("utf-8"))
        grille = json.loads(data.decode("utf-8"))
        affiche_grille(grille)

pseudo = input("Entrez votre pseudo : ")
m_socket.sendto((BALISE_NEW_NAME + pseudo).encode("utf-8"), (IP,PORT))

# Création des processus
send_thread = threading.Thread ( target = send )
recv_thread = threading.Thread ( target = receive )

# Lancement des processus

send_thread.start()
recv_thread.start()