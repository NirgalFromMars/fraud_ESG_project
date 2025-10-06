# Original and Synthetic Data

This folder contains the raw datasets used in the "Fraud vs Sustainability" project as well as the generated synthetic data required for analysis and visualization.

## Subfolders and Files

### `kaggle__fraud_transactions`
- **fraudTrain.csv**  
  Original Kaggle training dataset with transaction records, including fraud labels.
- **fraudTest.csv**  
  Original Kaggle test dataset with transaction records.

### `list compañies`
- **companies_list.csv**  
  List of companies used in the project, including company identifiers and basic information.

### Other CSV files in this folder
- **thresholds_ESG.csv**  
  Defines threshold values for ESG metrics used to determine compliance.
- **fraudTrain_reduced.csv**  
  Preprocessed/reduced version of the Kaggle fraud training dataset.
- **esg_metrics.csv**  
  Synthetic ESG metrics generated for all companies.
- **esg_metrics_reduced.csv**  
  Reduced version of the ESG metrics dataset, possibly with selected columns.
- **fraud_merchant_mapping.csv**  
  Mapping of transactions to merchants used in data preprocessing.
- **compliance.csv**  
  Generated compliance indicators based on ESG thresholds for each company.

## Notes

- All raw data (Kaggle datasets) are kept unchanged; transformations and preprocessing are handled in the Jupyter notebooks.
- Synthetic data is created to simulate ESG metrics and compliance, allowing integrated analysis with fraud transactions.
- The structure and naming conventions are designed to simplify linking with Power BI and the API endpoints.
