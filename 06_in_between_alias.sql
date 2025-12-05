-- ============================================================
-- IN Operator
-- ============================================================
-- The IN operator allows specifying multiple values inside
-- a WHERE clause.
-- It is used as a shorthand for multiple OR conditions.
--
-- Syntax:
--   SELECT column_name(s)
--   FROM table_name
--   WHERE column_name IN (value1, value2, ...);
-- ============================================================

SELECT * FROM department 
WHERE location IN ('mp', 'ny', 'ah');

SELECT * FROM department 
WHERE location NOT IN ('mp', 'ny', 'ah');


-- ============================================================
-- BETWEEN Operator
-- ============================================================
-- The BETWEEN operator selects values within a given RANGE.
-- It is inclusive (both start and end values are included).
--
-- Syntax:
--   SELECT column_name(s)
--   FROM table_name
--   WHERE column_name BETWEEN value1 AND value2;
-- ============================================================

SELECT * FROM employee 
WHERE salary BETWEEN 50000 AND 72000;

SELECT * FROM employee 
WHERE salary NOT BETWEEN 50000 AND 72000;


-- ============================================================
-- Aliases (AS Keyword)
-- ============================================================
-- Aliases give temporary names to columns or tables.
-- They make query results more readable.
-- Aliases exist only for the duration of that query.
--
-- Column Alias Syntax:
--   SELECT column_name AS alias_name FROM table;
--
-- Table Alias Syntax:
--   SELECT column_name(s) FROM table_name AS alias_name;
-- ============================================================

SELECT department AS dept 
FROM employee;

SELECT * FROM employee AS emp;
