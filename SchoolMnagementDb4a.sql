USE [SchoolManagementDb]

GO

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
