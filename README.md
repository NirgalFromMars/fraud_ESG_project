# Fraud & ESG Project - Power BI & ML Pipeline

## Project Overview
This project provides a complete end-to-end solution for analyzing **fraud transactions** and **ESG (sustainability) metrics** of companies. It includes:

- Integration and preprocessing of raw and synthetic data from CSV files.
- Creation of a local **SQL Server database** for structured storage.
- Implementation of **ML models** (basic and advanced) with scikit-learn.
- An **API** to train models and extract metrics and predictions.
- A **Power BI dashboard** for executive, detailed, and ESG-focused insights.

The project allows cross-analysis between fraud risk and sustainability compliance, supporting both operational and strategic decision-making.

---

## Repository Structure

Fraud_ESG_Project/
│
├── README.md
├── LICENSE (optional)
├── power_bi/
│ └── Fraude_vs_Sostenibilidad.pbix
│
├── sql_queries/
│ ├── SQLQuery__Create SQL DB with CSV Data.sql
│ └── SQLQuery__Checks.sql
│
├── notebooks/
│ ├── API.ipynb
│ ├── API_Test.ipynb
│ ├── fraud_merchant_mapping.ipynb
│ ├── Generate__ESG_metrics.ipynb
│ └── Generate__compliance.ipynb
│
├── data/
│ ├── kaggle__fraud_transactions/
│ │ ├── fraudTrain.csv
│ │ └── fraudTest.csv
│ ├── list_companies/
│ │ └── companies_list.csv
│ ├── thresholds_ESG.csv
│ ├── fraudTrain_reduced.csv
│ ├── esg_metrics.csv
│ ├── esg_metrics_reduced.csv
│ ├── fraud_merchant_mapping.csv
│ └── compliance.csv
│
└── api_config/
├── api.log
├── openapi.json
└── security_config.py

## Setup & Usage

### 1. SQL Database
- Open **SSMS** and execute the following scripts in order:
  1. `SQLQuery__Create SQL DB with CSV Data.sql` → creates database and tables, loads CSV data.
  2. `SQLQuery__Checks.sql` → basic checks to validate the database.

### 2. Python Environment
- Create and activate a virtual environment:
```bash
python -m venv venv
# Linux / Mac
source venv/bin/activate
# Windows
venv\Scripts\activate
```
Install dependencies: pip install -r requirements.txt

### 3. Jupyter Notebooks

API.ipynb: defines the ML API endpoints.
API_Test.ipynb: tests API endpoints locally.
fraud_merchant_mapping.ipynb, Generate__ESG_metrics.ipynb, Generate__compliance.ipynb: notebooks for data preprocessing and synthetic data generation.

### 4. Power BI Dashboard

Open power_bi file "Fraude_vs_Sostenibilidad.pbix".
Update database connections if necessary.
The dashboard contains:
  * Executive view: top fraud metrics and summary KPIs.
  * Analytics view: detailed breakdowns and trends.
  * ML view: model metrics, confusion matrices, and performance comparison.
  * ESG view: company sustainability metrics and sector-level analysis.
  * Fraud vs ESG view: combined insights between fraud and compliance scores.

Notes
All raw and transformed data is stored in the /data folder.
Predictions from ML models are stored in local SQL Server tables (ml_predictions_basic and ml_predictions_advanced).
The API allows the training of models and extraction of metrics (accuracy, precision, recall, F1, confusion matrix).
Power BI visuals are mostly dynamic, responding to slicers for country, sector, and other filters.

Recommendations & Best Practices
Commits: Use clear and descriptive messages (e.g., Added Power BI dashboard, Implemented ML API endpoint).
Large files: If .pbix files are large, consider Git LFS or external links.
Sensitive data: Exclude credentials or API keys via .gitignore.
Versioning: Keep a clean version of notebooks and Power BI files for reproducibility.

Contact / Support
For any questions about the project structure, notebooks, or Power BI setup, please contact the project maintainer.
