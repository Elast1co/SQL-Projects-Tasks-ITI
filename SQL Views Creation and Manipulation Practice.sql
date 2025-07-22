--1--
create view v_clerk as
select EmpNo, ProjectNo, Enter_Date
from Works_on
where Job = 'Clerk';

select * from v_clerk;

--2--
create view v_without_budget as
select * from company.Project 
where Budget is null;

select * from dbo.v_without_budget;

--3--
create view v_count as 
select P.ProjectName, count(W.Job) as jobs
from company.Project P 
inner join Works_on W 
on P.ProjectNo = W.ProjectNo
group by P.ProjectName;

select * from dbo.v_count;

--4--
create view v_project_p2 as
select empno from v_clerk where ProjectNo = 'p2';

select * from v_project_p2;

--5--
alter view v_without_budget as
select * from company.Project 
where ProjectNo in ('p1', 'p2');

select * from dbo.v_without_budget;

--6--
drop view v_clerk;
drop view v_count;

--7--
create view v_emps_lname as
select EmpNo, Emp_Lname
from HR.Employee
where DeptNo = 'd2';

select * from dbo.v_emps_lname;

--8--
select Emp_Lname
from dbo.v_emps_lname
where Emp_Lname like '%J%';

--9--
create view v_dept as
select DeptNo, DeptName from company.Department;

select * from dbo.v_dept;

--10--
insert into v_dept (DeptNo, DeptName)
values ('d4', 'Development');

--11--
create view v_2006_check as
select EmpNo, ProjectNo, Enter_Date from Works_on
where Enter_Date between '2006-01-01' and '2006-12-31';

select * from v_2006_check;

