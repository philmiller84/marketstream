#OTConnect
import cbpro
import time
import socket
import json
import numpy as np
import datetime as dt


orderBook = {}
exchangeOrderNumber = 1000
public_client = cbpro.PublicClient()


def SimulatedOrderEntry(o):
	global orderBook
	global public_client
	global exchangeOrderNumber

	#strip local order id
	local_order_id = str(o['local_order_id'])
	del o['local_order_id']

	#set simulated exchange id
	o['id'] = str(exchangeOrderNumber)

	if exchangeOrderNumber % 10 == 1:
		o['status'] = "404"
	elif exchangeOrderNumber % 10 == 2:
		o['status'] = "open"
	elif exchangeOrderNumber % 10 == 3:
		o['status'] = "done"
	else:
		o['status'] = "active"



	orderBook[str(exchangeOrderNumber)] = o

	#print(o['id'], o['product_id'],o['price'],o['size'],orderBook[local_order_id], sep=' :: ')
	
    #"id": "d0c5340b-6d6c-49d9-b567-48c4bfca13d2",
    #"price": "0.10000000",
    #"size": "0.01000000",
    #"product_id": "BTC-USD",
    #"side": "buy",
    #"stp": "dc",
    #"type": "limit",
    #"time_in_force": "GTC",
    #"post_only": false,
    #"created_at": "2016-12-08T20:02:28.53864Z",
    #"fill_fees": "0.0000000000000000",
    #"filled_size": "0.00000000",
    #"executed_value": "0.0000000000000000",
    #"status": "pending",
    #"settled": false


	#set parameters
	coin = 'BTC-USD'
	marketLevel=1 # 1 = best bid and ask, 2 = list of 50 orders

    #get current L1 for stock
	l1data = public_client.get_product_order_book(coin, level=marketLevel)
	fees = 0.000

	if o['side'] == "buy":
		if o['price'] >= l1data['asks'][0]['price']:
			fees = 0.0025
	elif o['side'] == "sell":
		if o['price'] <= l1data['bids'][0]['price']:
			fees = 0.0025

	if o['status'] == "done":
		o['fill_fees'] = o['price'] * o['size'] * fees

	exchangeOrderNumber += 1

	return o;

def SimulatedFillRequest(f):
	global orderBook
	global exchangeOrderNumber
	global public_client

	#SIMILATED FILLS
	f['settled'] = True

	#set parameters
	coin = 'BTC-USD'
	marketLevel=1 # 1 = best bid and ask, 2 = list of 50 orders

    #get current L1 for stock
	l1data = public_client.get_product_order_book(coin, level=marketLevel)
	fees = 0.000

	o = orderBook[f['order_id']]

	if o['side'] == "buy":
		if o['price'] >= l1data['asks'][0]['price']:
			fees = 0.0025
	elif o['side'] == "sell":
		if o['price'] <= l1data['bids'][0]['price']:
			fees = 0.0025

	f['price'] = orderBook[f['order_id']]['price']
	f['size'] = orderBook[f['order_id']]['size']
	f['fee'] = f['price'] * f['size'] * fees

	return f;


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
		#print('Received message', body)
		if body == 'ORDER_ENTRY':
			#print('Processing ORDER_ENTRY. Sending acknowledge ----------------------------')
			conn.sendall(bytes("ACK", "UTF-8"))
			#print('Waiting for follow-up --------------------------------------------------')
			data = conn.recv(1024)
			body = str(data, "utf-8")
			#print('Received message', body)
			o = json.loads(body)
			#print('Simulating Order Entry -------------------------------------------------')
			resp = SimulatedOrderEntry(o)
			#resp = auth_client.place_limit_order( product_id=o['product_id'], side=o['side'], price=o['price'], size=o['size'])
		elif body == 'FILL_REQUEST':
			#print('Processing FILL_REQUEST. Sending acknowledge ---------------------------')
			conn.sendall(bytes("ACK", "UTF-8"))
			#print('Waiting for follow-up --------------------------------------------------')
			data = conn.recv(1024)
			body = str(data, "utf-8")
			#print('Received message', body)
			f = json.loads(body)
			#print('Simulating Fill Request -------------------------------------------------')
			resp = SimulatedFillRequest(f)
			#resp = auth_client.get_fills( order_id=f['order_id'], product_id=f['product_id'])

		conn.sendall(json.dumps(resp).encode('utf-8'))

	else: 
		break

print("MADE IT!")
