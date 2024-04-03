import socket as sock
import sys
import datetime

s = sock.socket(sock.AF_INET, sock.SOCK_STREAM)

s.bind(("",80))

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
        key,value = liste[0],",".join(liste[1:])
        dico[key] = value

    if dico["page"].endswith("/"):
        dico["page"] += "index.html"

    return dico


while True:
    s.listen()
    conn, addr = s.accept()
    
    data = conn.recv(1024)

    headers = DecodeHTTPHeader(data.decode())

    if headers["method"] == "GET":
        try :
            with open("./www" + headers["page"]) as file:
                content = file.read()
                req =  f'HTTP/1.0 200 OK\r\n'

        except :
            content = f'<HTML><BODY>Error 404</BODY></HTML>'
            req =  f'HTTP/1.0 404 NOT FOUND\r\n'
    else : 
        content = f'<HTML><BODY>Error 403</BODY></HTML>'
        req =  f'HTTP/1.0 403 Forbidden\r\n'


    req += f'Content-Type:text/html\r\n'
    req += f'Content-Length: {len(content)}\r\n\r\n'
    req += f'{content}\r\n'
    
    conn.sendall(req.encode())