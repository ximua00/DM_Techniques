import pandas as pd
import numpy as np
from RelevanceGrades import relevance_grade
'''Preprocessing: missing'''


def preprocessing_missing(dataset, preprocess_flag = True):
	'''
	Preprocesses missing data for features
	Outputs a dataset with no missing values
	and also creates some relevant variables
	'''

	if preprocess_flag:

		dataset['time'] = pd.to_datetime(dataset['date_time'])
		dataset['hour'] = dataset['time'].dt.hour
		dataset['weekday'] = dataset['time'].dt.dayofweek

		################################################
		#Conclusion: Make boolean for weekend
		dataset['is_weekend'] = np.where(dataset['weekday'] > 4, 1, 0)

		#Conclusion: Make boolean for most booked site_id
		dataset['best_site_id'] = np.where(np.logical_or(dataset['site_id'] == 20, dataset['site_id'] == 31), 1, 0)
		################################################

		#visitor_hist_starrating
		#Too many missing values, set them to 0 and then discretize the data
		dataset['visitor_hist_starrating'].fillna(-1, inplace=True)

		###############################################
		#visitor_hist_adr_usd
		dataset['visitor_hist_adr_usd'].fillna(-1, inplace=True)

		###############################################
		#prop_location_score2
		dataset['prop_location_score2'].fillna(-1, inplace=True)

		###############################################
		#srch_query_affinity_score
		avg_srch_query_score = abs(dataset['srch_query_affinity_score'].mean())
		dataset['srch_query_affinity_score'].fillna(avg_srch_query_score, inplace=True)

		###############################################
		#remove
		dataset.drop(columns = ['random_bool'], inplace = True)

		###############################################
		#comp_rate

		for i in range(1,9):
			dataset['comp'+str(i)+'_rate'].fillna(-2, inplace = True)
			dataset['comp'+str(i)+'_inv'].fillna(-2, inplace = True)
			dataset['comp'+str(i)+'_rate_percent_diff'].fillna(0, inplace = True)

		for i in range(1,9):
			dataset['comp'+str(i)+'_rate'] += 2
			dataset['comp'+str(i)+'_inv'] += 2

		###############################################
		# prop_review_score
		# since only 7364 (out of a gazillion) null values, just replace it with 0s
		dataset['prop_review_score'].fillna(0, inplace=True)

		###############################################
		dataset['orig_destination_distance'].fillna(method='bfill', inplace = True)

		###############################################
		dataset['Relevance'] = dataset.apply(relevance_grade, axis = 1)

		###############################################
		# TODO: gross_bookings_usd

	return dataset
