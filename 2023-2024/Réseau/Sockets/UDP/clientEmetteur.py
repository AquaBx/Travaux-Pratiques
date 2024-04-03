import socket as sock

s = sock.socket(sock.AF_INET, sock.SOCK_DGRAM)

host = "127.0.0.1"
port = 12345


while True:
	data = input()
	print("Sending",data , "to", host,"on port", port)
	s.sendto(data.encode(), (host,port) )