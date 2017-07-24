#!/usr/bin/python


"""
    Starter code for the evaluation mini-project.
    Start by copying your trained/tested POI identifier from
    that which you built in the validation mini-project.

    This is the second step toward building your POI identifier!

    Start by loading/formatting the data...
"""

import pickle
import sys
sys.path.append("../tools/")
from feature_format import featureFormat, targetFeatureSplit

data_dict = pickle.load(open("../final_project/final_project_dataset.pkl", "r") )

### add more features to features_list!
features_list = ["poi", "salary"]

data = featureFormat(data_dict, features_list)
labels, features = targetFeatureSplit(data)



### your code goes here 
 
from sklearn import cross_validation  
features_train, features_test, labels_train, labels_test = cross_validation.train_test_split(features, labels, test_size=0.3, random_state=42)

# Create a decision tree classifier
from sklearn.tree import DecisionTreeClassifier
clf = DecisionTreeClassifier()

from sklearn.metrics import accuracy_score 
clf = clf.fit(features_train, labels_train)
pred = clf.predict(features_test)

print "POIs pred in the test set:", reduce(lambda x,y: x+y, pred)
print "POIs total in the test set:", len(pred)

print "Not POIs pred all 0.0 accuracy:", accuracy_score(len(pred) * [0], labels_test)

true_positives=0
for predd, actual in zip(pred, labels_test):
	if predd == actual and actual == 1:
		true_positives += 1
        
print "Number of true positives:", true_positives        

from sklearn.metrics import precision_score
print "precision:" , precision_score(labels_test, pred)

from sklearn.metrics import recall_score
print "recall:", recall_score(labels_test, pred)


prediction = [0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1] 
truth = [0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0]

true_positives=true_negatives=false_positives=false_negatives=0
for predd, actual in zip(prediction, truth):
	if predd == actual and actual == 1:
		true_positives += 1
    	if predd == actual and actual == 0:
		true_negatives += 1   
    	if predd == 1 and actual == 0:
		false_positives += 1 
    	if predd == 0 and actual == 1:
		false_negatives += 1          

print "Number of true positives:", true_positives
print "Number of true negatives:", true_negatives
print "Number of false positives:", false_positives
print "Number of false negatives:", false_negatives
 
print "precision:" , precision_score(truth, prediction)
print "recall:", recall_score(truth, prediction)
