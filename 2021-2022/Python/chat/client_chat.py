import socket
import threading

BALISE_NEW_NAME = " __new_name__ :"
BALISE_MESSAGE = " __message__ :"
BALISE_QUIT = " __quit__ :"

IP = '127.0.0.1'
PORT = 5005
BUFFER = 65536

m_socket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

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

pseudo = input("Entrez votre pseudo : ")
m_socket.sendto((BALISE_NEW_NAME + pseudo).encode("utf-8"), (IP,PORT))

# Création des processus
send_thread = threading.Thread ( target = send )
recv_thread = threading.Thread ( target = receive )

# Lancement des processus
recv_thread.start()
send_thread.start()