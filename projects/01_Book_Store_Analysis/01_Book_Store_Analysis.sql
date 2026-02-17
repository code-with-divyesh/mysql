-- ============================================
--        ONLINE BOOKSTORE DATABASE PROJECT
-- ============================================

-- Create Database
CREATE DATABASE OnlineBookstore;
USE OnlineBookstore;

-- ============================================
-- Drop existing tables (if already created)
-- ============================================
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;

-- ============================================
-- Create Books Table
-- Stores book details
-- ============================================
CREATE TABLE Books (
    Book_ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price DECIMAL(10,2),
    Stock INT
);

-- ============================================
-- Create Customers Table
-- Stores customer personal details
-- ============================================
CREATE TABLE Customers (
    Customer_ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

-- ============================================
-- Create Orders Table
-- Stores order transactions
-- Foreign Keys link Customers & Books
-- ============================================
CREATE TABLE Orders (
    Order_ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Customer_ID BIGINT UNSIGNED,
    Book_ID BIGINT UNSIGNED,
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);

-- ============================================
-- Enable LOCAL INFILE for CSV Import
-- ============================================
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

-- ============================================
-- Import Books Data from CSV
-- ============================================
LOAD DATA LOCAL INFILE '.../Books.csv'
INTO TABLE Books
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Title, Author, Genre, Published_Year, Price, Stock);

-- ============================================
-- Import Customers Data
-- ============================================
LOAD DATA LOCAL INFILE '.../Customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Name, Email, Phone, City, Country);

-- ============================================
-- Import Orders Data (Convert Date Format)
-- ============================================
LOAD DATA LOCAL INFILE '.../Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Customer_ID, Book_ID, @Order_Date, Quantity, Total_Amount)
SET Order_Date = STR_TO_DATE(@Order_Date, '%d-%m-%Y');

-- ============================================
-- BASIC QUERIES
-- ============================================


-- 1) Retrieve all books in the "Fiction" genre:

select * from books
where Genre="Fiction";



-- 2) Find books published after the year 1950:

select * from books
where published_year>="1950";

-- 3) List all customers from the Canada:

SET SQL_SAFE_UPDATES = 0;

select * from customers;
UPDATE Customers
SET Country = TRIM(REPLACE(Country, '\r', ''));

select * from customers
where Country="Canada";


-- 4) Show orders placed in November 2023:

select * from orders;
SELECT *
FROM Orders
WHERE Order_Date >= '2023-11-01'
AND Order_Date < '2023-12-01';

SELECT *
FROM Orders
WHERE Order_Date 
BETWEEN '2023-11-01' AND '2023-11-30';



-- 5) Retrieve the total stock of books available:

select sum(stock) 
from books;

-- 6) Find the details of the most expensive book:

select * from books where price = (select max(price) from books);

select * from books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:

select * from customers 
where customer_id in 
	(select customer_id 
	from orders 
	where quantity>1);

-- 8) Retrieve all orders where the total amount exceeds $20:

select * from orders 
where total_amount>20;


-- 9) List all genres available in the Books table:

select distinct(genre) from books;

-- 10) Find the book with the lowest stock:

SELECT *
FROM Books
WHERE Stock = (
    SELECT MIN(Stock)
    FROM Books
);

SELECT *
FROM Books
ORDER BY Stock ASC
LIMIT 1;




-- 11) Calculate the total revenue generated from all orders:

select sum(total_amount) as Total_Revenue from orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:


select distinct b.genre,sum(o.quantity)  as total_no_of_books
from books b
join orders o 
on b.Book_ID=o.Book_ID
group by b.genre
;

-- 2) Find the average price of books in the "Fantasy" genre:

select avg(price) as Avg_Price from books where genre="Fantasy";


-- 3) List customers who have placed at least 2 orders:

select c.customer_id,c.name,count(o.order_id) as order_count 
from orders o
join customers c
on c.customer_id=o.customer_id
group by c.customer_id 
having count(o.order_id)>=2; 

-- 4) Find the most frequently ordered book:

select b.Book_id,b.title, count(o.order_id) as order_count 
from orders o 
join books b
on b.book_id=o.book_id
group by b.Book_id
order by order_count desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

select book_id,title,price from books where genre="Fantasy" order by price desc limit 3; 

-- 6) Retrieve the total quantity of books sold by each author:

select b.author,sum(o.quantity)  as Total_books_sold
from books b join orders o 
on b.book_id=o.book_id
group by b.author;


-- 7) List the cities where customers who spent over $30 are located:

select distinct(c.city),o.total_amount from customers c join orders o
on c.customer_id=o.customer_id 
where o.total_amount>30;

-- 8) Find the customer who spent the most on orders:

select c.customer_id,c.name,sum(o.total_amount) as total_spent from customers c join orders o
on c.customer_id=o.customer_id 
group by c.customer_id,c.name
order by total_spent desc limit 1;



-- 9) Calculate the stock remaining after fulfilling all orders:

select b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0) as order_quantity,b.stock-coalesce(sum(o.quantity),0) as remaining 
from books b 
left join orders o
on b.book_id=o.book_id
group by b.book_id
;

