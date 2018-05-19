"""""""""""""""""""""""""""""""""""""""
       CONVERTING CSV INTO TXT
"""""""""""""""""""""""""""""""""""""""
import pickle
import matplotlib
import numpy as np
import pandas as pd
import seaborn as sns
import os
from sklearn import preprocessing
import time

def df_to_txt(df, txt_path, add_relevance_grades=False, normalize=False, replace_nas=False, relevance=True):
    matplotlib.rcParams.update({'font.size': 7})
    sns.set(style="ticks")

    print("shape: " + str(df.shape))

    """ remove unwanted columns """
    del df['date_time']
    # del df['position']

    """ add relevance grade """
    if add_relevance_grades:
        print("Adding Relevance Grade...")
        def relevance_grade(row):
            if int(row['booking_bool']) == 1 and int(row['click_bool']) == 1:
                grade = 5
            elif int(row['click_bool']) == 0 and int(row['booking_bool']) == 0:
                grade = 0
            else:
                grade = 1
            return grade

        if relevance:
            df['relevance'] = df.apply(relevance_grade, axis = 1)
        del df['click_bool']
        del df['booking_bool']

    """ normalize data """
    if normalize:
        print("Normalizing...")
        for col in df:
            if col == 'relevance':
                continue
            df[col]=(df[col]-df[col].min())/(df[col].max()-df[col].min())

    """ replaces NA's """
    if replace_nas:
        print("Replacing NA's...")
        df.fillna(0, inplace=True)

    """ the actual converting """

    print("Converting...")
    time1 = time.time()

    # txt_file = os.path.join('..', 'data', 'test.txt')
    n_row = 0

    with open(txt_path, 'w') as output_file:
        for _, row in df.iterrows():
            n_row += 1
            print(str(n_row) + "out of " + str(df.shape[0]))
            if 'relevance' in df.columns:
                output_file.write(str(int(row['relevance'])) + " ")

            output_file.write("qid:" + str(int(row['srch_id'])))
            n = 1
            for name in row.index:
                if name == 'srch_id' or name == 'relevance':
                    continue

                output_file.write(" " + str(n) + ":" + str(row[name]))
                n += 1
            output_file.write(" # bleh\n")

    print("Time: ", time.time() - time1)
    # pickle.dump(df, open('..\\pickled_data\\df2.pkl', 'wb'))

