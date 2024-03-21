/*
	4th sheet of MS SQL Server Masterclass
	Create and Manage Views
*/

USE SchoolManagementDb

GO

CREATE VIEW ViewEnrollmentDetails AS
SELECT
		st.Id  AS StudentId,
		st.FirstName + ' ' + st.LastName AS StudentName,
		AVG(Grade) AVGgrade,
		MIN(Grade) MINgrade,
		MAX(Grade) MAXgrade,
		COUNT(Grade) Total
	FROM Enrollments en
	INNER JOIN Students st ON st.Id = en.StudentId
	GROUP BY st.Id, st.FirstName + ' ' + st.LastName, en.Grade

SELECT * FROM ViewEnrollmentDetails

--------------------------------------------------------------------
ALTER VIEW [dbo].[ViewClassCourseProgram] AS
SELECT
    dbo.Classes.CourseId AS ID,
    dbo.Courses.Name AS [Course Name],
    dbo.Courses.Code AS Code,
    dbo.Courses.Credits AS Credit,
    dbo.ProgrammeOfStudy.Name AS [Program Name]
FROM
    dbo.Classes
INNER JOIN
    dbo.Courses ON dbo.Classes.CourseId = dbo.Courses.Id
INNER JOIN
    dbo.ProgrammeOfStudy ON dbo.Courses.ProgrammeOfStudy = dbo.ProgrammeOfStudy.Id
GROUP BY
    dbo.Classes.CourseId, dbo.Courses.Name, dbo.Courses.Code, dbo.Courses.Credits, dbo.ProgrammeOfStudy.Name;

