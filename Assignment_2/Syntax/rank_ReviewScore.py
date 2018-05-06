'''
Benchmark rank according to review's score
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


#check data filling
print ('Number of missing values in column prop_review_score {} \n'.format(validation_data['prop_review_score'].isnull().sum()))

#Replace missing with 0's
validation_data['prop_review_score'].fillna(0, inplace = True)
print ('Filled NAs {} \n'.format(validation_data['prop_review_score'].isnull().sum()))


#Per query sort by prop_review_score
#validation_data.sort_values(by = ['srch_id', 'position'], ascending=[1, 1], inplace = True)
validation_data.sort_values(by = ['srch_id', 'prop_review_score'], ascending=[1, 0], inplace = True)


#Evaluate NDCG
validation_data['score'] = validation_data['click_bool'] + 4*validation_data['booking_bool']
#validation_data['score'][validation_data['score'] > 5] = 5 

print ('Evaluating {} ids...'.format(validation_data['srch_id'].nunique()))
ndcg = evaluate(validation_data)
print (ndcg)