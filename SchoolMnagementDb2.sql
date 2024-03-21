/*
	2nd sheet of MS SQL Server Masterclass

*/
USE SchoolManagementDb

CREATE TABLE Classes (
	Id int PRIMARY KEY IDENTITY,
	LecturerId int FOREIGN KEY REFERENCES Lectures(Id),
	CourseId int FOREIGN KEY REFERENCES Courses(Id),
	[Time] time
)

CREATE TABLE Enrollments (
	Id int PRIMARY KEY IDENTITY,
	StudentId int FOREIGN KEY REFERENCES Students(Id),
	CourseId int FOREIGN KEY REFERENCES Courses(Id),
	Grade nvarchar(2)
)

SELECT * FROM ProgrammeOfStudy

INSERT INTO ProgrammeOfStudy (Id, Name, DurationInYears)
	VALUES(1,'Bsc in IT', 4.00),
		  (2, 'ASc in IT', 2)

SELECT * FROM Courses

UPDATE Courses
	SET ProgrammeOfStudy = 1
	WHERE Id < 3

SELECT * FROM Students

INSERT INTO Students ( FirstName, LastName, DateOfBirth, StudentId, ProgrammeOfStudyId)
	VALUES('Sofia', 'Khan', '2002-08-11', 'SK110802', 1),
		  ('Versha', 'Rai', '1997-08-02', 'VR020897', 1),
		  ('Rinki', 'Pandey', '1999-04-24', 'RP240499', NULL)

UPDATE Students
	SET ProgrammeOfStudyId = 2
	WHERE Id = 2

SELECT * FROM Lectures
SELECT * FROM Courses

SELECT * FROM Classes

INSERT INTO Classes
	VALUES(2, 1, '12:00'),
		  (1, 2, '10:30'),
		  (NULL, 2, '08:30'),
		  (NULL, 2, '11:00'),
		  (1, NULL, '09:30'),
		  (1, NULL, '07:30')