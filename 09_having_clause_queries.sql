USE set2;

-- ================================
-- HAVING CLAUSE PRACTICE QUERIES
-- ================================

/*
The HAVING clause is used to filter grouped data.
It is applied after GROUP BY and works with aggregate functions.

WHY HAVING?
- WHERE filters individual rows before grouping
- HAVING filters groups after aggregation

Syntax:
SELECT column_name(s), aggregate_function(column)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);
*/

-- =================================
-- Designation wise total salary
-- Show only those designations
-- where total salary is greater than 75000
-- =================================
SELECT designation, SUM(salary)
FROM employee
GROUP BY designation
HAVING SUM(salary) > 75000;

-- =================================
-- Filter rows using WHERE first
-- Then apply HAVING on grouped result
-- =================================
SELECT designation, SUM(salary)
FROM employee
WHERE gender = 'female'
GROUP BY designation
HAVING SUM(salary) > 75000;

-- =================================
-- Count of employees per designation
-- Display only designations having more than one employee
-- =================================
SELECT designation, COUNT(*) AS total_emp
FROM employee
GROUP BY designation
HAVING COUNT(*) > 1;

-- =================================
-- Department wise average salary
-- Display departments where average salary > 50000
-- =================================
SELECT dept_no, AVG(salary) AS avg_salary
FROM employee
GROUP BY dept_no
HAVING AVG(salary) > 50000;

-- =================================
-- Address wise maximum salary
-- Show addresses where max salary is greater than 60000
-- =================================
SELECT address, MAX(salary)
FROM employee
GROUP BY address
HAVING MAX(salary) > 60000;

-- =================================
-- Multiple conditions in HAVING
-- Total salary > 50000 AND employee count > 1
-- =================================
SELECT designation, SUM(salary), COUNT(*)
FROM employee
GROUP BY designation
HAVING SUM(salary) > 50000
   AND COUNT(*) > 1;

-- =================================
-- Using alias and ORDER BY with HAVING
-- Sort result by total salary in descending order
-- =================================
SELECT designation, SUM(salary) AS total_salary
FROM employee
GROUP BY designation
HAVING total_salary > 50000
ORDER BY total_salary DESC;
