--1--
use ITI
create view student_course(full_name,course) as
select S.St_Fname + ' ' + S.St_Lname, C.Crs_name from Student S 
inner join Stud_Course SC on s.St_Id = sc.St_Id
inner join Course C on sc.Crs_Id = c.Crs_Id
where sc.Grade > 50;

select * from student_course;

--2--
create view manager_topic with ENCRYPTION as
select I.Ins_Name as ManagerName,T.Top_Name as TopicName
from Instructor I
inner join Department D on I.Ins_Id = D.Dept_Manager
inner join Ins_Course IC on IC.Ins_Id = I.Ins_Id
inner join Course C on C.Crs_Id = IC.Crs_Id
inner join Topic T on T.Top_Id = C.Top_Id;

select * from manager_topic;

--3--
create view inst_dept(Instructor,Department) as
select I.Ins_Name, D.Dept_Name
from Instructor I
inner join Department D on I.Dept_Id = D.Dept_Id
where D.Dept_Name in ('SD', 'Java');

select * from inst_dept;

--4--
create view V1 as
select *
from Student
where St_Address in ('Alex', 'Cairo')
WITH CHECK OPTION;

select * from V1;

Update V1 set st_address='tanta'
Where st_address='alex';

--5--
use SD
create view project_employee_count as
select P.ProjectName,COUNT(W.EmpNo) as EmployeeCount
from company.Project P
inner join Works_on W on P.ProjectNo = W.ProjectNo
group by P.ProjectName;

select * from project_employee_count;

--6--
use ITI
create clustered index index_Manager_hiredate
on Department (Manager_hiredate);

--7--
create unique index unique_student_age
on Student (St_Age);

--8--
create table Dailyt(Yid int,Yval int);
create table lastt(Xid int,Xval int);

Merge into dailyt as T
using lastt as S
on T.Yid = S.Xid
when Matched then
	update
		set T.Yval = S.Xval
when not matched then
    insert
    values(s.xid,s.xval);  

--9--
use Company_SD
declare c1 cursor
for select salary from Employee
for update
declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS=0
	begin
		if @sal>=3000
			update Employee
				set Salary=@sal*1.20
			where current of c1
		else if @sal<3000
			update Employee
				set Salary=@sal*1.10
			where current of c1
		fetch c1 into @sal
	end
close c1
deallocate c1

--10--
use ITI
declare c1 cursor
for select D.Dept_Name, I.Ins_Name
from Instructor I inner join Department D on I.Ins_Id = D.Dept_Manager
for read only     
declare @inst varchar(20),@dept varchar(20)
open c1
fetch c1 into @inst,@dept
while @@FETCH_STATUS=0
	begin
		select @inst,@dept
        fetch c1 into @inst,@dept
	end
close c1
deallocate c1

--11--
declare c1 cursor
for select st_fname from Student where st_fname is not null
for read only
declare @name varchar(20),@all_names varchar(300)=''
open c1
fetch c1 into @name  
while @@FETCH_STATUS=0
	begin
		set @all_names=CONCAT(@all_names,',',@name)
		fetch c1 into @name 
	end
select @all_names
close c1
deallocate c1