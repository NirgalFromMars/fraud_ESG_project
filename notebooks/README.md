# Jupyter Notebooks

This folder contains all the Jupyter notebooks used for data preprocessing, transformation, and API implementation in the "Fraud vs Sustainability" project.

## Contents

- **API.ipynb**  
  Main notebook where the API is defined and configured. Includes:
  - Data loading from CSV and database.
  - Preprocessing of datasets.
  - Definition of endpoints to serve aggregated metrics and predictions.
  - Definition and training of ML models (basic and advanced).
  - Evaluation of models (accuracy, precision, recall, F1 score, confusion matrix).

- **API_Test.ipynb**  
  Notebook for testing the API endpoints and verifying the outputs. Useful for debugging and ensuring consistency of the API responses.

- **fraud_merchant_mapping.ipynb**  
  Notebook used to generate and transform the mapping between transactions and merchants, as part of data preprocessing.

- **Generate__ESG_metrics.ipynb**  
  Notebook to generate synthetic ESG metrics for companies, including CO2 emissions, energy consumption, renewable energy percentage, waste, and water withdrawal.

- **Generate__compliance.ipynb**  
  Notebook to compute compliance indicators based on ESG thresholds and create the `compliance` dataset used in analysis and visualizations.

## Notes

- `API.ipynb` is the main notebook and should be prioritized for understanding how the API and ML endpoints are implemented.
- The notebooks for data generation and transformation are essential to replicate the datasets if working from scratch.
- All notebooks are written in Python and require the usual packages for data analysis, ML, and API development (pandas, scikit-learn, fastapi, sqlalchemy, etc.).
