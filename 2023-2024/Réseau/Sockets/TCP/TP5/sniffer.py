import socket

RAW = socket.socket(socket.AF_PACKET,socket.SOCK_RAW,socket.htons(0x0003))

while True:
    print( RAW.recvfrom(65565) )