/* --------------------------------------------------------
   SELECT STATEMENT
   Purpose: Used to retrieve data from a database table
   Basic Syntax:
   SELECT column1, column2, ... FROM table_name;
---------------------------------------------------------*/


/*  
   Query 1:
   Select specific columns from a table
*/
SELECT dept_no, dept_name, location FROM department;


/*
   Query 2:
   Select all columns and all rows from the table
*/
SELECT * FROM department;


/*
   Query 3:
   Select only one specific column (location)
*/
SELECT location FROM department;


/*
   Query 4:
   Select only UNIQUE (non-duplicate) values from a column
*/
SELECT DISTINCT location FROM department;


/*
   Query 5:
   Count how many UNIQUE locations exist in the table
*/
SELECT COUNT(DISTINCT location) FROM department;



# --------------------------------------------------------
# SELECT WITH WHERE CLAUSE
# --------------------------------------------------------

/*
   WHERE CLAUSE:
   Used to filter records.
   It returns only those rows that satisfy a given condition.

   Syntax:
   SELECT column1, column2, ...
   FROM table_name
   WHERE condition;
*/


/*
   Query 6:
   Select all rows where location equals "NY"
*/
SELECT * FROM department WHERE location = "NY";


/*
   Query 7:
   Select rows where dept_no is exactly 10
*/
SELECT * FROM department WHERE dept_no = 10;


/*
   Query 8:
   Select rows where dept_no is greater than 20
*/
SELECT * FROM department WHERE dept_no > 20;


/*
   Query 9:
   Select rows where dept_no is less than 20
*/
SELECT * FROM department WHERE dept_no < 20;


/*
   Query 10:
   Select rows where dept_no is between 1 and 100 (inclusive)
*/
SELECT * FROM department 
WHERE dept_no >= 1 AND dept_no <= 100;


/*
   Query 11:
   Using OR — returns rows where dept_no = 10 OR dept_name = 'EDP'
*/
SELECT * FROM department 
WHERE dept_no = 10 OR dept_name = 'EDP';


/*
   Query 12:
   Using BETWEEN — selects values within the range 10 to 35
*/
SELECT * FROM department 
WHERE dept_no BETWEEN 10 AND 35;


/*
   Query 13:
   Using IN — matches any value in the list
*/
SELECT * FROM department 
WHERE location IN ('mu', 'Ah');
