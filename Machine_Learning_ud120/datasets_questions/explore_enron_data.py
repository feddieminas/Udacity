#!/usr/bin/python

""" 
    Starter code for exploring the Enron dataset (emails + finances);
    loads up the dataset (pickled dict of dicts).

    The dataset has the form:
    enron_data["LASTNAME FIRSTNAME MIDDLEINITIAL"] = { features_dict }

    {features_dict} is a dictionary of features associated with that person.
    You should explore features_dict as part of the mini-project,
    but here's an example to get you started:

    enron_data["SKILLING JEFFREY K"]["bonus"] = 5600000
    
"""

import pickle

enron_data = pickle.load(open("../final_project/final_project_dataset.pkl", "r"))

print "Data Points (People): " + str(len(enron_data))

print "Features: " + str(len(enron_data['ALLEN PHILLIP K']))


poiCount=0
for person in enron_data:
    if enron_data[person]['poi']==1:
        poiCount+=1
        
        
print "Poi counts pkl:",poiCount  

f = open("../final_project/poi_names.txt")

poiCountxt=0
for line in f:
    if line[0]=='(':
        poiCountxt+=1
        
print "Poi counts txt:",poiCountxt  

print "James Prentice stock value: " + str(enron_data['PRENTICE JAMES']['total_stock_value'])     

print "Email messages from Wesley Colwell: " + str(enron_data['COLWELL WESLEY']['from_this_person_to_poi']) 

print "Jeffrey Skilling excercised stock options: " + str(enron_data['SKILLING JEFFREY K']['exercised_stock_options'])

'''
ptf=False
if any(str(['LAY'] in ['LAY KENNETH L'])):
    ptf=True
    print ptf
'''

MaxTotalPayment=0
PersonGot=str
for key, value in enron_data.iteritems():
    if key in ['LAY KENNETH L','SKILLING JEFFREY K','FASTOW ANDREW S']:
        print key,  "total_payments: ", value['total_payments']
        if value['total_payments']>MaxTotalPayment: 
            MaxTotalPayment=value['total_payments']
            PersonGot=key

print PersonGot, "got", MaxTotalPayment

quantified_salaryCount = 0
known_email = 0
for key, value in enron_data.items():
    if value['salary'] != 'NaN':
        quantified_salaryCount+=1
    if value['email_address'] != 'NaN':
        known_email+=1

print "Quantified salary count: ", quantified_salaryCount 
print "Known email addresses: ", known_email

############

total_paymentsCount = 0
for key, value in enron_data.items():
    if value['total_payments'] == 'NaN':
        total_paymentsCount+=1

print "Total NaN payments count: ", total_paymentsCount
print "Total NaN payments count percentage: ", (round(float(total_paymentsCount) / len(enron_data.values())*100,3)), "%"

total_nanpaymentsCount = 0
for key, value in enron_data.items():
    if value['total_payments'] == 'NaN' and value['poi'] == True:
        total_nanpaymentsCount+=1

print "Total NaN payments count: ", (round(float(total_nanpaymentsCount) / len(enron_data.values()),3))

print "New Data Points (People): " + str(len(enron_data)+10)

print "New Total NaN payments count: ", str(total_paymentsCount+10)

print "New Poi counts pkl:",str(poiCount+10)  

print "New Total NaN payments count: ", str(total_nanpaymentsCount+10)







      

