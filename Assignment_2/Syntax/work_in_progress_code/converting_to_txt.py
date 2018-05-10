
"""""""""""""""""""""""""""""""""""""""
       CONVERTING CSV INTO TXT
"""""""""""""""""""""""""""""""""""""""
import pickle
import matplotlib
import pandas as pd
import seaborn as sns
import os
from sklearn import preprocessing
import time

matplotlib.rcParams.update({'font.size': 7})
sns.set(style="ticks")

print("Reading data...")
# df = pd.read_csv(open(os.path.join('..', 'data', 'test.csv')))
if os.path.isfile(os.path.join('..', 'pickled_data', 'df.pkl')):
    df = pickle.load(open(os.path.join('..', 'pickled_data', 'df.pkl'), 'rb'))
else:
    df = pd.read_csv(open(os.path.join('..', 'data', 'training_set_VU_DM_2014.csv')))

df = df[99166 + 16500:99166 + 16500*2]
print("shape: " + str(df.shape))
""" remove unwanted columns """
del df['date_time']
# del df['position']

""" add relevance grade """
print("Adding Relevance Grade...")
def relevance_grade(row):
    if int(row['booking_bool']) == 1 and int(row['click_bool']) == 1:
        grade = 5
    elif int(row['click_bool']) == 0 and int(row['booking_bool']) == 0:
        grade = 0
    else:
        grade = 1
    return grade

df['relevance'] = df.apply(relevance_grade, axis = 1)
del df['click_bool']
del df['booking_bool']

""" normalize data """
print("Normalizing...")
df=(df-df.min())/(df.max()-df.min())

# x = df.values
# min_max_scaler = preprocessing.MinMaxScaler()
# x_scaled = min_max_scaler.fit_transform(x)
# df = pd.DataFrame(x_scaled)

""" replaces NA's """
print("Replacing NA's...")
df.fillna(0, inplace=True)

""" the actual converting """
print("Converting...")

txt_file = os.path.join('..', 'data', 'test.txt')
n_row = 0

with open(txt_file, 'w') as output_file:
    for _, row in df.iterrows():
        n_row += 1
        print(str(n_row))
        output_file.write(str(int(row['relevance'])) + " qid:" + str(int(row['srch_id'])))
        n = 1
        for name in row.index:
            if name == 'srch_id' or name == 'relevance':
                continue

            output_file.write(" " + str(n) + ":" + str(row[name]))
            n += 1
        output_file.write("\n")

#todo: don't normalize the relevance
#todo: add the garbage at the end of each line after # just like they do
#todo: round for 6 decimals just like they do

# pickle.dump(df, open('..\\pickled_data\\df2.pkl', 'wb'))


