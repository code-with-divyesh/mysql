/*
The UNION operator is used to combine the result-set of two or more SELECT statements.

Key Points:
1. UNION removes duplicate rows automatically
2. UNION ALL keeps duplicate rows
3. Each SELECT must return:
   - same number of columns
   - compatible data types
   - same column order

UNION Syntax:
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;
*/

-- --------------------------------------------
-- Create Database
-- --------------------------------------------
CREATE DATABASE union_practice;
USE union_practice;

-- --------------------------------------------
-- Table: employee_2023
-- --------------------------------------------
CREATE TABLE employee_2023 (
    emp_id INT,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    salary INT
);

-- --------------------------------------------
-- Table: employee_2024
-- --------------------------------------------
CREATE TABLE employee_2024 (
    emp_id INT,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    salary INT
);

-- --------------------------------------------
-- Insert data into employee_2023
-- --------------------------------------------
INSERT INTO employee_2023 VALUES
(1, 'Amit', 'HR', 40000),
(2, 'Sneha', 'Finance', 55000),
(3, 'Rahul', 'IT', 70000),
(4, 'Pooja', 'HR', 38000);

-- --------------------------------------------
-- Insert data into employee_2024
-- --------------------------------------------
INSERT INTO employee_2024 VALUES
(5, 'Karan', 'Marketing', 45000),
(6, 'Meena', 'Finance', 60000),
(3, 'Rahul', 'IT', 70000),   -- duplicate record
(7, 'Neha', 'HR', 50000);

-- --------------------------------------------
-- UNION Example (removes duplicates)
-- --------------------------------------------
SELECT * FROM employee_2023
UNION
SELECT * FROM employee_2024;

-- --------------------------------------------
-- UNION with ORDER BY
-- (ORDER BY applied on final result set)
-- --------------------------------------------
SELECT emp_id, emp_name, dept_name, salary FROM employee_2023
UNION
SELECT emp_id, emp_name, dept_name, salary FROM employee_2024
ORDER BY salary DESC;

-- --------------------------------------------
-- UNION with WHERE condition
-- --------------------------------------------
SELECT emp_name, salary FROM employee_2023 WHERE salary > 45000
UNION
SELECT emp_name, salary FROM employee_2024 WHERE salary > 45000;

-- --------------------------------------------
-- UNION ALL (keeps duplicates)
-- --------------------------------------------
SELECT * FROM employee_2023
UNION ALL
SELECT * FROM employee_2024;