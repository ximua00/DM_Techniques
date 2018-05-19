'''Preprocessing: Outliers Treatment'''
#TODO Select feautures to be treated as outliers - after feature engineering

import pandas as pd
import numpy as np
import time
import pickle
from collections import defaultdict
from evaluate import evaluate_ndcg as evaluate


#Load training data
train_data = pickle.load(open('../pickled_data/train_data.pkl', 'rb'))


#have a look at the data
train_data = train_data[:10000]
print(train_data.head(30))	


#get feauture names
#feauture_names = train_data.columns.values.tolist()
#print (feauture_names)

# feauture_names = ['visitor_hist_adr_usd', 'price_usd', 'srch_booking_window', 'srch_adults_count', 'srch_children_count', 'srch_room_count', 'srch_query_affinity_score', 'orig_destination_distance']

for variable in feauture_names:
	print (variable)
	print ('Max {}'.format(train_data[variable].max()))
	print ('Min {}'.format(train_data[variable].min()))
	q99 = train_data[variable].quantile(0.99)
	print ('99th Percentile {}'.format(q99))

	#Replace all values above 99thpercentile with 99thpercentile value
	#train_data[variable][train_data[variable] > q99] = q99
	train_data.loc[train_data[variable] > q99 ] = q99
	print ('Max AFTER {}'.format(train_data[variable].max()))


	print ('\n')