import os
import matplotlib.patches as mpatches
import pickle
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# plt.style.use('bmh')

# data_path = os.path.join('..', 'data', 'training_set_VU_DM_2014.csv')
data_path = os.path.join('..', 'data', 'test.csv')
df = pd.read_csv(data_path)

if os.path.isfile(os.path.join('..', 'pickled_data', 'df.pkl')):
    df = pickle.load(open(os.path.join('..', 'pickled_data', 'df.pkl'), 'rb'))

"""""""""""""""""""""""""""""""""""""""
position-bias: how many times(on avg) has the user clicked on which position
"""""""""""""""""""""""""""""""""""""""
# group by query
grouped = df.groupby(by='srch_id')

clicked_counts = np.zeros(41)
booked_counts = np.zeros(41)
booked_n = 0
clicked_n = 0

# get the number of times each position was clicked in total
for key, item in grouped:
    group = grouped.get_group(key)
    # print(group)

    booked_rows = group.loc[group['booking_bool'] == 1]
    for index, row in booked_rows.iterrows():
        booked_counts[int(row['position'])] += 1
        booked_n += 1


    clicked_rows = group.loc[group['click_bool'] == 1]
    for index, row in clicked_rows.iterrows():
        clicked_counts[int(row['position'])] += 1
        clicked_n += 1


# normalize by the number of queries
for index, item in enumerate(booked_counts):
    booked_counts[index] /= booked_n
    print("Position", index, "booked: ", booked_counts[index])

for index, item in enumerate(clicked_counts):
    clicked_counts[index] /= clicked_n
    print("Position", index, "clicked: ", clicked_counts[index])

print("*"*50)
pickle.dump(booked_counts, open('..\\pickled_data\\position_booked_counts.pkl', 'wb'))
pickle.dump(clicked_counts, open('..\\pickled_data\\position_clicked_counts.pkl', 'wb'))

booked_counts = pickle.load(open('..\\pickled_data\\position_booked_counts.pkl', 'rb'))
clicked_counts = pickle.load(open('..\\pickled_data\\position_clicked_counts.pkl', 'rb'))

print(booked_counts)
x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]
plt.bar(x, booked_counts[1:], width=0.2, align='edge', color='b')
plt.bar(x, clicked_counts[1:], width=-0.2, align='edge', color='r')

# n, bins, patches = plt.hist(booked_counts, bins=)
red_patch = mpatches.Patch(color='red', label='Clicked')
blue_patch = mpatches.Patch(color='blue', label='Booked')
plt.legend(handles=[blue_patch, red_patch])
plt.xlabel('Position')
plt.ylabel('Probability')
plt.title('Histogram of Position Bias')

plt.show()



