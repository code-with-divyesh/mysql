-- Switch to practice database
USE practice2;

-- ============================================================
-- SUBQUERY OVERVIEW
-- ============================================================
/*
A subquery is a query written inside another query.
It is also known as a nested query.

Execution flow:
- Inner query executes first
- Outer query uses the result of the inner query

General Syntax:
SELECT column_name
FROM table_name
WHERE column_name operator
      (SELECT column_name FROM table_name WHERE condition);
*/

-- ============================================================
-- 1. Scalar Subquery (Returns a Single Value)
-- Used with =, >, < operators
-- Example: Employees earning more than the average salary
-- ============================================================
SELECT *
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);

-- ============================================================
-- 2. Multiple Row Subquery (Returns Multiple Values)
-- Used with IN, ANY, ALL
-- Example: Employees working in IT and HR departments
-- ============================================================
SELECT 
    emp_id,
    emp_name
FROM employee
WHERE dept_id IN (
    SELECT dept_id
    FROM department
    WHERE dept_name IN ('IT', 'HR')
);

-- ============================================================
-- 3. Subquery in SELECT Clause
-- Scalar subquery used to add a derived column
-- Example: Show average salary along with each employee
-- ============================================================
SELECT 
    emp_id,
    emp_name,
    salary,
    (SELECT AVG(salary) FROM employee) AS avg_salary
FROM employee;

-- ============================================================
-- 4. Subquery in FROM Clause (Derived Table)
-- Treated as a temporary table
-- Example: Employees earning more than their department average
-- ============================================================
SELECT *
FROM (
    SELECT 
        dept_id,
        AVG(salary) AS dept_avg_salary
    FROM employee
    GROUP BY dept_id
) dept_avg
JOIN employee e
    ON e.dept_id = dept_avg.dept_id
WHERE e.salary > dept_avg.dept_avg_salary;

-- ============================================================
-- 5. Correlated Subquery
-- Inner query depends on outer query
-- Executes once for each row of the outer query
-- Example: Employees earning more than their own department average
-- ============================================================
SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.salary
FROM employee e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employee e2
    WHERE e2.dept_id = e1.dept_id
);

-- ============================================================
-- 6. Subquery with ANY
-- ANY returns TRUE if condition matches at least one value
-- Example: Employees earning more than any employee in department 10
-- ============================================================
SELECT emp_name
FROM employee
WHERE salary > ANY (
    SELECT salary
    FROM employee
    WHERE dept_id = 10
);
