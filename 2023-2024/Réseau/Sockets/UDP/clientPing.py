import socket as sock
import time
import sys

pingNum = 100

s = sock.socket(sock.AF_INET, sock.SOCK_DGRAM)
host = sys.argv[1]
port = 7

MEAN = 0
MAX = 0
MIN = 0

for i in range(pingNum):
    data = "PING "+ str(i)
    print("SENT :",data,"to",host)

    t0 = time.time_ns()
    s.sendto(data.encode(),(host,port))
    data, addr = s.recvfrom(1024)
    t1 = time.time_ns()

    lat = (t1-t0)/1000/1000

    print("RECEIVED :",data.decode(),"from",host,", RTT", round(lat,3), "ms")

    MEAN += lat/pingNum

    if (i == 0):
        MAX = lat
        MIN = lat
    else :
        MAX = max(MAX,lat)
        MIN = min(MIN,lat)

print("MIN RTT",MIN, "ms")
print("MAX RTT",MAX, "ms")
print("AVG RTT",MEAN, "ms")

# Problème : si la source est inaccessible, on va attendre indéfiniment car on a pas intégrer de timer