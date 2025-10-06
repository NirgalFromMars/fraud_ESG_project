-- 1 --

-- Create bbdd
CREATE DATABASE esg_project;
GO
-- (Opcional) Stablish recovery model SIMPLE to avoid big log
ALTER DATABASE esg_project SET RECOVERY SIMPLE;
GO
USE esg_project;
GO
-- Create logical schema to organize tables
CREATE SCHEMA esg AUTHORIZATION dbo;
GO

-- 2 --
USE esg_project;
GO
-- 2.1 Companies
IF OBJECT_ID('esg.companies') IS NOT NULL DROP TABLE esg.companies;
CREATE TABLE esg.companies (
	rank                    INT           NULL,
    company_id              INT           NOT NULL PRIMARY KEY,
    name                    NVARCHAR(200) NOT NULL,
    symbol                  NVARCHAR(50)  NULL,
    marketcap               DECIMAL(19,2) NULL,
    price_usd               DECIMAL(19,4) NULL,
    country                 NVARCHAR(100) NULL,
    sector                  NVARCHAR(50)  NOT NULL
);
GO
BULK INSERT esg.companies
FROM 'C:\Users\Eros\Documents\__Proyecto Integral__Fraude vs Sostenibilidad\original data & synthetic created\list companies\companies_list.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
-- 2.2 Thresholds by sector
IF OBJECT_ID('esg.thresholds_esg') IS NOT NULL DROP TABLE esg.thresholds_esg;
CREATE TABLE esg.thresholds_esg (
    sector                          NVARCHAR(50)  NOT NULL PRIMARY KEY,
    co2_emissions                   DECIMAL(18,2) NOT NULL,
    energy_consumption_mwh          DECIMAL(18,2) NOT NULL,
    percent_renewable_energy        DECIMAL(5,2)  NOT NULL,  -- 0..100
    waste_generated_tons            DECIMAL(18,2) NOT NULL,
    water_withdrawal_m3             DECIMAL(18,2) NOT NULL,
    CONSTRAINT CK_thresholds_percent_ren CHECK (percent_renewable_energy BETWEEN 0 AND 100)
);
GO
BULK INSERT esg.thresholds_esg
FROM 'C:\Users\Eros\Documents\__Proyecto Integral__Fraude vs Sostenibilidad\original data & synthetic created\thresholds_ESG.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
-- 2.3 ESG metrics by company
IF OBJECT_ID('esg.esg_metrics') IS NOT NULL DROP TABLE esg.esg_metrics;
CREATE TABLE esg.esg_metrics (
    company_id                      INT           NOT NULL PRIMARY KEY,
    co2_emissions                   DECIMAL(18,2) NOT NULL,
    energy_consumption_mwh          DECIMAL(18,2) NOT NULL,
    percent_renewable_energy        DECIMAL(5,2)  NOT NULL,
    waste_generated_tons            DECIMAL(18,2) NOT NULL,
    water_withdrawal_m3             DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_esgmetrics_company FOREIGN KEY (company_id) REFERENCES esg.companies(company_id),
    CONSTRAINT CK_esg_percent_ren CHECK (percent_renewable_energy BETWEEN 0 AND 100)
);
GO
BULK INSERT esg.esg_metrics
FROM 'C:\Users\Eros\Documents\__Proyecto Integral__Fraude vs Sostenibilidad\original data & synthetic created\esg_metrics_reduced.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
-- 2.4 Compliance (wider, with value/threshold/compliance by metric)
IF OBJECT_ID('esg.compliance') IS NOT NULL DROP TABLE esg.compliance;
CREATE TABLE esg.compliance (
    company_id                              INT            NOT NULL PRIMARY KEY,
    -- Identification (duplicatedon purpose to facilitate BI)
    name                                    NVARCHAR(200)  NULL,
    sector                                  NVARCHAR(50)   NULL,
    country                                 NVARCHAR(100)  NULL,

    -- CO2
    co2_emissions_value                     DECIMAL(18,2)  NULL,
    co2_emissions_threshold                 DECIMAL(18,2)  NULL,
    co2_emissions_compliance                BIT            NULL,  -- 1/0

    -- Energy
    energy_consumption_mwh_value            DECIMAL(18,2)  NULL,
    energy_consumption_mwh_threshold        DECIMAL(18,2)  NULL,
    energy_consumption_mwh_compliance       BIT            NULL,

    -- % Renewable ("higher is better")
    percent_renewable_energy_value          DECIMAL(5,2)   NULL,
    percent_renewable_energy_threshold      DECIMAL(5,2)   NULL,
    percent_renewable_energy_compliance     BIT            NULL,

    -- Waste
    waste_generated_tons_value              DECIMAL(18,2)  NULL,
    waste_generated_tons_threshold          DECIMAL(18,2)  NULL,
    waste_generated_tons_compliance         BIT            NULL,

    -- Water
    water_withdrawal_m3_value               DECIMAL(18,2)  NULL,
    water_withdrawal_m3_threshold           DECIMAL(18,2)  NULL,
    water_withdrawal_m3_compliance          BIT            NULL,

    -- Global summarize
    compliance_score                        DECIMAL(5,2)   NULL,  -- 0..1
    compliance_status                       NVARCHAR(30)   NULL,

    CONSTRAINT FK_compliance_company FOREIGN KEY (company_id) REFERENCES esg.companies(company_id)
);
GO
BULK INSERT esg.compliance
FROM 'C:\Users\Eros\Documents\__Proyecto Integral__Fraude vs Sostenibilidad\original data & synthetic created\compliance.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
-- (Optional) Indexes for typical queries
CREATE INDEX IX_companies_sector ON esg.companies(sector);
CREATE INDEX IX_companies_country ON esg.companies(country);
CREATE INDEX IX_compliance_sector ON esg.compliance(sector);
GO
-- 2.5 Create bridge table where every merchant at fraud table is assigned to a company_id
CREATE TABLE esg.fraud_merchant_mapping (
    merchant NVARCHAR(200) PRIMARY KEY,   -- value from CSV fraudTrain
    company_id INT NOT NULL,              -- FK to esg.companies
    CONSTRAINT FK_mapping_company FOREIGN KEY (company_id) REFERENCES esg.companies(company_id)
);
BULK INSERT esg.fraud_merchant_mapping
FROM 'C:\Users\Eros\Documents\__Proyecto Integral__Fraude vs Sostenibilidad\original data & synthetic created\fraud_merchant_mapping.csv'
WITH (
    FIELDTERMINATOR = ';', 
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- if there are headers at csv
);
-- 2.6 Create staging table with original fraudTrain.csv data (only 6 columns to work with) 
CREATE TABLE esg.fraud_staging (
    trans_date_trans_time DATETIME2,
    cc_num BIGINT,
    merchant NVARCHAR(100),
    amt DECIMAL(18,2),
    trans_num NVARCHAR(64),
    is_fraud BIT
);
BULK INSERT esg.fraud_staging
FROM 'C:\Users\Eros\Documents\__Proyecto Integral__Fraude vs Sostenibilidad\original data & synthetic created\fraudTrain_reduced.csv'
WITH (
    FIELDTERMINATOR = ';',  
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- if there are headers at csv
);
GO
-- 2.7 Create table to keep fraud_transactions data with company_id field
IF OBJECT_ID('esg.fraud_transactions', 'U') IS NOT NULL DROP TABLE esg.fraud_transactions;
CREATE TABLE esg.fraud_transactions (
    trans_id INT IDENTITY(1,1) PRIMARY KEY,  -- surrogate key for every transaction
    trans_date_trans_time DATETIME2 NOT NULL,
    cc_num BIGINT NOT NULL,
    amt DECIMAL(18,2) NOT NULL,
    trans_num NVARCHAR(64) NOT NULL,
    is_fraud BIT NOT NULL,
    company_id INT NOT NULL,
    CONSTRAINT FK_fraud_transactions_companies FOREIGN KEY (company_id) REFERENCES esg.companies(company_id)
);
GO
INSERT INTO esg.fraud_transactions (
    trans_date_trans_time,
    cc_num,
    amt,
    trans_num,
    is_fraud,
    company_id
)
SELECT 
    s.trans_date_trans_time,
    s.cc_num,
    s.amt,
    s.trans_num,
    s.is_fraud,
    m.company_id
FROM esg.fraud_staging s
INNER JOIN esg.fraud_merchant_mapping m 
    ON s.merchant = m.merchant;
GO
-- 2.8 Create fraud_transactions table with country/sector from esg.company
CREATE TABLE esg.fraud_transactions_enriched (
    transaction_id INT NOT NULL,
    company_id INT NOT NULL,
    company_name VARCHAR(255),
    country VARCHAR(50),
    sector VARCHAR(50),
    cc_num BIGINT,
    amount DECIMAL(18,2),
	trans_num VARCHAR(50),
    trans_date_trans_time DATETIME,
    is_fraud BIT
);
INSERT INTO esg.fraud_transactions_enriched (
    transaction_id,
    company_id,
    company_name,
    country,
    sector,
    cc_num,
    amount,
	trans_num,
    trans_date_trans_time,
    is_fraud
)
SELECT 
    ft.trans_id,
    ft.company_id,
    c.name AS company_name,
    c.country,
    c.sector,
    ft.cc_num,
    ft.amt,
	ft.trans_num,
    ft.trans_date_trans_time,
    ft.is_fraud
FROM esg.fraud_transactions AS ft
INNER JOIN esg.companies AS c
    ON ft.company_id = c.company_id;


SELECT TOP(5) * FROM esg_project.esg.compliance
SELECT COUNT(*) FROM esg.compliance
SELECT TABLE_NAME, count(COLUMN_NAME) FROM INFORMATION_SCHEMA.COLUMNS GROUP BY TABLE_NAME