'''GradientBoostingClassifier model'''

#TODO:Hyperparameter tuning

import pandas as pd
import numpy as np
import os
import time
import pickle
import SplitData
from evaluate import evaluate_ndcg as evaluate
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.preprocessing import normalize
from preprocessing_missing import preprocessing_missing, composite_features
from preprocessing_balance import class_balance
from preprocessing_outliers import preprocessing_outliers
import matplotlib.pyplot as plt 


def remove_variables(dataset, regressor = "booking_bool"):
	#select variables for model
	feature_names = list(train_sample.columns)
	feature_names.remove("click_bool")
	feature_names.remove("booking_bool")
	feature_names.remove("gross_bookings_usd")
	feature_names.remove("date_time")
	feature_names.remove("position")
	feature_names.remove("time")

	features = np.asarray(dataset[feature_names].values, dtype = np.float64)
	target = dataset[regressor].values

	return (features, target, feature_names)


def plot_feature_importance(classifier_model, regressor = "booking_bool"):

	'''Plot feature importance'''

	feature_importance = classifier_model.feature_importances_
	# make importances relative to max importance
	feature_importance = 100.0 * (feature_importance / feature_importance.max())
	sorted_idx = np.argsort(feature_importance)
	pos = np.arange(sorted_idx.shape[0]) + .5


	plt.barh(pos, feature_importance[sorted_idx], align='center')
	feature_names = np.array(train_sample.columns.values.tolist())

	print(pos, feature_importance[sorted_idx])
	plt.yticks(pos, feature_names[sorted_idx])
	plt.xlabel('Relative Importance')
	plt.title('Variable Importance' + ' ' + regressor)
	plt.show()

	return 


n_estimators = 100
max_depth = 3

save_path = '../models/random_forest' + str(n_estimators) + '_' + str(max_depth)


#load data
train_data = pickle.load(open('../pickled_data/train_data.pkl', 'rb'))
validation_data = pickle.load(open('../pickled_data/validation_data.pkl', 'rb'))

train_data = preprocessing_missing(train_data)
train_data = composite_features(train_data)
#train_data = class_balance(train_data)

validation_data = preprocessing_missing(validation_data)
validation_data = composite_features(validation_data)
#train_data, validation_data = preprocessing_outliers(train_data, validation_data)


#subset data
train_sample = train_data[:100000]


#BOOKING MODEL
features, target, feature_names = remove_variables(train_sample)

#TRAIN MODEL 
print("Training booking Classifier...")
classifier = GradientBoostingClassifier(n_estimators = n_estimators, verbose = 2, max_depth = max_depth)
classifier.fit(features, target)
#SAVE MODEL
pickle.dump(classifier, open((save_path + 'book.pkl'), 'wb'))

##

#CLICK MODEL
features, target, feature_names = remove_variables(train_sample, regressor = "click_bool")

#TRAIN MODEL
print("Training click Classifier...")
classifier_click = GradientBoostingClassifier(n_estimators = n_estimators, verbose = 2, max_depth = max_depth)
classifier_click.fit(features, target)
#SAVE MODEL
pickle.dump(classifier_click, open((save_path + 'click.pkl'), 'wb'))



#CLEAN TEST DATA
test_sample = validation_data
t_features, t_target, _ = remove_variables(test_sample)

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

#book
plot_feature_importance(classifier)
plot_feature_importance(classifier_click, regressor = "click_bool")










