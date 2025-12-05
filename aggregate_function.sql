-- ============================================================
-- Create Employee Table
-- ============================================================
-- This table stores basic employee information including:
-- ID, Name, Department, Salary, and Age.
-- emp_id is used as the PRIMARY KEY.
-- ============================================================

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    age INT
);


-- ============================================================
-- Insert Sample Records
-- ============================================================
-- These sample rows help in performing aggregate functions such 
-- as MIN, MAX, AVG, SUM, and COUNT for practice.
-- ============================================================

INSERT INTO employee (emp_id, emp_name, department, salary, age) VALUES
(1, 'Amit', 'HR', 35000, 28),
(2, 'Sneha', 'Finance', 55000, 32),
(3, 'Rahul', 'IT', 72000, 25),
(4, 'Priya', 'IT', 68000, 30),
(5, 'Karan', 'Marketing', 40000, 27),
(6, 'Meena', 'Finance', 90000, 38),
(7, 'Ravi', 'HR', 30000, 24);

SELECT * FROM employee;


-- ============================================================
-- MIN() and MAX() Functions
-- ============================================================
-- MIN(): Returns the smallest value from the selected column.
-- Syntax:
--   SELECT MIN(column_name) FROM table_name WHERE condition;
--
-- MAX(): Returns the largest value from the selected column.
-- Syntax:
--   SELECT MAX(column_name) FROM table_name WHERE condition;
-- ============================================================

SELECT MIN(salary) AS min_salary FROM employee;
SELECT MAX(salary) AS max_salary FROM employee;


-- ============================================================
-- COUNT() Function
-- ============================================================
-- COUNT(): Returns the number of rows that match a condition.
-- Syntax:
--   SELECT COUNT(column_name) FROM table_name WHERE condition;
--
-- Note: NULL values are not counted.
-- ============================================================

SELECT COUNT(salary) FROM employee WHERE salary > 50000;


-- ============================================================
-- AVG() Function
-- ============================================================
-- AVG(): Returns the average value of a numeric column.
-- Syntax:
--   SELECT AVG(column_name) FROM table_name WHERE condition;
--
-- Note: NULL values are ignored.
-- ============================================================

SELECT AVG(salary) FROM employee;


-- ============================================================
-- SUM() Function
-- ============================================================
-- SUM(): Returns the total sum of a numeric column.
-- Syntax:
--   SELECT SUM(column_name) FROM table_name WHERE condition;
--
-- Note: NULL values are ignored.
-- ============================================================

SELECT SUM(salary) FROM employee;
