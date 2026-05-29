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

SELECT 
    *
FROM
    books
WHERE
    Genre = 'Fiction';



-- 2) Find books published after the year 1950:

SELECT 
    *
FROM
    books
WHERE
    published_year >= '1950';

-- 3) List all customers from the Canada:

SET SQL_SAFE_UPDATES = 0;

SELECT 
    *
FROM
    customers;
UPDATE Customers 
SET 
    Country = TRIM(REPLACE(Country, '', ''));

SELECT 
    *
FROM
    customers
WHERE
    Country = 'Canada';


-- 4) Show orders placed in November 2023:

select * from orders;
SELECT 
    *
FROM
    Orders
WHERE
    Order_Date >= '2023-11-01'
        AND Order_Date < '2023-12-01';

SELECT 
    *
FROM
    Orders
WHERE
    Order_Date BETWEEN '2023-11-01' AND '2023-11-30';



-- 5) Retrieve the total stock of books available:

SELECT 
    SUM(stock)
FROM
    books;

-- 6) Find the details of the most expensive book:

SELECT 
    *
FROM
    books
WHERE
    price = (SELECT 
            MAX(price)
        FROM
            books);

SELECT 
    *
FROM
    books
ORDER BY price DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT 
    *
FROM
    customers
WHERE
    customer_id IN (SELECT 
            customer_id
        FROM
            orders
        WHERE
            quantity > 1);

-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT 
    *
FROM
    orders
WHERE
    total_amount > 20;


-- 9) List all genres available in the Books table:

SELECT DISTINCT
    (genre)
FROM
    books;

-- 10) Find the book with the lowest stock:

SELECT 
    *
FROM
    Books
WHERE
    Stock = (SELECT 
            MIN(Stock)
        FROM
            Books);

SELECT 
    *
FROM
    Books
ORDER BY Stock ASC
LIMIT 1;




-- 11) Calculate the total revenue generated from all orders:

SELECT 
    SUM(total_amount) AS Total_Revenue
FROM
    orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:


SELECT DISTINCT
    b.genre, SUM(o.quantity) AS total_no_of_books
FROM
    books b
        JOIN
    orders o ON b.Book_ID = o.Book_ID
GROUP BY b.genre
;

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT 
    AVG(price) AS Avg_Price
FROM
    books
WHERE
    genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders:

SELECT 
    c.customer_id, c.name, COUNT(o.order_id) AS order_count
FROM
    orders o
        JOIN
    customers c ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) >= 2; 

-- 4) Find the most frequently ordered book:

SELECT 
    b.Book_id, b.title,SUM(o.quantity) AS order_count
FROM
    orders o
        JOIN
    books b ON b.book_id = o.book_id
GROUP BY b.Book_id
ORDER BY order_count DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT 
    book_id, title, price
FROM
    books
WHERE
    genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3; 

-- 6) Retrieve the total quantity of books sold by each author:

SELECT 
    b.author, SUM(o.quantity) AS Total_books_sold
FROM
    books b
        JOIN
    orders o ON b.book_id = o.book_id
GROUP BY b.author;


-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT
    (c.city), o.total_amount
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
WHERE
    o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:

SELECT 
    c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id , c.name
ORDER BY total_spent DESC
LIMIT 1;



-- 9) Calculate the stock remaining after fulfilling all orders:

SELECT 
    b.book_id,
    b.title,
    b.stock,
    COALESCE(SUM(o.quantity), 0) AS order_quantity,
    b.stock - COALESCE(SUM(o.quantity), 0) AS remaining
FROM
    books b
        LEFT JOIN
    orders o ON b.book_id = o.book_id
GROUP BY
b.book_id,
b.title,
b.stock
;

