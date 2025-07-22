--1 
CREATE FUNCTION month_name(@date date)
	RETURNS VARCHAR(20) as 
	BEGIN 
		RETURN DATENAME(MONTH, @date) 
	END 
	 
SELECT dbo.month_name('1-18-2000');
 
--2
CREATE FUNCTION inbetween(@first INT,@second INT) 
RETURNS @final TABLE (number INT) AS 
BEGIN 
	DECLARE @i INT = @first +1 
	WHILE @i<@second 
		BEGIN 
			INSERT INTO @final VALUES(@i) 
			SET @i += 1 
		END 
	RETURN 
END 
 
SELECT * FROM dbo.inbetween(3,8) 
 
--3 
CREATE FUNCTION stud_dept(@id INT) 
RETURNS TABLE AS  
RETURN(SELECT S.st_fname + ' ' + S.St_Lname AS Full_name,  
		D.Dept_Name FROM Student S  
		inner join Department D ON s.Dept_Id = D.Dept_Id  
		WHERE s.St_Id = @id  
) 
 
SELECT * FROM stud_dept(1)
 
--4
CREATE FUNCTION check_name(@id INT)
RETURNS VARCHAR(50) AS
BEGIN
	DECLARE @Fname VARCHAR(50), @Lname VARCHAR(50), @Message VARCHAR(50)
    SELECT @Fname = St_Fname, @Lname = St_Lname FROM Student WHERE St_Id = @id
    IF @Fname is NULL and @Lname is NULL
        SET @Message = 'First name & last name are null'
    ELSE IF @Fname is NULL
        SET @Message = 'first name is null'
    ELSE IF @Lname is NULL
        SET @Message = 'last name is null'
    ELSE
        SET @Message = 'First name & last name are not null'
    RETURN @Message
END
 
SELECT dbo.check_name(1)
SELECT dbo.check_name(13)
SELECT dbo.check_name(14)
 
--5
CREATE FUNCTION manager(@id int)
RETURNS TABLE AS  
RETURN(SELECT D.Dept_Name, I.Ins_Name AS Manager_Name, D.Manager_hiredate
		FROM Department D inner join Instructor I 
		ON D.Dept_Manager = I.Ins_Id
		WHERE D.Dept_Manager = @id
) 
 
SELECT * FROM manager(2); 
 
--6
CREATE FUNCTION get_name(@need varchar(50))
RETURNS @final TABLE(NAME VARCHAR(50)) as
BEGIN
	IF @need ='first name'
		INSERT INTO @final SELECT isnull(st_fname,' ') FROM Student
	ELSE IF @need = 'last name'
		INSERT INTO @final SELECT isnull(St_Lname,' ') FROM Student
	ELSE IF @need = 'full name'
		INSERT INTO @final select isnull(St_fname,' ') +' '+ isnull(St_Lname,' ') from Student
	RETURN
END
 
SELECT * FROM get_name('full name')
SELECT * FROM get_name('first name')
SELECT * FROM get_name('last name')
 
--7
SELECT St_Id,substring(st_fname,1,len(st_fname)-1)
FROM Student
 
--8 24 Rows affected
DELETE SC  
FROM Stud_Course SC 
inner join Student S ON SC.St_Id = S.St_Id
inner join Department D ON S.Dept_Id = D.Dept_Id
WHERE D.Dept_Name = 'SD'
