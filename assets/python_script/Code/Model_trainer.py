import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split 
from sklearn.ensemble import RandomForestClassifier

np.set_printoptions(suppress=True)

train_data = pd.read_csv(r"C:\Users\boscu\Code Projects\Keep On Hearing\e-nnovate\Android Phone\flutter_application_1\assets\python_script\Data\AI\Dataset1.csv", delimiter=',') # Read in data

labels = np.array(train_data['Earplugs'])
criteria = np.array(train_data['Criteria'])

train_data = train_data.drop('Earplugs', axis = 1)
train_data = train_data.drop('Criteria', axis = 1)

train_data_list = list(train_data.columns)
train_data = np.array(train_data)

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

rf.fit(train_train_data, train_labels)

import joblib

joblib_file = "joblib_rf.pkl"  
joblib.dump(rf, joblib_file)

ML_model = joblib.load(joblib_file)

predictions = ML_model.predict(test_train_data)