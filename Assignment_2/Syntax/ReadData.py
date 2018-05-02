import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import time
import pickle
import SplitData

#################################################################
# Load data
start = time.time()
train_data = pd.read_csv('../Data/training_set_VU_DM_2014.csv')
print ("Time to read data = %.2fs " % (time.time() - start))

#################################################################

pickle.dump(train_data, open('../pickled_data/trainFullData.pkl', 'wb'))


#Load training data
start = time.time()
train_data = pickle.load(open('../pickled_data/trainFullData.pkl', 'rb'))
print ("Time to read data = %.2fs " % (time.time() - start))


# print (train_data.head())
# #print (train_data.describe())
# print (list(train_data))

# print (train_data['click_bool'].sum())
# print (train_data['booking_bool'].sum())

# print (train_data['booking_bool'].sum() / train_data['click_bool'].sum())

# #Look at single user data 
# #print(train_data[train_data['srch_id'] == 4]) 

# #Count unique hotels
# print (train_data['prop_id'].nunique())

# #summarise hotels by number of bookings
# popular_prop = train_data.groupby(['prop_id'])['booking_bool'].sum()

# print (popular_prop.(by = 'booking_bool'))


# #plt.show()	