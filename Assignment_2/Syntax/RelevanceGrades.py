import os
import time
import pickle
import matplotlib

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

matplotlib.rcParams.update({'font.size': 7})
sns.set(style="ticks")

start = time.time()

df = pd.read_csv(open("Data/training_set_VU_DM_2014.csv"))
# df = pd.read_csv(open("Data/training_2000.csv"))
#
# with open('training_set.pickle', 'wb') as f:
#     pickle.dump(df, f, pickle.HIGHEST_PROTOCOL)

# with open('training_set.pickle', 'rb') as f:
#     df = pickle.load(f)

print ("Time to read data = %.2fs" % (time.time() - start))
# subset dataframe
# df2 = df.iloc[:, [0, 2, 14, 51, 53]]
# print(df2.sample(5))

rel2 = time.time()
def relevance_grade(row):
    if row['booking_bool'] == 1 and row['click_bool'] == 1:
        grade = 5
    elif row['click_bool'] == 0 and row['booking_bool'] == 0:
        grade = 0
    else: grade = 1
    return grade

df['Relevance'] = df.apply(relevance_grade, axis = 1)
print ("Time to apply relevance = %.2fs" % (time.time() - rel2))
# print(df.head(5))
