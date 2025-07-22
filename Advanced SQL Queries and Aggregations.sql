-- 1
SELECT COUNT(*) AS NumberOfStudentsWithAge 
FROM Student 
WHERE St_Age IS NOT NULL;  
 
-- 2
SELECT DISTINCT Ins_Name 
FROM Instructor; 
 
-- 3
SELECT  
    St_Id AS [Student ID], 
    ISNULL(St_Fname, '') + ' ' + ISNULL(St_Lname, '') AS [Student Full Name], 
    Department.Dept_Name AS [Department Name] 
FROM Student 
INNER JOIN Department ON Student.Dept_Id = Department.Dept_Id;
 
-- 4
SELECT  
    Ins_Name, 
    ISNULL(Department.Dept_Name, 'No Department') AS Dept_Name 
FROM Instructor 
LEFT JOIN Department ON Instructor.Dept_Id = Department.Dept_Id; 
 
-- 5
SELECT  
    St_Fname + ' ' + St_Lname AS [Student Full Name], 
    Crs_Name AS [Course Name] 
FROM Stud_Course 
JOIN Student ON Stud_Course.St_Id = Student.St_Id 
JOIN Course ON Stud_Course.Crs_Id = Course.Crs_Id 
WHERE Grade IS NOT NULL; 
 
-- 6
SELECT Top_Name,
   COUNT(Crs_Id) AS CourseCount 
   FROM Topic 
   LEFT JOIN Course ON Topic.Top_Id = Course.Top_Id 
   GROUP BY Top_Name;
    
-- 7 
SELECT  
    MAX(Salary) AS MaxSalary, 
    MIN(Salary) AS MinSalary 
FROM Instructor; 
 
-- 8 
SELECT * 
FROM Instructor 
WHERE Salary < (SELECT AVG(Salary) FROM Instructor); 
 
-- 9
SELECT Dept_Name 
FROM Department 
WHERE Dept_Id = ( 
    SELECT Dept_Id 
    FROM Instructor 
    WHERE Salary = (SELECT MIN(Salary) FROM Instructor) 
); 
 
-- 10 
SELECT DISTINCT TOP 2 Salary 
FROM Instructor 
ORDER BY Salary DESC; 
 
-- 11
SELECT  
    Ins_Name, 
    COALESCE(CAST(Salary AS VARCHAR), 'instructor bonus') AS SalaryOrBonus 
FROM Instructor; 
  
-- 12
SELECT AVG(Salary) AS AverageSalary 
FROM Instructor; 
 
-- 13
SELECT 
    S_1.St_Fname,
    S_2.*
FROM Student S_1
INNER JOIN. Student S_2 
ON S_1.Dept_Id = S_2.Dept_Id;
 
-- 14.
SELECT
       Dept_Id, 
       Salary
FROM (
    SELECT  
        Dept_Id, 
        Salary, 
        ROW_NUMBER() OVER (PARTITION BY Dept_Id ORDER BY Salary DESC) AS SalaryRank
    FROM Instructor 
    WHERE Salary IS NOT NULL
) AS RankedSalaries
WHERE SalaryRank <= 2;

 
-- 15. 
SELECT St_Id, 
       St_Fname, 
       St_Lname, 
       Dept_Id
FROM (
    SELECT  
        St_Id, 
        St_Fname, 
        St_Lname, 
        Dept_Id, 
        ROW_NUMBER() OVER (PARTITION BY Dept_Id ORDER BY NEWID()) AS rn 
    FROM Student
) AS NewTable
WHERE rn = 1 
  AND Dept_Id IS NOT NULL;



 