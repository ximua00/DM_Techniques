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
		dataset['srch_query_affinity_score'].fillna(-1, inplace=True)

		###############################################
		#remove
		dataset.drop(columns = ['random_bool'], inplace = True)

		###############################################
		#comp_rate

		dataset['comp1_rate'].fillna(-2, inplace=True)
		dataset['comp1_rate'] = dataset['comp1_rate'] + 2

		dataset['comp1_inv'].fillna(-2, inplace=True)
		dataset['comp1_inv'] = dataset['comp1_inv'] + 2

		dataset['comp1_diff'] = dataset['comp1_rate'] * dataset['comp1_rate_percent_diff']
		dataset.drop(columns = ['comp1_rate_percent_diff'], inplace = True)
		dataset['comp1_diff'].fillna(0, inplace=True)
		##

		dataset['comp2_rate'].fillna(-2, inplace=True)
		dataset['comp2_rate'] = dataset['comp2_rate'] + 2

		dataset['comp2_inv'].fillna(-2, inplace=True)
		dataset['comp2_inv'] = dataset['comp2_inv'] + 2

		dataset['comp2_diff'] = dataset['comp2_rate'] * dataset['comp2_rate_percent_diff']
		dataset.drop(columns = ['comp2_rate_percent_diff'], inplace = True)
		dataset['comp2_diff'].fillna(0, inplace=True)
		##

		dataset['comp3_rate'].fillna(-2, inplace=True)
		dataset['comp3_rate'] = dataset['comp3_rate'] + 2

		dataset['comp3_inv'].fillna(-2, inplace=True)
		dataset['comp3_inv'] = dataset['comp3_inv'] + 2

		dataset['comp3_diff'] = dataset['comp3_rate'] * dataset['comp3_rate_percent_diff']
		dataset.drop(columns = ['comp3_rate_percent_diff'], inplace = True)
		dataset['comp3_diff'].fillna(0, inplace=True)
		##

		dataset['comp4_rate'].fillna(-2, inplace=True)
		dataset['comp4_rate'] = dataset['comp4_rate'] + 2

		dataset['comp4_inv'].fillna(-2, inplace=True)
		dataset['comp4_inv'] = dataset['comp4_inv'] + 2

		dataset['comp4_diff'] = dataset['comp4_rate'] * dataset['comp4_rate_percent_diff']
		dataset.drop(columns = ['comp4_rate_percent_diff'], inplace = True)
		dataset['comp4_diff'].fillna(0, inplace=True)
		##

		dataset['comp5_rate'].fillna(-2, inplace=True)
		dataset['comp5_rate'] = dataset['comp5_rate'] + 2

		dataset['comp5_inv'].fillna(-2, inplace=True)
		dataset['comp5_inv'] = dataset['comp5_inv'] + 2

		dataset['comp5_diff'] = dataset['comp5_rate'] * dataset['comp5_rate_percent_diff']
		dataset.drop(columns = ['comp5_rate_percent_diff'], inplace = True)
		dataset['comp5_diff'].fillna(0, inplace=True)
		##

		dataset['comp6_rate'].fillna(-2, inplace=True)
		dataset['comp6_rate'] = dataset['comp6_rate'] + 2

		dataset['comp6_inv'].fillna(-2, inplace=True)
		dataset['comp6_inv'] = dataset['comp6_inv'] + 2

		dataset['comp6_diff'] = dataset['comp6_rate'] * dataset['comp6_rate_percent_diff']
		dataset.drop(columns = ['comp6_rate_percent_diff'], inplace = True)
		dataset['comp6_diff'].fillna(0, inplace=True)
		##

		dataset['comp7_rate'].fillna(-2, inplace=True)
		dataset['comp7_rate'] = dataset['comp7_rate'] + 2

		dataset['comp7_inv'].fillna(-2, inplace=True)
		dataset['comp7_inv'] = dataset['comp7_inv'] + 2

		dataset['comp7_diff'] = dataset['comp7_rate'] * dataset['comp7_rate_percent_diff']
		dataset.drop(columns = ['comp7_rate_percent_diff'], inplace = True)
		dataset['comp7_diff'].fillna(0, inplace=True)
		##

		dataset['comp8_rate'].fillna(-2, inplace=True)
		dataset['comp8_rate'] = dataset['comp8_rate'] + 2

		dataset['comp8_inv'].fillna(-2, inplace=True)
		dataset['comp8_inv'] = dataset['comp8_inv'] + 2

		dataset['comp8_diff'] = dataset['comp8_rate'] * dataset['comp8_rate_percent_diff']
		dataset.drop(columns = ['comp8_rate_percent_diff'], inplace = True)
		dataset['comp8_diff'].fillna(0, inplace=True)
		##

		###############################################
		# prop_review_score
		dataset['prop_review_score'].fillna(-1, inplace=True)

		###############################################
		dataset['orig_destination_distance'].fillna(method='bfill', inplace = True)

	return dataset


