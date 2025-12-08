create database practice2;
use practice2;

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    gender VARCHAR(10),
    salary INT,
    age INT,
    dept_id INT,
    joining_date DATE,
    city VARCHAR(50),
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

INSERT INTO department (dept_id, dept_name, location) VALUES
(10, 'HR', 'Delhi'),
(20, 'Finance', 'Mumbai'),
(30, 'IT', 'Bangalore'),
(40, 'Sales', 'Pune'),
(50, 'Marketing', 'Delhi'),
(60, 'Support', NULL);

INSERT INTO employee (emp_id, emp_name, gender, salary, age, dept_id, joining_date, city) VALUES
(1, 'Amit Sharma', 'Male', 35000, 28, 10, '2022-01-15', 'Delhi'),
(2, 'Sneha Verma', 'Female', 55000, 32, 20, '2021-03-10', 'Mumbai'),
(3, 'Rahul Jain', 'Male', 72000, 25, 30, '2023-07-01', 'Bangalore'),
(4, 'Priya Singh', 'Female', 68000, 30, 30, '2020-11-20', 'Pune'),
(5, 'Karan Mehta', 'Male', 40000, 27, 40, '2022-09-05', 'Pune'),
(6, 'Meena Patel', 'Female', 90000, 38, 20, '2019-05-12', 'Mumbai'),
(7, 'Ravi Kumar', 'Male', 30000, 24, 10, '2023-02-18', 'Delhi'),
(8, 'Anjali Rao', 'Female', 48000, 29, 50, '2021-12-01', 'Delhi'),
(9, 'Suresh Nair', 'Male', 52000, 35, 40, '2018-08-23', 'Chennai'),
(10, 'Neha Gupta', 'Female', 61000, 31, 50, '2020-06-30', NULL),
(11, 'Vikas Joshi', 'Male', 45000, 34, NULL, '2022-04-14', 'Jaipur'),
(12, 'Pooja Shah', 'Female', 37000, 26, 60, '2023-01-10', 'Ahmedabad'),
(13, 'Rohit Agarwal', 'Male', 80000, 41, 30, '2017-10-05', 'Bangalore'),
(14, 'Sunita Malhotra', 'Female', 29000, 23, 10, '2023-09-01', 'Delhi'),
(15, 'Arjun Kapoor', 'Male', 60000, 36, 20, '2019-07-19', 'Mumbai');


-- 1.Select all records from employee table 

select * from employee;

-- 2.Select only emp_name and salary

select emp_name,salary from employee;

-- 3.Display all unique cities from employee

select distinct city from employee;

-- 4.Show employee names with salary greater than 40000

select emp_name from employee where salary>40000;

-- 5.Show employees whose age is less than 30

select emp_name from employee where age<30;

-- 6.Display employees working in dept_id = 20

select emp_name from employee where dept_id=20;

-- 7.Show employees ordered by salary (ascending)

select * from employee order by salary asc;

-- 8.Show employees ordered by salary (descending)

select * from employee order by salary desc;

-- 9.Show top 5 employees using LIMIT

select * from employee limit 5;

-- 10.Display employees who joined after 2022

select * from employee where joining_date > '2022-01-01';

-- 11.Find employees whose name starts with 'A'

select * from employee where emp_name like 'A%';

-- 12.Find employees whose name ends with 'a'

select * from employee where emp_name like '%a';

-- 13.Find employees whose name contains 'an'

select * from employee where emp_name like '%an%';

-- 14.Show employees working in dept_id IN (10, 20, 30)

select * from employee where dept_id in(10,20,30);

-- 15.Show employees whose salary BETWEEN 30000 and 60000

select * from employee where salary between 30000 and 60000;

-- 16. Show employees from cities IN ('Delhi', 'Mumbai')

select * from employee where city in('Delhi', 'Mumbai');

-- 17.Find employees whose age BETWEEN 25 and 35

select * from employee where age between 25 and 35;

-- 18.Show employees whose city is NOT Mumbai

SELECT * FROM employee WHERE city <> 'Mumbai';

-- 19.Display employees whose salary NOT IN (30000, 40000)

select * from employee where salary not in (30000,40000);

-- 20.Find employees whose name length is greater than 5

select * from employee where length(emp_name)>5;

-- 21. Find employees whose city is NULL

select * from employee where city is null;

-- 22 Find employees whose dept_id is NULL

select * from employee where dept_id is null;

-- 23 Update employee city where city IS NULL

SET SQL_SAFE_UPDATES = 0;
update employee set city="jaipur" where city is null;

-- 24.Delete employees whose dept_id IS NULL

delete from employee where dept_id is null;

-- 25.Increase salary by 5000 for all employees

update employee set salary=salary+5000;
select * from employee;

-- 26.Increase salary by 10% where salary < 40000

update employee set salary = salary * 1.10 where salary < 40000;
select * from employee;

-- 27.Update city to 'Pune' for employees in dept_id = 20

update employee set city="pune" where dept_id=20;
select * from employee;

-- 28.Delete employees whose age is greater than 60

delete from employee where age>60;
select * from employee;

-- 29.Delete employees whose salary < 25000

delete from employee where salary <25000;
select * from employee;

-- 30.Update department location to 'Bangalore' where dept_name = 'IT'

update department set location="Bangalore" where dept_name='it';
select * from department;

-- 31. Find minimum salary from employee table

select min(salary) from employee;

-- 32. Find maximum salary from employee table

select max(salary) from employee;

-- 33. Find average salary from employee table

select avg(salary) from employee;

-- 34.Find total salary paid to all employees

select sum(Salary) from employee;

-- 35.Count number of employees

select count(*) from employee;

-- 36.Count employees department-wise

select dept_id,count(*) from employee group by dept_id;

-- 37.Show department-wise average salary

select dept_id,avg(salary) from employee group by dept_id;

-- 38.Show department-wise total salary

select dept_id,sum(salary) from employee group by dept_id;

-- 39.Show department-wise employee count

select dept_id,count(*) from employee group by dept_id;

-- 40.Show departments having more than 2 employees

SELECT dept_id, COUNT(*) FROM employee GROUP BY dept_id HAVING COUNT(*) > 2;

-- 41.Show departments where average salary > 50000

SELECT dept_id FROM employee GROUP BY dept_id having avg(salary)>50000;

-- 42.Show city-wise employee count

select city,count(*) from employee group by city;

-- 43.Show gender-wise average salary

select gender,avg(salary) from employee group by gender;


-- 44.Display employee name with department name (INNER JOIN)

select e.emp_name,d.dept_name from employee e inner join department d 
on e.dept_id=d.dept_id;

-- 45.Display all departments with employees (LEFT JOIN)

select d.dept_name,e.emp_name from department d left join employee e 
on e.dept_id=d.dept_id;

-- 46.Display all employees with department details (RIGHT JOIN)

select d.dept_name,e.emp_name from department d right join employee e 
on e.dept_id=d.dept_id;


-- 47.Display departments with no employees

SELECT d.dept_name
FROM department d
LEFT JOIN employee e
ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;

-- 48.Show department-wise total salary using JOIN

SELECT d.dept_name, SUM(e.salary)
FROM department d
JOIN employee e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 49.Show employees working in 'HR' department

SELECT e.emp_name
FROM employee e
JOIN department d
ON e.dept_id = d.dept_id
WHERE d.dept_name = 'HR';

-- 50. Department-wise employee count (DESC)

SELECT d.dept_name, COUNT(e.emp_id) AS total_emp
FROM department d
LEFT JOIN employee e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY total_emp DESC;


