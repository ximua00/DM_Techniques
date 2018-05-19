import os
import matplotlib.patches as mpatches
import pickle
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import pickle
import matplotlib
import numpy as np
import pandas as pd
import seaborn as sns
import os
from sklearn import preprocessing
import time

"""""""""""""""""""""""""""""""""""""""
           THE ACTUAL MAIN
"""""""""""""""""""""""""""""""""""""""
from SplitData import Train_Validation_Split
import sys
sys.path.insert(0, os.path.join('.'))
from df_to_txt import df_to_txt
import pyltr_pls_backup

load_txt = True

train_path = os.path.join('..', 'data', 'train.txt')
val_path = os.path.join('..', 'data', 'val.txt')
test_path = os.path.join('..', 'data', 'test.txt')

if not load_txt:
    print("Reading train data...")
    if os.path.isfile(os.path.join('..', 'pickled_data', 'training_set_VU_DM_2014.pkl')):
        df_training_set = pickle.load(open(os.path.join('..', 'pickled_data', 'training_set_VU_DM_2014.pkl'), 'rb'))
    else:
        df_training_set = pd.read_csv(open(os.path.join('..', 'data', 'training_set_VU_DM_2014.csv')))
        pickle.dump(df_training_set, open(os.path.join('..', 'pickled_data', 'training_set_VU_DM_2014.pkl')))

    print("Reading test data...")
    if os.path.isfile(os.path.join('..', 'pickled_data', 'test_set_VU_DM_2014.pkl')):
        df_test = pickle.load(open(os.path.join('..', 'pickled_data', 'test_set_VU_DM_2014.pkl'), 'rb'))
    else:
        df_test = pd.read_csv(open(os.path.join('..', 'data', 'test_set_VU_DM_2014.csv')))
        pickle.dump(df_test, open(os.path.join('..', 'pickled_data', 'test_set_VU_DM_2014.pkl'), 'wb'))

    print("Spliting data...")
    df_train, df_val = Train_Validation_Split(df_training_set[:49583*2])
    df_train, df_test = Train_Validation_Split(df_train)

    df_to_txt(df_train, train_path, add_relevance_grades=True, normalize=True, replace_nas=True)
    df_to_txt(df_val, val_path, add_relevance_grades=True, normalize=True, replace_nas=True)
    df_to_txt(df_test, test_path, add_relevance_grades=True, normalize=True, replace_nas=True)

train_time = time.time()
model = pyltr_pls_backup.train_model(train_path, val_path, test_path)
print("Train time:", time.time() - train_time)

pickle.dump(model, open('..\\pickled_data\\lambdamart_model.pkl', 'wb'))




"""""""""""""""""""""""""""""""""""""""
Number of uniques in the dataset - hotels, sites etc.
"""""""""""""""""""""""""""""""""""""""
# counts = []
# df_names = []
# # number of uniques in each column
# for column in df:
#     count = column + ": " + str(df[column].nunique()) + '\n'
#
#     df_names.append(column)
#     counts.append(count)
#     print(count)
#
# # pickle.dump(counts, open('..\\pickled_data\\unique_counts.pkl', 'wb'))
# print("*"*50)


"""""""""""""""""""""""""""""""""""""""
position-bias: how many times(on avg) has the user clicked on which position
"""""""""""""""""""""""""""""""""""""""
# # group by query
# grouped = df.groupby(by='srch_id')
#
# clicked_counts = np.zeros(41)
# booked_counts = np.zeros(41)
# booked_n = 0
# clicked_n = 0
#
# # get the number of times each position was clicked in total
# for key, item in grouped:
#     group = grouped.get_group(key)
#     # print(group)
#
#     booked_rows = group.loc[group['booking_bool'] == 1]
#     for index, row in booked_rows.iterrows():
#         booked_counts[int(row['position'])] += 1
#         booked_n += 1
#
#
#     clicked_rows = group.loc[group['click_bool'] == 1]
#     for index, row in clicked_rows.iterrows():
#         clicked_counts[int(row['position'])] += 1
#         clicked_n += 1
#
#
# # normalize by the number of queries
# for index, item in enumerate(booked_counts):
#     booked_counts[index] /= booked_n
#     print("Position", index, "booked: ", booked_counts[index])
#
# for index, item in enumerate(clicked_counts):
#     clicked_counts[index] /= clicked_n
#     print("Position", index, "clicked: ", clicked_counts[index])
#
# print("*"*50)
# pickle.dump(booked_counts, open('..\\pickled_data\\position_booked_counts.pkl', 'wb'))
# pickle.dump(clicked_counts, open('..\\pickled_data\\position_clicked_counts.pkl', 'wb'))
#
# booked_counts = pickle.load(open('..\\pickled_data\\position_booked_counts.pkl', 'rb'))
# clicked_counts = pickle.load(open('..\\pickled_data\\position_clicked_counts.pkl', 'rb'))
#
# print(booked_counts)
# x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]
# plt.bar(x, booked_counts[1:], width=0.2, align='edge', color='b')
# plt.bar(x, clicked_counts[1:], width=-0.2, align='edge', color='r')
#
# # n, bins, patches = plt.hist(booked_counts, bins=)
# red_patch = mpatches.Patch(color='red', label='Clicked')
# blue_patch = mpatches.Patch(color='blue', label='Booked')
# plt.legend(handles=[blue_patch, red_patch])
# plt.xlabel('Position')
# plt.ylabel('Probability')
# plt.title('Histogram of Position Bias')
#
# plt.show()
"""""""""""""""""""""""""""""""""""""""
how often a hotel is booked when the price of at least 1 competitor is lower
"""""""""""""""""""""""""""""""""""""""

# # df = df[['comp1_rate', 'comp1_inv', 'comp2_rate', 'comp2_inv', 'comp3_rate', 'comp3_inv', 'comp4_rate', 'comp4_inv', 'comp5_rate', 'comp5_inv', 'comp6_rate', 'comp6_inv', 'comp7_rate', 'comp7_inv', 'comp8_rate', 'comp8_inv']]
#
# df_competition_wins = df[((df['comp1_rate'] == -1) & (df['comp1_inv'] != 1)) \
#                | ((df['comp2_rate'] == -1) & (df['comp2_inv'] != 1)) \
#                | ((df['comp3_rate'] == -1) & (df['comp3_inv'] != 1)) \
#                | ((df['comp4_rate'] == -1) & (df['comp4_inv'] != 1)) \
#                | ((df['comp5_rate'] == -1) & (df['comp5_inv'] != 1)) \
#                | ((df['comp6_rate'] == -1) & (df['comp6_inv'] != 1)) \
#                | ((df['comp7_rate'] == -1) & (df['comp7_inv'] != 1)) \
#                | ((df['comp8_rate'] == -1) & (df['comp8_inv'] != 1))]
#
# df_competition_loses = df[((df['comp1_rate'] != -1) & (df['comp1_inv'] != -1)) \
#                          & ((df['comp2_rate'] != -1) & (df['comp2_inv'] != -1)) \
#                          & ((df['comp3_rate'] != -1) & (df['comp3_inv'] != -1)) \
#                          & ((df['comp4_rate'] != -1) & (df['comp4_inv'] != -1)) \
#                          & ((df['comp5_rate'] != -1) & (df['comp5_inv'] != -1)) \
#                          & ((df['comp6_rate'] != -1) & (df['comp6_inv'] != -1)) \
#                          & ((df['comp7_rate'] != -1) & (df['comp7_inv'] != -1)) \
#                          & ((df['comp8_rate'] != -1) & (df['comp8_inv'] != -1))]
#
# value_counts_competition_wins = df_competition_wins['booking_bool'].value_counts() # df_competition_wins.groupby('booking_bool').count()
#
# if len(value_counts_competition_wins.values) >= 2:
#     print("Ratio of booked/not_booked when competition has better price: ", value_counts_competition_wins.values[1] / value_counts_competition_wins.values[0])
# else:
#     print("Ratio of booked/not_booked when competition has better price: ", 0)
#     # print(value_counts_competition_wins.values[0])
#
# value_counts_competition_loses = df_competition_loses['booking_bool'].value_counts() # df_competition_wins.groupby('booking_bool').count()
#
# if len(value_counts_competition_loses.values) >= 2:
#     print("Ratio of booked/not_booked when expedia has better price: ", value_counts_competition_loses.values[1] / value_counts_competition_loses.values[0])
# else:
#     print("Ratio of booked/not_booked when expedia has better price: ", 0)
#     # print(value_counts_competition_loses.values[0])

"""""""""""""""""""""""""""""""""""""""
 Correlation matrix visualisation
"""""""""""""""""""""""""""""""""""""""
# corr = df.corr()
#
# # plot the correlations
# sns.heatmap(corr,
#         xticklabels=corr.columns,
#         yticklabels=corr.columns)
# plt.show()
# conclusion: absolutely nothing correlates except the number of nights to stay and price xD



"""""""""""""""""""""""""""""""""""""""
       CONVERTING CSV INTO TXT
"""""""""""""""""""""""""""""""""""""""
#
# matplotlib.rcParams.update({'font.size': 7})
# sns.set(style="ticks")
#
# print("Reading data...")
# # df = pd.read_csv(open(os.path.join('..', 'data', 'test.csv')))
# if os.path.isfile(os.path.join('..', 'pickled_data', 'df.pkl')):
#     df = pickle.load(open(os.path.join('..', 'pickled_data', 'df.pkl'), 'rb'))
# else:
#     df = pd.read_csv(open(os.path.join('..', 'data', 'training_set_VU_DM_2014.csv')))
#
# print("shape: " + str(df.shape))
# # np.split(df, [int(.8 * len(df)), int(.85 * len(df))])
# # train, validate, test = np.split(df.sample(frac=1), [int(.*len(df)), int(.8*len(df))])
#
# # 4958347
# # df = df[0:49583]
# # df = df[16500:16500*2]
# df = df[16500*2:16500*3]
# print("shape: " + str(df.shape))
# """ remove unwanted columns """
# del df['date_time']
# # del df['position']
#
# """ add relevance grade """
# print("Adding Relevance Grade...")
# def relevance_grade(row):
#     if int(row['booking_bool']) == 1 and int(row['click_bool']) == 1:
#         grade = 5
#     elif int(row['click_bool']) == 0 and int(row['booking_bool']) == 0:
#         grade = 0
#     else:
#         grade = 1
#     return grade
#
# df['relevance'] = df.apply(relevance_grade, axis = 1)
# del df['click_bool']
# del df['booking_bool']
#
# """ normalize data """
# print("Normalizing...")
# for col in df:
#     if col == 'relevance':
#         continue
#     df[col]=(df[col]-df[col].min())/(df[col].max()-df[col].min())
#
# # x = df.values
# # min_max_scaler = preprocessing.MinMaxScaler()
# # x_scaled = min_max_scaler.fit_transform(x)
# # df = pd.DataFrame(x_scaled)
#
# """ replaces NA's """
# print("Replacing NA's...")
# df.fillna(0, inplace=True)
#
# """ the actual converting """
# print("Converting...")
# time1 = time.time()
#
# txt_file = os.path.join('..', 'data', 'test.txt')
# n_row = 0
#
# with open(txt_file, 'w') as output_file:
#     for _, row in df.iterrows():
#         n_row += 1
#         print(str(n_row))
#         output_file.write(str(int(row['relevance'])) + " qid:" + str(int(row['srch_id'])))
#         n = 1
#         for name in row.index:
#             if name == 'srch_id' or name == 'relevance':
#                 continue
#
#             output_file.write(" " + str(n) + ":" + str(row[name]))
#             n += 1
#         output_file.write(" # bleh\n")
#
# print("Time: ", time.time() - time1)
# # pickle.dump(df, open('..\\pickled_data\\df2.pkl', 'wb'))





