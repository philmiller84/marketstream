#MarketStream
import cbpro
import time
import socket
import json

#header
print("MarketStream")

HOST = '127.0.0.1'  # Standard loopback interface address (localhost)
PORT = 65432        # Port to listen on (non-privileged ports are > 1023)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen()
conn, addr = s.accept()
print('Connected by', addr)

#connect to API
public_client = cbpro.PublicClient()

#set parameters
coin = 'BTC-USD'
marketLevel=1 # 1 = best bid and ask, 2 = list of 50 orders

#requests per second
rps = 4

while True:
    #get current L1 for stock
    l1data = public_client.get_product_order_book(coin, level=marketLevel)
    print(l1data)

    #send data to distributor
    data = conn.recv(1024)
    if data:
        body = str(data, "utf-8")
        if body == "GET":
            l1data_json=json.dumps(l1data).encode('utf-8')
            conn.sendall(l1data_json)
    else: 
        break

    #throttle and repeat
    #print("Throttling and waiting.",rps,"requests per second")
    time.sleep(1/rps)


print("Exiting")