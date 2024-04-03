import socket
import doctest

ex_requete_http1="GET /page1.html HTTP/1.1\r\nHost: localhost\r\nAccept-Language: fr-FR,en;q=0.3\r\nUser-Agent: Mozilla/5.0 Firefox/98.0\r\n\r\n"
ex_requete_http2="GET /pages/index.html HTTP/1.1\r\nHost: localhost\r\nAccept-Language: fr\r\n\r\n"
ex_requete_http3="GET /autres_pages/toto.html HTTP/1.1\r\nHost: localhost\r\n\r\n"

def decode_requete_http(requete) :
    """
    >>> a,b = decode_requete_http(ex_requete_http1)
    >>> a == "/page1.html"
    True
    >>> len(b)
    3
    >>> b["Host"] == "localhost"
    True
    >>> b["Accept-Language"] == "fr-FR,en;q=0.3"
    True
    >>> b["User-Agent"] == "Mozilla/5.0 Firefox/98.0"
    True
    """
    req=requete.split("\r\n")
    page = req[0].split(" ")[1]
    options = {}
    for item in req[1:]:
        cp=item.split(": ")
        if len(cp)>1:
            options[cp[0]]=cp[1]
    return page,options

def get_reponse(url_page) :
    """
    >>> a = get_reponse("pages_serveur/fr/pages/index.html")
    >>> a == "HTTP/1.0 200 OK\\r\\nContent-Type:text/html\\r\\nContent-Length:74\\r\\n\\r\\n<!DOCTYPE html>\\n<html>\\n<body>\\n<h1>Voici index.html !</h1>\\n</body>\\n</html>\\r\\n"
    True
    >>> b = get_reponse("page_non_existante")
    >>> b == "HTTP/1.0 404 NotFound\\r\\nContent-Type:text/html\\r\\nContent-Length:173\\r\\n\\r\\n<!DOCTYPE html>\\n<html>\\n<head><title>404 Not Found</title></head><body>\\n<h1>Page non trouvée !!</h1>\\n<p>L'URL demandée n'a pas été trouvée sur ce serveur.</p></body>\\n</html>\\r\\n"
    True
    """
    try:
        with open(url_page,encoding='utf-8') as f:
            code = "200 OK"
            content = f.read()
    except:
        with open("pages_serveur/page404.html",encoding='utf-8') as f:
            code = "404 NotFound"
            content = f.read()
    return "HTTP/1.0 " + code + "\r\nContent-Type:text/html\r\nContent-Length:" + str( len(content) + 1 ) + "\r\n\r\n" + content +  "\r\n"

def traite_requete(requete) :
    """
    >>> traite_requete(ex_requete_http1) == get_reponse("pages_serveur/fr/page1.html")
    True
    >>> traite_requete(ex_requete_http2) == get_reponse("pages_serveur/fr/pages/index.html")
    True
    >>> traite_requete(ex_requete_http3) == get_reponse("pages_serveur/en/autres_pages/toto.html")
    True
    """
    if len(requete) < 1: return ""
    req = decode_requete_http(requete)
    if "Accept-Language" in req[1]:
        lang = req[1]["Accept-Language"].split(";")[0].split(",")[0].split("-")[0]
    else: 
        lang = "en"

    try:
        open("pages_serveur/" + lang + req[0])
        return get_reponse("pages_serveur/"+ lang + req[0])
    except:
        try:
            open("pages_serveur/" + lang + "/pages/" + req[0])
            return get_reponse("pages_serveur/"+ lang + "/pages/" + req[0])
        except:
            return get_reponse("pages_serveur/" + lang + "/autres_pages/" + req[0])

if __name__ == "__main__" :
    doctest.testmod()

    import socket

    TCP_IP = '127.0.0.1'
    TCP_PORT = 8080
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind((TCP_IP,TCP_PORT))

    s.listen()

    while True:
        conn,addr = s.accept()
        data = conn.recv(1024)
        ndata = traite_requete(data.decode("utf-8"))
        conn.send(ndata.encode("utf-8"))