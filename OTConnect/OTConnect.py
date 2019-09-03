#OTConnect
import cbpro
import time
import socket
import json
import numpy as np
import datetime as dt

#header
print("OTConnect")

HOST = '127.0.0.1'	# Standard loopback interface address (localhost)
PORT = 65433		# Port to listen on (non-privileged ports are > 1023)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen()
conn, addr = s.accept()
print('Connected by', addr)

#s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
#s.connect((HOST, PORT))

#key = 'a3cb28a4c971f8e1efa4921dd822ef2b'
#passphrase = 'marketdata'
#b64secret = 'djHMB5e34/f2ULjtVUpaPuh1lbAMGRMCQ1F5kQ/Kl0y9ljgwUxE+dEYeIci7WqkA72lR5U6GT+tPqnrdqYIXlA=='
#auth_client = cbpro.AuthenticatedClient(key, b64secret, passphrase)

key = 'dade335cbf980ac239880a70fd4b38a1'
passphrase = 'sandboxtest'
b64secret = 'pdw9Mkd2I51xqnSwSywJYZgPjUsxW54ZE6DkK69qW56KIy+DveIbsI/oyrpWUDWAIYkGv9+WrJN+Mjv87Kmw7w=='
auth_client = cbpro.AuthenticatedClient(key, b64secret, passphrase, api_url='https://api-public.sandbox.pro.coinbase.com')

while True:

	#Get request type
	data = conn.recv(1024)
	if data:
		body = str(data, "utf-8")
		if body == 'ORDER_ENTRY':
			data = conn.recv(1024)
			body = str(data, "utf-8")
			o = json.loads(body)
			resp = auth_client.place_limit_order( product_id=o['product_id'], side=o['side'], price=o['price'], size=o['size'])
		elif body == 'FILL_REQUEST':
			data = conn.recv(1024)
			body = str(data, "utf-8")
			f = json.loads(body)
			resp = auth_client.get_fills( order_id=f['order_id'], product_id=f['product_id'])

		conn.sendall(resp)

	else: 
		break

print("MADE IT!")
