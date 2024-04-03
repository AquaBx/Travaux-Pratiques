import socket as sock
import sys

def DecodeHTTPHeader(header) : 
    dico = {}
    splitted = header.split("\r\n")
    for i in range(len(splitted)) :
        item = splitted[i]
        if (item == ""):
            break
        elif i == 0 :
            liste = item.split(" ")
            dico["method"] = liste[0] 
            dico["page"] = liste[1]
            dico["version"] = liste[2] 
            
            continue

        liste = item.split(": ")
        key,value = liste[0].lower(),",".join(liste[1:])
        dico[key] = value

    if dico["page"].endswith("/"):
        dico["page"] += "index.html"

    return dico

def printMsg():
    data = ""
    headers = ""
    content = b""
    taille = 1

    while not "\r\n\r\n" in data:
        data += s.recv(1024).decode()

    splitted = data.split("\r\n\r\n")
    headers = splitted[0]
    content = splitted[1].encode()
    
    lenContent = int(DecodeHTTPHeader(headers)["content-length"])

    while len(content) < lenContent:
        content += s.recv(1024)
    
    print("-------------- HEADER --------------")
    print()
    print(headers)
    print()
    print("--------------- BODY ---------------")
    print()
    print(content.decode())

if len(sys.argv) < 3:
    sys.exit("Usage : python clientHTTP.py {METHOD} {URL}")

s = sock.socket(sock.AF_INET, sock.SOCK_STREAM)
args = sys.argv[2].split("/")

method = sys.argv[1]

host = args[0]
page = "/".join(args[1:])
port = 80

s.connect((host,port))
s.sendall(f"{method} /{page} HTTP/1.1\r\nHOST: {host}\r\n\r\n".encode())

printMsg()