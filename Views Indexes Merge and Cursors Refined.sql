-- 1
CREATE View_StudentGrades AS
SELECT 
    s.St_Fname + ' ' + s.St_Lname AS FullName,
    c.Crs_Name,
    sc.Grade
FROM 
    Student s
JOIN 
    Stud_Course sc ON s.St_Id = sc.St_Id
JOIN 
    Course c ON sc.Crs_Id = c.Crs_Id
WHERE 
    sc.Grade > 50;

SELECT * FROM View_StudentGrades;

-- 2
CREATE VIEW Encrypted_ManagerTopics
WITH ENCRYPTION
AS
SELECT 
    d.Dept_Manager AS ManagerName,
    t.Top_Name AS TopicName
FROM 
    Department d
JOIN 
    Instructor i ON d.Dept_Id = i.Dept_Id
JOIN 
    Ins_Course ic ON i.Ins_Id = ic.Ins_Id
JOIN 
    Course c ON ic.Crs_Id = c.Crs_Id
JOIN 
    Topic t ON c.Top_Id = t.Top_Id;

SELECT * FROM Encrypted_ManagerTopics;

-- 3
CREATE VIEW View_SpecificDepartments AS
SELECT 
    i.Ins_Name,
    d.Dept_Name
FROM 
    Instructor i
JOIN 
    Department d ON i.Dept_Id = d.Dept_Id
WHERE 
    d.Dept_Name IN ('SD', 'Java');

SELECT * FROM View_SpecificDepartments;

-- 4 
CREATE VIEW V1 AS
SELECT *
FROM Student
WHERE St_Address IN ('Alex', 'Cairo')
WITH CHECK OPTION;
-- Student originally from Cairo, changing age — allowed
UPDATE V1 SET St_Age = 25 WHERE St_Id = 1;
Update V1 set st_address=’tanta’
Where st_address=’alex’;


SELECT * FROM V1;

-- 5. View: Project (Course) name and number of employees (Instructors)
CREATE OR ALTER VIEW View_ProjectEmployees AS
SELECT 
    c.Crs_Name AS ProjectName,
    COUNT(ic.Ins_Id) AS NumOfEmployees
FROM 
    Ins_Course ic
JOIN 
    Course c ON ic.Crs_Id = c.Crs_Id
GROUP BY 
    c.Crs_Name;

-- 6. Clustered Index on Manager_hiredate
IF EXISTS (
    SELECT name 
    FROM sys.indexes 
    WHERE name = 'idx_ManagerHireDate' AND object_id = OBJECT_ID('Department')
)
    DROP INDEX idx_ManagerHireDate ON Department;
GO
CREATE CLUSTERED INDEX idx_ManagerHireDate
ON Department(Manager_hiredate);

-- 7. Unique Index on Student Age
IF EXISTS (
    SELECT name 
    FROM sys.indexes 
    WHERE name = 'idx_UniqueAge' AND object_id = OBJECT_ID('Student')
)
    DROP INDEX idx_UniqueAge ON Student;
GO
CREATE UNIQUE INDEX idx_UniqueAge
ON Student(St_Age);

-- 8. MERGE statement template (edit table names as needed)
-- MERGE Transaction_Current AS Target
-- USING Transaction_New AS Source
-- ON Target.User_ID = Source.User_ID
-- WHEN MATCHED THEN
--     UPDATE SET Target.Transaction_Amount = Source.Transaction_Amount
-- WHEN NOT MATCHED BY TARGET THEN
--     INSERT (User_ID, Transaction_Amount)
--     VALUES (Source.User_ID, Source.Transaction_Amount);

-- ========================================
-- Test Queries (Run the Views)
-- ========================================

-- Test 1: View_StudentGrades


-- Test 2: Encrypted_ManagerTopics
SELECT * FROM Encrypted_ManagerTopics;

-- Test 3: View_SpecificDepartments
SELECT * FROM View_SpecificDepartments;

-- Test 4: V1
SELECT * FROM V1;

-- Test 5: View_ProjectEmployees
SELECT * FROM View_ProjectEmployees;

-- Test Trigger (should raise an error!)
-- UPDATE V1 SET St_Address = 'Tanta' WHERE St_Address = 'Alex';
