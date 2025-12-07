USE set2;

-- ================================
-- GROUP BY PRACTICE QUERIES
-- ================================

/*
The GROUP BY clause is used to group rows that have the same values
in specified columns into summary rows.

It is commonly used with aggregate functions such as:
COUNT(), MAX(), MIN(), AVG(), SUM()

Syntax:
SELECT column_name(s), aggregate_function(column)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s);
*/

-- =================================
-- GROUP BY on gender
-- =================================

-- Display unique genders
SELECT gender
FROM employee
GROUP BY gender;

-- Average salary gender-wise
SELECT gender, AVG(salary)
FROM employee
GROUP BY gender;

-- Maximum salary gender-wise
SELECT gender, MAX(salary)
FROM employee
GROUP BY gender;

-- Minimum salary gender-wise
SELECT gender, MIN(salary)
FROM employee
GROUP BY gender;

-- Count of employees gender-wise
SELECT gender, COUNT(dept_no)
FROM employee
GROUP BY gender;

-- =================================
-- GROUP BY on department number
-- =================================

-- Total employees in each department
SELECT dept_no, COUNT(*)
FROM employee
GROUP BY dept_no;

-- Average salary department-wise
SELECT dept_no, AVG(salary)
FROM employee
GROUP BY dept_no;

-- =================================
-- Display all employee records
-- =================================
SELECT * FROM employee;

-- =================================
-- GROUP BY on designation
-- =================================

-- Employee count per designation
SELECT designation, COUNT(*)
FROM employee
GROUP BY designation;

-- Maximum salary per designation
SELECT designation, MAX(salary)
FROM employee
GROUP BY designation;

-- Minimum salary per designation
SELECT designation, MIN(salary)
FROM employee
GROUP BY designation;

-- =================================
-- GROUP BY on address
-- =================================

-- Employee count per address
SELECT address, COUNT(*)
FROM employee
GROUP BY address;

-- Minimum salary per address
SELECT address, MIN(salary)
FROM employee
GROUP BY address;

-- Maximum salary per address
SELECT address, MAX(salary)
FROM employee
GROUP BY address;

-- Average salary per address
SELECT address, AVG(salary)
FROM employee
GROUP BY address;

-- =================================
-- GROUP BY on multiple columns
-- =================================

-- Department and gender wise employee count
SELECT dept_no, gender, COUNT(*)
FROM employee
GROUP BY dept_no, gender;
