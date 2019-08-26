
import cbpro
import numpy as np
import datetime as dt
import time

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

	#ROC11=np.zeros(13)
	#ROC14=np.zeros(13)
	#ROCSUM=np.zeros(13)

	#for ii in range(0,13):
	#	ROC11[ii] = (100*(price[ii]-price[ii+11]) / float(price[ii+11]))
	#	ROC14[ii] = (100*(price[ii]-price[ii+14]) / float(price[ii+14]))
	#	ROCSUM[ii] = ( ROC11[ii] + ROC14[ii] )

	## Calculate the past 4 Coppock values with Weighted Moving Average
	#for ll in range(0,4):
	#	coppock[ll] = (((1*ROCSUM[ll+9]) + (2*ROCSUM[ll+8]) + (3*ROCSUM[ll+7]) \
	#	+ (4*ROCSUM[ll+6]) + (5*ROCSUM[ll+5]) + (6*ROCSUM[ll+4]) \
	#	+ (7*ROCSUM[ll+3]) + (8*ROCSUM[ll+2]) + (9*ROCSUM[ll+1]) \
	#    + (10*ROCSUM[ll])) / float(55))

 #   # Calculate the past 3 derivatives of the Coppock Curve
	#coppockD1 = np.zeros(3)

	#for mm in range(3):
	#	coppockD1[mm] = coppock[mm] - coppock[mm+1]

	currentPrice = 3686.77
 
	possiblePurchase = (float(funding)) / float(currentPrice)

	owned = float(auth_client.get_account(specificID)['available'])

	possibleIncome = float(currentPrice)*owned


	if True:

		order = auth_client.place_market_order(product_id=currency, side='buy', funds=str(funding))

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
