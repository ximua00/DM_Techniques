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

load_txt = False

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

pickle.dump(model, open(os.path.join('..', 'pickled_data', 'lambdamart_model.pkl', 'wb')))

