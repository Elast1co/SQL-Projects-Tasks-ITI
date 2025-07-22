--1
GO
CREATE VIEW v_clerk
AS
SELECT EmpNo, ProjectNo, Enter_Date
FROM Works_on
WHERE Job = 'Clerk';
GO

SELECT * FROM v_clerk

--2
GO
CREATE VIEW v_without_budget
AS
SELECT * FROM company.Project 
WHERE Budget is null;
GO

SELECT * FROM dbo.v_without_budget

--3--
GO
CREATE VIEW v_count 
AS 
SELECT P.ProjectName, count(W.Job) as jobs
FROM company.Project P 
inner join Works_on W 
ON P.ProjectNo = W.ProjectNo
GROUP BY P.ProjectName;
GO

SELECT * FROM dbo.v_count;

--4
GO
CREATE VIEW v_project_p2
AS
SELECT empno FROM v_clerk
WHERE ProjectNo = 'p2';
GO

SELECT * FROM v_project_p2;

--5
GO
ALTER VIEW v_without_budget 
AS
SELECT * FROM company.Project 
WHERE ProjectNo in ('p1', 'p2');
GO

SELECT * FROM  dbo.v_without_budget;

--6--
DROP VIEW v_clerk;
DROP VIEW v_count;

--7
GO
CREATE VIEW v_emps_lname
AS
SELECT EmpNo, EmpLname
FROM Human_Resource.Employee
WHERE DeptNo = 'd2';
GO

SELECT * FROM dbo.v_emps_lname;

--8--
SELECT EmpLname
FROM dbo.v_emps_lname
WHERE EmpLname like '%J%';

--9
GO
CREATE VIEW v_dept
AS
SELECT DeptNo, DeptName FROM company.Department;
GO

SELECT * FROM dbo.v_dept;

--10
INSERT INTO v_dept (DeptNo, DeptName)
VALUES ('d4', 'Development');

--11--
GO
CREATE VIEW v_2006_check 
AS
SELECT EmpNo, ProjectNo, Enter_Date FROM Works_on
WHERE Enter_Date between '2006-01-01' and '2006-12-31';
GO

SELECT * FROM v_2006_check;

