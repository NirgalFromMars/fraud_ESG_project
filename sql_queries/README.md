# SQL Queries

This folder contains the SQL scripts used to create, transform, and verify the datasets imported into the local SQL Server database for the "Fraud vs Sustainability" project.

## Contents

- **SQLQuery__Create SQL DB with CSV Data.sql**  
  Script to create the database and tables, and to load the original and preprocessed CSV datasets into SQL Server.

- **SQLQuery__Checks.sql**  
  Script to perform basic validation and sanity checks on the data, including row counts, column types, and simple aggregations.

## Notes

- These queries are intended to be executed in Microsoft SQL Server Management Studio (SSMS).  
- The scripts assume that CSV files have been previously downloaded and organized in the corresponding folder structure.  
- They are foundational for ensuring the datasets are correctly loaded and consistent before connecting them to Power BI or the API.  
