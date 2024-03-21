/*
	3rd sheet of MS SQL Server Masterclass
	Joins
	Distinct
	GroupBy
*/

USE SchoolManagementDb

SELECT * FROM Students
SELECT * FROM ProgrammeOfStudy

SELECT * FROM Students
INNER JOIN ProgrammeOfStudy ON Students.ProgrammeOfStudyId = ProgrammeOfStudy.Id

SELECT Classes.Time [Class Time],
	   Lectures.FirstName + Lectures.LastName [Lecturer],
	   Courses.Name [Course Name]
FROM Classes
	INNER JOIN Lectures 
		ON Classes.LecturerId = Lectures.Id
	INNER JOIN Courses 
		ON Classes.CourseId = Courses.Id

SELECT * FROM Classes
LEFT JOIN Lectures ON Classes.LecturerId = Lectures.Id

SELECT * FROM Classes
RIGHT JOIN Lectures ON Classes.LecturerId = Lectures.Id

SELECT * FROM Classes
FULL JOIN Lectures ON Classes.LecturerId = Lectures.Id

SELECT * FROM Classes CROSS JOIN Lectures


INSERT Enrollments(StudentId, CourseId)
			VALUES(1, 2),
				  (5, 1),
				  (2, 3)


SELECT * FROM Enrollments
SELECT * FROM Classes
SELECT * FROM Courses

SELECT * FROM Students

-- Distinct
SELECT DISTINCT * FROM Enrollments

SELECT DISTINCT Enrollments.StudentId,
				Students.FirstName + Students.LastName [Student Name]
	FROM Enrollments
INNER JOIN Students ON Students.Id = Enrollments.StudentId

--Group By
SELECT CourseId, Courses.Code, Courses.Name FROM Classes
INNER JOIN Courses ON Courses.Id = Classes.CourseId
GROUP BY CourseId, Courses.Code, Courses.Name

--SQL COUNT.Aggregate Function
SELECT COUNT(Id) [Number of Students] FROM Students

SELECT Students.StudentId,
	   Students.FirstName + Students.LastName,
	COUNT(Students.StudentId) [Students Enrolled]
	FROM Enrollments
	INNER JOIN Students ON Students.Id = Enrollments.StudentId
	GROUP BY Students.StudentId, Students.FirstName + Students.LastName

--SQL AVG(Average) Aggregate Fnction
SELECT StudentId,
		AVG(Grade),
		COUNT(GRADE)
	FROM Enrollments
	GROUP BY StudentId, Grade

SELECT s.FirstName + ' ' + s.LastName,
		AVG(Grade) GradeAVG,
		COUNT(Grade) GradeCOUNT
	FROM Enrollments e
	INNER JOIN Students s ON s.Id = e.StudentId
	GROUP BY s.FirstName + ' ' + s.LastName, Grade


--SQL MAX and MIN Aggregate Function
SELECT s.FirstName + s.LastName,
		MIN(Grade) LowGrade,
		MAX(Grade) HigGrade
	FROM Enrollments e
	LEFT JOIN Students s ON s.Id = e.StudentId
	GROUP BY s.FirstName + s.LastName


SELECT	COUNT(Id) [Total Students],
		AVG(Grade) [Avg Grade],
		MIN(Grade) [Min Grade],
		MAX(Grade) [MAX Grade]
	FROM Enrollments
	WHERE CourseId = 1


--SQL SUM Aggregate Function
SELECT s.Id,
		s.FirstName + ' ' + s.LastName,
		AVG(Grade) [AVG Grade],
		SUM(Grade) [SUM Grade]
	FROM Enrollments e
	INNER JOIN Classes c ON c.Id = e.CourseId	
	INNER JOIN Students s ON s.Id = e.StudentId
	GROUP BY s.Id, s.FirstName + ' ' + s.LastName, Grade

--Filtering Having on Aggregate VAlues
SELECT st.Id,
		st.FirstName + ' ' +st.LastName,
		AVG(Grade) [AVG Grade],
		SUM(Grade) [SUM Grade]
	FROM Enrollments en
	INNER JOIN Classes cl ON cl.Id = en.CourseId
	INNER JOIN Students st ON st.Id = en.StudentId
	GROUP BY st.Id, st.FirstName + ' ' + st.LastName, en.Grade
	HAVING AVG([Grade]) > 50																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																									