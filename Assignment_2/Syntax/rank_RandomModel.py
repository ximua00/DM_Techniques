'''
Random rank model
'''

import pandas as pd
import numpy as np
import time
import pickle
import SplitData
from evaluate import evaluate_ndcg as evaluate



#Load training data
#start = time.time()
validation_data = pickle.load(open('../pickled_data/validation_data.pkl', 'rb'))
#print ("Time to read data = %.2fs " % (time.time() - start))

#Evaluate NDCG
validation_data['score'] = validation_data['click_bool'] + 4*validation_data['booking_bool']

print ('Evaluating {} ids...'.format(validation_data['srch_id'].nunique()))
ndcg = evaluate(validation_data)
print (ndcg)
