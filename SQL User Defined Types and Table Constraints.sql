--Create a new user data type 
USE SD

CREATE RULE rule_loc
AS @loc IN ('NY', 'DS', 'KW');

sp_addtype loc ,'nchar(2)';

CREATE DEFAULT loc1 AS 'NY';

sp_bindrule rule_loc,loc;

sp_bindefault loc1,loc 

--Create it by code Department
CREATE TABLE Department (
deptno VARCHAR(5) primary key ,
deptName VARCHAR(50),
location loc );

-- Insert Data in Department Table
INSERT INTO Department 
VALUES
('d1' , 'Research' , 'NY'),
('d2' , 'Accounting' , 'DS'),
('d3' , 'Research' , 'KW')

--CREATE EMPLOYEE TABLE
CREATE TABLE Employee(
EmpNo INT PRIMARY KEY,
Emp_Fname VARCHAR(50) NOT NULL,
Emp_Lname VARCHAR(50) NOT NULL,
DeptNo VARCHAR(5) FOREIGN KEY REFERENCES Department(deptNo),
salary INT UNIQUE );

CREATE RULE r1 AS @x <6000

sp_bindrule r1, 'Employee.salary'

INSERT INTO Employee
VALUES
('25348' , 'Mathew' , 'Smith','d3','2500'),
('10102' , 'Ann' , 'Jones','d3','3000'),
('18316' , 'John' , 'Barrimore','d1','2400');

