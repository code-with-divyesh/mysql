USE set2;

-- =========================
-- RIGHT JOIN
-- =========================

/*
RIGHT JOIN:
The RIGHT JOIN keyword returns:
- ALL records from the RIGHT table
- Matching records from the LEFT table
- If no match exists in the left table → NULL is returned

RIGHT JOIN Syntax:

SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name = table2.column_name;
*/

-- -----------------------------------------
-- Example 1:
-- employee is RIGHT table
-- department is LEFT table
-- -----------------------------------------
-- This query returns:
-- • All employees
-- • Their department details if available
-- • NULL where department information is missing

SELECT
    d.dept_no,
    d.dept_name,
    e.emp_name
FROM department d
RIGHT JOIN employee e
ON d.dept_no = e.dept_no;

-- -----------------------------------------
-- Example 2:
-- department is RIGHT table
-- employee is LEFT table
-- -----------------------------------------
-- This query returns:
-- • All departments
-- • Employees belonging to departments (if any)
-- • NULL for departments without employees

SELECT
    d.dept_no,
    d.dept_name,
    e.emp_name
FROM employee e
RIGHT JOIN department d
ON d.dept_no = e.dept_no;
