--1--
create rule r1 as @x in('NY','DS','KW');
create default def1 as 'NY';

sp_addtype loc , 'nchar(2)';
sp_bindrule r1, loc;
sp_bindefault def1, loc;

create table Department (
DeptNo varchar(50) primary key,
DeptName varchar(50),
Location loc);


create table Employee(
EmpNo int primary key,
Emp_Fname varchar(50) not null,
Emp_Lname varchar(50) not null,
DeptNo varchar(50) foreign key references department(DeptNo),
salary int unique,
);

create rule r2 as @x < 6000;
sp_bindrule r2, 'Employee.salary';


insert into works_on VALUES(1111,'p1');
update works_on set empno = 11111 where empno = 10102;
update employee set empno = 22222 where empno = 10102;
delete from Employee where empno = 10102;

alter table employee add TelephoneNumber int;
alter table employee drop column TelephoneNumber;

--2--
create schema company;
alter schema company transfer department;

create schema HR;
alter schema HR transfer employee;

--3--
select tc.CONSTRAINT_NAME, tc.CONSTRAINT_TYPE
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS as tc
where tc.TABLE_NAME = 'Employee';

--4--
create synonym Emp for Employee;
select * from Employee;
select * from HR.Employee;
select * from Emp;
select * from HR.Emp;

--5--
update company.Project
set Budget = Budget * 1.1
where ProjectNo in (select ProjectNo from Works_on where EmpNo = 10102 and Job = 'Manager');

--6-- 
update company.department
set DeptName = 'Sales'
where DeptNo in (select DeptNo from HR.employee where emp_fname ='james')

--7--
update works_on
set enter_date = '12.12.2007'
where ProjectNo = 'p1' and 
EmpNo in (SELECT E.EmpNo from HR.Employee E 
			inner join company.Department D on E.DeptNo = D.DeptNo
			where D.DeptName = 'Sales' );

--8--
delete from Works_on
where EmpNo in (
    select e.EmpNo
    from HR.Employee e
    inner join company.Department d on e.DeptNo = d.DeptNo
    where d.Location = 'KW'
);








--select budget from company.project p inner join works_on w on p.projectno = w.projectno 
--where w.empno =10102 and w.job = 'manager';