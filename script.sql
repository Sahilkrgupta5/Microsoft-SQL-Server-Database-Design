﻿USE [master]
GO
/****** Object:  Database [SchoolManagementDb]     ******/
CREATE DATABASE [SchoolManagementDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SchoolManagementDb', FILENAME = N'SchoolManagementDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SchoolManagementDb_log', FILENAME = N'SchoolManagementDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SchoolManagementDb] SET COMPATIBILITY_LEVEL = 160
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
USE [SchoolManagementDb]
GO
/****** Object:  UserDefinedFunction [dbo].[func_GetAllMember]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sahil Kumar Gupta
-- Create date: 07-01-2024
-- Description:	Get All Members of School
-- =============================================
CREATE FUNCTION [dbo].[func_GetAllMember] 
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
/****** Object:  UserDefinedFunction [dbo].[func_GetHighestGrede]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_GetHighestGrede]
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
/****** Object:  Table [dbo].[Students]    Script Date: 13-Mar-24 12:05:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NULL,
	[StudentId] [nvarchar](10) NOT NULL,
	[ProgrammeOfStudyId] [int] NULL,
 CONSTRAINT [PK__Students__3214EC070D56C06B] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollments]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[CourseId] [int] NULL,
	[Grade] [decimal](3, 1) NULL,
 CONSTRAINT [PK__Enrollme__3214EC074A006677] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewEnrollmentDetails]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ViewEnrollmentDetails] AS
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

GO
/****** Object:  UserDefinedFunction [dbo].[func_GetGradeRange]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[func_GetGradeRange] 
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
/****** Object:  Table [dbo].[Classes]    ******/
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
/****** Object:  Table [dbo].[ProgrammeOfStudy]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgrammeOfStudy](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[DurationInYears] [decimal](10, 2) NULL,
 CONSTRAINT [PK_ProgrammeOfStudy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Credits] [int] NULL,
	[Code] [nvarchar](5) NULL,
	[ProgrammeOfStudy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewClassCourseProgram]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewClassCourseProgram]
AS
SELECT        dbo.Classes.CourseId AS ID, dbo.Courses.Name AS [Course Name], dbo.Courses.Code, dbo.Courses.Credits AS Credit, dbo.ProgrammeOfStudy.Name AS [Program Name]
FROM            dbo.Classes INNER JOIN
                         dbo.Courses ON dbo.Classes.CourseId = dbo.Courses.Id INNER JOIN
                         dbo.ProgrammeOfStudy ON dbo.Courses.ProgrammeOfStudy = dbo.ProgrammeOfStudy.Id
GROUP BY dbo.Classes.CourseId, dbo.Courses.Name, dbo.Courses.Code, dbo.Courses.Credits, dbo.ProgrammeOfStudy.Name
GO
/****** Object:  Table [dbo].[Lectures]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lectures](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NULL,
	[StaffId] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Classes] ON 

INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (1, 2, 1, CAST(N'12:00:00' AS Time))
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (2, 1, 2, CAST(N'10:30:00' AS Time))
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (3, NULL, 2, CAST(N'08:30:00' AS Time))
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (4, NULL, 3, CAST(N'11:00:00' AS Time))
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (5, 1, NULL, CAST(N'09:30:00' AS Time))
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (6, 1, NULL, CAST(N'07:30:00' AS Time))
SET IDENTITY_INSERT [dbo].[Classes] OFF
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([Id], [Name], [Credits], [Code], [ProgrammeOfStudy]) VALUES (1, N'Web Development', 3, N'WD101', 1)
INSERT [dbo].[Courses] ([Id], [Name], [Credits], [Code], [ProgrammeOfStudy]) VALUES (2, N'C#', 4, N'CS101', 2)
INSERT [dbo].[Courses] ([Id], [Name], [Credits], [Code], [ProgrammeOfStudy]) VALUES (3, N'.Net', 3, N'DN108', 1)
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[Enrollments] ON 

INSERT [dbo].[Enrollments] ([Id], [StudentId], [CourseId], [Grade]) VALUES (7, 1, 2, CAST(93.7 AS Decimal(3, 1)))
INSERT [dbo].[Enrollments] ([Id], [StudentId], [CourseId], [Grade]) VALUES (8, 5, 1, CAST(39.2 AS Decimal(3, 1)))
INSERT [dbo].[Enrollments] ([Id], [StudentId], [CourseId], [Grade]) VALUES (9, 2, 3, CAST(60.8 AS Decimal(3, 1)))
INSERT [dbo].[Enrollments] ([Id], [StudentId], [CourseId], [Grade]) VALUES (10, 2, 2, NULL)
SET IDENTITY_INSERT [dbo].[Enrollments] OFF
GO
SET IDENTITY_INSERT [dbo].[Lectures] ON 

INSERT [dbo].[Lectures] ([Id], [FirstName], [LastName], [DateOfBirth], [StaffId]) VALUES (1, N'Sahil', N'Gupta', CAST(N'1997-06-29' AS Date), NULL)
INSERT [dbo].[Lectures] ([Id], [FirstName], [LastName], [DateOfBirth], [StaffId]) VALUES (2, N'Test1', N'One', CAST(N'1990-01-01' AS Date), N'10110046')
INSERT [dbo].[Lectures] ([Id], [FirstName], [LastName], [DateOfBirth], [StaffId]) VALUES (4, N'Test3', N'Three', CAST(N'1990-01-01' AS Date), N'10110048')
INSERT [dbo].[Lectures] ([Id], [FirstName], [LastName], [DateOfBirth], [StaffId]) VALUES (5, N'Test4', N'Four', CAST(N'1990-01-01' AS Date), N'10110049')
INSERT [dbo].[Lectures] ([Id], [FirstName], [LastName], [DateOfBirth], [StaffId]) VALUES (6, N'Nitish', N'Kumar', CAST(N'2003-10-24' AS Date), N'10110050')
SET IDENTITY_INSERT [dbo].[Lectures] OFF
GO
INSERT [dbo].[ProgrammeOfStudy] ([Id], [Name], [DurationInYears]) VALUES (1, N'Bsc in IT', CAST(4.00 AS Decimal(10, 2)))
INSERT [dbo].[ProgrammeOfStudy] ([Id], [Name], [DurationInYears]) VALUES (2, N'ASc in IT', CAST(2.00 AS Decimal(10, 2)))
INSERT [dbo].[ProgrammeOfStudy] ([Id], [Name], [DurationInYears]) VALUES (6, N'N/A', CAST(0.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (1, N'Sofia', N'Khan', CAST(N'2002-08-11' AS Date), N'SK110802', 1)
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (2, N'Versha', N'Rai', CAST(N'1997-08-02' AS Date), N'VR020897', 2)
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (5, N'Rinki', N'Pandey', CAST(N'1999-04-24' AS Date), N'RP240499', NULL)
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (11, N'Vishal', N'Choubey', CAST(N'1994-11-01' AS Date), N'VC110194', 1)
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (12, N'Nitesh', N'Gupta', CAST(N'2000-05-01' AS Date), N'NG050100', 2)
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Courses__A25C5AA74B045654]    ******/
ALTER TABLE [dbo].[Courses] ADD UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Lectures__96D4AB167A59CB54]    ******/
ALTER TABLE [dbo].[Lectures] ADD UNIQUE NONCLUSTERED 
(
	[StaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Students__32C52B98BF14A60C]    ******/
ALTER TABLE [dbo].[Students] ADD  CONSTRAINT [UQ__Students__32C52B98BF14A60C] UNIQUE NONCLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD FOREIGN KEY([LecturerId])
REFERENCES [dbo].[Lectures] ([Id])
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_ProgrammeOfStudy] FOREIGN KEY([ProgrammeOfStudy])
REFERENCES [dbo].[ProgrammeOfStudy] ([Id])
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_ProgrammeOfStudy]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Classes] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Classes] ([Id])
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Enrollments_Classes]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Enrollments_Students]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_ProgrammeOfStudy] FOREIGN KEY([ProgrammeOfStudyId])
REFERENCES [dbo].[ProgrammeOfStudy] ([Id])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_ProgrammeOfStudy]
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectAllStudents]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SelectAllStudents] 
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
/****** Object:  StoredProcedure [dbo].[sp_SelectStudentbyId]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SelectStudentbyId]
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
/****** Object:  StoredProcedure [dbo].[spins_AddStudent]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spins_AddStudent]
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
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Classes"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Courses"
            Begin Extent = 
               Top = 10
               Left = 248
               Bottom = 140
               Right = 443
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ProgrammeOfStudy"
            Begin Extent = 
               Top = 6
               Left = 481
               Bottom = 119
               Right = 654
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1335
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewClassCourseProgram'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewClassCourseProgram'
GO
USE [master]
GO
ALTER DATABASE [SchoolManagementDb] SET  READ_WRITE 
GO
