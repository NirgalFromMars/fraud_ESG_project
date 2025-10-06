# Data Folder

This directory contains all datasets used in the **Fraud vs. ESG** project, including both original data sources and synthetic or derived datasets generated during preprocessing and feature engineering.

---

## 📁 Structure

### Main Datasets

* **fraudTrain_reduced.csv** — Compressed version of the Kaggle dataset *“Fraud Detection”* ([original source](https://www.kaggle.com/datasets/kartik2112/fraud-detection)).
  This file was reduced to keep only the essential variables for model training and testing.

* **companies_list.csv** — List of companies and identifiers used to map financial transactions with ESG performance metrics.

* **thresholds_ESG.csv** — Reference thresholds used for ESG compliance evaluation.

* **fraud_merchant_mapping.csv** — Mapping table linking merchants to companies/sectors for enriched analysis.

* **esg_metrics.csv / esg_metrics_reduced.csv** — Generated ESG indicators for each company, including sustainability, governance, and social responsibility metrics.

* **compliance.csv** — Derived dataset with compliance status (“compliant” / “non_compliant”) based on ESG thresholds.

---

## 🧩 Notebooks Using These Files

The preprocessing and creation of the above datasets were performed in the following notebooks (see `/notebooks` folder):

* `fraud_merchant_mapping.ipynb`
* `Generate__ESG_metrics.ipynb`
* `Generate__compliance.ipynb`

---

## ⚙️ Notes

* Only **reduced and synthetic** datasets are included to minimize repository size and comply with Kaggle’s redistribution policy.
* All data are stored in CSV format and later imported into the local SQL database for integration with Power BI and the API endpoints.
