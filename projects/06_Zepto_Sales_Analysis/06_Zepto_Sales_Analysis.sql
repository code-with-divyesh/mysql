-- ==========================================
-- Zepto Sales & Inventory Analysis Project
-- Database: MySQL
-- ==========================================

-- 1️⃣ Create Database
CREATE DATABASE Zepto_db;
USE Zepto_db;

-- 2️⃣ Create Products Table
CREATE TABLE products (
    sku_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique product ID
    category VARCHAR(100) NOT NULL,         -- Product category
    name VARCHAR(100) NOT NULL,             -- Product name
    mrp DECIMAL(10,2) NOT NULL,             -- Maximum Retail Price
    discountPercent INT DEFAULT 0,          -- Discount percentage
    availableQuantity INT DEFAULT 0,        -- Current stock quantity
    discountedSellingPrice DECIMAL(10,2),   -- Final selling price
    weightInGms INT,                        -- Product weight in grams
    outOfStock TINYINT DEFAULT 0,           -- Stock status (0 = In Stock, 1 = Out of Stock)
    quantity INT DEFAULT 1                  -- Default purchase quantity
);

-- 3️⃣ Enable CSV Import
SET GLOBAL local_infile = 1;

-- 4️⃣ Load Data from CSV
LOAD DATA LOCAL INFILE 'path_to_csv/zepto_v2.csv'
INTO TABLE products
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(category,name,mrp,discountPercent,availableQuantity,
 discountedSellingPrice,weightInGms,outOfStock,quantity);

-- ==========================================
-- DATA EXPLORATION
-- ==========================================

-- Total records
SELECT COUNT(*) AS total_rows FROM products;

-- Check for NULL values
SELECT 
    SUM(category IS NULL) AS null_category,
    SUM(name IS NULL) AS null_name,
    SUM(mrp IS NULL) AS null_mrp,
    SUM(discountPercent IS NULL) AS null_discount
FROM products;

-- Category distribution
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category
ORDER BY total_products DESC;

-- Stock status distribution
SELECT outOfStock, COUNT(*) AS stock_count
FROM products
GROUP BY outOfStock;

-- ==========================================
-- DATA CLEANING
-- ==========================================

-- Identify invalid pricing
SELECT * 
FROM products
WHERE mrp = 0 OR discountedSellingPrice = 0;

-- Remove invalid rows
DELETE FROM products
WHERE mrp = 0;

-- Convert paisa to rupees
UPDATE products
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

-- ==========================================
-- BUSINESS ANALYSIS
-- ==========================================

-- Top 10 products with highest discount
SELECT name, MAX(discountPercent) AS max_discount
FROM products
GROUP BY name
ORDER BY max_discount DESC
LIMIT 10;

-- Category-wise potential revenue
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS potential_revenue
FROM products
WHERE outOfStock = 0
GROUP BY category
ORDER BY potential_revenue DESC;

-- Profit margin calculation
SELECT name,
       ROUND(((mrp - discountedSellingPrice) / mrp) * 100, 2) AS margin_percent
FROM products;

-- Price per gram analysis
SELECT name, category,
       ROUND(discountedSellingPrice / weightInGms, 4) AS price_per_gram
FROM products
WHERE weightInGms > 0
ORDER BY price_per_gram ASC;

-- Revenue contribution %
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS revenue,
       ROUND(
           SUM(discountedSellingPrice * availableQuantity) /
           (SELECT SUM(discountedSellingPrice * availableQuantity) FROM products) * 100
       ,2) AS revenue_percent
FROM products
GROUP BY category;

-- ==========================================
-- PERFORMANCE OPTIMIZATION
-- ==========================================

-- Create indexes for faster filtering
CREATE INDEX idx_category ON products(category);
CREATE INDEX idx_stock ON products(outOfStock);

-- ==========================================
-- VIEW CREATION
-- ==========================================

-- Virtual table for category revenue
CREATE VIEW category_revenue AS
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS revenue
FROM products
GROUP BY category;

-- ==========================================
-- STORED PROCEDURE
-- ==========================================

-- Procedure to find low stock products
DELIMITER //

CREATE PROCEDURE LowStock()
BEGIN
    SELECT name, availableQuantity
    FROM products
    WHERE availableQuantity < 5;
END //

DELIMITER ;

-- Execute procedure
CALL LowStock();