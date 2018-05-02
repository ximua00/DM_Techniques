'''EDA - distribution of price of booked properties
   EDA - boxplot of booked price vs distance
'''

import pickle
import pandas as pd
import numpy as np
import time
import matplotlib.pyplot as plt
import seaborn as sns


#Load Data
start = time.time()
train_data = pickle.load(open('../pickled_data/trainFullData.pkl', 'rb'))
print ("Time to read data = %.2fs " % (time.time() - start))

#Select only booked data points
bookedData = train_data[train_data['booking_bool'] == 1]

print ('Number of missing values in column gross_bookings_usd {} \n'.format(bookedData['gross_bookings_usd'].isnull().sum()))

#remove outliers
q = bookedData['gross_bookings_usd'].quantile(0.99)
bookedData = bookedData[bookedData['gross_bookings_usd'] < q]

#Plot distribution of prices across all
sns.distplot(bookedData['gross_bookings_usd'])



#Average Price per distance
#check data filling
print ('Number of missing values in column orig_destination_distance {} \n'.format(bookedData['orig_destination_distance'].isnull().sum()))

#Remove missing values
bookedData = bookedData.dropna(subset = ['orig_destination_distance'])
print ('Number of missing values in column orig_destination_distance AFTER {} \n'.format(bookedData['orig_destination_distance'].isnull().sum()))

#Create buckets on distance
print(bookedData['orig_destination_distance'].describe())

q25 = bookedData['orig_destination_distance'].quantile(0.25)
q50 = bookedData['orig_destination_distance'].quantile(0.5)
q75 = bookedData['orig_destination_distance'].quantile(0.75)

#Binning:
def binning(col, cut_points, labels=None):
	#Define min and max values:
	minval = col.min()
	maxval = col.max()

	#create list by adding min and max to cut_points
	break_points = [minval] + cut_points + [maxval]

	#if no labels provided, use default labels 0 ... (n-1)
	if not labels:
		labels = range(len(cut_points)+1)

	#Binning using cut function of pandas
	colBin = pd.cut(col,bins=break_points,labels=labels,include_lowest=True)
	return colBin

#Binning age:
cut_points = [q25, q50, q75]

labels = ["close","medium","far","very far"]
bookedData['Bin_destination_distance'] = binning(bookedData['orig_destination_distance'], cut_points, labels)
print (pd.value_counts(bookedData["Bin_destination_distance"], sort=False))

sns.boxplot(x = bookedData['gross_bookings_usd'], y = bookedData['Bin_destination_distance'])
plt.show()

















