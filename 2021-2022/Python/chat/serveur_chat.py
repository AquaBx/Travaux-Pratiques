import socket
import threading

BALISE_NEW_NAME = " __new_name__ :"
BALISE_MESSAGE = " __message__ :"
BALISE_QUIT = " __quit__ :"

IP = '127.0.0.1'
PORT = 5005
BUFFER = 65536

adresses = {}

m_socket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
m_socket.bind( (IP, PORT) )

def send_entrance_notification(addr,name):
    if addr not in adresses:
        adresses[addr] = name
    for addrs in adresses:
        m_socket.sendto( ("\n***#"+name+"#*** vient de rentrer sur le chat !\n").encode("utf-8"), addrs )
    return

def send_message(addr,message):
    name = adresses[addr]
    for addrs in adresses:
        if addrs != addr:
            m_socket.sendto( ("[" + name + "] : " + message + "").encode("utf-8"), addrs )

def send_quit_notification(addr):
    name = adresses[addr]
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