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
		dataset['month'] = dataset['time'].dt.month

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
		# dataset.drop(columns = ['random_bool'], inplace = True)
		dataset.drop(['random_bool'], inplace = True, axis = 1)

		###############################################
		#comp_rate

		for i in range(1,9):
			dataset['comp'+str(i)+'_rate'].fillna(-2, inplace = True)
			dataset['comp'+str(i)+'_inv'].fillna(-2, inplace = True)

		for i in range(1,9):
			dataset['comp'+str(i)+'_rate'] += 2
			dataset['comp'+str(i)+'_inv'] += 2

		for i in range(1,9):
			dataset['comp'+str(i)+'_diff'] = dataset['comp'+str(i)+'_rate'] * dataset['comp'+str(i)+'_rate_percent_diff']
			dataset.drop(['comp'+str(i)+'_rate_percent_diff'], inplace = True, axis =1)
			dataset['comp'+str(i)+'_diff'].fillna(0, inplace = True)

		# dataset['comp8_diff'] = dataset['comp8_rate'] * dataset['comp8_rate_percent_diff']
		# dataset.drop(columns = ['comp8_rate_percent_diff'], inplace = True)

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


def composite_features(dataset):
	# create additional features to increase performance
	gdata = dataset.groupby(by = 'prop_country_id')
	for k, v in gdata:
	    country_mean = v['price_usd'].mean()
	    dataset['diff_country_mean'] = country_mean - dataset['price_usd']
	del gdata

	dataset['cost_per_adult'] = np.where(dataset['srch_adults_count'] > 1, dataset['price_usd']*dataset['srch_room_count']/dataset['srch_adults_count'], dataset['price_usd']*dataset['srch_room_count'])
	dataset['usd_diff'] = np.where(dataset['visitor_hist_adr_usd'] > 0, dataset['visitor_hist_adr_usd'] - dataset['price_usd'], dataset['price_usd'])
	dataset['starrating_diff'] = np.where(dataset['visitor_hist_starrating'] > 0, dataset['visitor_hist_starrating'] - dataset['prop_starrating'], dataset['prop_starrating'])
	dataset['total_cost'] = dataset['price_usd']*dataset['srch_room_count']
	dataset['total_people_booking'] = dataset['srch_children_count'] + dataset['srch_adults_count']
	dataset['people_per_room'] = dataset['total_people_booking']/dataset['srch_room_count']
	dataset['prev_trading_cost_diff'] = np.where(dataset['prop_log_historical_price'] > 0, dataset['price_usd'] - np.exp(dataset['prop_log_historical_price']), dataset['price_usd'])
	dataset['hotel_click_rate'] = np.where(dataset['srch_query_affinity_score'] < 0, dataset['prop_location_score2']*10**(dataset['srch_query_affinity_score']*np.log(10))*100, -1)

	return dataset


def remove_variables(dataset, regressor = "booking_bool"):
    #select variables for model
    feature_names = list(dataset.columns)
    feature_names.remove("click_bool")
    feature_names.remove("booking_bool")
    feature_names.remove("gross_bookings_usd")
    feature_names.remove("date_time")
    feature_names.remove("position")
    feature_names.remove("time")

    features = dataset[feature_names].values
    target = dataset[regressor].values

    return (features, target)
