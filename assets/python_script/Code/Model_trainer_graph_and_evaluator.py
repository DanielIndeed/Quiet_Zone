#!/usr/bin/env python
# coding: utf-8

# In[1]:


#Reading data

import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split 
from sklearn.ensemble import RandomForestClassifier

train_data = pd.read_csv(r"C:\Users\boscu\Code Projects\Keep On Hearing\e-nnovate\Android Phone\flutter_application_1\assets\python_script\Data\AI\Dataset1.csv", delimiter=',') # Read in data

labels = np.array(train_data['Earplugs']) # Labels are the values we want to predict
criteria = np.array(train_data['Criteria'])

train_data = train_data.drop('Earplugs', axis = 1) # Remove the labels from the features and axis 1 refers to the columns
train_data = train_data.drop('Criteria', axis = 1)

train_data_list = list(train_data.columns) # Saving factor names for later use
train_data = np.array(train_data) # Convert to numpy array


# In[2]:


train_train_data, test_train_data, train_labels, test_labels = train_test_split(
    train_data, 
    labels, 
    test_size = 0.25, 
    random_state = 1001,
)

rf = RandomForestClassifier(
    n_estimators = 780, 
    random_state = 42,
    max_depth = 13
) 


# In[3]:


rf.fit(train_train_data, train_labels) # Train the model on training data


# In[4]:


from sklearn.metrics import accuracy_score

predictions = rf.predict(test_train_data) # Use the forest's predict method on the test data
accuracy = accuracy_score(test_labels, predictions)
np.set_printoptions(suppress=True)
print("Accuracy:", accuracy)
print(test_train_data)
print (predictions)


# In[5]:

from sklearn.metrics import accuracy_score, confusion_matrix, classification_report

print(classification_report(test_labels, predictions))
# Convert to png using system command (requires Graphviz)
# In[ ]:


#Graphs of all sorts

import matplotlib.pyplot as plt
x = list(range(np.count_nonzero(predictions) + np.count_nonzero(predictions==0)))
y = test_labels

a = x
b = predictions
fig = plt.scatter(x, y, color = "blue", label="answers")
ax = plt.scatter(a, b, color = "red", label="predictions", alpha=0.9)
plt.legend(loc="upper left")
plt.ylim(-0.1, 2.5)


plt.savefig(r'C:\Users\boscu\e_nnovate\Graphs', dpi=400)
plt.show()

from sklearn import datasets
from sklearn.tree import DecisionTreeRegressor
from sklearn import tree

X = train_data
Y = labels

regr = DecisionTreeRegressor(max_depth=2, random_state=10000)
model = regr.fit(X, Y)

print(X[1])

fig = plt.figure(figsize=(50,45))
_ = tree.plot_tree(regr, filled=True)
fig.savefig(r'C:\Users\boscu\e_nnovate\Graphs', dpi=400)


# In[ ]:





# In[ ]:




