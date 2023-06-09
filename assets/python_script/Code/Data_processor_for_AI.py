import pandas as pd
import numpy as np
import joblib
import sys

f = open(r"C:\Users\boscu\Code Projects\Keep On Hearing\e-nnovate\Android Phone\flutter_application_1\assets\python_script\Data\Notepads\Age.txt", 'r+')
content = f.readlines()
val_age = float(content[0])
avg_val_dB = float(sys.argv[1])
k = float(sys.argv[2])

if avg_val_dB >= 80:
	absolute_timer_alg=float(k*0.1)
else:
	absolute_timer_alg=0
if absolute_timer_alg > 60:
	absolute_timer_alg=0
absolute_timer_alg=float(absolute_timer_alg)

input_data = {
    'Age': [val_age],
    'Noise level': [avg_val_dB],
    'Time exposure': [absolute_timer_alg]
}

input_data = pd.DataFrame(input_data)
input_data = np.array(input_data)

joblib_file = "joblib_rf.pkl"
ML_model = joblib.load(joblib_file)
prediction = ML_model.predict(input_data)

print(prediction)
