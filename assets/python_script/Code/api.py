import os
import subprocess
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/age', methods=['GET'])
def process_age():
    age = {}
    age['query_age'] = request.args.get('query_age')
    with (open(r"/home/quietzone/mysite/Age.txt", 'w')) as f:
        f.write(str(age['query_age']))
    return jsonify(age)

@app.route('/db_values', methods=['GET'])
def process_db_values():
    db_values = {}
    db_values['query_db_values'] = request.args.get('query_db_values')
    with (open(r"/home/quietzone/mysite/Microphone/Microphone_values.txt", 'a')) as f:
        f.write(str(db_values['query_db_values']) + "/n")
    return jsonify(db_values)

@app.route('/response') # type: ignore
def home():
    avg_val_dB = request.args.get('avg_val_dB')
    k = request.args.get('k')
    command = ['python', r'C:/Users/boscu/Code Projects/Keep On Hearing/e-nnovate/Android Phone/flutter_application_1/assets/python_script/Code/Data_processor_for_AI.py', avg_val_dB, k]
    response_1 = subprocess.run(command, stdout=subprocess.PIPE) # type: ignore
    return jsonify({'response' : response_1.stdout.decode('utf-8')[2:10]})

app.run(port=8000, debug=True)


