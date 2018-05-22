import pandas as pd
import numpy as np
import os
import time
import pickle
import SplitData
from evaluate import evaluate_ndcg as evaluate
from preprocessing_missing import preprocessing_missing
from preprocessing_missing import composite_features

#TODO
#Change validation data to test data
#Remove feature names not in the test set
#delete evaluation part
#make csv part


def remove_variables(dataset, regressor = "booking_bool"):
	#select variables for model
	feature_names = list(dataset.columns)
	
	feature_names.remove("date_time")
	feature_names.remove("time")

	features = np.asarray(dataset[feature_names].values, dtype = np.float64)
	

	return features


print ('-'*10, 'Loading test data', '-'*10)
#load data
test_data = pickle.load(open('../pickled_data/test_data.pkl', 'rb'))
print (test_data.shape)

#load models
classifier = pickle.load(open('../models/random_forest200_3book.pkl', 'rb'))
classifier_click = pickle.load(open('../models/random_forest200_3click.pkl', 'rb'))

#preprocess data

print ('-'*10, 'Preprocessing test data', '-'*10)
test_data = preprocessing_missing(test_data)
test_data = composite_features(test_data)
print (test_data.shape)



print ('-'*10, 'Ranking', '-'*10)
#prepare data for modelling
test_sample = test_data
t_features = remove_variables(test_sample)

#book predictions
print("Making booking predictions")
predictions = classifier.predict_proba(t_features)[:,1]
test_sample['predictions_book'] = predictions

#click predictions
print("Making clicking predictions")
predictions = classifier_click.predict_proba(t_features)[:,1]
test_sample['predictions_click'] = predictions

#Sort data according to predictions
test_sample['predictions'] = test_sample['predictions_click'] + 5*test_sample['predictions_book']
test_sample.sort_values(by = ['srch_id', 'predictions'], ascending=[1, 0], inplace = True)


submission_data = test_sample[['srch_id', 'prop_id']]
submission_data.rename(index=str, columns={"srch_id": "SearchId", "prop_id": "PropertyId"}, inplace = True)


#export to csv
submission_data.to_csv('../results/submission_file.csv' ,index=False, sep=',')








