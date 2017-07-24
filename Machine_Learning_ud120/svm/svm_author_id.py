#!/usr/bin/python

""" 
    This is the code to accompany the Lesson 2 (SVM) mini-project.

    Use a SVM to identify emails from the Enron corpus by their authors:    
    Sara has label 0
    Chris has label 1
"""
    
import sys
from time import time
sys.path.append("../tools/")
from email_preprocess import preprocess


### features_train and features_test are the features for the training
### and testing datasets, respectively
### labels_train and labels_test are the corresponding item labels
features_train, features_test, labels_train, labels_test = preprocess()




#########################################################
### your code goes here ###

#from sklearn.svm import LinearSVC
#clf = LinearSVC()

from sklearn.svm import SVC
clf = SVC(kernel='rbf', C=10000)

#features_train = features_train[:len(features_train)/100] 
#labels_train = labels_train[:len(labels_train)/100] 

t0 = time()
clf.fit(features_train, labels_train)
print "training time:", round(time()-t0, 3), "s"

t1 = time()
pred = clf.predict(features_test)
print "predicting time:", round(time()-t1, 3), "s"

print "accuracy: ", clf.score(features_test, labels_test)

print("pred[10]: ",pred[10]) 
print("pred[26]: ",pred[26])
print("pred[50]: ",pred[50])

chris = 0
for y in pred:
	if y == 1:
		chris += 1

print chris

#########################################################


