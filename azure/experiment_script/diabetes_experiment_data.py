# Let's create a new script that uses this data, using named input "csv_data"
from azureml.core import Run
import argparse
import pandas as pd
import matplotlib.pyplot as plt
import joblib
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import roc_auc_score, plot_confusion_matrix

parser = argparse.ArgumentParser()
parser.add_argument('--reg_rate', type=float, dest='reg', default=0.01)
args = parser.parse_args()
reg = args.reg


# Start logging
run = Run.get_context()

# Input
data = run.input_datasets['csv_data'].to_pandas_dataframe()
X = data.drop(columns=['PatientID', 'Diabetic'])
y = data.iloc[:,-1]

# Scale X
X_scaled = StandardScaler().fit_transform(X)
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size = 0.2)

# Number of rows in data for funsies
run.log('observations', len(data))
run.log('positives', len(data[data['Diabetic'] == 1]))
run.log('negatives', len(data[data['Diabetic'] == 0]))

# Train a model
model = LogisticRegression(C=1/reg, random_state=0).fit(X_train, y_train)
y_pred = model.predict(X_test)

auc = roc_auc_score(y_test, y_pred)
run.log('AUC', auc)

conf = plot_confusion_matrix(model, X_test, y_test)
run.log_image(name = "confusion_matrix", plot = plt)

# Upload sample file, because why not
sample = data.sample(n=100)
# Creates outputs folder which is auto-uploaded to the experiment, instead of run.upload_file()
sample.to_csv('outputs/sample.csv')
# Save model
joblib.dump(value=model, filename='outputs/model.pkl')

run.complete()
