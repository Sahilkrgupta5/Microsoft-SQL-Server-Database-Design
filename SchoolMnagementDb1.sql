/*
	1st sheet of MS SQL Server Masterclass
	
	CRUD Oprations

	Create - INSERT INTO
	Read - SELECT * FROM
	Update - UPDATE
	Delete - DELETE
*/

USE master

--DROP DATABASE SchoolManagementDb

CREATE DATABASE SchoolManagementDb
GO

USE SchoolManagementDb

--DROP TABLE Students

	Id int PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE,
	StudentId NVARCHAR(10) UNIQUE,
	ProgrammeOfStudy NVARCHAR(50) NOT NULL
);

--DROP TABLE Lectures

CREATE TABLE Lectures (
	Id int PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE,
	StaffId NVARCHAR(10) UNIQUE
);

--DROP TABLE Courses

CREATE TABLE Courses(
	Id int PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	Credits int,
	Code NVARCHAR(5) UNIQUE
);

-- INSERT INTO TableName (Col1, Col2, Col3, Col4)
-- VALUES (Val1, Val2, Val3, Val4),
--		  (Val1, Val2, Val3, Val4)

-- INSERT INTO TableName VALUES (Val1, Val2, Val3, Val4)

INSERT INTO Lectures VALUES ('Sahil', 'Gupta', '1997-06-29', NULL)

INSERT INTO Lectures (FirstName, LastName, StaffId)
VALUES ('Test2', 'Two', '10110047'),
	   ('Test3', 'Three', '10110048'),
	   ('Test4', 'Four', '10110049')

SELECT * FROM Lectures

SELECT FirstName, LastName, StaffId FROM Lectures

SELECT * FROM Lectures WHERE Id = 3

SELECT * FROM Lectures WHERE StaffId = '10110048'

SELECT * FROM Lectures
	WHERE FirstName = 'Four' OR LastName = 'Four'

SELECT * FROM Lectures
	WHERE LastName LIKE 'T%'

SELECT * FROM Lectures
	WHERE LastName LIKE '%E'

SELECT * FROM Lectures
	WHERE LastName LIKE '%U%'

SELECT * FROM Courses

INSERT INTO Courses (Name, Credits, Code)
	VALUES ('Web Development', 3, 'WD101'),
		   ('C#', 4, 'CS101'),
		   ('.Net', 3, 'DN108')

SELECT * FROM Courses
	WHERE Credits <= 3

SELECT
      [FirstName]
      ,[LastName]
      ,[StaffId]
  FROM [SchoolManagementDb].[dbo].[Lectures]
  WHERE DateOfBirth IS NULL

SELECT
      [FirstName]
      ,[LastName]
	  ,[DateOfBirth]
      ,[StaffId]
	  ,CASE
	   WHEN DateOfBirth IS NULL THEN ' '
	   ELSE DateOfBirth
	  END EmptyDOB
  FROM [SchoolManagementDb].[dbo].[Lectures]

SELECT FirstName, LastName, 
	CASE
		WHEN DateOFBirth IS NULL THEN ''
		ELSE DateOFBirth
	END CheckDOB
	FROM Lecture

UPDATE Lectures SET DateOfBirth = '1990-01-01'
WHERE DateOfBirth IS NULL

DELETE FROM Lectures
	WHERE StaffId = 10110047

BEGIN TRANSACTION
	DELETE FROM Lectures


ROLLBACK

BEGIN TRANSACTION
	INSERT INTO Lectures(FirstName, LastName, DateOfBirth, StaffId)
				  VALUES('Nitish', 'Kumar', '2003-10-24', 10110050)

COMMIT