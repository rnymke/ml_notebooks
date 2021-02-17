from azureml.core import Run
import argparse
import pandas as pd
import os
# Start logging
run = Run.get_context()

# Args
parser = argparse.ArgumentParser()
parser.add_argument('--output-folder', type=str, dest='output_folder')
args = parser.parse_args()
output_folder = args.output_folder

# Input dataframe
raw_df = run.input_datasets['raw_data'].to_pandas_dataframe()

run.log('cols before', raw_df.columns)

# Output dataframe
out_df = raw_df.drop(columns=['PatientID'])

run.log('cols after', out_df.columns)

out_df.to_csv(output_folder + 'prepped_data.csv')

run.complete()

