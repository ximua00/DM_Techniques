import os
import pickle
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# NOTE: replace the path with your own if it's different

# data_path = os.path.join('data', 'test.csv')
#data_path = os.path.join('data', 'training_set_VU_DM_2014.csv')
df = pd.read_csv('../Data/training_set_VU_DM_2014.csv')

######################################
#   Number of uniques in the dataset - hotels, sites etc.
######################################
counts = []
df_names = []
# number of uniques in each column
for column in df:
    count = column + ": " + str(df[column].nunique()) + '\n'
    counts.append(count)
    print(count, end="")  # print without newline char

# pickle.dump(counts, open('..\\pickled_data\\unique_counts.pkl', 'wb'))
print("*"*50)


######################################
# position-bias: how many times(on avg) has the user clicked on which position
######################################
# group by query
grouped = df.groupby(by='srch_id')
clicked_counts = {}
booked_counts = {}

# get the number of times each position was clicked in total
for key, item in grouped:
    group = grouped.get_group(key)
    # print(group)

    # get per-query-index of a row that has booking_bool == 1
    booked_indices = np.where(group['booking_bool'] == 1)
    for index in booked_indices[0]:
        if index in booked_counts:
            booked_counts[index.item()] += 1 # converting from numpy.int64 to int
        else:
            booked_counts[index.item()] = 1

    clicked_indices = np.where(group['click_bool'] == 1)
    for index in clicked_indices[0]:
        if index in clicked_counts:
            clicked_counts[index.item()] += 1
        else:
            clicked_counts[index.item()] = 1

# normalize by the number of queries
for key in booked_counts:
    booked_counts[key] /= len(grouped)
    print("Position", key + 1, "booked: ", booked_counts[key])

print("*"*50)
for key in clicked_counts:
    clicked_counts[key] /= len(grouped)
    print("Position", key + 1, "clicked: ", clicked_counts[key])
print("*"*50)


# pickle.dump(booked_counts, open('..\\pickled_data\\position_booked_counts.pkl', 'wb'))
# pickle.dump(clicked_counts, open('..\\pickled_data\\position_clicked_counts.pkl', 'wb'))


######################################
# Correlation matrix visualisation
######################################
corr = df.corr()

# plot the correlations
sns.heatmap(corr,
            xticklabels=corr.columns,
            yticklabels=corr.columns)
plt.show()
# conclusion: absolutely nothing meaningful correlates except the number of nights to stay and price xD
