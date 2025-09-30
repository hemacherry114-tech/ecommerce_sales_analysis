-- PHASE 1
-- DATA INSPECTION ADN UNDERSTANDING

-- Step 1: Check the first 10 rows of each table to understand the data
SELECT * FROM `ecommerce_sales` LIMIT 10;

-- Step 2: Get a count of all records in each table
SELECT COUNT(*) AS total_records FROM `ecommerce_sales`;

-- Step 3: Find the number of unique customers, products, and orders
SELECT COUNT(DISTINCT `ORDERNUMBER`) AS unique_orders FROM `ecommerce_sales`;
SELECT COUNT(DISTINCT `CUSTOMERNAME`) AS unique_customers FROM `ecommerce_sales`;
SELECT COUNT(DISTINCT `PRODUCTLINE`) AS unique_products FROM `ecommerce_sales`;

-- Step 3: Find the number of unique customers, products, and orders
-- (An efficient way to combine all three queries into one result)
SELECT
    (SELECT COUNT(DISTINCT `ORDERNUMBER`) FROM `ecommerce_sales`) AS unique_orders,
    (SELECT COUNT(DISTINCT `CUSTOMERNAME`) FROM `ecommerce_sales`) AS unique_customers,
    (SELECT COUNT(DISTINCT `PRODUCTLINE`) FROM `ecommerce_sales`) AS unique_products;
    
-- PHASE 2
-- Data Cleaning and Standardization
-- check for NULL or empty strings
-- Checking for NULL or empty strings in key identifier and metric columns
SELECT COUNT(*) AS missing_ordernumbers FROM `ecommerce_sales` WHERE `ORDERNUMBER` IS NULL OR `ORDERNUMBER` = '';
SELECT COUNT(*) AS missing_quantities FROM `ecommerce_sales` WHERE `QUANTITYORDERED` IS NULL OR `QUANTITYORDERED` = '';
SELECT COUNT(*) AS missing_prices FROM `ecommerce_sales` WHERE `PRICEEACH` IS NULL OR `PRICEEACH` = '';
SELECT COUNT(*) AS missing_sales FROM `ecommerce_sales` WHERE `SALES` IS NULL OR `SALES` = '';
SELECT COUNT(*) AS missing_productcodes FROM `ecommerce_sales` WHERE `PRODUCTCODE` IS NULL OR `PRODUCTCODE` = '';
SELECT COUNT(*) AS missing_orderdates FROM `ecommerce_sales` WHERE `ORDERDATE` IS NULL OR `ORDERDATE` = '';

-- Checking for NULL or empty strings in customer and location columns
SELECT COUNT(*) AS missing_customernames FROM `ecommerce_sales` WHERE `CUSTOMERNAME` IS NULL OR `CUSTOMERNAME` = '';
SELECT COUNT(*) AS missing_phones FROM `ecommerce_sales` WHERE `PHONE` IS NULL OR `PHONE` = '';
SELECT COUNT(*) AS missing_addresses FROM `ecommerce_sales` WHERE `ADDRESSLINE1` IS NULL OR `ADDRESSLINE1` = '';
SELECT COUNT(*) AS missing_cities FROM `ecommerce_sales` WHERE `CITY` IS NULL OR `CITY` = '';
SELECT COUNT(*) AS missing_states FROM `ecommerce_sales` WHERE `STATE` IS NULL OR `STATE` = '';
SELECT COUNT(*) AS missing_postalcodes FROM `ecommerce_sales` WHERE `POSTALCODE` IS NULL OR `POSTALCODE` = '';
SELECT COUNT(*) AS missing_countries FROM `ecommerce_sales` WHERE `COUNTRY` IS NULL OR `COUNTRY` = '';
SELECT COUNT(*) AS missing_territories FROM `ecommerce_sales` WHERE `TERRITORY` IS NULL OR `TERRITORY` = '';

-- Check for Specific Missing Value Placeholders in All Header
-- Checking for specific text placeholders like 'na' in all columns

SELECT COUNT(*) AS placeholder_ordernumber FROM `ecommerce_sales` WHERE LOWER(`ORDERNUMBER`) = 'na';
SELECT COUNT(*) AS placeholder_quantity FROM `ecommerce_sales` WHERE LOWER(`QUANTITYORDERED`) = 'na';
SELECT COUNT(*) AS placeholder_price FROM `ecommerce_sales` WHERE LOWER(`PRICEEACH`) = 'na';
SELECT COUNT(*) AS placeholder_sales FROM `ecommerce_sales` WHERE LOWER(`SALES`) = 'na';
SELECT COUNT(*) AS placeholder_orderline FROM `ecommerce_sales` WHERE LOWER(`ORDERLINENUMBER`) = 'na';
SELECT COUNT(*) AS placeholder_orderdate FROM `ecommerce_sales` WHERE LOWER(`ORDERDATE`) = 'na';
SELECT COUNT(*) AS placeholder_status FROM `ecommerce_sales` WHERE LOWER(`STATUS`) = 'na';
SELECT COUNT(*) AS placeholder_qtr_id FROM `ecommerce_sales` WHERE LOWER(`QTR_ID`) = 'na';
SELECT COUNT(*) AS placeholder_month_id FROM `ecommerce_sales` WHERE LOWER(`MONTH_ID`) = 'na';
SELECT COUNT(*) AS placeholder_year_id FROM `ecommerce_sales` WHERE LOWER(`YEAR_ID`) = 'na';
SELECT COUNT(*) AS placeholder_productline FROM `ecommerce_sales` WHERE LOWER(`PRODUCTLINE`) = 'na';
SELECT COUNT(*) AS placeholder_msrp FROM `ecommerce_sales` WHERE LOWER(`MSRP`) = 'na';
SELECT COUNT(*) AS placeholder_productcode FROM `ecommerce_sales` WHERE LOWER(`PRODUCTCODE`) = 'na';
SELECT COUNT(*) AS placeholder_customername FROM `ecommerce_sales` WHERE LOWER(`CUSTOMERNAME`) = 'na';
SELECT COUNT(*) AS placeholder_phone FROM `ecommerce_sales` WHERE LOWER(`PHONE`) = 'na';
SELECT COUNT(*) AS placeholder_addressline1 FROM `ecommerce_sales` WHERE LOWER(`ADDRESSLINE1`) = 'na';
SELECT COUNT(*) AS placeholder_addressline2 FROM `ecommerce_sales` WHERE LOWER(`ADDRESSLINE2`) = 'na';
SELECT COUNT(*) AS placeholder_city FROM `ecommerce_sales` WHERE LOWER(`CITY`) = 'na';
SELECT COUNT(*) AS placeholder_state FROM `ecommerce_sales` WHERE LOWER(`STATE`) = 'na';
SELECT COUNT(*) AS placeholder_postalcode FROM `ecommerce_sales` WHERE LOWER(`POSTALCODE`) = 'na';
SELECT COUNT(*) AS placeholder_country FROM `ecommerce_sales` WHERE LOWER(`COUNTRY`) = 'na';
SELECT COUNT(*) AS placeholder_territory FROM `ecommerce_sales` WHERE LOWER(`TERRITORY`) = 'na';
SELECT COUNT(*) AS placeholder_contactlastname FROM `ecommerce_sales` WHERE LOWER(`CONTACTLASTNAME`) = 'na';
SELECT COUNT(*) AS placeholder_contactfirstname FROM `ecommerce_sales` WHERE LOWER(`CONTACTFIRSTNAME`) = 'na';
SELECT COUNT(*) AS placeholder_dealsize FROM `ecommerce_sales` WHERE LOWER(`DEALSIZE`) = 'na';

SET SQL_SAFE_UPDATES = 0;
    
-- Update empty strings in the STATE column to NULL
UPDATE `ecommerce_sales`
SET `STATE` = NULL
WHERE `STATE` = '';

-- Update empty strings in the POSTALCODE column to NULL
UPDATE `ecommerce_sales`
SET `POSTALCODE` = NULL
WHERE `POSTALCODE` = '';

SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
-- This query handles the 'NA' placeholders you found
UPDATE `ecommerce_sales`
SET `TERRITORY` = NULL
WHERE LOWER(`TERRITORY`) = 'na';

-- This query handles the blank fields you found in the STATE column
UPDATE `ecommerce_sales`
SET `STATE` = NULL
WHERE `STATE` = '';

-- This query handles the blank fields you found in the POSTALCODE column
UPDATE `ecommerce_sales`
SET `POSTALCODE` = NULL
WHERE `POSTALCODE` = '';
SET SQL_SAFE_UPDATES = 1;

-- PHASE 3
-- Feature engeneering

-- Add the new column to your table
ALTER TABLE `ecommerce_sales` ADD COLUMN `Total_Revenue` DECIMAL(10, 2);
SELECT * FROM `ecommerce_sales` LIMIT 5;
DESCRIBE `ecommerce_sales`;
-- Populate the new column with the calculated revenue
SET SQL_SAFE_UPDATES = 0;
UPDATE `ecommerce_sales`
SET `Total_Revenue` = `QUANTITYORDERED` * `PRICEEACH`;

SET SQL_SAFE_UPDATES = 0;
UPDATE `ecommerce_sales`
SET `Total_Revenue` = CAST(`QUANTITYORDERED` AS DECIMAL(15, 2)) * CAST(`PRICEEACH` AS DECIMAL(15, 2));

-- Create a column for the order year
ALTER TABLE `ecommerce_sales` ADD COLUMN `Order_Year` INT;
UPDATE `ecommerce_sales`
SET `Order_Year` = YEAR(`ORDERDATE`);

-- Create a column for the order month
ALTER TABLE `ecommerce_sales` ADD COLUMN `Order_Month` INT;
UPDATE `ecommerce_sales`
SET `Order_Month` = MONTH(`ORDERDATE`);

-- Create a column for the order day of the week (1=Sunday, 2=Monday, etc.)
ALTER TABLE `ecommerce_sales` ADD COLUMN `Order_Day_of_Week` INT;
UPDATE `ecommerce_sales`
SET `Order_Day_of_Week` = DAYOFWEEK(`ORDERDATE`);

-- PHASE 4
-- Exploratory Data Analysis (EDA)
-- 1. Summarize Key Metrics
-- Find the total sales, average order value, and the number of unique customers.
SELECT
    SUM(`Total_Revenue`) AS total_sales,
    AVG(`Total_Revenue`) AS avg_order_value,
    COUNT(DISTINCT `CUSTOMERNAME`) AS total_customers
FROM
    `ecommerce_sales`;









