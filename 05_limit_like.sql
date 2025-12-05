-- ============================================================
-- LIMIT Clause
-- ============================================================
-- The LIMIT clause is used to restrict the number of records 
-- returned by a query.
--
-- It is especially useful when working with large tables, as 
-- fetching too many rows can impact performance.
--
-- Syntax:
-- SELECT column_name(s)
-- FROM table_name
-- WHERE condition
-- LIMIT number;
-- ============================================================

-- Examples:
SELECT * FROM department WHERE manager_id = 1 LIMIT 3;

SELECT * FROM department LIMIT 5;

SELECT * FROM department WHERE manager_id = 1 LIMIT 4;


-- ============================================================
-- LIKE Operator
-- ============================================================
-- The LIKE operator is used in the WHERE clause to search for 
-- a specific pattern within a column.
--
-- Wildcards used with LIKE:
--   %  → matches zero, one, or multiple characters
--   _  → matches exactly one single character
--
-- These wildcards can be used individually or combined.
--
-- Syntax:
-- SELECT column1, column2, ...
-- FROM table_name
-- WHERE columnN LIKE pattern;
-- ============================================================

-- Examples:
SELECT * FROM department WHERE location LIKE 'm%';       -- starts with 'm'

SELECT * FROM department WHERE location LIKE '%y';       -- ends with 'y'

SELECT * FROM department WHERE dept_name LIKE '%ct%';    -- contains 'ct'

SELECT * FROM department WHERE dept_name LIKE '%tech%';  -- contains 'tech'

SELECT * FROM department WHERE dept_name LIKE '_e%';     -- second letter is 'e'
