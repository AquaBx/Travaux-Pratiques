import socket as sock

s = sock.socket(sock.AF_INET, sock.SOCK_DGRAM)
port = 12345

s.bind(("", port))
print("waiting on port:", port)
while True:
	data, addr = s.recvfrom(1024)
	print(data.decode())

