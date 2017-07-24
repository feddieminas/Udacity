#!/usr/bin/python

import sys
import pickle
sys.path.append("../tools/")

from feature_format import featureFormat, targetFeatureSplit
from tester import test_classifier,dump_classifier_and_data

### Task 1: Select what features you'll use.
### features_list is a list of strings, each of which is a feature name.
### The first feature must be "poi".
### features_list = ['poi','salary'] #default
features_list = ['poi','salary', 'long_term_incentive','loan_advances', 'total_payments', 'exercised_stock_options', 'deferral_payments','deferred_income','bonus', 'shared_receipt_with_poi', 'total_stock_value', 'restricted_stock',  'director_fees', 'other', 'from_poi_to_this_person'] # You will need to use more features

### Load the dictionary containing the dataset
with open("final_project_dataset.pkl", "r") as data_file:
    data_dict = pickle.load(data_file)

### Task 2: Remove outliers
for outlier in ['TOTAL']:
        data_dict.pop(outlier, 0)

### Task 3: Create new feature(s) One can add the ratio of messages pois shared with each other

### Store to my_dataset for easy export below.
my_dataset = data_dict

### Extract features and labels from dataset for local testing
data = featureFormat(my_dataset, features_list, sort_keys = True)
labels, features = targetFeatureSplit(data)

### Task 4: Try a varity of classifiers
### Please name your classifier clf for easy export below.
### Note that if you want to do PCA or other multi-stage operations,
### you'll need to use Pipelines. For more info:
### http://scikit-learn.org/stable/modules/pipeline.html

# Provided to give you a starting point. Try a variety of classifiers.

from sklearn.feature_selection import SelectKBest
k=6
kbest = SelectKBest(k=k)
kbest.fit(features, labels)

scores = kbest.scores_
scorelist=zip(features_list,scores)
scorelist=sorted(scorelist, key=lambda x:x[1])
bestscorelist=scorelist[-k-1:] #best k plus poi

print "best feature_list with scores:", bestscorelist

features_list=dict(bestscorelist).keys()
for i,val in enumerate(features_list):
    if val=='poi':
        features_list[0],features_list[i] = 'poi',features_list[0]

print "feature_list:", features_list

from sklearn.cross_validation import train_test_split   
features_train, features_test, labels_train, labels_test = \
    train_test_split(features, labels, test_size=0.3, random_state=42)

from sklearn.decomposition import PCA
from sklearn.pipeline import Pipeline


#1)     
from sklearn.svm import LinearSVC
clfselect = LinearSVC(random_state=42)
params_svc = {"C": [1, 2, 5, 10, 100, 1000],"tol":[0.1,0.01,0.00001],"class_weight":['auto']}    

''''''    
pca=PCA(n_components=2)
pca.fit(features_train)
print "Explained Variance ratio:", pca.explained_variance_ratio_
print "First_pc:", pca.components_[0]
print "Second_pc:", pca.components_[1]
''''''

pca=PCA()
params_PCA={"pca__n_components":[2,3,4,5], "pca__whiten": [False]}

upd_params_svc = {}
for key, value in params_svc.items():
    upd_params_svc["svm" + "__" + key] = value

upd_params_svc.update(params_PCA)

#clf = Pipeline([("pca", pca), ("svm", clfselect)])
clf = (Pipeline([("pca", pca), ("svm", clfselect)]), upd_params_svc)

clf, params=clf

from sklearn.metrics import make_scorer
from sklearn.metrics import f1_score
from sklearn.grid_search import GridSearchCV
scorer = make_scorer(f1_score)
clf = GridSearchCV(clf, params, scoring=scorer)
clf = clf.fit(features_train, labels_train)
clf = clf.best_estimator_

from sklearn.metrics import recall_score
from sklearn.metrics import precision_score

pred = clf.predict(features_test)
f1 = f1_score(labels_test, pred)
print "f1:", f1
recall = recall_score(labels_test, pred)
print "recall:", recall
precision = precision_score(labels_test, pred)
print "precision:", precision


#2)
'''    
from sklearn.naive_bayes import GaussianNB #default
pca=PCA(n_components=5)
clfselect = GaussianNB()  #default
clf = Pipeline([("pca", pca), ("nb", clfselect)])
'''


#3)
'''
from sklearn.cluster import KMeans    
clfselect = KMeans(n_clusters=2, tol = 0.001)
pca = PCA(n_components=2)
clf = Pipeline([("pca", pca), ("kmeans", clfselect)]) 

from sklearn.preprocessing import MinMaxScaler
scaler = MinMaxScaler() 
features = scaler.fit_transform(features)
print features
'''


#accuracy, precision, recall, f1,f2 scores and confusion matrix can be created by
#yourself but tester.py later does it for you and you can view it on output 

### Task 5: Tune your classifier to achieve better than .3 precision and recall 
### using our testing script. Check the tester.py script in the final project
### folder for details on the evaluation method, especially the test_classifier
### function. Because of the small size of the dataset, the script uses
### stratified shuffle split cross validation. For more info: 
### http://scikit-learn.org/stable/modules/generated/sklearn.cross_validation.StratifiedShuffleSplit.html

# Example starting point. Try investigating other evaluation techniques!
#from sklearn.cross_validation import train_test_split   #default used above
#features_train, features_test, labels_train, labels_test = \
#    train_test_split(features, labels, test_size=0.3, random_state=42)
    
test_classifier(clf, my_dataset, features_list)    

### Task 6: Dump your classifier, dataset, and features_list so anyone can
### check your results. You do not need to change anything below, but make sure
### that the version of poi_id.py that you submit can be run on its own and
### generates the necessary .pkl files for validating your results.

dump_classifier_and_data(clf, my_dataset, features_list)