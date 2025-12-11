-- Create database
CREATE DATABASE window_fun;

-- Select database
USE window_fun;


CREATE TABLE OrdersWindow (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    ProductID INT,
    TotalSales INT,
    OrderStatus VARCHAR(20),
    SimilarGroup INT
);

---------------------------------------------------------
-- 2) Insert sample data
---------------------------------------------------------
INSERT INTO OrdersWindow 
(OrderID, OrderDate, ProductID, TotalSales, OrderStatus, SimilarGroup)
VALUES
(1,  '2025-01-01', 101, 10, 'Delivered', 1),
(2,  '2025-01-05', 102, 15, 'Pending',   1),
(3,  '2025-01-10', 101, 20, 'Delivered', 1),
(4,  '2025-01-20', 105, 60, 'Cancelled', 2),
(5,  '2025-02-01', 104, 25, 'Delivered', 2),
(6,  '2025-02-05', 104, 50, 'Delivered', 2),
(7,  '2025-02-15', 102, 30, 'Pending',   1),
(8,  '2025-02-18', 101, 90, 'Delivered', 1),
(9,  '2025-03-10', 101, 20, 'Delivered', 1),
(10, '2025-03-15', 102, 60, 'Delivered', 1);



---------------------------------------------------------
-- 3) Why we need Window Functions?
-- GROUP BY combines rows and removes details like OrderID & OrderDate.
-- Window functions keep details AND calculate aggregates at the same time.
---------------------------------------------------------

-- Normal GROUP BY (works fine)
SELECT ProductID, SUM(TotalSales)
FROM OrdersWindow
GROUP BY ProductID;

-- This fails because OrderID and OrderDate are not grouped:
-- SELECT ProductID, OrderID, OrderDate, SUM(TotalSales)
-- FROM OrdersWindow GROUP BY ProductID;


---------------------------------------------------------
-- 4) Using Window Function to keep row-level details
-- SUM(...) OVER(PARTITION BY ProductID) gives total per product
-- without losing OrderID, OrderDate.
---------------------------------------------------------
SELECT 
    ProductID,
    OrderDate,
    SUM(TotalSales) OVER (PARTITION BY ProductID) AS TotalSalesByProduct
FROM window_fun.OrdersWindow;


---------------------------------------------------------
-- 5) PARTITION clause examples
---------------------------------------------------------

-- Total sales across all orders
SELECT 
    ProductID,
    OrderDate,
    SUM(TotalSales) OVER() AS TotalSalesOverall
FROM window_fun.OrdersWindow;

-- Total sales for each product
SELECT 
    ProductID,
    OrderDate,
    SUM(TotalSales) OVER(PARTITION BY ProductID) AS TotalSalesByProduct
FROM window_fun.OrdersWindow;

-- Multiple partitions
SELECT 
    ProductID,
    OrderDate,
    OrderStatus,
    SUM(TotalSales) OVER(PARTITION BY ProductID) AS TotalByProduct,
    SUM(TotalSales) OVER() AS TotalOverall,
    SUM(TotalSales) OVER(PARTITION BY ProductID, OrderStatus) AS TotalByProductStatus
FROM window_fun.OrdersWindow;



---------------------------------------------------------
-- 6) ORDER BY with Window Function (ranking)
---------------------------------------------------------
SELECT 
    OrderID,
    OrderDate,
    TotalSales,
    RANK() OVER(ORDER BY TotalSales DESC) AS SalesRank
FROM window_fun.OrdersWindow;



---------------------------------------------------------
-- 7) FRAME clause examples (ROWS)
-- How many rows to include in window from the sorted table
---------------------------------------------------------

-- Current row + next 2 rows (based on date)
SELECT 
    OrderID,
    OrderDate,
    OrderStatus,
    TotalSales AS Sales,
    SUM(TotalSales) OVER(
        PARTITION BY OrderStatus
        ORDER BY OrderDate DESC
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
    ) AS WindowTotal
FROM window_fun.OrdersWindow;


-- Last 2 rows + current row (backward-looking window)
SELECT 
    OrderID,
    OrderDate,
    OrderStatus,
    TotalSales AS Sales,
    SUM(TotalSales) OVER(
        PARTITION BY OrderStatus
        ORDER BY OrderDate DESC
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS WindowTotal
FROM window_fun.OrdersWindow;


-- ROWS 2 PRECEDING (same as BETWEEN 2 PRECEDING AND CURRENT ROW)
SELECT 
    OrderID,
    OrderDate,
    OrderStatus,
    TotalSales AS Sales,
    SUM(TotalSales) OVER(
        PARTITION BY OrderStatus
        ORDER BY OrderDate DESC
        ROWS 2 PRECEDING
    ) AS WindowTotal
FROM window_fun.OrdersWindow;


-- Running total (UNBOUNDED PRECEDING = start of group to current row)
SELECT 
    OrderID,
    OrderDate,
    OrderStatus,
    TotalSales AS Sales,
    SUM(TotalSales) OVER(
        PARTITION BY OrderStatus
        ORDER BY OrderDate DESC
        ROWS UNBOUNDED PRECEDING
    ) AS RunningTotal
FROM window_fun.OrdersWindow;



---------------------------------------------------------
-- 8) Window functions execute AFTER WHERE clause
-- Here, ProductID is filtered first and then window is computed.
---------------------------------------------------------
SELECT 
    OrderID,
    OrderDate,
    OrderStatus,
    ProductID,
    TotalSales AS Sales,
    SUM(TotalSales) OVER(
        PARTITION BY OrderStatus
        ORDER BY OrderDate DESC
        ROWS UNBOUNDED PRECEDING
    ) AS WindowTotal
FROM window_fun.OrdersWindow
WHERE ProductID IN (101, 102);



---------------------------------------------------------
-- 9) Ranking customers based on their total sales
-- GROUP BY + Window Function allowed
---------------------------------------------------------
SELECT 
    OrderID,
    SUM(TotalSales) AS TotalSales,
    RANK() OVER(ORDER BY SUM(TotalSales) DESC) AS RankOrder
FROM window_fun.OrdersWindow
GROUP BY OrderID;
