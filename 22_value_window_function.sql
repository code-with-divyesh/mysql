USE window_fun;

-- =====================================================
-- VALUE WINDOW FUNCTIONS
-- =====================================================
-- Value window functions return values from other rows
-- without collapsing data like GROUP BY.
-- Used for:
-- • Comparisons
-- • Trend analysis
-- • Event-based analytics
-- =====================================================


-- -----------------------------------------------------
-- Types of Value Window Functions
-- -----------------------------------------------------
-- | Function        | Description                | Common Use Case           |
-- |-----------------|----------------------------|---------------------------|
-- | LAG()           | Previous row value         | Past comparison           |
-- | LEAD()          | Next row value             | Forecast / gap analysis  |
-- | FIRST_VALUE()   | First value in window      | Baseline comparison       |
-- | LAST_VALUE()    | Last value in window       | End value comparison      |
-- | NTH_VALUE()     | Nth value in window        | Custom reference points   |
-- -----------------------------------------------------


-- =====================================================
-- 1. LAG()
-- =====================================================
-- Returns value from a previous row.
-- Syntax:
-- LAG(column, offset, default) OVER (ORDER BY column)

-- Compare each order's sales with previous order
SELECT
    OrderID,
    OrderDate,
    TotalSales,
    LAG(TotalSales) OVER (ORDER BY OrderDate) AS prev_sales,
    TotalSales - LAG(TotalSales) OVER (ORDER BY OrderDate) AS sales_diff
FROM window_fun.orderswindow;


-- Month-over-Month sales analysis
SELECT
    ordermonth,
    currentmonthsales,
    LAG(currentmonthsales) OVER (ORDER BY ordermonth) AS prevmonthsales
FROM (
    SELECT
        MONTH(OrderDate) AS ordermonth,
        SUM(TotalSales) AS currentmonthsales
    FROM window_fun.orderswindow
    GROUP BY MONTH(OrderDate)
) t
ORDER BY ordermonth;


-- Year-over-Year sales analysis
SELECT
    order_year,
    yearly_sales,
    LAG(yearly_sales) OVER (ORDER BY order_year) AS prev_year_sales
FROM (
    SELECT
        YEAR(OrderDate) AS order_year,
        SUM(TotalSales) AS yearly_sales
    FROM window_fun.orderswindow
    GROUP BY YEAR(OrderDate)
) t
ORDER BY order_year;


-- =====================================================
-- 2. LEAD()
-- =====================================================
-- Returns value from the next row.
-- Used for forecast comparison & gap detection

-- Compare current order sales with next order
SELECT
    OrderID,
    OrderDate,
    TotalSales,
    LEAD(TotalSales) OVER (ORDER BY OrderDate) AS next_sales
FROM window_fun.orderswindow;


-- Forecast comparison (current vs next month)
SELECT
    order_month,
    monthly_sales,
    LEAD(monthly_sales) OVER (ORDER BY order_month) AS next_month_sales,
    LEAD(monthly_sales) OVER (ORDER BY order_month) - monthly_sales AS forecast_gap
FROM (
    SELECT
        MONTH(OrderDate) AS order_month,
        SUM(TotalSales) AS monthly_sales
    FROM window_fun.orderswindow
    GROUP BY MONTH(OrderDate)
) t
ORDER BY order_month;


-- Gap detection between order dates
SELECT
    OrderID,
    OrderDate,
    LEAD(OrderDate) OVER (ORDER BY OrderDate) AS next_order_date,
    DATEDIFF(
        LEAD(OrderDate) OVER (ORDER BY OrderDate),
        OrderDate
    ) AS gap_in_days
FROM window_fun.orderswindow;


-- =====================================================
-- 3. FIRST_VALUE()
-- =====================================================
-- Returns the first value in the window.
-- Used for baseline & first-event analysis

-- First sale per product
SELECT
    OrderID,
    ProductID,
    OrderDate,
    TotalSales,
    FIRST_VALUE(TotalSales) OVER (
        PARTITION BY ProductID
        ORDER BY OrderDate
    ) AS first_sale
FROM window_fun.orderswindow;


-- Baseline comparison
SELECT
    OrderDate,
    TotalSales,
    FIRST_VALUE(TotalSales) OVER (ORDER BY OrderDate) AS baseline_sales,
    TotalSales - FIRST_VALUE(TotalSales) OVER (ORDER BY OrderDate) AS change_from_baseline
FROM window_fun.orderswindow;


-- First transaction analysis (overall)
SELECT
    OrderID,
    OrderDate,
    TotalSales,
    FIRST_VALUE(OrderDate) OVER (ORDER BY OrderDate) AS first_transaction_date,
    FIRST_VALUE(TotalSales) OVER (ORDER BY OrderDate) AS first_transaction_sales
FROM window_fun.orderswindow;


-- =====================================================
-- 4. LAST_VALUE()
-- =====================================================
-- Returns the last value in the window.
-- IMPORTANT: Explicit frame is required!

-- Final sale per product
SELECT
    ProductID,
    OrderDate,
    TotalSales,
    LAST_VALUE(TotalSales) OVER (
        PARTITION BY ProductID
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS final_product_sales
FROM window_fun.orderswindow;


-- End value comparison (current vs final sale)
SELECT
    OrderID,
    OrderDate,
    TotalSales,
    LAST_VALUE(TotalSales) OVER (
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS final_sales,
    LAST_VALUE(TotalSales) OVER (
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) - TotalSales AS diff_from_final
FROM window_fun.orderswindow;


-- =====================================================
-- 5. NTH_VALUE()
-- =====================================================
-- Returns the Nth value in the window.
-- Used for custom reference & event-based analysis

-- 2nd sale per product
SELECT
    ProductID,
    OrderDate,
    TotalSales,
    NTH_VALUE(TotalSales, 2) OVER (
        PARTITION BY ProductID
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS second_sale
FROM window_fun.orderswindow;


-- Custom reference point comparison (2nd transaction)
SELECT
    OrderID,
    OrderDate,
    TotalSales,
    NTH_VALUE(TotalSales, 2) OVER (
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS second_transaction_sales,
    TotalSales - NTH_VALUE(TotalSales, 2) OVER (
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS diff_from_second
FROM window_fun.orderswindow;


-- Event-based analysis (5th transaction)
SELECT
    OrderID,
    OrderDate,
    TotalSales,
    NTH_VALUE(OrderDate, 5) OVER (
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS fifth_transaction_date
FROM window_fun.orderswindow;
