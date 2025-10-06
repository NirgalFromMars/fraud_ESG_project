-- 1 - Total at base table
SELECT COUNT(*) AS total_tx
FROM esg.fraud_transactions_enriched;

-- Total by month
SELECT COUNT(*) AS total_tx
FROM esg.fraud_transactions_enriched
GROUP BY YEAR(trans_date_trans_time), MONTH(trans_date_trans_time);


-- 2 - Check unique company_name at different tables
-- companies name at fraud_transactions table
SELECT COUNT(DISTINCT company_name) AS total_clientes_base
FROM esg.fraud_transactions_enriched;

-- companies name at compliance table
SELECT COUNT(DISTINCT name) AS total_clientes_ranking
FROM esg.compliance;


-- 3 - Check dates (range and format)
SELECT MIN(trans_date_trans_time) AS first_date, MAX(trans_date_trans_time) AS last_date
FROM esg.fraud_transactions_enriched;


-- 4 - Check no duplicates at "trans_num" field at fraud_transactions_enriched table
SELECT trans_num, COUNT(*) AS country_count
FROM esg.fraud_transactions_enriched
GROUP BY trans_num
HAVING COUNT(*) > 1;