#OTConnect
import cbpro
import time
import socket
import json
import numpy as np
import datetime as dt

#header
print("OTConnect")

HOST = '127.0.0.1'
PORT = 65433

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((HOST, PORT))

#key = 'a3cb28a4c971f8e1efa4921dd822ef2b'
#passphrase = 'marketdata'
#b64secret = 'djHMB5e34/f2ULjtVUpaPuh1lbAMGRMCQ1F5kQ/Kl0y9ljgwUxE+dEYeIci7WqkA72lR5U6GT+tPqnrdqYIXlA=='
#auth_client = cbpro.AuthenticatedClient(key, b64secret, passphrase)

key = 'dade335cbf980ac239880a70fd4b38a1'
passphrase = 'sandboxtest'
b64secret = 'pdw9Mkd2I51xqnSwSywJYZgPjUsxW54ZE6DkK69qW56KIy+DveIbsI/oyrpWUDWAIYkGv9+WrJN+Mjv87Kmw7w=='
auth_client = cbpro.AuthenticatedClient(key, b64secret, passphrase, api_url='https://api-public.sandbox.pro.coinbase.com')

initInvestment = 20

funding = initInvestment

currency = 'BTC-USD'

def getSpecificAccount(cur):
	x = auth_client.get_accounts()
	for account in x:
			if account['currency'] == cur:
					return account['id']

specificID = getSpecificAccount(currency[:3])

period = 60 

iteration = 1

buy = True

while True:


	#try:
	#	historicData = auth_client.get_product_historic_rates(currency, granularity=period)

	#	price = np.squeeze(np.asarray(np.matrix(historicData)[:,4]))

	#	time.sleep(1)

	#	newData = auth_client.get_product_ticker(product_id=currency)
	#	print(newData)
	#	currentPrice=newData['price']

	#except Exception as e:
	#	print("Error Encountered", e)

	currentPrice = 3686.77
	possiblePurchase = (float(funding)) / float(currentPrice)

	owned = float(auth_client.get_account(specificID)['available'])

	possibleIncome = float(currentPrice)*owned


	if True:

		#order = auth_client.place_market_order(product_id=currency, side='buy', funds=str(funding))

		message = "Buying Approximately " + str(possiblePurchase) + " " + \
			currency + "   Now @" + str(currentPrice) + "/Coin. TOTAL = " + str(funding)

		print(message)

		funding = 0
		buy = False

	break


print("Current Price: ", currentPrice)

print("Your Funds = ", funding)

print("You Own ", owned, "BCH")


print("MADE IT!")
