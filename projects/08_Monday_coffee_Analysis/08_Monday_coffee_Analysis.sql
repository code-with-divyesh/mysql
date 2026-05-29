/* =====================================================
   COFFEE SALES ANALYTICS PROJECT
   Database: coffee_db
   Objective: Perform business analysis on coffee sales
   ===================================================== */

-- =====================================================
-- DATABASE CREATION
-- =====================================================

CREATE DATABASE coffee_db;
USE coffee_db;

-- Drop existing tables (to avoid duplication errors)
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS city;

-- =====================================================
-- TABLE CREATION
-- =====================================================

/* City Master Table
   Stores demographic and rental information of cities */
CREATE TABLE city (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(15),
    population BIGINT,
    estimated_rent FLOAT,
    city_rank INT
);

/* Products Table
   Stores coffee product details */
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(35),
    price FLOAT
);

/* Customers Table
   Stores customer details and city mapping */
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(25),
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

/* Sales Table
   Transaction-level sales data */
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    product_id INT,
    customer_id INT,
    total FLOAT,
    rating INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- =====================================================
-- BUSINESS ANALYSIS QUERIES
-- =====================================================


-- =====================================================
-- Q1: Estimated Coffee Consumers per City
-- Assumption: 25% of population consumes coffee
-- =====================================================

SELECT 
    city_name,
    ROUND(population * 0.25) AS estimated_coffee_consumers
FROM city
ORDER BY estimated_coffee_consumers DESC;




-- =====================================================
-- Q2: Total Revenue in Last Quarter of 2023
-- =====================================================

SELECT 
    SUM(total) AS total_revenue
FROM sales
WHERE sale_date BETWEEN '2023-10-01' AND '2023-12-31';



-- =====================================================
-- Q3: Sales Count per Product
-- Identifies most sold product by volume
-- =====================================================

SELECT 
    p.product_name,
    COUNT(s.sale_id) AS sale_count
FROM sales s
JOIN products p 
    ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY sale_count DESC;



-- =====================================================
-- Q4: Average Customer Spending per City
-- Calculates per-customer total spend then city average
-- =====================================================

SELECT 
    city_name,
    ROUND(AVG(customer_spent)) AS average_spent
FROM (
        SELECT 
            cu.customer_id,
            c.city_name,
            SUM(s.total) AS customer_spent
        FROM customers cu
        JOIN sales s 
            ON cu.customer_id = s.customer_id
        JOIN city c 
            ON cu.city_id = c.city_id
        GROUP BY cu.customer_id, c.city_name
     ) AS t
GROUP BY city_name;



-- =====================================================
-- Q5: City Population vs Current Customers
-- Compares potential vs actual market penetration
-- =====================================================

SELECT 
    c.city_name,
    COUNT(cu.customer_id) AS total_current_customers,
    ROUND(c.population * 0.25) AS estimated_coffee_consumers
FROM city c
LEFT JOIN customers cu 
    ON cu.city_id = c.city_id
GROUP BY c.city_id, c.city_name, c.population;



-- =====================================================
-- Q6: Top 3 Selling Products by City (Volume Based)
-- Uses window function for ranking
-- =====================================================

SELECT *
FROM (
        SELECT 
            c.city_name,
            p.product_name,
            COUNT(s.sale_id) AS total_sales,
            ROW_NUMBER() OVER (
                PARTITION BY c.city_name
                ORDER BY COUNT(s.sale_id) DESC
            ) AS rnk
        FROM sales s
        JOIN customers cu ON cu.customer_id = s.customer_id
        JOIN city c ON c.city_id = cu.city_id
        JOIN products p ON p.product_id = s.product_id
        GROUP BY c.city_name, p.product_name
     ) AS t
WHERE rnk <= 3;



-- =====================================================
-- Q9: Monthly Sales Growth by City
-- Calculates month-over-month growth %
-- =====================================================

SELECT 
    c.city_name,
    DATE_FORMAT(s.sale_date,'%Y-%m') AS yearly_month,
    SUM(s.total) AS total_sales,
    ROUND(
        (SUM(s.total) -
         LAG(SUM(s.total)) OVER(
             PARTITION BY c.city_name
             ORDER BY DATE_FORMAT(s.sale_date,'%Y-%m')
         )
        )
        /
        LAG(SUM(s.total)) OVER(
             PARTITION BY c.city_name
             ORDER BY DATE_FORMAT(s.sale_date,'%Y-%m')
        ) * 100,
    2) AS growth_percentage
FROM city c
JOIN customers cu ON c.city_id = cu.city_id
JOIN sales s ON s.customer_id = cu.customer_id
GROUP BY c.city_name, yearly_month;



-- =====================================================
-- Q10: Market Potential Analysis
-- Top 3 cities by total sales
-- Returns revenue, rent, customer count, and estimated consumers
-- =====================================================

SELECT 
    c.city_name,
    IFNULL(SUM(s.total), 0) AS total_sales,
    c.estimated_rent AS total_rent,
    COUNT(DISTINCT cu.customer_id) AS total_customers,
    ROUND(c.population * 0.25) AS estimated_coffee_consumers
FROM city c
LEFT JOIN customers cu ON c.city_id = cu.city_id
LEFT JOIN sales s ON cu.customer_id = s.customer_id
GROUP BY c.city_id, c.city_name, c.estimated_rent, c.population
ORDER BY total_sales DESC
LIMIT 3;



-- =====================================================
-- Customer Lifetime Value (CLV)
-- Total revenue generated per customer
-- =====================================================

SELECT 
    cu.customer_id,
    cu.customer_name,
    SUM(s.total) AS customer_lifetime_value
FROM customers cu
JOIN sales s ON cu.customer_id = s.customer_id
GROUP BY cu.customer_id, cu.customer_name
ORDER BY customer_lifetime_value DESC
LIMIT 5;



-- =====================================================
-- Revenue Contribution by City
-- Percentage contribution to overall revenue
-- =====================================================

SELECT 
    c.city_name,
    SUM(s.total) AS city_revenue,
    ROUND(
        (SUM(s.total) / (SELECT SUM(total) FROM sales)) * 100,
        2
    ) AS percentage_contribution
FROM city c
JOIN customers cu ON c.city_id = cu.city_id
JOIN sales s ON s.customer_id = cu.customer_id
GROUP BY c.city_name
ORDER BY city_revenue DESC;



-- =====================================================
-- Monthly Best Selling Product (Revenue Based)
-- Identifies highest revenue product each month
-- =====================================================

SELECT *
FROM (
        SELECT 
            DATE_FORMAT(s.sale_date, '%Y-%m') AS yearly_month,
            p.product_name,
            SUM(s.total) AS total_revenue,
            ROW_NUMBER() OVER (
                PARTITION BY DATE_FORMAT(s.sale_date, '%Y-%m')
                ORDER BY SUM(s.total) DESC
            ) AS rnk
        FROM sales s
        JOIN products p 
            ON s.product_id = p.product_id
        GROUP BY yearly_month, p.product_name
     ) AS t
WHERE rnk = 1;

-- =====================================================
-- Churn Risk Customers
-- Customers who haven't purchased in last 60 days
-- =====================================================

SELECT 
    cu.customer_id,
    cu.customer_name,
    MAX(s.sale_date) AS last_purchase_date,
    DATEDIFF(CURDATE(), MAX(s.sale_date)) AS days_since_last_purchase
FROM customers cu
JOIN sales s 
    ON cu.customer_id = s.customer_id
GROUP BY cu.customer_id, cu.customer_name
HAVING days_since_last_purchase > 60
ORDER BY days_since_last_purchase DESC;