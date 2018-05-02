'''EDA - Effect of promotions on booked/clicked
'''

import pickle
import pandas as pd
import numpy as np
import time
import matplotlib.pyplot as plt
import seaborn as sns


#Load Data
start = time.time()
train_data = pickle.load(open('../pickled_data/trainFullData.pkl', 'rb'))
print ("Time to read data = %.2fs " % (time.time() - start))

#Crosstables
print (pd.crosstab(train_data['click_bool'], train_data['promotion_flag']))
print (pd.crosstab(train_data['booking_bool'], train_data['promotion_flag']))

# promotion_flag        0        1
# click_bool                      
# 0               3731819  1004649
# 1                157410    64469


# promotion_flag        0        1
# booking_bool                    
# 0               3792786  1027171
# 1                 96443    41947

#P(Clicking | Promotion = 1) = 64469 /1004649 + 64469 = 6,03%
#P(Clicking | Promotion = 0) = 157410 /3731819 + 157410 = 4,05%

#P(Booking | Promotion = 1) = 41947 /1027171 + 41947 = 3,92%
#P(Booking | Promotion = 0) = 96443 /3792786 + 96443 = 2,48%

#CONCLUSION: Having promotion has a positive effect on booking and clicking. 