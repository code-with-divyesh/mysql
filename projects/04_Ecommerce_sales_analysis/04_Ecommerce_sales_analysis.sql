-- Create Database
CREATE DATABASE Ecommerce_sales_db;

-- Use the Database
USE Ecommerce_sales_db;

-- Drop table if already exists (to avoid duplicate error)
DROP TABLE IF EXISTS orders;

-- Create Orders Table
CREATE TABLE orders (
    order_date DATE,              -- Date of the order
    product_name VARCHAR(255),    -- Name of the product
    category VARCHAR(100),        -- Product category
    region VARCHAR(100),          -- Sales region
    quantity INT,                 -- Quantity sold
    sales DECIMAL(10,2),          -- Total sales amount
    profit DECIMAL(10,2)          -- Profit earned
);

-- View all records from orders table
SELECT * FROM orders;

-- ============================================
-- 1️⃣ Overall Business Summary
-- ============================================

-- Calculate total quantity, total profit and total sales
SELECT 
    SUM(quantity) AS Total_Quantity,
    SUM(profit) AS Total_Profit,
    SUM(sales) AS Total_Sales
FROM orders;

-- ============================================
-- 2️⃣ Category-wise Performance Analysis
-- ============================================

-- Total profit, sales and quantity by category
SELECT 
    category,
    SUM(profit) AS category_profit,
    SUM(sales) AS category_sales,
    SUM(quantity) AS category_quantity
FROM orders
GROUP BY category
ORDER BY category_quantity DESC;

-- Count total number of orders
SELECT COUNT(*) AS Total_Orders
FROM orders;

-- Count total orders by category
SELECT 
    category,
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY category;

-- Calculate Profit Margin (%) by Category
SELECT 
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin
FROM orders
GROUP BY Category
ORDER BY Profit_Margin DESC;

-- ============================================
-- 3️⃣ Regional Analysis
-- ============================================

-- Total Sales by Region
SELECT 
    region,
    SUM(sales) AS Sales_By_Region
FROM orders
GROUP BY region
ORDER BY Sales_By_Region DESC;

-- Identify Regions with Negative Profit
SELECT 
    Region,
    SUM(Profit) AS Total_Profit
FROM orders
GROUP BY Region
HAVING SUM(Profit) < 0;

-- ============================================
-- 4️⃣ Product-Level Analysis
-- ============================================

-- Top Products by Sales
SELECT
    product_name,
    SUM(sales) AS Total_Sales
FROM orders
GROUP BY product_name
ORDER BY Total_Sales DESC;

-- Top Products by Profit
SELECT
    product_name,
    SUM(profit) AS Total_Profit
FROM orders
GROUP BY product_name
ORDER BY Total_Profit DESC;

-- ============================================
-- 5️⃣ Monthly Sales & Profit Trend
-- ============================================

-- Monthly Sales
SELECT 
    DATE_FORMAT(order_date,"%Y-%m") AS month,
    SUM(sales) AS monthly_sales
FROM orders
GROUP BY month 
ORDER BY month;

-- Monthly Profit
SELECT 
    DATE_FORMAT(order_date,"%Y-%m") AS month,
    SUM(profit) AS monthly_profit
FROM orders
GROUP BY month 
ORDER BY month;

-- ============================================
-- 6️⃣ Month-over-Month (MoM) Growth
-- ============================================

-- Calculate MoM growth in sales using LAG function
SELECT 
    month,
    monthly_sales,
    monthly_sales - LAG(monthly_sales) 
        OVER (ORDER BY month) AS mom_growth
FROM (
    SELECT 
        DATE_FORMAT(order_date,"%Y-%m") AS month,
        SUM(sales) AS monthly_sales
    FROM orders
    GROUP BY month
) t;

-- ============================================
-- 7️⃣ Running Total Sales (Cumulative Sales)
-- ============================================

-- Calculate running total of sales ordered by date
SELECT 
    Order_Date,
    Sales,
    SUM(Sales) OVER (ORDER BY Order_Date) AS Running_Total
FROM orders;

-- ============================================
-- 8️⃣ Category Sales Ranking
-- ============================================

-- Rank categories based on total sales
SELECT 
    Category,
    SUM(Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM orders
GROUP BY Category;

-- ============================================
-- 9️⃣ Advanced Filtering
-- ============================================

-- Orders where sales are above average 
-- and profit is below average
SELECT *
FROM orders
WHERE Sales > (SELECT AVG(sales) FROM orders) 
AND Profit < (SELECT AVG(profit) FROM orders);

-- ============================================
-- 🔟 Averages
-- ============================================

-- Average Order Value
SELECT AVG(Sales) AS Avg_Order_Value
FROM orders;

-- Average Profit per Order
SELECT AVG(Profit) AS Avg_Profit
FROM orders;