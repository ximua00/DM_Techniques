import os
import time
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
# df = pd.read_csv(open("Data/training_no_comp.csv"))

print ("Time to read data = %.2fs" % (time.time() - start))

# print(df.sample(5))
# --------- Displays the number of null values for each attribute
df2 = df.isnull().sum().sort_values()
# print(df2)
print(df2.sum(), ": Sum of all null values")
#
# # ------------ plot for number of null attributes
plt.figure()
plt.title("Number of null values for each attribute")
plt.ylabel("Attributes")
plt.xlabel("Null Counts")
df2.plot.barh()
plt.show()
# After observing the plots (and doing some calculations in excel), around 82% of the dataset
# is comprised of NULL instances, arising mainly from the "competitor comparing"
# attributes. I removed these attributes, and the resulting csv file was just 122MB.

# ------------- Time period the data was collected
date = df[['date_time']]
print(date.max())
print(date.min())

# ------------- location of customer vs. price of clicked/booked hotels
# ------------- show top/bottom 5

subset1 = df[['visitor_location_country_id', 'prop_country_id', 'gross_bookings_usd']]
subset1 = subset1.groupby(by = ['visitor_location_country_id'])
temp = subset1['gross_bookings_usd'].agg(np.mean)
temp = temp.sort_values(na_position = 'last').dropna(axis = 0, how = 'any')

fig, axes = plt.subplots(nrows=1, ncols=2)
# plt.figure()
ax = temp.tail(10).plot(ax = axes[1], kind='bar', title = 'Avg expenditure by customers from each country - top 10', color = 'green')
ax.set_ylabel("Cost")
ax.set_xlabel("Country ID")

ax1 = temp.head(10).plot(ax = axes[0], kind='bar', title = 'Avg expenditure by customers from each country - bottom 10', color = 'red')
ax1.set_ylabel("Cost")
ax1.set_xlabel("Country ID")
plt.show()
print(subset1.sample(5))

# # plt.figure()
# sns.pairplot(data = subset1, y_vars = ['visitor_location_country_id'],  x_vars = ['gross_bookings_usd'],  hue= 'prop_country_id', size = 10)
# # plt.legend(loc='lower right')
# # subset1.plot.scatter(y = 'visitor_location_country_id', x = 'gross_bookings_usd', c = 'prop_country_id', colourmap = 'winter')
# plt.show()

# ------- removing entries where the "user" country is same as the "hotel" country
# NOTE: This method can't be used. neglect it --------

# The data set has reduced drastically to only 514 rows. I'm not sure if this
# approach is correct. There might be some errors.

# index = []
# subset1 = df[['visitor_location_country_id', 'prop_country_id']]
# temp = df.groupby(['visitor_location_country_id', 'prop_country_id']).nunique()
# dummy = df.groupby(by = ['visitor_location_country_id', 'prop_country_id']).groups
#
# for visitor, prop in dummy:
#     if visitor == prop:
#         index.append(visitor)
#
# df = temp.drop(index, axis = 0)
# df.to_csv('training_mod1.csv', sep = '\t', encoding = 'utf-8')
