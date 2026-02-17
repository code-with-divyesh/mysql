-- ============================================================
-- RETAIL SALES ANALYSIS PROJECT
-- Database Creation, Data Import & Business Queries
-- ============================================================


-- ------------------------------------------------------------
-- 1️⃣ Create Database and Use It
-- ------------------------------------------------------------

CREATE DATABASE Retailbookstore;
USE Retailbookstore;


-- ------------------------------------------------------------
-- 2️⃣ Create Table Structure
-- ------------------------------------------------------------
-- This table stores transactional retail sales data

CREATE TABLE retail_sales
(
	transactions_id INT PRIMARY KEY,   -- Unique transaction ID
    sale_date DATE,                    -- Date of sale
    sale_time TIME,                    -- Time of sale
    customer_id INT,                   -- Unique customer ID
    gender VARCHAR(10),                -- Gender of customer
    age INT,                           -- Age of customer
    category VARCHAR(35),              -- Product category
    quantiTy INT,                      -- Quantity purchased
    price_per_unit FLOAT,              -- Price per product unit
    cogs FLOAT,                        -- Cost of goods sold
    total_sale FLOAT                   -- Total transaction amount
);


-- ------------------------------------------------------------
-- 3️⃣ Enable LOCAL INFILE (Required for CSV Import)
-- ------------------------------------------------------------

SET GLOBAL local_infile = 1;

-- Check if LOCAL INFILE is enabled
SHOW VARIABLES LIKE 'local_infile';


-- ------------------------------------------------------------
-- 4️⃣ Load CSV Data into Table
-- ------------------------------------------------------------
-- Converting sale_date from DD-MM-YYYY format to MySQL DATE format

LOAD DATA LOCAL INFILE 
'C:/Users/gandh/OneDrive/Documents/mysql/projects/02_Retail_Sales_Analysis/SQL - Retail Sales Analysis_utf .csv'
INTO TABLE retail_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(transactions_id, @sale_date, sale_time, customer_id, gender,
 age, category, quantity, price_per_unit, cogs, total_sale)
SET sale_date = STR_TO_DATE(TRIM(@sale_date), '%d-%m-%Y');


-- ------------------------------------------------------------
-- 5️⃣ Basic Data Exploration
-- ------------------------------------------------------------

-- View all records
SELECT * FROM retail_sales;

-- Total number of records
SELECT COUNT(*) FROM retail_sales;

-- Count of unique customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Count of unique categories
SELECT COUNT(DISTINCT category) FROM retail_sales;

-- View distinct categories
SELECT DISTINCT category FROM retail_sales;


-- ------------------------------------------------------------
-- 6️⃣ Business Queries
-- ------------------------------------------------------------

-- 1. Retrieve all columns for sales made on '2022-11-05'

SELECT * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';


-- Rename column for consistency
ALTER TABLE retail_sales 
RENAME COLUMN quantiTy TO quantity;


-- 2. Retrieve transactions where:
-- Category = 'Clothing'
-- Quantity > 4
-- Month = November 2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantity > 4
AND sale_date >= '2022-11-01'
AND sale_date < '2022-12-01';


-- 3. Calculate total sales for each category

SELECT 
    category,
    SUM(total_sale) AS net_sale
FROM retail_sales
GROUP BY category;


-- 4. Find average age of customers who purchased 'Beauty' items

SELECT 
    ROUND(AVG(age), 2) AS Avg_age
FROM retail_sales
WHERE category = 'Beauty';


-- 5. Find transactions where total_sale > 1000

SELECT *
FROM retail_sales
WHERE total_sale > 1000;


-- 6. Total number of transactions by gender in each category

SELECT 
    category,
    gender,
    COUNT(transactions_id) AS Total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category;


-- 7. Find best selling month (highest total revenue) in each year

SELECT year, month, total_monthly_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(total_sale) AS total_monthly_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY SUM(total_sale) DESC
        ) AS rnk
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) t
WHERE rnk = 1;


-- 8. Top 5 customers based on highest total sales

SELECT 
    customer_id,
    SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;


-- 9. Number of unique customers per category

SELECT 
    category,
    COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;


-- 10. Create shift-wise order distribution
-- Morning   : Hour < 12
-- Afternoon : 12–17
-- Evening   : >17

SELECT 
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM retail_sales
GROUP BY shift
ORDER BY shift;

