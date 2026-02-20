-- =====================================================
-- LIBRARY SYSTEM MANAGEMENT SQL PROJECT
-- =====================================================

USE library_db;

-- Create table "Branch"
CREATE TABLE branch(
	branch_id VARCHAR(10) PRIMARY KEY,
	manager_id VARCHAR(10),
	branch_address VARCHAR(50),
	contact_no VARCHAR(10)
);

-- Create table "Employee"
CREATE TABLE employee
(
    emp_id VARCHAR(10),
	emp_name VARCHAR(30),
	position VARCHAR(30),
	salary DECIMAL (10,2),
	branch_id VARCHAR(10),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

ALTER TABLE employee
ADD PRIMARY KEY (emp_id);

-- Create table "Members"
CREATE TABLE members
(
	member_id VARCHAR(10) PRIMARY KEY,
	member_name VARCHAR(30),
	member_address VARCHAR(30),
	reg_date DATE
);

-- Create table "Books"
CREATE TABLE books
(
	isbn VARCHAR(50) PRIMARY KEY,
	book_title VARCHAR(80),
	category VARCHAR(30),
	rental_price DECIMAL(10,2),
	status VARCHAR(10),
	author VARCHAR(30),
	publisher VARCHAR(30)
);

-- Create table "IssueStatus"
CREATE TABLE issued_status
(
	issued_id VARCHAR(10) PRIMARY KEY,
	issued_member_id VARCHAR(30),
	issued_book_name VARCHAR(80),
	issued_date DATE,
	issued_book_isbn VARCHAR(50),
	issued_emp_id VARCHAR(10),
	FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
	FOREIGN KEY (issued_emp_id) REFERENCES employee(emp_id),
	FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn) 
);

-- Create table "ReturnStatus"
CREATE TABLE return_status
(
    return_id VARCHAR(10) PRIMARY KEY,
    issued_id VARCHAR(30),
    return_book_name VARCHAR(80),
    return_date DATE,
    return_book_isbn VARCHAR(50),
    FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);

ALTER TABLE branch
MODIFY contact_no VARCHAR(20);

SELECT * FROM branch;
SELECT * FROM employee;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM issued_status;
SELECT * FROM return_status;


-- **Task 1. Create a New Book Record**
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books 
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

SELECT * FROM books;

-- **Task 2: Update an Existing Member's Address**

UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';

SELECT * FROM members;

-- **Task 3: Delete a Record from the Issued Status Table**
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status 
WHERE issued_id='IS121';

SELECT * FROM issued_status;

-- **Task 4: Retrieve All Books Issued by a Specific Employee**
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * 
FROM issued_status 
WHERE issued_emp_id='E101';


-- **Task 5: List Members Who Have Issued More Than One Book**
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT issued_emp_id,
       COUNT(*) AS Total_issued_book 
FROM issued_status 
GROUP BY issued_emp_id
HAVING COUNT(issued_id)>1;


-- ### 3. CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

CREATE TABLE book_issued_cnt AS
SELECT b.isbn,
       b.book_title,
       COUNT(ist.issued_id) AS book_issued_cnt
FROM issued_status ist
JOIN books b
ON b.isbn=ist.issued_book_isbn
GROUP BY b.isbn,b.book_title;

SELECT * FROM book_issued_cnt;


-- ### 4. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:

SELECT * 
FROM books 
WHERE category="classic";


-- Task 8: Find Total Rental Income by Category:

SELECT category,
       SUM(rental_price),
       COUNT(*) 
FROM books
GROUP BY 1;


-- Task 9: **List Members Who Registered in the Last 180 Days**:

SELECT * 
FROM members
WHERE reg_date >= DATE_SUB(CURDATE(),INTERVAL 180 DAY);


-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:

SELECT 
e.emp_id,
e.emp_name,
e.position,
e.salary,
b.*
FROM employee e 
JOIN branch b 
ON e.branch_id=b.branch_id;


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold

SELECT * 
FROM books 
WHERE rental_price >= (SELECT AVG(rental_price) FROM books);


-- Task 12: Retrieve the List of Books Not Yet Returned

SELECT * 
FROM issued_status ist 
LEFT JOIN return_status re 
ON ist.issued_id=re.issued_id
WHERE re.return_id IS NULL;


-- Task 13: Identify Members with Overdue Books
-- Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's name, book title, issue date, and days overdue.

SELECT 
m.member_id,
m.member_name,
b.book_title,
ist.issued_date,
DATEDIFF(CURDATE(),ist.issued_date) AS overdue
FROM issued_status ist 
JOIN members m
ON ist.issued_member_id=m.member_id 
JOIN books b
ON b.isbn=ist.issued_book_isbn
LEFT JOIN return_status re
ON re.issued_id=ist.issued_id
WHERE re.return_date IS NULL
AND DATEDIFF(CURDATE(),ist.issued_date)>30
ORDER BY 1;


-- Task 14: Branch Performance Report
-- Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

CREATE TABLE branch_reports AS
SELECT 
    b.branch_id,
    b.manager_id,
    COUNT(ist.issued_id) AS number_book_issued,
    COUNT(rs.return_id) AS number_of_book_return,
    SUM(bk.rental_price) AS total_revenue
FROM issued_status ist
JOIN employee e
ON e.emp_id = ist.issued_emp_id
JOIN branch b
ON e.branch_id = b.branch_id
LEFT JOIN return_status rs
ON rs.issued_id = ist.issued_id
JOIN books bk
ON ist.issued_book_isbn = bk.isbn
GROUP BY 1,2;


-- Task 15: Update Book Status on Return
-- Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).

UPDATE books b 
JOIN issued_status ist 
ON b.isbn=ist.issued_book_isbn 
JOIN return_status re 
ON re.issued_id=ist.issued_id 
SET b.status='yes'
WHERE re.return_date IS NOT NULL;


-- Task 16: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

SELECT 
    e.emp_name,
    b.*,
    COUNT(ist.issued_id) AS no_book_issued
FROM issued_status ist
JOIN employee e
ON e.emp_id = ist.issued_emp_id
JOIN branch b
ON e.branch_id = b.branch_id
GROUP BY 1,2
ORDER BY no_book_issued DESC
LIMIT 3;