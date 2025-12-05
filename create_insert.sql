use departments;
CREATE TABLE department(
dept_no INT PRIMARY KEY AUTO_INCREMENT,
dept_name VARCHAR(10),
dept_code VARCHAR(10),
manager_id int,
location varchar(100)
);

insert into DEPARTMENT values (10, 'Account',"Act01",01, 'NY');
 insert into DEPARTMENT values(20, 'HR',"Hr01",01, 'NY');
insert into DEPARTMENT values(30, 'Production',"p01",01, 'DL'); 
insert into DEPARTMENT values(40, 'Sales',"sales01",01, 'NY');
 insert into DEPARTMENT values(50, 'EDP',"edp01",01, 'MU');
 insert into DEPARTMENT values(60, 'TRG',"trg01",01, 'rj');
insert into DEPARTMENT values(110, 'RND',"rnd01",01, 'AH'); 
