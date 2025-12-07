USE set2;

-- =========================
-- SQL JOINS
-- =========================

/*
A JOIN clause is used to combine rows from two or more tables
based on a related column between them.

In this project, we join:
- employee table
- department table

Common column: dept_no
*/

-- =========================
-- Types of JOINS in MySQL
-- =========================

/*
1. INNER JOIN
   - Returns only the records that have matching values in both tables

2. LEFT JOIN
   - Returns all records from the left table
   - And matching records from the right table

3. RIGHT JOIN
   - Returns all records from the right table
   - And matching records from the left table

4. CROSS JOIN
   - Returns Cartesian product (all combinations of rows)
*/

-- =========================
-- Sample Data Insert
-- =========================

-- Insert a new department record
INSERT INTO department
VALUES (160, 'police', 'police01', 055, 'gu');

-- =========================
-- View Data
-- =========================

-- View department table
SELECT * FROM department;

-- View employee table
SELECT * FROM employee;

-- =========================
-- INNER JOIN Example
-- =========================

/*
This query returns:
- department number
- department name
- employee salary

Only rows where dept_no exists in BOTH tables are returned
*/

SELECT
    department.dept_no,
    department.dept_name,
    employee.salary
FROM department
INNER JOIN employee
ON department.dept_no = employee.dept_no;
