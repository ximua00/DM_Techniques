import os
import time
import pickle
import matplotlib

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

from sklearn.ensemble import GradientBoostingRegressor  #GBM algorithm
from SplitData import Train_Validation_Split

from preprocessing_missing import preprocessing_missing, composite_features, remove_variables

matplotlib.rcParams.update({'font.size': 8})
sns.set(style="ticks")

start = time.time()
with open('pickled_data/training_set.pickle', 'rb') as f:
    df = pickle.load(f)

print ("Time to read data = %.2fs" % (time.time() - start))

prep_time = time.time()
df = preprocessing_missing(df)
df_complete_composite = composite_features(df)

with open('pickled_data/training_set_modified.pickle', 'wb') as f:
    pickle.dump(df_complete_composite, f, pickle.HIGHEST_PROTOCOL)

print ("Time to preprocess = %.2fs" % (time.time() - prep_time))

train, valid = Train_Validation_Split(df_complete_composite)
train_features, train_target = remove_variables(df_complete_composite)

# Fit regression model
gbm_time = time.time()
params = {'n_estimators': 500, 'max_depth': 4, 'min_samples_split': 2,
          'learning_rate': 0.01, 'loss': 'ls'}
clf = GradientBoostingRegressor(**params)
clf.fit(train_features, train_target)
print ("Time to run GB regressor = %.2fs" % (time.time() - gbm_time))

test_sample = valid
test_features, test_target = remove_variables(test_sample)

test_score = np.zeros((params['n_estimators'],), dtype=np.float64)
for i, pred_target in enumerate(clf.staged_predict(test_features)):
    test_score[i] = clf.loss_(test_target, pred_target)

plt.title('Deviance')
plt.plot(np.arange(params['n_estimators']) + 1, clf.train_score_, 'b-',
         label='Training Set Deviance')
plt.plot(np.arange(params['n_estimators']) + 1, test_score, 'r-',
         label='Validation Set Deviance')
plt.legend(loc='upper right')
plt.xlabel('Boosting Iterations')
plt.ylabel('Deviance')
plt.show()
