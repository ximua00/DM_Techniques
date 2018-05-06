import pickle
import time
import numpy as np
import random

#set seed for replicating validation set across team members
random.seed(9001)

def Train_Validation_Split(train_data, validation_percentage = 0.15):
	'''
	Split data based on search id 
	I: Pandas dataframe to be split per srch_id
	O: (train_data, validation_data)
	'''
	
	#Split train and validation data based on search ID
	print ('Number of missing values in column srch_id {} \n'.format(train_data['srch_id'].isnull().sum()))

	#Unique values in search ID 
	unique_search_id = train_data['srch_id'].unique()
	n_ids = unique_search_id.shape[0]
	print ('Number of total search ids:{} \n'.format(n_ids))

	#Randomly select id's for validation set
	n_validation = np.floor(n_ids * validation_percentage).astype(int)
	print ('Number of validation search ids:{} \n'.format(n_validation))

	val_idx = np.random.choice(n_ids, n_validation)
	validation_search_ids = unique_search_id[val_idx]
	train_search_ids = unique_search_id[val_idx]

	# Validation_search_ids has the ids of which we want to subset the validation data based on the srch_id
	validation_data = train_data[ train_data['srch_id'].isin(validation_search_ids)]
	train_data = train_data[ ~train_data['srch_id'].isin(validation_search_ids)]

	#print (validation_data.shape)
	#print (train_data.shape)

	return (train_data, validation_data)

#EXAMPLE
# train_data, validation_data = Train_Validation_Split(train_data)
# print (train_data.shape)
# print (validation_data)






