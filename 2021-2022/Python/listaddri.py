import os



for i in range(0,256):
	for j in range(0,256):
		host="148.60." + str(i) + "." + str(j)
		host="148.60.136.169"
		cmd = "ping -c 1 -t 1 " + host + " | grep '1 received' | wc -l" 
		resp = os.system(cmd)
		if resp == "1\n":
			print(host)
		
		print(resp,1,resp==1,resp=="1")
		break
	break
