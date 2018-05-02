import os
import time
import matplotlib

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

matplotlib.rcParams.update({'font.size': 7})

start = time.time()

df = pd.read_csv(open("Data/training_set_VU_DM_2014.csv"))
# df = pd.read_csv(open("Data/training_2000.csv"))
# df = pd.read_csv(open("Data/training_no_comp.csv"))

print ("Time to read data = %.2fs" % (time.time() - start))

# print(df.sample(5))
# --------- Displays the number of null values for each attribute
df2 = df.isnull().sum()
# print(df2)
print(df2.sum(), ": Sum of all null values")

# ------------ plot for number of null attributes
plt.figure()
plt.title("Number of null values for each attribute")
plt.ylabel("Attributes")
plt.xlabel("Null Counts")
plt.show()
df2.plot.barh()
# After observing the plots (and doing some calculations in excel), around 82% of the dataset
# is comprised of NULL instances, arising mainly from the "competitor comparing"
# attributes. I removed these attributes, and the resulting csv file was just 122MB.


# ------- removing entries where the "user" country is same as the "hotel" country
index = []
# subset1 = df[['visitor_location_country_id', 'prop_country_id']]
temp = df.groupby(['visitor_location_country_id', 'prop_country_id']).nunique()
dummy = df.groupby(by = ['visitor_location_country_id', 'prop_country_id']).groups

for visitor, prop in dummy:
    if visitor == prop:
        index.append(visitor)

df = temp.drop(index, axis = 0)
# df.to_csv('training_mod1.csv', sep = '\t', encoding = 'utf-8')
# The data set has reduced drastically to only 514 rows. I'm not sure if this
# approach is correct. There might be some errors. TODO: Need to discuss
