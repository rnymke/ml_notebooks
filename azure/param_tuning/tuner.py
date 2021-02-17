from azureml.core import Run
import argparse
import pandas as pd
import joblib
from sklearn.model_selection import train_test_split
from xgboost import XGBClassifier
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import roc_auc_score

parser = argparse.ArgumentParser()
parser.add_argument('--eta', type=float, dest='eta', default=0.1, help='help me!')
parser.add_argument('--colsample', type=float, dest='colsample', default=0.8, help='help me!')
parser.add_argument('--max_depth', type=int, dest='max_depth', default=5, help='help me!')
args = parser.parse_args()

eta = args.eta
colsample = args.colsample
max_depth = args.max_depth

# Start logging
run = Run.get_context()

data = run.input_datasets['training_data'].to_pandas_dataframe()
X = data.drop(columns=['PatientID', 'Diabetic'])
y = data.iloc[:,-1]

# Scale X
X_scaled = StandardScaler().fit_transform(X)
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size = 0.2)

# Train a model
model = XGBClassifier(learning_rate=eta, colsample_bytree=colsample, max_depth=max_depth).fit(X_train, y_train)
y_pred = model.predict(X_test)

auc = roc_auc_score(y_test, y_pred)

# Log the target performance metric (AUC)
run.log('AUC', auc)

# Save model
joblib.dump(value=model, filename='outputs/model.pkl')

run.complete()
