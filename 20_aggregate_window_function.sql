use window_fun;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Score INT
);

INSERT INTO Customer (CustomerID, FirstName, LastName, Country, Score) VALUES
(1, 'Jossef', 'Goldberg', 'Germany', 350),
(2, 'Kevin', 'Brown', 'USA', 900),
(3, 'Mary', NULL, 'USA', 750),
(4, 'Mark', 'Schwarz', 'Germany', 500),
(5, 'Anna', 'Adams', 'USA', NULL);

-- window aggregate count function

-- find total number of product
-- additionally provide all product details
select
	 ProductID,
	 count(TotalSales) over(partition by productID) totalProduct
 from window_fun.orderswindow;
 
 
 -- find the total no of customer
 -- find the total number of scores for the customer
 -- additionally provide all  details
 select
	*,
	count(*) over() Totalcustomers,
    count(1) over() Totalcustomers,
    count(score) over() Totalscore,
    count(country) over() Totalcountries,
	count(lastname) over() Totallastname
    from window_fun.customer;
    
    
    
-- window sum function


select * from window_fun.orderswindow;

-- find the total sales across all orders
-- find the total sales for each product
-- Additionally ,provide details such as order id and order date.

select 
OrderID,
OrderDate,
ProductID,
TotalSales,
 sum(TotalSales) over() TotalSales,
 sum(TotalSales) over(partition by productID) salesByProducts
from window_fun.orderswindow;

-- find the percentage contribution of each product's sales total sales

select 
OrderID,
OrderDate,
ProductID,
TotalSales,
 sum(TotalSales) over() TotalSales,
 round(TotalSales/sum(TotalSales) over()*100,2) percentageofTotal
from window_fun.orderswindow;



-- find the avg sales across all orders
-- find the avg sales for each product
-- Additionally ,provide details such as order id and order date.

select 
OrderID,
OrderDate,
ProductID,
TotalSales,
 avg(TotalSales) over() TotalSales,
 avg(TotalSales) over(partition by ProductID) salesByProducts
from window_fun.orderswindow;


-- find the average score of customer 
-- Additionally provide details such customerId and last name


select
 customerID,
lastname,
score,
avg(Score) over() avgScores,
avg(coalesce(score,0)) over() avgscorewithoutnull,
avg(Score) over(partition by customerId) avgscorepercustomer
from window_fun.customer;

-- find all orders where sales greater than avg sales across all orders


SELECT *
FROM (
    SELECT 
        OrderID,
        ProductID,
        TotalSales,
        AVG(TotalSales) OVER() AS avgsales
    FROM window_fun.orderswindow
) t
WHERE TotalSales > avgsales;


-- min and max function


-- find the highest and lowest sales for all orders
-- find the highest and lowest sales for each product
-- Additionally provide details such as orderID,order date

select
OrderID,
orderdate,
TotalSales,
max(TotalSales) over() HighestSales,
min(TotalSales) over() MinSales,
max(TotalSales) over(partition by ProductID) HighestSalesperproduct,
min(TotalSales) over(partition by ProductID) MinSalesperproduct
from window_fun.orderswindow;

-- find the deviation of each sales from the minimum and maximum sales ammounts

select
OrderID,
orderdate,
TotalSales,
max(TotalSales) over() HighestSales,
min(TotalSales) over() MinSales,
TotalSales-min(TotalSales) over() deviationfrommin,
max(TotalSales) over()-TotalSales deviationfrommax
from window_fun.orderswindow;

-- running total and rolling total 

-- 1️⃣ Running Total (Cumulative Sum)
-- 👉 What it means

-- A running total adds values from the beginning up to the current row.

-- Think of it as:

-- “Keep adding everything I’ve seen so far.”

-- 2️⃣ Rolling Total (Moving Window Sum)
-- 👉 What it means

-- A rolling total sums values over a fixed number of previous rows (a sliding window).

-- Think of it as:

-- “Add only the last N rows, not everything.”

-- | Feature       | Running Total      | Rolling Total           |
-- | ------------- | ------------------ | ----------------------- |
-- | Window start  | First row          | Fixed number of rows    |
-- | Window end    | Current row        | Current row             |
-- | Window size   | Grows over time    | Constant                |
-- | Can decrease? | ❌ No              | ✅ Yes                 |
-- | Typical use   | Cumulative revenue | Moving averages, trends |



