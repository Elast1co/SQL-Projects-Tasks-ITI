--1 
GO
CREATE VIEW View_StudentGrades AS 
SELECT  
    s.St_Fname + ' ' + s.St_Lname AS FullName, 
    c.Crs_Name 
FROM  
    Student s 
JOIN  
    Stud_Course sc ON s.St_Id = sc.St_Id 
JOIN  
    Course c ON sc.Crs_Id = c.Crs_Id 
WHERE
    sc.Grade > 50; 
GO

SELECT * FROM View_StudentGrades 

--2
GO
CREATE VIEW mangers_topics
WITH ENCRYPTION
AS
SELECT I.Ins_Name AS ManagerName,T.Top_Name AS TopicName
FROM Instructor I
inner join Department D ON I.Ins_Id = D.Dept_Manager
inner join Ins_Course IC ON IC.Ins_Id = I.Ins_Id
inner join Course C ON C.Crs_Id = IC.Crs_Id
inner join Topic T ON T.Top_Id = C.Top_Id;
GO

SELECT * FROM mangers_topics;
	 
--3 
CREATE VIEW inst_dept(Instructor,Department) AS
SELECT I.Ins_Name, D.Dept_Name
FROM Instructor I
inner join Department D on I.Dept_Id = D.Dept_Id
WHERE D.Dept_Name in ('SD', 'Java');

SELECT * FROM inst_dept;

--4 
CREATE VIEW V1 AS
SELECT *
FROM Student
WHERE St_Address in ('Alex', 'Cairo')
WITH CHECK OPTION;

SELECT * FROM V1;

Update V1 SET st_address='tanta'
WHERE st_address='alex';


--5 HERE WE RUN ON ( SD ) DATABASE
GO

CREATE VIEW Project_details AS
SELECT P.ProjectName,COUNT(W.EmpNo) AS EmployeeCount
FROM company.Project P
inner join Works_on W ON P.ProjectNo = W.ProjectNo
GROUP BY P.ProjectName;

GO

SELECT * FROM Project_details;

--6 Error / because department already has his own clustered index (Primary key)
CREATE CLUSTERED INDEX index_ManagerHireDate
ON Department(Manager_hiredate);

--7 Error / Theres duplicated ages so the unique index is not going to work
CREATE UNIQUE INDEX idx_UniqueAge
ON Student(St_Age);

--8
CREATE TABLE Dailyt(Yid int,Yval int);
CREATE TABLE lastt(Xid int,Xval int);

Merge into dailyt as T
using lastt as S
on T.Yid = S.Xid
when Matched then
	update
		set T.Yval = S.Xval
when not matched then
    insert
    values(s.xid,s.xval);  

SELECT * FROM Dailyt;

--9
USE Company_SD

DECLARE c1 CURSOR
FOR SELECT salary FROM Employee
FOR update
DECLARE @sal INT
OPEN c1
FETCH c1 INTO @sal
while @@FETCH_STATUS=0
	BEGIN
		IF @sal>=3000
			update Employee
				SET Salary=@sal*1.20
			WHERE CURRENT OF c1
		ELSE IF @sal<3000
			update Employee
				SET Salary=@sal*1.10
			WHERE CURRENT OF c1
		FETCH c1 INTO @sal
	END
CLOSE c1
DEALLOCATE c1

--10
USE ITI

DECLARE c1 CURSOR
FOR SELECT D.Dept_Name, I.Ins_Name
FROM Instructor I inner join Department D ON I.Ins_Id = D.Dept_Manager
FOR READ only     
DECLARE @inst VARCHAR(20),@dept VARCHAR(20)
OPEN c1
FETCH c1 INTO @inst,@dept
WHILE @@FETCH_STATUS=0
	BEGIN
		SELECT @inst,@dept
        FETCH c1 INTO @inst,@dept
	END
CLOSE c1
DEALLOCATE c1

--11
DECLARE c1 CURSOR
FOR SELECT st_fname FROM Student WHERE st_fname is not null
FOR READ only
DECLARE @name VARCHAR(20),@all_names VARCHAR(300)=''
OPEN c1
FETCH c1 INTO @name  
WHILE @@FETCH_STATUS=0
	BEGIN
		SET @all_names=CONCAT(@all_names,',',@name)
		FETCH c1 INTO @name 
	END
SELECT @all_names
CLOSE c1
DEALLOCATE c1
