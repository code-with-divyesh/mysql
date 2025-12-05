USE departments;

-- ============================================================
-- UPDATE Statement
-- ============================================================
-- The UPDATE statement is used to modify existing records 
-- in a table.
--
-- Syntax:
-- UPDATE table_name
-- SET column1 = value1, column2 = value2, ...
-- WHERE condition;
-- (Always use a WHERE clause to avoid updating all rows)
-- ============================================================

SELECT * FROM department;

-- Update the location for a specific department
UPDATE department 
SET location = 'mp' 
WHERE dept_no = 20;

SELECT * FROM department;

-- ============================================================
-- Updating Multiple Records
-- ============================================================
-- When Safe Update Mode is enabled, MySQL may block updates 
-- without a key column in the WHERE clause.
-- To allow such updates temporarily, disable safe updates:
--
-- SET SQL_SAFE_UPDATES = 0;
-- ============================================================

SET SQL_SAFE_UPDATES = 0;

UPDATE department 
SET manager_id = 21 
WHERE location = 'mp';

SELECT * FROM department;

-- ============================================================
-- DELETE Statement
-- ============================================================
-- The DELETE statement is used to remove existing records 
-- from a table.
--
-- Syntax:
-- DELETE FROM table_name WHERE condition;
-- (Avoid using DELETE without a WHERE clause)
-- ============================================================

-- Delete rows where location has a NULL value
DELETE FROM department 
WHERE location IS NULL;

SELECT * FROM department;
