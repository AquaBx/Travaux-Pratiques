#!/usr/bin/env python
import struct
import sys
import socket

def decodeICMP(trame):
  print("---- ICMP ----")

  Type,Code,Checksum = struct.unpack("!BBH",trame[0:4])

  print( "Type     :" , Type )
  print( "Code     :" , Code )
  print( "Checksum :" , Checksum )
  
def decodeTCP(trame):
  
  s,d,sck,ack,offset_reserved_controls,window,checksum,pointer = struct.unpack("!HHLLHHHH",trame[0:20])

  # offset_reserved_controls

  # print(s,d,sck,ack,offset_reserved_controls,window,checksum,pointer)

  offset = int(offset_reserved_controls/2**12)
  reserved = int(offset_reserved_controls/2**6) -offset*2**6
  ctrls = int(offset_reserved_controls) -reserved*2**6 - offset*2**12

  print("----- TCP ----")
  print( "Source Port          :" , s        )
  print( "Source Destination   :" , d        )
  print( "Numéro de séquence   :" , sck      )
  print( "Numéro de acknoledge :" , ack      )
  print( "Data offset          :" , offset )
  print( "Reserved             :" , reserved )
  print( "Controles            :" , ctrls )
  print( "Taille de la fênetre :" , window   )
  print( "Checksum             :" , checksum )
  print( "Urgent pointer       :" , pointer  )

def decodeUDP(trame):

  s,d,l,c = struct.unpack("!HHHH",trame[0:8])

  print("----- UDP ----")
  print( "Source Port      :" , s )
  print( "Destination Port :" , d )
  print( "Taille UDP       :" , l )
  print( "Checksum         :" , c )

def decodeETH(trame):

  dest = struct.unpack("!BBBBBB",trame[0:6])
  src = struct.unpack("!BBBBBB",trame[6:12])
  length = struct.unpack("!H",trame[12:14])

  print("----- ETH ----")
  print( "MAC Destination      :" , dest )
  print( "MAC Source           :" , src )
  print( "Type ou longueur     :" , length )

def decodeTrame(protocol,data) :
  
  if protocol == 1: #ICMP
    decodeICMP(data[35:39])
  elif protocol == 6: #TCP
    decodeTCP(data[35:65])
  elif protocol == 17: #UDP
    decodeUDP(data[35:43])



# Tous les paquets 0x0003 (Ethernet)
rawSocket=socket.socket(socket.AF_PACKET,socket.SOCK_RAW,socket.htons(0x0003))

while True :
  donneesbrutesrecues = rawSocket.recvfrom(65565) # 65565 represent the size of the buffer
  
  # Obtenir les donnees
  donneesbrutesrecues = donneesbrutesrecues[0]
  # L'en-tete IP commence au quinzieme octets, apres l'en-tete ethernet, et fait 20 octets (sans les options)
  # Le 14 correspond a l'entete Ethernet qui va de 0 a 13.

  decodeETH(donneesbrutesrecues[0:14])

  en_tete_ip = donneesbrutesrecues[14:34]
  # On lit l'en-tete IP et on le structure. B : entier sur 1 octet, H : entier sur 2 octets, s chaine de caracteres (pour l'adresse IP)
  Eip = struct.unpack('!BBHHHBBH4s4s' , en_tete_ip)
  version_ihl = Eip[0]
  # Decalage de 4 bits car le champs version est sur 4 bit et qu'on lit 1 octet
  version = version_ihl >> 4
  # Annulation des 4 premiers bits pour n'avoir que les 4 bits du champs header length
  ihl = version_ihl & 0xF
  #Nombre de mot de 4 octets en octets
  longueur_en_tete_IP = ihl * 4
  ttl = Eip[5]
  protocol = Eip[6]
  s_addr = socket.inet_ntoa(Eip[8])
  d_addr = socket.inet_ntoa(Eip[9])

  print("----- IP -----")

  print('Version : ' + str(version) + ' Longueur en-tete IP : ' + str(ihl) + ' TTL : ' + str(ttl) + ' Protocole : ' + str(protocol) + ' Adresse IP Source : ' + str(s_addr) + ' Adresse IP Destination : ' + str(d_addr))


  decodeTrame(protocol,donneesbrutesrecues)

  print("--------------")
