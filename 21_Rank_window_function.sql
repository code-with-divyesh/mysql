USE window_fun;

----------------------------------------------------
-- RANKING WINDOW FUNCTIONS
----------------------------------------------------
-- Ranking window functions assign a position (rank/number)
-- to rows based on an ORDER BY condition.
-- Unlike GROUP BY, they DO NOT reduce rows;
-- all row-level details are preserved.

-- Common use case: Top-N analysis

-- | Function       | Handles Ties | Skips Numbers | Typical Use Case              |
-- |--------------- |------------- |-------------- |------------------------------|
-- | ROW_NUMBER()   | No           | No            | Unique numbering             |
-- | RANK()         | Yes          | Yes           | Competition ranking          |
-- | DENSE_RANK()   | Yes          | No            | Leaderboards / Top-N         |
-- | NTILE(n)       | No           | No            | Buckets / Percentiles        |

----------------------------------------------------
-- ROW_NUMBER()
----------------------------------------------------
-- Assigns a unique sequential number to each row
-- Even if values are same, ranks will be different
-- Does NOT handle ties

-- Rank orders based on TotalSales (highest to lowest)

SELECT 
    OrderID,
    OrderDate,
    ProductID,
    TotalSales,
    ROW_NUMBER() OVER (ORDER BY TotalSales DESC) AS salesRank
FROM window_fun.orderswindow;

-- Find highest sales order for each product
-- (exactly one row per product)

SELECT *
FROM (
    SELECT 
        OrderID,
        OrderDate,
        ProductID,
        TotalSales,
        ROW_NUMBER() OVER (PARTITION BY ProductID ORDER BY TotalSales DESC) AS RankByProduct
    FROM window_fun.orderswindow
) t
WHERE RankByProduct = 1;

----------------------------------------------------
-- RANK()
----------------------------------------------------
-- Assigns same rank to ties
-- Skips rank numbers after ties

-- Best for competition-style ranking
-- (sports, exams, leaderboards with gaps allowed)

SELECT 
    OrderID,
    OrderDate,
    ProductID,
    TotalSales,
    RANK() OVER (ORDER BY TotalSales DESC) AS salesRank
FROM window_fun.orderswindow;

-- Highest sales per product (ties included)

SELECT *
FROM (
    SELECT 
        OrderID,
        OrderDate,
        ProductID,
        TotalSales,
        RANK() OVER (PARTITION BY ProductID ORDER BY TotalSales DESC) AS RankByProduct
    FROM window_fun.orderswindow
) t
WHERE RankByProduct = 1;

----------------------------------------------------
-- DENSE_RANK()
----------------------------------------------------
-- Assigns same rank to ties
-- DOES NOT skip rank numbers

-- Best for:
-- Leaderboards
-- Top-N analysis
-- Continuous ranking

SELECT 
    OrderID,
    OrderDate,
    ProductID,
    TotalSales,
    DENSE_RANK() OVER (ORDER BY TotalSales DESC) AS salesRank
FROM window_fun.orderswindow;

-- Highest sales per product (no gaps in ranking)

SELECT *
FROM (
    SELECT 
        OrderID,
        OrderDate,
        ProductID,
        TotalSales,
        DENSE_RANK() OVER (PARTITION BY ProductID ORDER BY TotalSales DESC) AS RankByProduct
    FROM window_fun.orderswindow
) t
WHERE RankByProduct = 1;

----------------------------------------------------
-- NTILE(n)
----------------------------------------------------
-- Divides ordered rows into n roughly equal buckets
-- Commonly used for:
-- Percentiles
-- Segmentation
-- Load balancing

SELECT 
    OrderID,
    OrderDate,
    ProductID,
    TotalSales,
    NTILE(2) OVER (ORDER BY TotalSales DESC) AS salesBucket
FROM window_fun.orderswindow;

-- Multiple bucket examples

SELECT 
    OrderID,
    OrderDate,
    ProductID,
    TotalSales,
    NTILE(1) OVER (ORDER BY TotalSales DESC) AS one_bucket,
    NTILE(2) OVER (ORDER BY TotalSales DESC) AS two_bucket,
    NTILE(3) OVER (ORDER BY TotalSales DESC) AS three_bucket,
    NTILE(4) OVER (ORDER BY TotalSales DESC) AS four_bucket
FROM window_fun.orderswindow;

----------------------------------------------------
-- ORDER / SALES SEGMENTATION
----------------------------------------------------
-- Segment orders into High / Medium / Low based on sales

SELECT *,
       CASE 
           WHEN buckets = 1 THEN 'High'
           WHEN buckets = 2 THEN 'Medium'
           WHEN buckets = 3 THEN 'Low'
       END AS sales_segmentation
FROM (
    SELECT
        ProductID,
        TotalSales,
        NTILE(3) OVER (ORDER BY TotalSales DESC) AS buckets
    FROM window_fun.orderswindow
) t;

----------------------------------------------------
-- EXPORT DATA USING NTILE
----------------------------------------------------
-- Divide orders into 2 groups for export / parallel processing

SELECT
    *,
    NTILE(2) OVER (ORDER BY OrderID) AS export_group
FROM window_fun.orderswindow;

----------------------------------------------------
-- CUME_DIST()
----------------------------------------------------
-- Cumulative distribution of values
-- Formula:
-- (number of rows <= current row) / (total rows)
-- Always ends at 1

-- Use cases:
-- Percentile cutoffs
-- Top X% analysis

SELECT
    ProductID,
    TotalSales,
    CUME_DIST() OVER (ORDER BY TotalSales) 
FROM window_fun.orderswindow;

----------------------------------------------------
-- PERCENT_RANK()
----------------------------------------------------
-- Relative rank position of a row
-- Formula:
-- (rank - 1) / (total rows - 1)
-- Starts at 0, never reaches 1

-- Use cases:
-- Relative performance comparison
-- Analytics dashboards

SELECT
    ProductID,
    TotalSales,
    PERCENT_RANK() OVER (ORDER BY TotalSales) perRank
FROM window_fun.orderswindow;
