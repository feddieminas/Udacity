#!/usr/bin/python

import os
import pickle
import re
import sys

sys.path.append( "../tools/" )
from parse_out_email_text import parseOutText

"""
    Starter code to process the emails from Sara and Chris to extract
    the features and get the documents ready for classification.

    The list of all the emails from Sara are in the from_sara list
    likewise for emails from Chris (from_chris)

    The actual documents are in the Enron email dataset, which
    you downloaded/unpacked in Part 0 of the first mini-project. If you have
    not obtained the Enron email corpus, run startup.py in the tools folder.

    The data is stored in lists and packed away in pickle files at the end.
"""

# Warming Up With ParseOutText()
testEmail = open("test_email.txt", "r")
print parseOutText(testEmail) #quiz 17 before changes from quiz 18 and on


from_sara  = open("from_sara.txt", "r")
from_chris = open("from_chris.txt", "r")

from_data = []
word_data = []

### temp_counter is a way to speed up the development--there are
### thousands of emails from Sara and Chris, so running over all of them
### can take a long time
### temp_counter helps you only look at the first 200 emails in the list so you
### can iterate your modifications quicker

#temp_counter = 0

for name, from_person in [("sara", from_sara), ("chris", from_chris)]:
    for path in from_person:
        ### only look at first 200 emails when developing
        ### once everything is working, remove this line to run over full dataset
        
        # temp_counter += 1
        # if temp_counter < 200:
        
        #path = os.path.join('..', path[:-1]) #if work this way, default
        #otherwise
        path = os.path.join('..', path[:-2]+'_')
        #print path
        email = open(path, "r")

        ### use parseOutText to extract the text from the opened email
        parsedOutText=parseOutText(email)
        
        #print parsedOutText

        ### use str.replace() to remove any instances of the words
        ### ["sara", "shackleton", "chris", "germani"] for this text learning lesson
        ### ["sara", "shackleton", "chris", "germani","sshacklensf","cgermannsf"] for next feature selection lesson    
        for word in ["sara", "shackleton", "chris", "germani"]:
            parsedOutText = parsedOutText.replace(word,"")

        ### append the text to word_data
        word_data.append(parsedOutText.strip())           

        ### append a 0 to from_data if email is from Sara, and 1 if email is from Chris
        from_data.append(0 if name=="sara" else 1)

        email.close()

            
print "String from word #152: ", word_data[152]

print "emails processed"
from_sara.close()
from_chris.close()

pickle.dump( word_data, open("your_word_data.pkl", "w") )
pickle.dump( from_data, open("your_email_authors.pkl", "w") )


### in Part 4, do TfIdf vectorization here
from sklearn.feature_extraction.text import TfidfVectorizer
vectorizer = TfidfVectorizer(stop_words='english')
vectorizer.fit_transform(word_data)  

pickle.dump( vectorizer, open("tfidf_vectorizer.pkl", "w") )

'''
need to comment temp_counter = 0, temp_counter += 1 and if temp_counter < 200:
to run through all files in order to obtain the answers below 
'''

feature_names = vectorizer.get_feature_names()    
print "unique words in Tfldf", len(feature_names) #38757

print "word 34597 in Tfldf made", feature_names[34597] #stephaniethank

