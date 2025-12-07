USE set2;

-- =========================
-- CROSS JOIN
-- =========================

/*
CROSS JOIN:
The CROSS JOIN keyword returns:
- ALL possible combinations of rows from both tables
- Also called Cartesian Product

If:
- department has N rows
- employee has M rows

Result = N × M rows

CROSS JOIN Syntax:

SELECT column_name(s)
FROM table1
CROSS JOIN table2;
*/

-- -----------------------------------------
-- Example 1: Pure CROSS JOIN
-- -----------------------------------------
-- Returns all combinations of departments and employees
-- No condition is applied

SELECT
    d.dept_no,
    d.dept_name,
    e.salary
FROM department d
CROSS JOIN employee e;

-- -----------------------------------------
-- Example 2: CROSS JOIN with WHERE condition
-- -----------------------------------------
-- Although CROSS JOIN is used,
-- adding a WHERE condition filters matching rows
-- This behaves the SAME as an INNER JOIN

SELECT
    d.dept_no,
    d.dept_name,
    e.salary
FROM department d
CROSS JOIN employee e
WHERE d.dept_no = e.dept_no;

-- NOTE:
-- CROSS JOIN + WHERE condition = INNER JOIN (logically)
