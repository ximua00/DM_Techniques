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

# pickle.dump(df, open('..\\pickled_data\\df.pkl', 'wb'))
if os.path.isfile(os.path.join('..', 'pickled_data', 'df.pkl')):
    df = pickle.load(open(os.path.join('..', 'pickled_data', 'df.pkl'), 'rb'))


"""""""""""""""""""""""""""""""""""""""
how often a hotel is booked when the price of at least 1 competitor is lower
"""""""""""""""""""""""""""""""""""""""

# df = df[['comp1_rate', 'comp1_inv', 'comp2_rate', 'comp2_inv', 'comp3_rate', 'comp3_inv', 'comp4_rate', 'comp4_inv', 'comp5_rate', 'comp5_inv', 'comp6_rate', 'comp6_inv', 'comp7_rate', 'comp7_inv', 'comp8_rate', 'comp8_inv']]

df_competition_wins = df[((df['comp1_rate'] == -1) & (df['comp1_inv'] != 1)) \
                         | ((df['comp2_rate'] == -1) & (df['comp2_inv'] != 1)) \
                         | ((df['comp3_rate'] == -1) & (df['comp3_inv'] != 1)) \
                         | ((df['comp4_rate'] == -1) & (df['comp4_inv'] != 1)) \
                         | ((df['comp5_rate'] == -1) & (df['comp5_inv'] != 1)) \
                         | ((df['comp6_rate'] == -1) & (df['comp6_inv'] != 1)) \
                         | ((df['comp7_rate'] == -1) & (df['comp7_inv'] != 1)) \
                         | ((df['comp8_rate'] == -1) & (df['comp8_inv'] != 1))]

df_competition_loses = df[((df['comp1_rate'] != -1) & (df['comp1_inv'] != -1)) \
                          & ((df['comp2_rate'] != -1) & (df['comp2_inv'] != -1)) \
                          & ((df['comp3_rate'] != -1) & (df['comp3_inv'] != -1)) \
                          & ((df['comp4_rate'] != -1) & (df['comp4_inv'] != -1)) \
                          & ((df['comp5_rate'] != -1) & (df['comp5_inv'] != -1)) \
                          & ((df['comp6_rate'] != -1) & (df['comp6_inv'] != -1)) \
                          & ((df['comp7_rate'] != -1) & (df['comp7_inv'] != -1)) \
                          & ((df['comp8_rate'] != -1) & (df['comp8_inv'] != -1))]

value_counts_competition_wins = df_competition_wins['booking_bool'].value_counts() # df_competition_wins.groupby('booking_bool').count()

if len(value_counts_competition_wins.values) >= 2:
    print("Ratio of booked/not_booked when competition has better price: ", value_counts_competition_wins.values[1] / value_counts_competition_wins.values[0])
else:
    print("Ratio of booked/not_booked when competition has better price: ", 0)
    # print(value_counts_competition_wins.values[0])

value_counts_competition_loses = df_competition_loses['booking_bool'].value_counts() # df_competition_wins.groupby('booking_bool').count()

if len(value_counts_competition_loses.values) >= 2:
    print("Ratio of booked/not_booked when expedia has better price: ", value_counts_competition_loses.values[1] / value_counts_competition_loses.values[0])
else:
    print("Ratio of booked/not_booked when expedia has better price: ", 0)
    # print(value_counts_competition_loses.values[0])


