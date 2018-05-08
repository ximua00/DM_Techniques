'''Random Forest model'''

#TODO: Preprocessing, Hyperparameter tuning, include classifier

import pandas as pd
import numpy as np
import time
import pickle
import SplitData
from evaluate import evaluate_ndcg as evaluate
from sklearn.ensemble import RandomForestClassifier


train_data = pickle.load(open('../pickled_data/train_data.pkl', 'rb'))
validation_data = pickle.load(open('../pickled_data/validation_data.pkl', 'rb'))



#Process data 
train_data.fillna(0, inplace=True)


#subset data
train_sample = train_data

#select variables for model
feature_names = list(train_sample.columns)
feature_names.remove("click_bool")
feature_names.remove("booking_bool")
feature_names.remove("gross_bookings_usd")
feature_names.remove("date_time")
feature_names.remove("position")

features = train_sample[feature_names].values
target = train_sample["booking_bool"].values

print(features.shape)

#TRAIN MODEL
print("Training booking Classifier...")
classifier = RandomForestClassifier(n_estimators=50, 
                                    verbose=2,
                                    n_jobs=1,
                                    min_samples_split=10,
                                    random_state=1)
classifier.fit(features, target)







train_sample = train_data

#select variables for model
feature_names = list(train_sample.columns)
feature_names.remove("click_bool")
feature_names.remove("booking_bool")
feature_names.remove("gross_bookings_usd")
feature_names.remove("date_time")
feature_names.remove("position")

features = train_sample[feature_names].values
target = train_sample["click_bool"].values

print(features.shape)

#TRAIN MODEL
print("Training click Classifier...")
classifier_click = RandomForestClassifier(n_estimators=50, 
                                    verbose=2,
                                    n_jobs=1,
                                    min_samples_split=10,
                                    random_state=1)
classifier_click.fit(features, target)







#CLEAN TEST DATA
test_sample = validation_data.fillna(value=0)

#create scores for evaluating
test_sample['score'] = test_sample['click_bool'] + 4*test_sample['booking_bool']

#remove variables
test_names = list(["srch_id", "booking_bool"])
test_resp = test_sample[test_names].values

t_feature_names = list(train_sample.columns)
t_feature_names.remove("click_bool")
t_feature_names.remove("booking_bool")
t_feature_names.remove("gross_bookings_usd")
t_feature_names.remove("date_time")
t_feature_names.remove("position")

t_features = test_sample[t_feature_names].values
t_target = test_sample["booking_bool"].values

print("Making booking predictions")
predictions = classifier.predict_proba(t_features)[:,1]

test_sample['predictions_book'] = predictions


print("Making clicking predictions")

predictions = classifier_click.predict_proba(t_features)[:,1]

test_sample['predictions_click'] = predictions

#Sort data by predictions
test_sample['predictions'] = test_sample['predictions_click'] + 4*test_sample['predictions_book']
test_sample.sort_values(by = ['srch_id', 'predictions'], ascending=[1, 0], inplace = True)


#Evaluate test data 
print ('Evaluating {} ids...'.format(test_sample['srch_id'].nunique()))
ndcg = evaluate(test_sample)
print (ndcg)







