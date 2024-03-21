/*
	6th sheet of MS SQL Server Masterclass
	Stored Proceures
*/

USE SchoolManagementDb

GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sahil Kumar Gupta
-- Create date: 07-01-2024
-- Description:	Select All Students
-- =============================================
CREATE PROCEDURE sp_SelectAllStudents 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Students
END
GO
------------------------------------------------------
exec sp_SelectAllStudents
--------------------------------------------------------
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sahil Kumar Gupta
-- Create date: 07-01-2024
-- Description:	Select Student by ID
-- =============================================
CREATE PROCEDURE sp_SelectStudentbyId
	-- Add the parameters for the stored procedure here
	@Id int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Students WHERE Id = @Id
END
GO
---------------------------------------------------
exec sp_SelectStudentbyId @Id = 1
----------------------------------------------------
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sahil Kumar Gupta
-- Create date: 07-01-2024
-- Description:	Stored Procedures for Insert Data in Student Table
-- =============================================
CREATE PROCEDURE spins_AddStudent
	-- Add the parameters for the stored procedure here
	@firstname nvarchar(50),
	@lastname nvarchar(50),
	@dateofbirth date,
	@studentId nvarchar(10),
	@programeid int = NULL,
	@id int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Students VALUES
	(@firstname, @lastname, @dateofbirth, @studentId, @programeid)

	SELECT @id = SCOPE_IDENTITY()
END
GO
-------------------------------------------------------------------
declare @id int

/* exec spins_AddStudent 
	@firstname = 'Nitesh',
	@lastname = 'Gupta',
	@dateofbirth = '05-01-2000',
	@studentId = 'NG050100',
	@programeid = 2,
*/
exec spins_AddStudent 
	'Nitesh', 'Gupta', '05-01-2000', 'NG050100', 2, @id OUTPUT
	
exec sp_SelectStudentbyId @id
-------------------------------------------------------------------

