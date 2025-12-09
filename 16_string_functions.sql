-- Switch to practice database
USE practice2;

-- View employee table
SELECT * FROM employee;

-- =========================
-- LENGTH function
-- =========================
SELECT LENGTH('divyesh');

SELECT 
    emp_name, 
    LENGTH(emp_name) AS name_length
FROM employee;

-- =========================
-- UPPER function
-- =========================
SELECT UPPER('divyesh');

SELECT 
    emp_name, 
    UPPER(emp_name) AS upper_name
FROM employee;

-- =========================
-- LOWER function
-- =========================
SELECT LOWER('Divyesh');

SELECT 
    emp_name, 
    LOWER(emp_name) AS lower_name
FROM employee;

-- =========================
-- TRIM functions
-- =========================
SELECT TRIM('      divu      ');

SELECT 
    emp_name, 
    TRIM(emp_name) AS trimmed_name
FROM employee;

SELECT LTRIM('      divu      ');
SELECT RTRIM('      divu      ');

-- =========================
-- LEFT & RIGHT functions
-- =========================
SELECT LEFT('Divyesh', 4);

SELECT 
    emp_name, 
    LEFT(emp_name, 4) AS left_characters
FROM employee;

SELECT RIGHT('Divyesh', 4);

SELECT 
    emp_name, 
    RIGHT(emp_name, 4) AS right_characters
FROM employee;

-- =========================
-- SUBSTRING function
-- =========================
SELECT SUBSTRING('Divyesh', 2, 3);

SELECT 
    emp_name, 
    SUBSTRING(emp_name, 2, 4) AS substring_name
FROM employee;

-- =========================
-- LOCATE function
-- =========================
SELECT LOCATE('y', 'Divyesh');

SELECT 
    emp_name, 
    LOCATE('an', emp_name) AS position_found
FROM employee;

-- =========================
-- CONCAT function
-- =========================
SELECT CONCAT('Divyesh', ' Gandhi');
