-- Calculate the count of all grades per Teacher in the system

Select  T.FirstName  as FirstName , T.LastName as LastName ,SUM(Grade) as Grades
FROM dbo.Teacher as T
inner join dbo.[Grade] as G ON G.TeacherID = T.ID 
GROUP BY   T.FirstName,T.LastName

-- Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
Select  T.FirstName  as FirstName , T.LastName as LastName ,SUM(Grade) as Grades
FROM dbo.Teacher as T
inner join dbo.Grade as G ON G.TeacherID = T.ID 
inner join dbo.Student as S ON S.ID = G.StudentID
WHERE S.ID <=100 
GROUP BY   T.FirstName,T.LastName

-- Find the Maximal Grade, and the Average Grade per Student on all grades in the system

Select S.FirstName as StudentFirstName , S.LastName as StudentLastName ,MAX(Grade) as MaximalGrade,AVG(Grade) as AverageGrade
FROM dbo.[Grade] as G
inner join dbo.Student as S ON S.ID = G.StudentID
GROUP BY S.FirstName , S.LastName 

-- Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200

Select T.FirstName as TeacherFirstName , T.LastName as TeacherLastName , SUM(Grade) as AllGrades
FROM dbo.[Grade] as G
inner join dbo.Teacher as T ON T.Id = g.TeacherID
GROUP BY T.FirstName, T.LastName,G.Grade
HAVING SUM(Grade) > 200


-- Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system.Filter only records where Maximal Grade is equal to Average Grade

SELECT S.FirstName,S.LastName,MAX(Grade) as MaximalGrade,AVG(Grade) as AverageGrade
FROM dbo.Grade as G
INNER JOIN dbo.Student as S ON S.ID = G.StudentID
GROUP BY S.FirstName,S.LastName
HAVING SUM(Grade) = AVG(Grade)


-- List Student First Name and Last Name next to the other details from previous query
--Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student

CREATE VIEW dbo.vv_StudentGrades
AS 
SELECT Student.ID As StudentID
FROM dbo.Student
GROUP BY Student.ID

Select * from dbo.vv_StudentGrades

ALTER VIEW dbo.vv_StudentGrades
AS
SELECT S.ID AS StudentId , G.Grade AS CountGrade
FROM
dbo.Grade as G
inner join dbo.Student as S ON S.ID = G.StudentID
GROUP BY S.ID , G.Grade

Select * from dbo.vv_StudentGrades


--Change the view to show Student First and Last Names instead of StudentID

ALTER VIEW dbo.vv_StudentGrades
AS
SELECT s.ID, COUNT (*) as TotalGrades
FROM
dbo.Grade as G
inner join dbo.Student as S ON S.ID = g.StudentID 
GROUP BY s.ID,G.StudentID

Select * from dbo.vv_StudentGrades


--List all rows from view ordered by biggest Grade Count

 SELECT * FROM dbo.vv_StudentGrades
 ORDER BY GradeCount DESC
