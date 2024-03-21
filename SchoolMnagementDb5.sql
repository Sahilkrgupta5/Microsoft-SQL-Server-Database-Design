/*
	5th sheet of MS SQL Server Masterclass
	Function
	Return one value
*/

USE SchoolManagementDb

GO

SELECT GETDATE(), MONTH(GETDATE()), YEAR(GETDATE())

------------------------------------------------------
-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sahil Kumar Gupta
-- Create date: 07-01-2024
-- Description:	Get Student Higer Grade
-- =============================================
CREATE FUNCTION func_GetHighestGrede
(
	-- Add the parameters for the function here
	--<@Param1, sysname, @p1> <Data_Type_For_Param1, , int>
)
RETURNS decimal(3,1)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @HigestGrade decimal(3,1)

	-- Add the T-SQL statements to compute the return value here
	SELECT @HigestGrade = Max(Grade) From Enrollments

	-- Return the result of the function
	RETURN @HigestGrade

END
GO


SELECT [dbo].[func_GetHighestGrede]() AS [Higest Grade]

-----------------------------------------------------------
--Table Valued Functions

-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sahil Kumar Gupta
-- Create date: 07-01-2024
-- Description:	Get Student Grade Range
-- =============================================
CREATE FUNCTION func_GetGradeRange 
(	
	-- Add the parameters for the function here
	@minGrade decimal(3,1), 
	@maxGrade decimal(3,1)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT Grade, StudentId From Enrollments
	--WHERE Grade >= @minGrade and Grade <= @maxGrade
	WHERE Grade BETWEEN @minGrade AND @maxGrade
)
GO

----------------------------------------------------------------------
SELECT * FROM func_GetGradeRange(40, 80)
----------------------------------------------------------------------
-- ================================================
-- Template generated from Template Explorer using:
-- Create Multi-Statement Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sahil Kumar Gupta
-- Create date: 07-01-2024
-- Description:	Get All Members of School
-- =============================================
CREATE FUNCTION func_GetAllMember 
(
)
RETURNS 
@persons TABLE 
(
	-- Add the column definitions for the TABLE variable here
	SchoolId nvarchar(10),
	Name nvarchar(100),
	DateOfBirth date,
	PersonType nvarchar(20)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	INSERT INTO @persons
	SELECT
		StudentId,
		FirstName + ' ' + LastName,
		DateOfBirth,
		'Student'
	FROM Students

	INSERT INTO @persons
	SELECT
		StaffId,
		FirstName + ' ' + LastName,
		DateOfBirth,
		'Lecturer'
	FROM Lectures

	RETURN
END
GO
-----------------------------------------------------------------
SELECT * FROM func_GetAllMember()
-----------------------------------------------------------------