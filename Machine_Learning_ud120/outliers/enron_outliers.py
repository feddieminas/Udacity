#!/usr/bin/python

import pickle
import sys
import matplotlib.pyplot
sys.path.append("../tools/")
from feature_format import featureFormat, targetFeatureSplit


### read in data dictionary, convert to numpy array
data_dict = pickle.load( open("../final_project/final_project_dataset.pkl", "r") )
features = ["salary", "bonus"]
#data = featureFormat(data_dict, features) #moved down


### your code below
max_salary = 0
max_salary_key = None

for key,value in data_dict.items():
	if value["salary"] != 'NaN' and value["salary"] > max_salary:
		max_salary = value["salary"]
		max_salary_key = key

print "dict key biggest outlier:", max_salary_key
data_dict.pop(max_salary_key, 0) #remove outlier

for key,value in data_dict.items():
	if value["salary"] != 'NaN' and value["bonus"] != 'NaN':
		if value["bonus"] >= 5000000 and value["salary"] > 1000000:
			print "Bandits:", key

data = featureFormat(data_dict, features)

for point in data:
    salary = point[0]
    bonus = point[1]
    matplotlib.pyplot.scatter( salary, bonus )

matplotlib.pyplot.xlabel("salary")
matplotlib.pyplot.ylabel("bonus")
matplotlib.pyplot.show() 
