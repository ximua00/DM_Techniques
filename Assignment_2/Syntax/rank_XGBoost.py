'''XGBoost model'''

import pandas as pd
import numpy as np
import time
import pickle
from evaluate import evaluate_ndcg as evaluate
from sklearn.preprocessing import normalize
from preprocessing_missing import preprocessing_missing
from preprocessing_balance import class_balance
from xgboost import XGBClassifier

#Price per person / day



def remove_variables(dataset, regressor = "booking_bool"):
	#select variables for model
	feature_names = list(train_sample.columns)
	feature_names.remove("click_bool")
	feature_names.remove("booking_bool")
	feature_names.remove("gross_bookings_usd")
	feature_names.remove("date_time")
	feature_names.remove("position")
	feature_names.remove("time")

	features = dataset[feature_names].values
	target = dataset[regressor].values

	return (features, target)




train_data = pickle.load(open('../pickled_data/train_data.pkl', 'rb'))
validation_data = pickle.load(open('../pickled_data/validation_data.pkl', 'rb'))

#PROCESS DATA
#train_data = train_data.fillna(0, inplace=True)
train_data = preprocessing_missing(train_data)
#train_data = class_balance(train_data)
validation_data = preprocessing_missing(validation_data)

#subset data
train_sample = train_data


#BOOKING MODEL
features, target = remove_variables(train_sample)

print(features.shape)

#TRAIN MODEL
print("Training booking Classifier...")
classifier = XGBClassifier(silent = False)
classifier.fit(features, target)


#CLICK MODEL
features, target = remove_variables(train_sample, regressor = "click_bool")

#TRAIN MODEL
print("Training click Classifier...")
classifier_click = XGBClassifier(silent = False)
classifier_click.fit(features, target)





#CLEAN TEST DATA
test_sample = validation_data
t_features, _ = remove_variables(test_sample)

#book predictions
print("Making booking predictions")
predictions = classifier.predict_proba(t_features)[:,1]
test_sample['predictions_book'] = predictions

#click predictions
print("Making clicking predictions")
predictions = classifier_click.predict_proba(t_features)[:,1]
test_sample['predictions_click'] = predictions


#create scores for evaluating
test_sample['score'] = test_sample['click_bool'] + 4*test_sample['booking_bool']
#Sort data by predictions
test_sample['predictions'] = test_sample['predictions_click'] + 5*test_sample['predictions_book']
test_sample.sort_values(by = ['srch_id', 'predictions'], ascending=[1, 0], inplace = True)


#Evaluate test data 
print ('Evaluating {} ids...'.format(test_sample['srch_id'].nunique()))
ndcg = evaluate(test_sample)
print (ndcg)

