USE departments;

-- ============================================================
-- ORDER BY Clause
-- ============================================================
-- The ORDER BY clause is used to sort query results.
-- By default, sorting is done in ASCENDING (ASC) order.
-- To sort in DESCENDING order, use the DESC keyword.
--
-- Syntax:
-- SELECT column1, column2, ...
-- FROM table_name
-- ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ... ;
-- ============================================================

SELECT * FROM department ORDER BY location;

SELECT * FROM department ORDER BY location DESC;

SELECT * FROM department ORDER BY location, dept_no;

SELECT * FROM department ORDER BY location DESC, dept_no ASC;

-- ============================================================
-- NULL Checking
-- ============================================================
-- Use IS NULL to find rows where a column has no value.
--
-- Syntax:
-- SELECT column_names
-- FROM table_name
-- WHERE column_name IS NULL;
-- ============================================================

SELECT * FROM department WHERE location IS NULL;

-- ============================================================
-- NOT NULL Checking
-- ============================================================
-- Use IS NOT NULL to find rows where a column has some value.
--
-- Syntax:
-- SELECT column_names
-- FROM table_name
-- WHERE column_name IS NOT NULL;
-- ============================================================

SELECT * FROM department WHERE location IS NOT NULL;
