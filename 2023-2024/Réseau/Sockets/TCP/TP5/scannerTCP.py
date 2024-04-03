import socket as sock

host = "127.0.0.1"

for port in [21, 22, 80, 139, 443, 661, 8080]:
    try :
        s = sock.socket(sock.AF_INET, sock.SOCK_STREAM)
        s.settimeout(10)
        s.connect((host,port))
        s.close()
        print(f'Port {port} ouvert')
    except:
        print(f'Port {port} fermé')
