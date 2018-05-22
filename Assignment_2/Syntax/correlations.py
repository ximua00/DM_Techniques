import pandas as pd
import numpy as np
import time
import pickle
import SplitData
from evaluate import evaluate_ndcg as evaluate
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.preprocessing import normalize
from preprocessing_missing import preprocessing_missing
from preprocessing_missing import composite_features
from preprocessing_balance import class_balance
from preprocessing_outliers import preprocessing_outliers
import matplotlib.pyplot as plt 
import seaborn as sns

def remove_variables(dataset, regressor = "booking_bool"):
	#select variables for model
	feature_names = list(train_data.columns)
	feature_names.remove("click_bool")
	feature_names.remove("booking_bool")
	feature_names.remove("gross_bookings_usd")
	feature_names.remove("date_time")
	feature_names.remove("position")
	feature_names.remove("time")

	features = np.asarray(dataset[feature_names].values, dtype = np.float64)
	target = dataset[regressor].values

	return dataset[feature_names]


train_data = pickle.load(open('../pickled_data/train_data.pkl', 'rb'))
validation_data = pickle.load(open('../pickled_data/validation_data.pkl', 'rb'))


#PROCESS DATA
train_data = preprocessing_missing(train_data)
train_data = composite_features(train_data)

validation_data = preprocessing_missing(validation_data)
validation_data = composite_features(validation_data)


#CHECK CORRELATIONS
features = remove_variables(train_data)



f, ax = plt.subplots(figsize=(10, 8))
corr = features.corr()
sns.heatmap(corr, mask=np.zeros_like(corr, dtype=np.bool), cmap=sns.diverging_palette(220, 10, as_cmap=True),
            square=True, ax=ax)
plt.show()

#features













