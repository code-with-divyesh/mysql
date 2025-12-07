USE set2;

-- =========================
-- LEFT JOIN
-- =========================

/*
LEFT JOIN:
The LEFT JOIN keyword returns:
- ALL records from the LEFT table
- Matching records from the RIGHT table
- If no match exists in the right table → NULL is returned

LEFT JOIN Syntax:

SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name = table2.column_name;
*/

-- -----------------------------------------
-- Example 1:
-- department is LEFT table
-- employee is RIGHT table
-- -----------------------------------------
-- This query returns:
-- • All departments
-- • Employees if they belong to that department
-- • NULL for departments with no employees

SELECT
    d.dept_no,
    d.dept_name,
    e.emp_name
FROM department d
LEFT JOIN employee e
ON d.dept_no = e.dept_no;

-- -----------------------------------------
-- Example 2:
-- employee is LEFT table
-- department is RIGHT table
-- -----------------------------------------
-- This query returns:
-- • All employees
-- • Their department details if available
-- • NULL where department information is missing

SELECT
    d.dept_no,
    d.dept_name,
    e.emp_name
FROM employee e
LEFT JOIN department d
ON d.dept_no = e.dept_no;
