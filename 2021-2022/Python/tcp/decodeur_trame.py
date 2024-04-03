import struct
import doctest
import socket

ex_udp = b'\x00-\xd9\x9e\x00\x0eR\x8ccoucou'
ex_tcp = b'\x00-\xd7[\x00\x00\x17\x15\x00\x00\x04e\x86\xc6\ndg!By!\xaf\xff&\xfc\x19R\xcc\x18\xac|(coincoin'
ex_icmp = b'\x05\x04g\x90\x1a@\xc9\x01'
ex_ip = b"H\xf7\x00&[\x0cI\r\xe5\x01v5\xea\xd8\xa0\xe5L\xda\x86\x93\x0e\xa0\xed\xe8\x99\xc1G\xc0{P'\xc4cuicui"
ex_eth = b'R\x0c\xc7\x1d\xca578\x1fUk\x98\x08\x00coicoi'

ex_complet1 = b'Q\xf0\xdeG?\xf4\xa0\x18\x12f\xde\xd5\x08\x00H$\x00(\x85\xc2\x11\xcc\x83\x01\xf1\x94\xff\xfc\xbf\x067\x17\xd9\x86\xd4\x96\xbf\xdfdv$a\xae\x01\xd0\x90\n\x07\x1d\xfd\xdb\t3\xad'
ex_complet2 = b'\xb3\x82\x90ze\xe66?HJ#9\x08\x00Hu\x00G\\S\n{\r\x06\x0f\x93\x1f\xc9\xa5\xd0\xac\xea\xbc\xea\xc4\x13a\xdet>\xe1\x13\x9cJ\x8f\x1b\x03\x15\xf5\x83\x00\x00\x11L\x00\x00\r\xea\x80:\\\x9dJ\x9c)\xaf\xba\xcc){\xc0\x97\x83\xc4\xcd\xec3\xb4bravo !'
ex_complet3 = b"\x8e`\x1cV\xbf\x86\xa6\x0b\x8f\x99\xe8\x1e\x08\x00H>\x001\x1e*\xd4\xc5\x13\x11\xb20W'\xce*\xdb+\xc4\xa7\x08}\x99\xfd\xd9\x90\x9d\x1cA/\x1f\x00\x02\x99\xddG\x00\x11\xda\x9asuper ;-)"

def decode_udp(data) :
    """
    >>> a = decode_udp(ex_udp)
    >>> len(a) == 2
    True
    >>> a[0] == "        +++ Paquet UDP +++\\n            Port source      : 45\\n            Port destination : 55710\\n            Longueur totale  : 14\\n"
    True
    >>> a[1].decode('utf-8') == "coucou"
    True
    """
    pin,pout,l,verif = struct.unpack("!HHHH",data[0:8])
    out = "        +++ Paquet UDP +++" + "\n"
    out += "            Port source      : " + str(pin) + "\n"
    out += "            Port destination : " + str(pout) + "\n"
    out += "            Longueur totale  : " + str(l) + "\n"
    return out,data[8:l]

def decode_tcp(data) :
    """
    >>> a = decode_tcp(ex_tcp)
    >>> len(a) == 2
    True
    >>> a[0] == "        +++ Paquet TCP +++\\n            Port source      : 45\\n            Port destination : 55131\\n            Longueur en-tête : 8\\n"
    True
    >>> a[1].decode('utf-8') == "coincoin"
    True
    """
    pin,pout = struct.unpack("!HH",data[0:4])
    c = struct.unpack("!H",data[12:14])[0]
    l=int(struct.unpack("!B",data[12:13])[0]/2**4)
    out = "        +++ Paquet TCP +++" + "\n"
    out += "            Port source      : " + str(pin) + "\n"
    out += "            Port destination : " + str(pout) + "\n"
    out += "            Longueur en-tête : " + str(l) + "\n"
    return out,data[l*4:]

def decode_icmp(data) :
    """
    >>> a = decode_icmp(ex_icmp)
    >>> a == "        +++ Paquet ICMP +++\\n            Type             : 5\\n"
    True
    """
    typ = struct.unpack("!B",data[0:1])
    out = "        +++ Paquet ICMP +++" + "\n"
    out += "            Type             : " + str(typ[0]) + "\n"
    return out

def decode_adresse_IP(addr) :
    """
    >>> decode_adresse_IP(2475088460) == "147.134.218.76"
    True
    """
    num = addr
    addrstr = ""
    for i in range(4):
        addrstr = str(num%2**8) + "." + addrstr
        num = num//2**8
    return addrstr[:-1]

def decode_ip(data) :
    """
    >>> a = decode_ip(ex_ip)
    >>> len(a) == 3
    True
    >>> a[0] == '    --- Paquet IP ---\\n        Version          : 4\\n        Longueur en-tête : 8\\n        Protocole        : 1\\n        Adresse source   : 234.216.160.229\\n        Adresse dest.    : 76.218.134.147\\n'
    True
    >>> a[1] == 1
    True
    >>> a[2].decode('utf-8') == "cuicui"
    True
    """
    l=struct.unpack("!B",data[0:1])[0]
    vers = (l//2**4)%2**4
    let = l%2**4
    
    prot=struct.unpack("!B",data[9:10])[0]
    
    src,dest=struct.unpack("!LL",data[12:20])
    
    
    out = "    --- Paquet IP ---" + "\n"
    out += "        Version          : " + str(vers) + "\n"
    out += "        Longueur en-tête : " + str(let) + "\n"
    out += "        Protocole        : " + str(prot) + "\n"
    out += "        Adresse source   : " + decode_adresse_IP(src) + "\n"
    out += "        Adresse dest.    : " + decode_adresse_IP(dest) + "\n"
    
    return out,prot,data[4*let:]

def decode_mac(data) :
    """
    >>> decode_mac(b'R\\x0c\\xc7\\x1d\\xca5') == "52:0c:c7:1d:ca:35"
    True
    """
    mac=""
    for i in range(len(data)):
        mac=mac + ":" + "%.2x" % data[i]
    return mac[1:]
    
def decode_Ethernet(data) :
    """
    >>> a = decode_Ethernet(ex_eth)
    >>> len(a) == 3
    True
    >>> a[0] == '>>> Trame Ethernet <<<\\n    Adresse MAC Destination : 52:0c:c7:1d:ca:35\\n    Adresse MAC Source      : 37:38:1f:55:6b:98\\n    Protocol                : 2048\\n'
    True
    >>> a[1] == 2048
    True
    >>> a[2].decode('utf-8') == "coicoi"
    True
    """    
    mac1=decode_mac(struct.unpack("!BBBBBB",data[0:6]))
    mac2=decode_mac(struct.unpack("!BBBBBB",data[6:12]))
    
    prot=struct.unpack("!H",data[12:14])
    
    
    out = ">>> Trame Ethernet <<<" + "\n"
    out += "    Adresse MAC Destination : " + str(mac1) + "\n"
    out += "    Adresse MAC Source      : " + str(mac2) + "\n"
    out += "    Protocol                : " + str(prot[0]) + "\n"
    
    return out,prot[0],data[14:]

def decode_trame(data) :
    print("todo")
    eth = decode_Ethernet(data)
    print(eth[0])
    ip = decode_ip(eth[2])
    print(ip[0])
    if ip[1] == 1:
        pck = decode_icmp(ip[2])
    elif ip[1] == 6:
        pck = decode_tcp(ip[2])
    elif ip[1] == 17:
        pck = decode_udp(ip[2])
    else:
        pck=["connait pas le protocole",ip[1]]
    print(pck[0])
    print("Data" , ":" ,pck[1].decode('utf-8'))

if __name__ == "__main__" :
    doctest.testmod()
    #test = socket.socket(socket.AF_PACKET , socket.SOCK_RAW , socket.htons(0x0003))
    #msg = test.recvfrom(1024)
    #decode_trame(msg[0])
    # print("ex_complet1 :")
    # decode_trame(ex_complet1)
    # print("ex_complet2 :")
    # decode_trame(ex_complet2)
    # print("ex_complet3 :")
    # decode_trame(ex_complet3)
