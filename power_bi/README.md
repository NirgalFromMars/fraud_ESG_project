# Power BI Reports

This folder contains the Power BI report developed for the "Fraud vs Sustainability" project.

## Files

- **Fraude_vs_Sostenibilidad.pbix**: Main Power BI report including the following tabs:
  1. **Index**: Overview and navigation page.
  2. **Fraud Executive**: Key metrics and top 5 suggested insights.
  3. **Analytics**: Detailed analysis of fraud transactions with filters by country and sector, area charts, scatter plots, heatmaps, and rankings.
  4. **ML**: Visualizations of ML model metrics, model comparisons, and confusion matrices.
  5. **ESG**: Sustainability metrics for companies, scatter plots, heatmaps, and comparisons with fraud metrics.
  6. **Fraud vs ESG**: Combined analysis of fraud and ESG compliance for companies and sectors.

## Notes

- The report is connected to two main data sources:
  1. **Local SQL Server database**: contains the transformed datasets (`esg_fraud_transactions`, `esg_compliance`, ML predictions, etc.).
  2. **API endpoints**: provide real-time or pre-calculated metrics, including:
      - ML model predictions and evaluation results (basic and advanced models)
      - Aggregated fraud metrics (rankings, totals, averages)
      - Temporal metrics for analysis by month, week, or day
      - Other preprocessed or enriched datasets used across the report
- Power BI connects to these endpoints to fetch additional tables or update metrics dynamically.
- Visualizations make use of dynamic slicers, tooltips, and conditional formatting.
- Due to file size (~69 MB), consider using Git LFS if the report will be updated frequently.

## Recommendations

- Open the `.pbix` file using Power BI Desktop version compatible with the report features.
- Ensure both the local SQL Server database and the API are accessible, and the connection strings are correctly configured before refreshing the report.

