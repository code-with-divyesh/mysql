-- Create database
CREATE DATABASE set2;

-- Use database
USE set2;

-- =========================
-- DEPARTMENT TABLE
-- =========================
CREATE TABLE department (
    dept_no INT PRIMARY KEY AUTO_INCREMENT,   -- Department Number (Primary Key)
    dept_name VARCHAR(10),                     -- Department Name
    dept_code VARCHAR(10),                     -- Department Code
    manager_id INT,                            -- Manager ID
    location VARCHAR(100)                      -- Department Location
);

-- Insert department records
INSERT INTO department VALUES (10, 'Account','Act01',01,'NY');
INSERT INTO department VALUES (20, 'HR','Hr01',01,'NY');
INSERT INTO department VALUES (30, 'Production','p01',01,'DL');
INSERT INTO department VALUES (40, 'Sales','sales01',01,'NY');
INSERT INTO department VALUES (50, 'EDP','edp01',01,'MU');
INSERT INTO department VALUES (60, 'TRG','trg01',01,'RJ');
INSERT INTO department VALUES (110,'RND','rnd01',01,'AH');
INSERT INTO department VALUES (130,'finance','fin01',01,'MP');
INSERT INTO department VALUES (140,'purchase','pur01',01,NULL);
INSERT INTO department VALUES (150,'Technical','tech01',01,'TP');

-- =========================
-- EMPLOYEE TABLE
-- =========================
CREATE TABLE employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,     -- Employee ID (Auto Increment)
    emp_name VARCHAR(30),                      -- Employee Name
    birth_date DATE,                           -- Date of Birth
    gender VARCHAR(10),                        -- Gender
    dept_no INT,                               -- Department Number (Foreign Key)
    address VARCHAR(100),                      -- Address
    designation ENUM('manager','clerk','leader','analyst','designer','coder','tester'),
    salary DECIMAL(6,1) CHECK (salary > 0),    -- Salary
    experience DECIMAL(4,1),                   -- Experience
    email VARCHAR(100) CHECK (email LIKE '%@%.%'),
    FOREIGN KEY (dept_no) REFERENCES department(dept_no)
);

-- View table structure
DESC department;
DESC employee;

-- Modify column definitions
ALTER TABLE employee MODIFY gender ENUM('male','female');
ALTER TABLE employee MODIFY salary DECIMAL(10,1);

-- =========================
-- INSERT EMPLOYEE DATA
-- =========================
INSERT INTO employee VALUES
(NULL,'Ramesh Kumar','1990-05-12','male',10,'NY','manager',75000.0,8.5,'ramesh@gmail.com');

INSERT INTO employee VALUES
(NULL,'Sita Sharma','1995-08-22','female',20,'NY','clerk',32000.0,3.0,'sita@yahoo.com');

INSERT INTO employee VALUES
(NULL,'Amit Verma','1988-02-10','male',30,'DL','leader',60000.0,10.0,'amit@outlook.com');

INSERT INTO employee VALUES
(NULL,'Neha Singh','1992-11-15','female',40,'NY','analyst',55000.0,6.5,'neha@gmail.com');

INSERT INTO employee VALUES
(NULL,'Rahul Mehta','1997-06-30','male',50,'MU','designer',45000.0,2.5,'rahul@gmail.com');

INSERT INTO employee VALUES
(NULL,'Pooja Patel','1994-09-18','female',60,'RJ','coder',40000.0,4.0,'pooja@yahoo.com');

INSERT INTO employee VALUES
(NULL,'Vikas Jain','1985-01-25','male',110,'AH','tester',52000.0,12.0,'vikas@gmail.com');

INSERT INTO employee VALUES
(NULL,'Anjali Rao','1996-03-05','female',130,'MP','analyst',48000.0,3.8,'anjali@outlook.com');

INSERT INTO employee VALUES
(NULL,'Suresh Nair','1989-07-19','male',140,'Pune','clerk',30000.0,7.0,'suresh@gmail.com');

INSERT INTO employee VALUES
(NULL,'Kiran Das','1993-12-01','male',150,'TP','coder',42000.0,5.2,'kiran@gmail.com');

-- =========================
-- BASIC SELECT QUERIES
-- =========================
SELECT * FROM employee;
SELECT * FROM department;

-- Order By
SELECT * FROM employee ORDER BY emp_id DESC;
SELECT * FROM department ORDER BY dept_no DESC;

-- =========================
-- DELETE OPERATIONS
-- =========================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM employee WHERE address = 'AH';
DELETE FROM employee WHERE gender = 'female';

-- =========================
-- FILTER QUERIES
-- =========================
SELECT emp_name, salary 
FROM employee 
WHERE salary BETWEEN 30000 AND 50000;

-- Reinsert deleted employee
INSERT INTO employee VALUES
(NULL,'Neha Singh','1992-11-15','female',40,'NY','analyst',55000.0,6.5,'neha@gmail.com');

-- =========================
-- UPDATE
-- =========================
UPDATE employee 
SET salary = salary + 1000 
WHERE salary > 50000;

-- =========================
-- LIMIT
-- =========================
SELECT * FROM employee LIMIT 2;

-- =========================
-- LIKE OPERATOR
-- =========================
SELECT * FROM employee WHERE emp_name LIKE 's%';
SELECT * FROM employee WHERE emp_name LIKE '%ahul%';
SELECT * FROM employee WHERE emp_name LIKE 'r%r';
SELECT * FROM employee WHERE emp_name LIKE '_m%';

-- =========================
-- IN & BETWEEN
-- =========================
SELECT * FROM employee WHERE address IN ('NY','MU','GU');
SELECT * FROM employee WHERE salary BETWEEN 35000 AND 65000;

-- =========================
-- AGGREGATE FUNCTIONS
-- =========================
SELECT MIN(salary) FROM employee;
SELECT MAX(salary) FROM employee;
SELECT COUNT(salary) FROM employee WHERE salary > 50000;
SELECT AVG(salary) FROM employee;
SELECT SUM(salary) FROM employee;

-- Subquery example
SELECT emp_name, salary 
FROM employee 
WHERE salary = (SELECT MIN(salary) FROM employee);

-- Aliasing example
select emp_name as e_name from employee;