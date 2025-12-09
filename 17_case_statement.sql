-- Switch to practice database
USE practice2;

-- =====================================================
-- CASE STATEMENT OVERVIEW
-- =====================================================
/*
The CASE statement evaluates conditions and returns a value
when the first condition is satisfied (similar to IF-ELSE).

If no conditions match and ELSE is not provided,
the result will be NULL.

Syntax:
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE result
END;
*/

-- =====================================================
-- Age Group Classification using CASE
-- =====================================================
SELECT 
    emp_id,
    emp_name,
    age,
    CASE
        WHEN age < 20 THEN 'Youth'
        WHEN age BETWEEN 20 AND 29 THEN 'Young Adults'
        WHEN age BETWEEN 30 AND 50 THEN 'Middle-aged Adults'
        ELSE 'Senior'
    END AS age_group
FROM employee;

-- =====================================================
-- Salary Group Classification using CASE
-- =====================================================
SELECT 
    emp_id,
    emp_name,
    salary,
    CASE
        WHEN salary < 30000 THEN 'Low Salary'
        WHEN salary BETWEEN 30000 AND 50000 THEN 'Medium Salary'
        WHEN salary BETWEEN 50001 AND 70000 THEN 'High Salary'
        ELSE 'Very High Salary'
    END AS salary_group
FROM employee;
