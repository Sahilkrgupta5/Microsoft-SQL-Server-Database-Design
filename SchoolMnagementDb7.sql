/*
	7th sheet of MS SQL Server Masterclass
	Table Triggers
*/
-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER dbo.AssignProgrammeOfStudyIdToStudent 
   ON  dbo.Students 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	DECLARE @programmeId int
	DECLARE @id int
	SELECT @programmeId = ProgrammeOfStudyId, @id = id FROM inserted

	IF @programmeId IS NULL
	BEGIN
		UPDATE Students SET ProgrammeOfStudyId = 6 WHERE Id = @id
	END

END
GO
-------------------------------------------------------------------

USE [SchoolManagementDb]
GO
/****** Object:  Trigger [dbo].[AssignProgrammeOfStudyIdToStudent]    Script Date: 08-Mar-24 3:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[AssignProgrammeOfStudyIdToStudent] 
   ON  [dbo].[Students] 
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	DECLARE @programmeId int
	DECLARE @id int
	SELECT @programmeId = ProgrammeOfStudyId, @id = id FROM deleted

	IF @programmeId IS NULL
	BEGIN
		UPDATE Students SET ProgrammeOfStudyId = 6 WHERE Id = @id
	END

END
----------------------------------------------------------------------
--Generating Table Scripts
/****** Object:  Table [dbo].[Classes]    Script Date: 13-Mar-24 10:46:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Classes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LecturerId] [int] NULL,
	[CourseId] [int] NULL,
	[Time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Classes]  WITH CHECK ADD FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
GO

ALTER TABLE [dbo].[Classes]  WITH CHECK ADD FOREIGN KEY([LecturerId])
REFERENCES [dbo].[Lectures] ([Id])
GO

----------------------------------------------------------------------------
--Generating Database Scripts

USE [master]
GO

/****** Object:  Database [SchoolManagementDb]    Script Date: 13-Mar-24 11:52:02 AM ******/
CREATE DATABASE [SchoolManagementDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SchoolManagementDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SchoolManagementDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SchoolManagementDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SchoolManagementDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SchoolManagementDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [SchoolManagementDb] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET ARITHABORT OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET AUTO_CLOSE ON 
GO

ALTER DATABASE [SchoolManagementDb] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [SchoolManagementDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [SchoolManagementDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET  ENABLE_BROKER 
GO

ALTER DATABASE [SchoolManagementDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [SchoolManagementDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [SchoolManagementDb] SET  MULTI_USER 
GO

ALTER DATABASE [SchoolManagementDb] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [SchoolManagementDb] SET DB_CHAINING OFF 
GO

ALTER DATABASE [SchoolManagementDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [SchoolManagementDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [SchoolManagementDb] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [SchoolManagementDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [SchoolManagementDb] SET QUERY_STORE = ON
GO

ALTER DATABASE [SchoolManagementDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [SchoolManagementDb] SET  READ_WRITE 
GO

--------------------------------------------------------------------------------------