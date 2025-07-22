create table Department (
DeptNo varchar(10) primary key ,
DeptName varchar(20),
Location varchar(20)
)

create rule locR1 as @x IN ('NY', 'DS', 'KW')
create default locD1 as 'NY'

sp_addtype loc , 'nchar(2)'
sp_bindrule locR1 , loc
sp_bindefault locD1 , loc 

alter table Department 
alter COLUMN Location loc


insert into Department 
values
('d1' , 'Research' , 'NY'),
('d2' , 'Accounting' , 'DS'),
('d3' , 'Research' , 'KW')

-------------------------------------------------------


create table Employee (
EmpNo INT primary key ,
EmpFname varchar(20) not null,
EmpLname varchar(20) not null,
DeptNo varchar(10),
Salary int Unique 
constraint empDep_FK foreign key(DeptNo) references Department(DeptNo)
)


create rule empSalary as @x < 6000

sp_bindrule empSalary , 'Employee.Salary'



insert into Employee 
values
( 25348 , 'Mathew' , 'Smith' , 'd3' , 2500),
( 10102 , 'Ann' , 'Jones' , 'd3' , 3000),
( 18316 , 'John' , 'Barrimore' , 'd1' , 2400 ),
( 29346 , 'James' , 'James' , 'd2' , 2800),
( 9031 , 'Lisa' , 'Bertoni' , 'd2' , 4000),
( 2581 , 'Elisa' , 'Hansel' , 'd2' , 3600),
( 28559 , 'Sybl' , 'Moser' , 'd1' , 2900)

---------------------------------------------------------------
---- 1-Add new employee with EmpNo =11111 In the works_on table [what will happen]
insert into works_on (EmpNo , ProjectNo) values (11111,'p1')


----- 2-Change the employee number 10102  to 11111  in the works on table [what will happen]

update works_on set EmpNo = 11111 where EmpNo=10102



----3-Modify the employee number 10102 in the employee table to 22222. [what will happen]

update Employee set EmpNo = 22222 where EmpNo=10102


---- 4-Delete the employee with id 10102

Delete from Employee where EmpNo = 10102 



-----------------------------------------------------------------------------------


--1-Add  TelephoneNumber column to the employee table[programmatically]
alter table employee
add TelephoneNumber int

---2-drop this column[programmatically]

alter table employee
drop COLUMN TelephoneNumber



--------------------------------------------------------------------------------------
--2--
create schema Company

alter schema Company transfer Department

create schema Human_Resource

alter schema Human_Resource transfer Employee
--------------------------------------------------------------------------------------
----3.Write query to display the constraints for the Employee table.


select tc.CONSTRAINT_NAME, tc.CONSTRAINT_TYPE
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS as tc
where tc.TABLE_NAME = 'Employee'

--------------------------------------------------------------------------------------
---- 4.	Create Synonym for table Employee as Emp and then run the following queries and describe the results


create synonym Emp for Human_Resource.Employee
Select * from Employee
Select * from Human_Resource.Employee
Select * from Emp
Select * from Human_Resource.Emp


--------------------------------------------------------------------------------------
-- 5 --Increase the budget of the project where the manager number is 10102 by 10%.

update Company.Project set Budget = Budget*1.1
 where ProjectNo = (select ProjectNo from Works_on where EmpNo = 10102 AND Job = 'Manager')


---------------------------------------------------------------------------------------

-- 6.Change the name of the department for which the employee named James works.The new department name is Sales.

update Company.Department set DeptName = 'Sales' 
where DeptNo = (select DeptNo from Human_Resource.Employee where EmpFname = 'James')


-------------------------------------------------------------------------------------------
--- 7.	Change the enter date for the projects for those 
---     employees who work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007

update works_on set Enter_Date = '12.12.2007' where ProjectNo = 'p1' and 
EmpNo in (SELECT E.EmpNo from Human_Resource.Employee E 
			join company.Department D on E.DeptNo = D.DeptNo
			where D.DeptName = 'Sales' )



--------------------------------------------------------------------------------------------

---8.Delete the information in the works_on table for all employees who work for the department located in KW

Delete from works_on 
where EmpNo in (select EmpNo from [Human_Resource].[Employee] e join Company.Department d on e.DeptNo = d.DeptNo
where d.Location = 'KW'
 )



------------------------------------------------------------------------------------------------

