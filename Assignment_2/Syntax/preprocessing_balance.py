'''Preprocessing: Class unbalance'''

import pandas as pd
import numpy as np
import time
import pickle


def class_balance(dataset, k = 10):
	'''Function deals with class imbalance: deletes negative examples
	i: dataset; k - number of observations to keep per query
	o: dataset filtered
	'''



	print ('-'*20)
	print ('Preprocessing: Class balance: \n')

	# Sort data 
	# CREATE SCORE
	dataset['score'] = dataset['click_bool'] + 4 * dataset['booking_bool']


	# SORT BY SCORE
	dataset.sort_values(by = ['srch_id', 'score'], ascending=[1, 0], inplace = True)

	# Ratio before changes
	print ('Number of rows BEFORE:', dataset.shape[0])
	print('Class Balance click_bool ---- BEFORE:', dataset['click_bool'].sum() / (dataset.shape[0]))
	print('Class Balance booking_bool ---- BEFORE:', dataset['booking_bool'].sum() / (dataset.shape[0]))

	#make count per group
	dataset['count'] = dataset.groupby('srch_id', as_index=False).cumcount()

	#filter 'count'
	#per group delete some observations
	dataset = dataset.loc[dataset['count'] <= k ]
	print ('Number of rows AFTER:',dataset.shape[0])
	print('Class Balance click_bool ---- AFTER:', dataset['click_bool'].sum() / (dataset.shape[0]))
	print('Class Balance booking_bool ---- AFTER:', dataset['booking_bool'].sum() / (dataset.shape[0]))



	#delete count variable
	dataset.drop(columns = ['count', 'score'], inplace = True)

	return dataset