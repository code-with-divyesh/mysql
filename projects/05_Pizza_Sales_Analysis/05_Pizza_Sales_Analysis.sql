-- ============================================
-- Create Database
-- ============================================

CREATE DATABASE pizzahut;
USE pizzahut;

-- ============================================
-- Create Orders Table
-- ============================================

CREATE TABLE orders
(
    order_id INT NOT NULL PRIMARY KEY,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL
);

-- ============================================
-- Create Order Details Table
-- ============================================

CREATE TABLE order_details
(
    order_details_id INT NOT NULL PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id VARCHAR(50) NOT NULL,  -- ✅ FIX 1: TEXT → VARCHAR(50)
    quantity INT NOT NULL
);

-- Foreign Keys
ALTER TABLE order_details 
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE pizzas 
MODIFY pizza_id VARCHAR(50) NOT NULL;

ALTER TABLE order_details 
MODIFY pizza_id VARCHAR(50) NOT NULL;

ALTER TABLE order_details 
ADD FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id);

-- ============================================
-- View Tables
-- ============================================

SELECT * FROM pizzas;
SELECT * FROM pizza_types;
SELECT * FROM orders;
SELECT * FROM order_details;

-- ============================================
-- Retrieve the total number of orders placed
-- ============================================

SELECT COUNT(*) AS Total_orders   -- ✅ FIX 3: Removed DISTINCT
FROM orders;

-- ============================================
-- Calculate total revenue
-- ============================================

SELECT 
    ROUND(SUM(o.quantity * p.price), 2) AS Total_revenue
FROM order_details o
JOIN pizzas p 
ON o.pizza_id = p.pizza_id;

-- ============================================
-- Highest Priced Pizza
-- ============================================

SELECT 
    pt.name, p.price
FROM pizza_types pt
JOIN pizzas p 
ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- ============================================
-- Most Common Pizza Size Ordered
-- ============================================

SELECT 
    p.size, 
    SUM(o.quantity) AS total_quantity   
FROM order_details o
JOIN pizzas p 
ON o.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
LIMIT 1;

-- ============================================
-- Top 5 Most Ordered Pizza Types
-- ============================================

SELECT 
    pt.name, 
    SUM(o.quantity) AS Total_quantity
FROM pizza_types pt
JOIN pizzas p 
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details o 
ON o.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY Total_quantity DESC
LIMIT 5;

-- ============================================
-- Category-wise Quantity
-- ============================================

SELECT 
    pt.category, 
    SUM(o.quantity) AS total_ordered_quantity
FROM pizza_types pt
JOIN pizzas p 
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details o 
ON o.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY total_ordered_quantity DESC;

-- ============================================
-- Orders Distribution by Hour
-- ============================================

SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(order_id) AS total_orders_per_hr
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- ============================================
-- Category-wise Pizza Count
-- ============================================

SELECT 
    category, 
    COUNT(name) AS total_pizzas
FROM pizza_types
GROUP BY category;

-- ============================================
-- Average Pizzas Ordered Per Day
-- ============================================

SELECT 
    ROUND(AVG(daily_pizzas), 0) AS avg_pizzas_per_day
FROM (
    SELECT 
        o.order_date,
        SUM(od.quantity) AS daily_pizzas
    FROM orders o
    JOIN order_details od 
    ON o.order_id = od.order_id
    GROUP BY o.order_date
) t;

-- ============================================
-- Top 3 Pizza Types by Revenue
-- ============================================

SELECT 
    pt.name,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM pizza_types pt
JOIN pizzas p 
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od 
ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;

-- ============================================
-- Revenue Contribution by Category (%)
-- ============================================

SELECT 
    pt.category,
    ROUND(SUM(od.quantity * p.price) / (SELECT 
                    SUM(o.quantity * p.price)
                FROM
                    order_details o
                        JOIN
                    pizzas p ON o.pizza_id = p.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY revenue DESC;

-- ============================================
-- Cumulative Revenue Over Time
-- ============================================

SELECT 
    order_date,
    revenue,
    SUM(revenue) OVER (ORDER BY order_date) AS cum_revenue
FROM (
    SELECT 
        o.order_date,
        SUM(od.quantity * p.price) AS revenue
    FROM order_details od
    JOIN pizzas p 
    ON p.pizza_id = od.pizza_id
    JOIN orders o 
    ON od.order_id = o.order_id
    GROUP BY o.order_date
) AS sales
ORDER BY order_date;

-- ============================================
-- Top 3 Pizza Types by Revenue for Each Category
-- ============================================

SELECT * 
FROM (
    SELECT 
        category,
        name,
        revenue,
        RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS rn
    FROM (
        SELECT 
            pt.category, 
            pt.name, 
            SUM(od.quantity * p.price) AS revenue
        FROM pizzas p
        JOIN pizza_types pt 
        ON pt.pizza_type_id = p.pizza_type_id
        JOIN order_details od 
        ON od.pizza_id = p.pizza_id
        GROUP BY pt.category, pt.name
    ) t
) t 
WHERE rn <= 3;