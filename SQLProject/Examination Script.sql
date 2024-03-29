USE [master]
GO
/****** Object:  Database [Examination_System]    Script Date: 13/1/2024 2:44:14 pm ******/
CREATE DATABASE [Examination_System]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Examination_System', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Examination_System.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Examination_System_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Examination_System_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Examination_System] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Examination_System].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Examination_System] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Examination_System] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Examination_System] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Examination_System] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Examination_System] SET ARITHABORT OFF 
GO
ALTER DATABASE [Examination_System] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Examination_System] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Examination_System] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Examination_System] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Examination_System] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Examination_System] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Examination_System] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Examination_System] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Examination_System] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Examination_System] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Examination_System] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Examination_System] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Examination_System] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Examination_System] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Examination_System] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Examination_System] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Examination_System] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Examination_System] SET RECOVERY FULL 
GO
ALTER DATABASE [Examination_System] SET  MULTI_USER 
GO
ALTER DATABASE [Examination_System] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Examination_System] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Examination_System] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Examination_System] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Examination_System] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Examination_System] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Examination_System', N'ON'
GO
ALTER DATABASE [Examination_System] SET QUERY_STORE = ON
GO
ALTER DATABASE [Examination_System] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Examination_System]
GO
/****** Object:  User [TrainingManager]    Script Date: 13/1/2024 2:44:15 pm ******/
CREATE USER [TrainingManager] FOR LOGIN [TrainingManager] WITH DEFAULT_SCHEMA=[T_Manager]
GO
/****** Object:  User [Student]    Script Date: 13/1/2024 2:44:15 pm ******/
CREATE USER [Student] FOR LOGIN [Student] WITH DEFAULT_SCHEMA=[Student]
GO
/****** Object:  User [Instructor]    Script Date: 13/1/2024 2:44:15 pm ******/
CREATE USER [Instructor] FOR LOGIN [Instructor] WITH DEFAULT_SCHEMA=[Instructor]
GO
/****** Object:  User [Admin]    Script Date: 13/1/2024 2:44:15 pm ******/
CREATE USER [Admin] FOR LOGIN [Admin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Schema [Instructor]    Script Date: 13/1/2024 2:44:15 pm ******/
CREATE SCHEMA [Instructor]
GO
/****** Object:  Schema [Student]    Script Date: 13/1/2024 2:44:15 pm ******/
CREATE SCHEMA [Student]
GO
/****** Object:  Schema [T_Manager]    Script Date: 13/1/2024 2:44:15 pm ******/
CREATE SCHEMA [T_Manager]
GO
/****** Object:  UserDefinedTableType [dbo].[AnswerTableType]    Script Date: 13/1/2024 2:44:15 pm ******/
CREATE TYPE [dbo].[AnswerTableType] AS TABLE(
	[QuestionID] [char](3) NULL,
	[StudentAnswer] [varchar](255) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[AnswerTableTypes]    Script Date: 13/1/2024 2:44:15 pm ******/
CREATE TYPE [dbo].[AnswerTableTypes] AS TABLE(
	[QuestionID] [char](3) NULL,
	[StudentAnswer] [varchar](255) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[QuestionDegreesType]    Script Date: 13/1/2024 2:44:15 pm ******/
CREATE TYPE [dbo].[QuestionDegreesType] AS TABLE(
	[QuestionID] [varchar](5) NULL,
	[QuestionDegree] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[StudentListType]    Script Date: 13/1/2024 2:44:15 pm ******/
CREATE TYPE [dbo].[StudentListType] AS TABLE(
	[Std_ID] [int] NULL
)
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[exam_ID] [int] IDENTITY(1,1) NOT NULL,
	[Type_Exam] [varchar](15) NULL,
	[Exam_Date] [date] NULL,
	[exam_StartTime] [time](7) NULL,
	[exam_EndTime]  AS (dateadd(minute,[exam_TotalDuration],[exam_StartTime])),
	[exam_TotalDuration] [int] NULL,
	[TotalDegree] [int] NULL,
	[Crs_Id] [int] NOT NULL,
	[class_Id] [int] NOT NULL,
	[Ins_Exam] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentExam]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentExam](
	[ExamID] [int] NULL,
	[QuestionID] [varchar](5) NULL,
	[StudentID] [int] NULL,
	[StudentAnswer] [varchar](255) NULL,
	[Result] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Std_ID] [int] NOT NULL,
	[std_Name] [varchar](50) NULL,
	[std_Age] [int] NULL,
	[std_City] [varchar](50) NULL,
	[std_Email] [varchar](100) NULL,
	[Class_ID] [int] NULL,
	[User_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Std_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [Instructor].[StudentSearchByPattern_FN]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [Instructor].[StudentSearchByPattern_FN]
(
    @Option1 VARCHAR(MAX),
    @SearchPattern VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        Stu.Std_ID AS StudentID, Stu.std_Name AS StudentName,
        ES.ExamID,  isnull(ES.StudentAnswer,'Not Answer Yet') as StudentAnswer,  ES.Result
    FROM
        StudentExam ES
    INNER JOIN
        Student Stu ON ES.StudentID = Stu.Std_ID  
    INNER JOIN
        Exam Ex ON ES.ExamID = Ex.exam_ID
    WHERE
        (
            (@Option1 = 'StudentName' AND Stu.std_Name LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'StudentAnswer' AND ES.StudentAnswer LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'ExamID' AND CAST(ES.ExamID AS VARCHAR(MAX)) LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'Result' AND CAST(ES.Result AS VARCHAR(MAX)) LIKE '%' + @SearchPattern + '%') 
        )
);
GO
/****** Object:  UserDefinedFunction [T_Manager].[SearchByPatternStdTable_FN]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [T_Manager].[SearchByPatternStdTable_FN]
    (@option1 VARCHAR(15), @SearchPattern NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Student
    WHERE
        (
            CASE 
                WHEN @option1 = 'Name' THEN std_Name
                WHEN @option1 = 'Email' THEN std_Email
                WHEN @option1 = 'City' THEN std_City
            END
        ) LIKE '%' + @SearchPattern + '%'
);
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[ID] [int] NOT NULL,
	[name] [varchar](100) NULL,
	[User_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](max) NULL,
	[max_degree] [int] NOT NULL,
	[min_degree] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[InstructorDataOrderedBy_Function]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[InstructorDataOrderedBy_Function] (@OrderByColumn VARCHAR(max))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        Ins.ID AS InstructorID, 
        Ins.name AS InstructorName, 
        Ex.exam_ID AS ExamID,
        Ex.Type_Exam AS ExamType,
        Ex.Exam_Date AS ExamDate, 
        Crs.id AS CourseID,
        Crs.name AS CourseName,
        Crs.description AS CourseDescription,
        ROW_NUMBER() OVER (ORDER BY
            CASE
                WHEN @OrderByColumn = 'InstructorName' THEN Ins.name
                WHEN @OrderByColumn = 'ExamDate' THEN CAST(Ex.Exam_Date AS varchar(max))
                WHEN @OrderByColumn = 'CourseName' THEN Crs.name
                WHEN @OrderByColumn = 'CourseID' THEN CAST(Crs.id AS varchar(max))
                WHEN @OrderByColumn = 'InstructorID' THEN CAST(Ins.ID AS varchar(max))
                ELSE NULL
            END
        ) AS RowNum
    FROM 
        Instructor Ins 
    INNER JOIN Exam Ex ON Ins.ID = Ex.[Ins_Exam]
    INNER JOIN Courses Crs ON Ex.Crs_Id = Crs.id
);
GO
/****** Object:  View [dbo].[StudentView]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StudentView] AS
SELECT [std_Name]'Name', [std_Age]'Age',[std_Email]'E-mail',[std_City]'City'
FROM [dbo].[Student];
GO
/****** Object:  View [T_Manager].[CourseView]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [T_Manager].[CourseView] AS
select [name]'Name',[description]'Description'
from [dbo].[Courses]
GO
/****** Object:  Table [dbo].[StudentCourse]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentCourse](
	[StudentID] [int] NOT NULL,
	[CourseID] [int] NOT NULL,
	[TotalDegree] [int] NULL,
	[FinalResult] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  View [T_Manager].[StudentCourseView]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    VIEW [T_Manager].[StudentCourseView] AS
SELECT  s.[std_Name], c.[name],se.[TotalDegree]
FROM [dbo].[StudentCourse] se
LEFT JOIN [dbo].[Student] s ON se.[StudentID] = s.[Std_ID]
LEFT JOIN [dbo].[Courses] c ON se.[CourseID] = c.[id];
GO
/****** Object:  Table [dbo].[Instructor_Courses]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor_Courses](
	[Instructor_id] [int] NULL,
	[Course_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[InstructorCourseView]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------
CREATE VIEW [dbo].[InstructorCourseView] AS
SELECT i.Name 'Instructor_name', c.[name]'course_name'
FROM Instructor i
INNER JOIN [dbo].[Instructor_Courses] ic ON i.[ID] = ic.[Instructor_id]
INNER JOIN [dbo].[Courses] c ON ic.[Course_id] = c.[id];
GO
/****** Object:  View [Instructor].[ExamInstructorView]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [Instructor].[ExamInstructorView] AS
SELECT e.[Type_Exam],e.exam_TotalDuration,e.TotalDegree, i.Name AS InstructorName
FROM Exam e
LEFT JOIN Instructor i ON e.[Ins_Exam] = i.[ID];
GO
/****** Object:  Table [dbo].[Tracks]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tracks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Track] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Intake]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intake](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NULL,
	[Intake_Year] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[ClassID] [int] NOT NULL,
	[TrackID] [int] NULL,
	[BranchID] [int] NULL,
	[IntakeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [T_Manager].[ClassDetailsView]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [T_Manager].[ClassDetailsView] AS
SELECT  t.Track, i.[Name] AS IntakeName, b.[Name] AS BranchName
FROM [dbo].[Class] c
LEFT JOIN [dbo].[Tracks] t ON c.[TrackID] = t.[id]
LEFT JOIN [dbo].[Intake] i ON c.[IntakeID] = i.[ID]
LEFT JOIN [dbo].[Branch] b ON c.[BranchID] = b.[ID];
GO
/****** Object:  Table [dbo].[Question]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[ID] [varchar](5) NOT NULL,
	[text] [varchar](1000) NULL,
	[type] [varchar](10) NULL,
	[degree] [int] NULL,
	[correct_answer] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [T_Manager].[StudentExamView]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE     VIEW [T_Manager].[StudentExamView] as
SELECT se.[ExamID],se.QuestionID,s.[std_Name],isnull(se.StudentAnswer,'Not Answer Yet')AS StudentAnswer,se.Result, q.[text]
FROM [dbo].[StudentExam] se
LEFT JOIN Exam e ON se.ExamID = e.[exam_ID]
LEFT JOIN Question q ON se.QuestionID = q.[ID]
LEFT JOIN Student s ON se.StudentID = s.[Std_ID];
GO
/****** Object:  UserDefinedFunction [T_Manager].[ManagerSearchByPattern_FN]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [T_Manager].[ManagerSearchByPattern_FN] 
    (@Option1 VARCHAR(MAX),
    @SearchPattern VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT
        S.Std_ID AS StudentID, S.std_Name AS StudentName, S.std_City AS StudentCity,
        S.std_Email AS StudentEmail,
        T.Track AS TrackName, B.Name AS BranchName, I.Name AS IntakeName
    FROM
        Student S
    INNER JOIN
        [dbo].[Class] C ON S.class_Id = C.ClassID
    INNER JOIN
        Tracks T ON C.TrackID = T.id
    INNER JOIN
        Branch B ON C.BranchID = B.ID
    INNER JOIN
        Intake I ON C.IntakeID = I.ID
    WHERE
        (
            (@Option1 = 'StudentName' AND  S.std_Name LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'StudentEmail' AND  S.std_Email LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'StudentCity' AND  S.std_City LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'BrancheName' AND B.Name LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'TrackName' AND T.Track LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'IntakeName' AND I.Name LIKE '%' + @SearchPattern + '%')  
        )
);
GO
/****** Object:  View [Instructor].[StudentCourseView]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [Instructor].[StudentCourseView] AS
SELECT s.std_Name AS Student_Name,s.std_Email'E-mail',s.std_Age'Age', c.[name]'Course Name',FinalResult
FROM [dbo].[Student] s
INNER JOIN StudentCourse sc ON s.Std_ID = sc.StudentID
INNER JOIN [dbo].[Courses] c ON sc.CourseID = c.id;
GO
/****** Object:  UserDefinedFunction [Student].[StdCourseInfoByStudentID_FN]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [Student].[StdCourseInfoByStudentID_FN] (@StudentID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        S.std_Name AS StudentName,
        C.[name] AS CourseName,
        SC.TotalDegree,
        SC.FinalResult
    FROM
        StudentCourse SC
    INNER JOIN
        Student S ON SC.StudentID = S.Std_ID
    INNER JOIN
        Courses C ON SC.CourseID = C.id
    WHERE
        SC.StudentID = @StudentID
);

GO
/****** Object:  UserDefinedFunction [dbo].[GetExamsByYear]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetExamsByYear] (
    @year INT,
    @courseId INT,
    @instructorId INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT e.exam_ID, e.Type_Exam, e.Exam_Date, e.exam_StartTime, e.exam_TotalDuration, e.TotalDegree, e.Ins_Exam, i.[name] AS InstructorName, e.Crs_Id, cr.[name] AS CourseName,
           c.id AS class_Id, c.intake_Name, c.track_Name
    FROM Exam e
    INNER JOIN Class c ON e.class_Id = c.id
    INNER JOIN Instructor i ON e.Ins_Exam = i.ID
    INNER JOIN [dbo].[Courses] cr ON e.Crs_Id = cr.id
    WHERE c.Year = @year
    AND e.Crs_Id = @courseId
    AND e.Ins_Exam = @instructorId
);
GO
/****** Object:  UserDefinedFunction [T_Manager].[InstructorSearchByPattern_FN]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [T_Manager].[InstructorSearchByPattern_FN]
(
    @Option1 VARCHAR(MAX),
    @SearchPattern VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        Ins.ID AS InstructorID, Ins.name AS InstructorName, Ex.exam_ID AS ExamID,
        Ex.Type_Exam AS ExamType, Ex.Exam_Date AS ExamDate,Crs.id AS CourseID,
        Crs.name AS CourseName, Crs.description AS CourseDescription
    FROM
        Instructor Ins INNER JOIN Exam Ex ON Ins.ID = Ex.Ins_Exam
    INNER JOIN Courses Crs ON Ex.Crs_Id = Crs.id
    WHERE
        (
            (@Option1 = 'InstructorName' AND Ins.name LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'CourseName' AND Crs.name LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'CourseID' AND CAST(Crs.id AS VARCHAR(MAX)) LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'InstructorID' AND CAST(Ins.ID AS VARCHAR(MAX)) LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'ExamID' AND CAST(Ex.exam_ID AS VARCHAR(MAX)) LIKE '%' + @SearchPattern + '%') OR
            (@Option1 = 'ExamType' AND CAST(Ex.Type_Exam AS VARCHAR(MAX)) LIKE '%' + @SearchPattern + '%') 

        )
);
GO
/****** Object:  Table [dbo].[Choises]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Choises](
	[ID] [varchar](5) NULL,
	[choose] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExamQuestion]    Script Date: 13/1/2024 2:44:15 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamQuestion](
	[ExamID] [int] NULL,
	[QuestionID] [varchar](5) NOT NULL,
	[Degree] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Account]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Account](
	[User_ID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[UserPassword] [varchar](100) NULL,
	[UserType] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Branch] ON 

INSERT [dbo].[Branch] ([ID], [Name]) VALUES (1, N'Giza')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (2, N'University')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (3, N'Mansura')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (4, N'Cairo')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (5, N'Qena')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (6, N'Minya')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (7, N'Beni Suef')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (8, N'Asyut')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (9, N'Sohag ')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (10, N'Alexandria')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (11, N'Ismailia ')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (12, N'Menofia ')
INSERT [dbo].[Branch] ([ID], [Name]) VALUES (13, N'Aswan')
SET IDENTITY_INSERT [dbo].[Branch] OFF
GO
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M1', N'Entity-relationship diagram')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M1', N'Entity diagram')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M1', N'Database diagram')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M1', N'Architectural representation')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M2', N'Entity set')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M2', N'Relationship set')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M2', N'Attributes of a relationship set')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M2', N'Primary key')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M3', N'Double diamonds')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M3', N'Undivided rectangles')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M3', N'Dashed lines')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M3', N' Diamond')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M4', N'Underline')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M4', N'Double line')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M4', N'Double diamond')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M4', N'Double rectangle')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M5', N' Cardinality')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M5', N'Entity')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M5', N'Schema')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M5', N'Attributes')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M6', N'Record')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M6', N'Relationship')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M6', N'Tuple')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M6', N'Field')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M7', N'one')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M7', N'two')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M7', N'five')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M7', N'Three')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M8', N'Third')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M8', N'Second')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M8', N'First ')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M8', N'Fourth')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M9', N'non-behavioral')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M9', N'non-structural')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M9', N'structural')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M9', N'behavioral')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M10', N'non-behavioral')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M10', N'non-structural')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M10', N'behavioral')
INSERT [dbo].[Choises] ([ID], [choose]) VALUES (N'M10', N'structural')
GO
INSERT [dbo].[Class] ([ClassID], [TrackID], [BranchID], [IntakeID]) VALUES (1, 1, 2, 3)
INSERT [dbo].[Class] ([ClassID], [TrackID], [BranchID], [IntakeID]) VALUES (2, 1, 1, 1)
INSERT [dbo].[Class] ([ClassID], [TrackID], [BranchID], [IntakeID]) VALUES (3, 4, 7, 8)
INSERT [dbo].[Class] ([ClassID], [TrackID], [BranchID], [IntakeID]) VALUES (4, 4, 5, 3)
INSERT [dbo].[Class] ([ClassID], [TrackID], [BranchID], [IntakeID]) VALUES (5, 9, 2, 3)
INSERT [dbo].[Class] ([ClassID], [TrackID], [BranchID], [IntakeID]) VALUES (6, 1, 2, 3)
INSERT [dbo].[Class] ([ClassID], [TrackID], [BranchID], [IntakeID]) VALUES (7, 9, 11, 3)
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (1, N'HTML', N'Learn about web page structure', 100, 65)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (2, N'CSS', N'Learn about web page Style', 100, 65)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (3, N'Network', N'Learn about computer networks', 100, 65)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (4, N'OOP', N'programming paradigm', 100, 65)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (5, N'Software Testing', N'Software Testing Techniques', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (6, N'Databases', N'Database Systems and Design', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (7, N'Cyber Ethics', N'Ethical Hacking and Cybersecurity', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (8, N'Artificial Neural Networks', N'Introduction to Artificial Neural Networks', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (9, N'Game Development', N'Introduction to Game Development', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (10, N'Cloud Computing', N'Cloud Computing Technologies', 100, 65)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (11, N'Computer Vision', N'Computer Vision Fundamentals', 100, 7)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (12, N'Software Project Management', N'Managing Software Projects', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (13, N'Computer Ethics', N'Ethical Considerations in Computing', 100, 75)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (14, N'Robotics', N'Introduction to Robotics', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (15, N'Big Data Analytics', N'Introduction to Big Data Analytics', 100, 70)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (16, N'Java Programming', N'Introduction to Java Programming Language', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (17, N'Python Programming', N'Python Programming Basics', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (18, N'C++ Programming', N'Advanced C++ Programming Concepts', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (19, N'JavaScript', N'Web Development with JavaScript', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (20, N'Database Management', N'Introduction to Database Management', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (21, N'Mobile App Development', N'Building Mobile Applications', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (22, N'Web Development', N'Web Development Fundamentals', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (23, N'Software Engineering', N'Software Engineering Principles', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (24, N'Algorithms', N'Algorithm Design and Analysis', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (25, N'Data Structures', N'Data Structures and Algorithms', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (26, N'Network Security', N'Network Security Principles', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (27, N'Machine Learning', N'Introduction to Machine Learning', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (28, N'Computer Architecture', N'Computer Architecture and Organization', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (29, N'Programming Languages', N'Overview of Programming Languages', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (30, N'Cybersecurity', N'Cybersecurity Fundamentals', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (31, N'Blockchain Technology', N'Understanding Blockchain Technology', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (32, N'Computer Graphics', N'Introduction to Computer Graphics', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (33, N'Artificial Intelligence', N'Fundamentals of Artificial Intelligence', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (34, N'Web Design', N'Web Design and User Experience', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (35, N'Statistics', N'Statistics for Data Analysis', 100, 60)
INSERT [dbo].[Courses] ([id], [name], [description], [max_degree], [min_degree]) VALUES (36, N'Computer Networks', N'Computer Networks and Protocols', 100, 60)
SET IDENTITY_INSERT [dbo].[Courses] OFF
--GO
--SET IDENTITY_INSERT [dbo].[Exam] ON 

----INSERT [dbo].[Exam] ([exam_ID], [Type_Exam], [Exam_Date], [exam_StartTime], [exam_TotalDuration], [TotalDegree], [Crs_Id], [class_Id], [Ins_Exam]) VALUES (9, N'Corrective', CAST(N'2024-01-11' AS Date), CAST(N'06:00:00' AS Time), 120, 100, 4, 1, 2)
----INSERT [dbo].[Exam] ([exam_ID], [Type_Exam], [Exam_Date], [exam_StartTime], [exam_TotalDuration], [TotalDegree], [Crs_Id], [class_Id], [Ins_Exam]) VALUES (14, N'Exam', CAST(N'2024-01-10' AS Date), CAST(N'23:00:00' AS Time), 150, 100, 5, 2, 2)
----INSERT [dbo].[Exam] ([exam_ID], [Type_Exam], [Exam_Date], [exam_StartTime], [exam_TotalDuration], [TotalDegree], [Crs_Id], [class_Id], [Ins_Exam]) VALUES (15, N'Exam', CAST(N'2024-01-10' AS Date), CAST(N'09:00:00' AS Time), 180, 50, 3, 3, 1)
----INSERT [dbo].[Exam] ([exam_ID], [Type_Exam], [Exam_Date], [exam_StartTime], [exam_TotalDuration], [TotalDegree], [Crs_Id], [class_Id], [Ins_Exam]) VALUES (17, N'Exam', CAST(N'2024-01-12' AS Date), CAST(N'09:00:00' AS Time), 180, 50, 3, 3, 1)
----INSERT [dbo].[Exam] ([exam_ID], [Type_Exam], [Exam_Date], [exam_StartTime], [exam_TotalDuration], [TotalDegree], [Crs_Id], [class_Id], [Ins_Exam]) VALUES (30, N'Corrective', CAST(N'2024-12-31' AS Date), CAST(N'23:00:00' AS Time), 120, 4, 3, 5, 1)
----INSERT [dbo].[Exam] ([exam_ID], [Type_Exam], [Exam_Date], [exam_StartTime], [exam_TotalDuration], [TotalDegree], [Crs_Id], [class_Id], [Ins_Exam]) VALUES (32, N'Corrective', CAST(N'2024-12-31' AS Date), CAST(N'23:00:00' AS Time), 170, 50, 3, 2, 1)
----INSERT [dbo].[Exam] ([exam_ID], [Type_Exam], [Exam_Date], [exam_StartTime], [exam_TotalDuration], [TotalDegree], [Crs_Id], [class_Id], [Ins_Exam]) VALUES (33, N'Corrective', CAST(N'2024-12-31' AS Date), CAST(N'23:00:00' AS Time), 170, 50, 3, 2, 1)
----INSERT [dbo].[Exam] ([exam_ID], [Type_Exam], [Exam_Date], [exam_StartTime], [exam_TotalDuration], [TotalDegree], [Crs_Id], [class_Id], [Ins_Exam]) VALUES (34, N'Corrective', CAST(N'2024-12-31' AS Date), CAST(N'23:00:00' AS Time), 170, 50, 3, 2, 1)
----INSERT [dbo].[Exam] ([exam_ID], [Type_Exam], [Exam_Date], [exam_StartTime], [exam_TotalDuration], [TotalDegree], [Crs_Id], [class_Id], [Ins_Exam]) VALUES (35, N'Corrective', CAST(N'2024-12-31' AS Date), CAST(N'23:00:00' AS Time), 170, 50, 3, 2, 1)
----INSERT [dbo].[Exam] ([exam_ID], [Type_Exam], [Exam_Date], [exam_StartTime], [exam_TotalDuration], [TotalDegree], [Crs_Id], [class_Id], [Ins_Exam]) VALUES (36, N'Corrective', CAST(N'2024-12-31' AS Date), CAST(N'23:00:00' AS Time), 170, 50, 3, 2, 1)
--SET IDENTITY_INSERT [dbo].[Exam] OFF
--GO
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'M1', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'M10', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'M2', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'M3', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'M4', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'M6', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'M8', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'T11', 5)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'T17', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'X21', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'X24', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'X26', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (9, N'X28', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'M1', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'T11', 5)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'T17', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'T15', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'X29', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'M10', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'M2', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'M4', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'T18', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'X25', 3)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'X30', 4)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (14, N'X21', 4)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (17, N'M6', 2)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (17, N'M3', 2)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (17, N'X22', 2)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (17, N'T11', 2)
--INSERT [dbo].[ExamQuestion] ([ExamID], [QuestionID], [Degree]) VALUES (17, N'M9', 2)
--GO
INSERT [dbo].[Instructor] ([ID], [name], [User_ID]) VALUES (1, N'Mohamoud', 21)
INSERT [dbo].[Instructor] ([ID], [name], [User_ID]) VALUES (2, N'Mohmed', 21)
INSERT [dbo].[Instructor] ([ID], [name], [User_ID]) VALUES (3, N'Ali', 21)
INSERT [dbo].[Instructor] ([ID], [name], [User_ID]) VALUES (4, N'Adham', 21)
INSERT [dbo].[Instructor] ([ID], [name], [User_ID]) VALUES (5, N'Fahmy', 21)
INSERT [dbo].[Instructor] ([ID], [name], [User_ID]) VALUES (6, N'Mona', 21)
INSERT [dbo].[Instructor] ([ID], [name], [User_ID]) VALUES (7, N'Sarah', 21)
INSERT [dbo].[Instructor] ([ID], [name], [User_ID]) VALUES (8, N'Malak', 21)
INSERT [dbo].[Instructor] ([ID], [name], [User_ID]) VALUES (9, N'Mina', 21)
INSERT [dbo].[Instructor] ([ID], [name], [User_ID]) VALUES (10, N'Rana', 21)
GO
INSERT [dbo].[Instructor_Courses] ([Instructor_id], [Course_id]) VALUES (1, 1)
INSERT [dbo].[Instructor_Courses] ([Instructor_id], [Course_id]) VALUES (1, 2)
INSERT [dbo].[Instructor_Courses] ([Instructor_id], [Course_id]) VALUES (1, 3)
INSERT [dbo].[Instructor_Courses] ([Instructor_id], [Course_id]) VALUES (2, 4)
INSERT [dbo].[Instructor_Courses] ([Instructor_id], [Course_id]) VALUES (2, 5)
INSERT [dbo].[Instructor_Courses] ([Instructor_id], [Course_id]) VALUES (3, 6)
INSERT [dbo].[Instructor_Courses] ([Instructor_id], [Course_id]) VALUES (3, 7)
INSERT [dbo].[Instructor_Courses] ([Instructor_id], [Course_id]) VALUES (3, 8)
INSERT [dbo].[Instructor_Courses] ([Instructor_id], [Course_id]) VALUES (4, 9)
INSERT [dbo].[Instructor_Courses] ([Instructor_id], [Course_id]) VALUES (4, 10)
GO
SET IDENTITY_INSERT [dbo].[Intake] ON 

INSERT [dbo].[Intake] ([ID], [Name], [Intake_Year]) VALUES (1, N'Round 35', 2022)
INSERT [dbo].[Intake] ([ID], [Name], [Intake_Year]) VALUES (2, N'Round 36', 2022)
INSERT [dbo].[Intake] ([ID], [Name], [Intake_Year]) VALUES (3, N'Round 37', 2022)
INSERT [dbo].[Intake] ([ID], [Name], [Intake_Year]) VALUES (4, N'Round 38', 2023)
INSERT [dbo].[Intake] ([ID], [Name], [Intake_Year]) VALUES (5, N'Round 39', 2023)
INSERT [dbo].[Intake] ([ID], [Name], [Intake_Year]) VALUES (6, N'Round 40', 2023)
INSERT [dbo].[Intake] ([ID], [Name], [Intake_Year]) VALUES (7, N'Round 41', 2024)
INSERT [dbo].[Intake] ([ID], [Name], [Intake_Year]) VALUES (8, N'Round 42', 2024)
INSERT [dbo].[Intake] ([ID], [Name], [Intake_Year]) VALUES (9, N'Round 43', 2027)
INSERT [dbo].[Intake] ([ID], [Name], [Intake_Year]) VALUES (10, N'Round 44', 2025)
SET IDENTITY_INSERT [dbo].[Intake] OFF
GO
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'M1', N' Which of the following gives a logical structure of the database graphically?', N'MCQ', 1, N'Entity-relationship diagram')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'M10', N'who consider diagrams as a type of Class diagram, component diagram, object diagram, and deployment diagram?', N'MCQ', 1, N'structural')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'M2', N'The Rectangles divided into two parts represents?', N'MCQ', 1, N'Entity set')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'M3', N'The entity relationship set is represented in E-R diagram as?', N'MCQ', 1, N' Diamond')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'M4', N'Weak entity set is represented as?', N'MCQ', 1, N'Double rectangle')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'M5', N'The number of entities to which another entity can be related through a relationship set is called?', N'MCQ', 1, N' Cardinality')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'M6', N'An association of various entities in an Entity-Relation model is known as?', N'MCQ', 1, N'Relationship')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'M7', N'If two entities have many to many relationships mostly results in how many tables?', N'MCQ', 1, N'Three')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'M8', N'The Relations bring from an E-R model will usually be in?', N'MCQ', 1, N'Third')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'M9', N'which type they considered Activity diagram, use case diagram, collaboration diagram, and sequence diagram?', N'MCQ', 1, N'behavioral')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'T11', N'An ID-dependent entity is an entity whose identifier is a composite identifier where no portion of the composite identifier is an identifier of another entity?', N'T&F', 1, N'False')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'T12', N'A ternary relationship is so called because in contains two entities and one association between them?', N'T&F', 1, N'False')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'T13', N'All instances of an entity class have the same attributes?', N'T&F', 1, N'True')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'T14', N'A minimum cardinality is the minimum number of entity instances that may participate in a relationship instance?', N'T&F', 1, N'False')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'T15', N'An attribute describes the entitys characteristics?', N'T&F', 1, N'True')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'T16', N'The degree of a relationship refers to the number of entity classes in the relationship?', N'T&F', 1, N'True')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'T17', N'Composite identifiers consist of two or more attributes?', N'T&F', 1, N'True')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'T18', N'Entities use identifiers while tables use keys?', N'T&F', 1, N'True')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'T19', N'When designing a database, first identify the entities, then determine the attributes, and finally establish the relationships?', N'T&F', 1, N'False')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'T20', N'A subtype entity is a special case of another entity called a supertype entity?', N'T&F', 1, N'True')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'X21', N'A table on the many side of a one to many or many to many relationship must?', N'Text', 2, N'Have a composite key')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'X22', N'For any pincode, there is only one city and state. Also, for given street, city and state, there is just one pincode. In normalization terms, empdt1 is a relation in?', N'Text', 2, N'2 NF and hence also in 1 NF')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'X23', N'The term for information that describes what type of data is available in a database is?', N'Text', 2, N'Metadata')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'X24', N'A data type that creates unique numbers for key columns in Microsoft Access is?', N'Text', 2, N' Autonumber')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'X25', N'Consider attributes ID, CITY and NAME. Which one of this can be considered as a super key?', N'Text', 2, N'ID')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'X26', N'The subset of a super key is a candidate key under what condition?', N'Text', 2, N' No proper subset is a super key')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'X27', N'The relation with the attribute which is the primary key is referenced in another relation. The relation which has the attribute as a primary key is called?', N'Text', 2, N'Referenced relation')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'X28', N'Access keys allows the user to run the application even when?', N'Text', 2, N'Mouse becomes inoperative')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'X29', N'Each access key in the interface should be?', N'Text', 2, N'Unique')
INSERT [dbo].[Question] ([ID], [text], [type], [degree], [correct_answer]) VALUES (N'X30', N'Designers generally use __________ font style and __________ font size in an interface.?', N'Text', 2, N'One, two')
GO
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (1, N'John Doe', 20, N'New York', N'john.doe@example.com', 1, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (2, N'Mo', 22, N'Los Angeles', N'jane.smith@example.com', 2, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (3, N'Robert Johnson', 25, N'Chicago', N'robert.johnson@example.com', 2, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (4, N'Michael Brown', 23, N'Houston', N'michael.brown@example.com', 3, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (5, N'Patricia Davis', 24, N'Philadelphia', N'patricia.davis@example.com', 4, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (6, N'James Wilson', 21, N'Phoenix', N'james.wilson@example.com', 5, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (7, N'Jennifer Taylor', 26, N'San Antonio', N'jennifer.taylor@example.com', 5, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (8, N'William Moore', 27, N'San Diego', N'william.moore@example.com', 7, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (9, N'Linda Thompson', 28, N'Dallas', N'linda.thompson@example.com', 7, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (10, N'Donald Jackson', 30, N'San Jose', N'donald.jackson@example.com', 5, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (11, N'Carol Anderson', 32, N'Austin', N'carol.anderson@example.com', 6, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (12, N'Henry White', 35, N'Jacksonville', N'henry.white@example.com', 7, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (13, N'Judith Harris', 37, N'Columbus', N'judith.harris@example.com', 5, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (14, N'Ralph Martinez', 40, N'El Paso', N'ralph.martinez@example.com', 6, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (15, N'Karen Robinson', 42, N'Oklahoma City', N'karen.robinson@example.com', 1, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (16, N'Timothy Torres', 45, N'Portland', N'timothy.torres@example.com', 1, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (17, N'Sharon Perez', 47, N'Memphis', N'sharon.perez@example.com', 1, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (18, N'Nancy Clark', 50, N'Denver', N'nancy.clark@example.com', 2, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (19, N'Phillip Lewis', 52, N'Tampa', N'phillip.lewis@example.com', 2, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (20, N'Emily Hall', 55, N'Atlanta', N'emily.hall@example.com', 7, 18)
INSERT [dbo].[Student] ([Std_ID], [std_Name], [std_Age], [std_City], [std_Email], [Class_ID], [User_ID]) VALUES (21, N'Mohamed', 27, N'Cairo', N'M.salah532@Gmail.com', 1, 18)
GO
INSERT [dbo].[StudentCourse] ([StudentID], [CourseID], [TotalDegree], [FinalResult]) VALUES (4, 4, 50, N'Corrective')
GO
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M1', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M10', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M2', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M3', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M4', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M6', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M8', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'T11', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'T17', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X21', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X24', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X26', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X28', 9, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M1', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M10', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M2', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M3', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M4', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M6', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M8', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'T11', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'T17', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X21', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X24', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X26', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X28', 4, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M1', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M10', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M2', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M3', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M4', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M6', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M8', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'T11', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'T17', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X21', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X24', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X26', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X28', 3, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M1', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M10', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M2', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M3', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M4', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M6', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'M8', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'T11', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'T17', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X21', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X24', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X26', 1, NULL, NULL)
--INSERT [dbo].[StudentExam] ([ExamID], [QuestionID], [StudentID], [StudentAnswer], [Result]) VALUES (9, N'X28', 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Tracks] ON 

INSERT [dbo].[Tracks] ([id], [Track]) VALUES (1, N'Programming')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (2, N'Power Systems')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (3, N'Thermal Engineering')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (4, N'Structural Engineering')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (5, N'Networks')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (6, N'Process Engineering')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (7, N'Biotechnology')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (8, N'Environmental Management')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (9, N'Marketing')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (10, N'Investment Banking')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (11, N'Employee Relations')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (12, N'Clinical Psychology')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (13, N'Applied Mathematics')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (14, N'Quantum Physics')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (15, N'Visual Arts')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (16, N'American Literature')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (17, N'World History')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (18, N'Geographical Information Systems')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (19, N'International Relations')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (20, N'Social Justice')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (21, N'hamo')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (22, N'Programming')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (23, N'Power Systems')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (24, N'Thermal Engineering')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (25, N'Structural Engineering')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (26, N'Networks')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (27, N'Process Engineering')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (28, N'Biotechnology')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (29, N'Environmental Management')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (30, N'Marketing')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (31, N'Investment Banking')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (32, N'Employee Relations')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (33, N'Clinical Psychology')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (34, N'Applied Mathematics')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (35, N'Quantum Physics')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (36, N'Visual Arts')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (37, N'American Literature')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (38, N'World History')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (39, N'Geographical Information Systems')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (40, N'International Relations')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (41, N'Social Justice')
INSERT [dbo].[Tracks] ([id], [Track]) VALUES (55, NULL)
SET IDENTITY_INSERT [dbo].[Tracks] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Account] ON 

INSERT [dbo].[User_Account] ([User_ID], [UserName], [UserPassword], [UserType]) VALUES (18, N'Student', N'123', N'Student')
INSERT [dbo].[User_Account] ([User_ID], [UserName], [UserPassword], [UserType]) VALUES (19, N'Training Manager', N'123', N'Training Manager')
INSERT [dbo].[User_Account] ([User_ID], [UserName], [UserPassword], [UserType]) VALUES (20, N'Admin', N'123', N'Admin')
INSERT [dbo].[User_Account] ([User_ID], [UserName], [UserPassword], [UserType]) VALUES (21, N'Instructor', N'123', N'Instructor')
SET IDENTITY_INSERT [dbo].[User_Account] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [stud_index_byname]    Script Date: 13/1/2024 2:44:16 pm ******/
CREATE NONCLUSTERED INDEX [stud_index_byname] ON [dbo].[Student]
(
	[std_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Choises]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[Question] ([ID])
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD FOREIGN KEY([BranchID])
REFERENCES [dbo].[Branch] ([ID])
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD FOREIGN KEY([IntakeID])
REFERENCES [dbo].[Intake] ([ID])
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD FOREIGN KEY([TrackID])
REFERENCES [dbo].[Tracks] ([id])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([class_Id])
REFERENCES [dbo].[Tracks] ([id])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([Crs_Id])
REFERENCES [dbo].[Courses] ([id])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([Ins_Exam])
REFERENCES [dbo].[Instructor] ([ID])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [fk_Ins_Exam] FOREIGN KEY([Ins_Exam])
REFERENCES [dbo].[Instructor] ([ID])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [fk_Ins_Exam]
GO
ALTER TABLE [dbo].[ExamQuestion]  WITH CHECK ADD FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([exam_ID])
GO
ALTER TABLE [dbo].[ExamQuestion]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Question] ([ID])
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD FOREIGN KEY([User_ID])
REFERENCES [dbo].[User_Account] ([User_ID])
GO
ALTER TABLE [dbo].[Instructor_Courses]  WITH CHECK ADD FOREIGN KEY([Course_id])
REFERENCES [dbo].[Courses] ([id])
GO
ALTER TABLE [dbo].[Instructor_Courses]  WITH CHECK ADD FOREIGN KEY([Instructor_id])
REFERENCES [dbo].[Instructor] ([ID])
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([User_ID])
REFERENCES [dbo].[User_Account] ([User_ID])
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Student] FOREIGN KEY([Class_ID])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Student]
GO
ALTER TABLE [dbo].[StudentCourse]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([id])
GO
ALTER TABLE [dbo].[StudentExam]  WITH CHECK ADD FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([exam_ID])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [chk_typeExam] CHECK  (([Type_Exam]='Exam' OR [Type_Exam]='Corrective'))
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [chk_typeExam]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [chk_type] CHECK  (([type]='Text' OR [type]='T&F' OR [type]='MCQ'))
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [chk_type]
GO
ALTER TABLE [dbo].[User_Account]  WITH CHECK ADD  CONSTRAINT [chk_typeuser] CHECK  (([UserType]='Training Manager' OR [UserType]='Instructor' OR [UserType]='Student' OR [UserType]='Admin'))
GO
ALTER TABLE [dbo].[User_Account] CHECK CONSTRAINT [chk_typeuser]
GO
/****** Object:  StoredProcedure [Instructor].[AddQuestions_Proc]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Instructor].[AddQuestions_Proc]
    @InstructorID int,
    @CourseID int,
    @RandomSelection varchar(15),
	@ExamID int,
	@NumberOfRandomQuestion int,
    @QuestionDegrees QuestionDegreesType readonly
AS
BEGIN
    SET NOCOUNT ON; 
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @TotalDegQuestion float = 0;
        DECLARE @TotalDegree float;
        SELECT @TotalDegree = TotalDegree
        FROM Exam
        WHERE Crs_Id = @CourseID;

        IF EXISTS (
            SELECT 1
            FROM Exam
            WHERE Ins_Exam = @InstructorID AND Crs_Id = @CourseID AND exam_ID = @ExamID
        )
        BEGIN
            IF NOT EXISTS (
        SELECT 1
        FROM ExamQuestion ,Exam
        WHERE ExamID = @ExamID AND Ins_Exam = @InstructorID AND Crs_Id = @CourseID
    )

	   begin
		   --Random Questions
            IF (@RandomSelection = 'Random' or @RandomSelection = 'random')
            BEGIN
                INSERT INTO ExamQuestion(ExamID, QuestionID, Degree)
                SELECT TOP (@NumberOfRandomQuestion)  @ExamID, ID, CAST(RAND() * 5 + 1 AS INT)
                FROM Question
                ORDER BY NEWID();
            END

            --Manually Questions
            ELSE IF (@RandomSelection = 'Manual' or @RandomSelection = 'manual')
            BEGIN
                INSERT INTO ExamQuestion  (ExamID ,QuestionID, Degree)
                SELECT @ExamID, QuestionID, QuestionDegree
                FROM @QuestionDegrees;
            END

			else 
			begin
			print 'Please Enter Random or Manual'
			end
         end
		 else 
		 begin
		 print 'This Exam has already added'
		 end

        END
        ELSE 
        BEGIN
            PRINT 'Check that ExamID, CourseID, InstructorID are related';
        END
         -- Calcalute Total degree of exam
set @TotalDegQuestion = (SELECT SUM(Degree) FROM ExamQuestion WHERE ExamID = @ExamID);

        ---- Check Total degree is greater than Course Max Degree
        IF @TotalDegQuestion > @TotalDegree
        BEGIN
            PRINT 'Error: Total degree questions exceeds Total Degree Of Exam.';
            ROLLBACK;
            DELETE FROM ExamQuestion WHERE ExamID = @ExamID; 
            RETURN;
        END
        COMMIT;
    END TRY 
BEGIN CATCH
    print('Please enter valid data');
    ROLLBACK;
    RETURN; 
END CATCH

END;
GO
/****** Object:  StoredProcedure [Instructor].[AddStudentsToExam]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Instructor].[AddStudentsToExam]
    @InstructorID INT,
    @StudentIDs NVARCHAR(MAX),
    @ExamID INT
AS
BEGIN
SET NOCOUNT ON;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM dbo.Instructor WHERE ID = @InstructorID)
        BEGIN
            PRINT 'Invalid Instructor ID';
            RETURN;
        END;

        IF @StudentIDs IS NULL OR @StudentIDs = ''
        BEGIN
            PRINT 'Invalid StudentIDs.';
            RETURN;
        END;

        IF NOT EXISTS (SELECT 1 FROM Exam WHERE exam_ID = @ExamID)
        BEGIN
            PRINT 'Invalid ExamID.';
            RETURN;
        END;
		DECLARE @CourseID INT;
        SELECT @CourseID = Crs_Id FROM Exam WHERE exam_ID = @ExamID;

        IF EXISTS (
            SELECT 1
            FROM StudentCourse sc
            INNER JOIN STRING_SPLIT(@StudentIDs, ',') s ON sc.StudentID = CAST(s.value AS INT)
            WHERE sc.CourseID = @CourseID AND sc.FinalResult = 'pass'
        )
        BEGIN
            PRINT 'One or more students have already passed the course related to this exam.';
            RETURN;
        END
        CREATE TABLE #TempStudentList (StudentID INT);

        INSERT INTO #TempStudentList (StudentID)
        SELECT CAST(value AS INT)
        FROM String_Split(@StudentIDs, ',');

        DECLARE @QuestionIDs NVARCHAR(MAX);
        SELECT @QuestionIDs = STRING_AGG(QuestionID, ',')
        FROM ExamQuestion
        WHERE ExamID = @ExamID;

        INSERT INTO dbo.StudentExam (StudentID, ExamID, QuestionID)
        SELECT ts.StudentID, @ExamID, eq.value
        FROM #TempStudentList ts
        CROSS JOIN STRING_SPLIT(@QuestionIDs, ',') eq
        WHERE NOT EXISTS (
            SELECT 1
            FROM dbo.StudentExam se
            WHERE se.StudentID = ts.StudentID
              AND se.ExamID = @ExamID
              AND se.QuestionID = eq.value
        );

        DECLARE @ExamDate DATE;
        DECLARE @StartTime TIME;
        DECLARE @EndTime TIME;

        SELECT @ExamDate = Exam_Date, @StartTime = exam_StartTime, @EndTime = exam_endTime
        FROM Exam
        WHERE exam_ID = @ExamID;

        DROP TABLE #TempStudentList;
    END TRY
    BEGIN CATCH
        PRINT 'Error in Your Data Please Check';
    END CATCH
END;
GO
/****** Object:  StoredProcedure [Instructor].[CreateExam]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Instructor].[CreateExam]  
    @Type NVARCHAR(50),
    @ExamDate DATE,
    @StartTime NVARCHAR(8),
    @TotalTime INT,
    @TotalDegree INT, 
    @Crs_Id INT,
    @Class_Id INT,
    @InstructorId INT
AS
BEGIN
 SET NOCOUNT ON;
    BEGIN TRY
        IF TRY_CAST(@ExamDate AS DATE) IS NULL
        BEGIN
            RAISERROR('Invalid ExamDate format. Please use yyyy-mm-dd format like (2024-01-12).', 16, 50005);
        END

        IF @ExamDate < GETDATE()
        BEGIN
            RAISERROR('ExamDate must be in the future.', 16, 50006);
        END

        IF TRY_CAST(@TotalTime AS INT) IS NULL OR TRY_CAST(@TotalDegree AS INT) IS NULL
        BEGIN
            RAISERROR('Invalid data type for TotalTime or TotalDegree', 16, 50001);
        END

        IF @Type NOT IN ('Exam', 'Corrective')
        BEGIN
            RAISERROR('Invalid Exam Type. Type should be either ''Exam'' or ''Corrective''', 16, 50002);
        END

        IF TRY_CAST(@StartTime AS TIME) IS NULL
        BEGIN
            SET @StartTime = @StartTime + ':00:00';
            IF TRY_CAST(@StartTime AS TIME) IS NULL
            BEGIN
                RAISERROR('Invalid StartTime format. Please use HH:mm format ', 16, 50003);
            END
        END

        IF @TotalTime <= 0 OR @TotalTime > 180
        BEGIN
            RAISERROR('Invalid TotalTime. Please provide a positive Number less than or equal to 180 for TotalTime.', 16, 50004);
        END

        IF NOT EXISTS (
            SELECT 1 
            FROM dbo.Instructor_Courses 
            WHERE Instructor_id = @InstructorId 
            AND Course_Id = @Crs_Id
        )
        BEGIN
            RAISERROR('Instructor does not have the specified Course', 16, 50000);
        END

        INSERT INTO dbo.Exam (Type_Exam, Exam_Date, exam_StartTime, exam_TotalDuration, TotalDegree, Crs_Id, Class_Id, Ins_Exam)
        VALUES (@Type, @ExamDate, @StartTime, @TotalTime, @TotalDegree, @Crs_Id, @Class_Id, @InstructorId);
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() IN (50000, 50001, 50002, 50003, 50004, 50005, 50006)
        BEGIN
            PRINT ERROR_MESSAGE();
        END
        ELSE
        BEGIN
            PRINT 'Please Enter Correct Data';
        END
    END CATCH
END;
GO
/****** Object:  StoredProcedure [Instructor].[GetExamsByYearCourseInstructor]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Instructor].[GetExamsByYearCourseInstructor] 
    @year INT,
    @courseId INT,
    @instructorId INT
AS
BEGIN
    DECLARE @classExists INT, @courseExists INT, @instructorExists INT;
    SELECT @classExists = COUNT(*) 
    FROM Class c
    INNER JOIN Intake i ON c.IntakeID = i.ID
    WHERE i.[Intake_Year] = @year;
    SELECT @courseExists = COUNT(*) FROM [dbo].[Courses] WHERE id = @courseId;
    SELECT @instructorExists = COUNT(*) FROM Instructor WHERE ID = @instructorId;

    IF @classExists = 0
    BEGIN
        PRINT 'Year does not exist in the Class table';
        RETURN;
    END
    IF @courseExists = 0
    BEGIN
        PRINT 'Course ID does not exist in the Course table';
        RETURN;
    END

    IF @instructorExists = 0
    BEGIN
        PRINT 'Instructor ID does not exist in the Instructor table';
        RETURN;
    END
    SELECT 
         e.Type_Exam, e.Exam_Date, e.exam_StartTime, e.exam_TotalDuration, 
        e.TotalDegree, cr.[name] AS CourseName, i.name AS Ins_Name,Ik.Name as Intake, B.Name as Branch, T.Track , Ik.Intake_Year
    FROM 
        Exam e
    INNER JOIN 
        Class c ON e.class_Id = c.[ClassID]
    INNER JOIN 
        Instructor i ON e.Ins_Exam = i.ID
    INNER JOIN 
        [dbo].[Courses] cr ON e.Crs_Id = cr.id
    INNER JOIN 
        Intake intake ON c.IntakeID = intake.ID
    INNER JOIN 
        Branch B ON c.BranchID = B.ID
    INNER JOIN 
        Intake Ik ON c.IntakeID = Ik.ID
    INNER JOIN 
        Tracks T ON c.TrackID = T.id
    WHERE 
        Ik.Intake_Year = @year
        AND e.Crs_Id = @courseId
        AND e.[Ins_Exam] = @instructorId;
END;
GO
/****** Object:  StoredProcedure [Instructor].[OrderBYStd_Proc]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [Instructor].[OrderBYStd_Proc] @option1 VARCHAR(100)
AS
BEGIN
    SELECT *
    FROM Student
    ORDER BY 
        CASE
            WHEN @option1 = 'Name' THEN std_Name
            WHEN @option1 = 'Age' THEN CAST(std_Age AS varchar(100))
            WHEN @option1 = 'Email' THEN std_Email
            WHEN @option1 = 'City' THEN std_City
        END;
END
GO
/****** Object:  StoredProcedure [Instructor].[StudentDataOrderedBy_Proc]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [Instructor].[StudentDataOrderedBy_Proc] @OrderByColumn VARCHAR(100)
AS
begin
    SELECT
            Stu.Std_ID AS StudentID,  Stu.std_Name AS StudentName,
            ES.ExamID,  ES.StudentAnswer,  ES.Result
        FROM
            StudentExam ES
        Inner Join
            Student Stu ON ES.StudentID = Stu.Std_ID  
			Inner Join
        Exam Ex ON ES.ExamID = Ex.exam_ID
            ORDER BY
            CASE
			    WHEN @OrderByColumn = 'ID' THEN CAST(Stu.Std_ID AS varchar(100))
              WHEN @OrderByColumn = 'Name' THEN Stu.std_Name
				WHEN @OrderByColumn = 'ExamID' THEN CAST(ES.ExamID AS varchar(100))
                WHEN @OrderByColumn = 'StudentAnswer' THEN ES.StudentAnswer
                WHEN @OrderByColumn = 'Result' THEN  CAST(ES.Result AS varchar(100))
           
            END;
end
GO
/****** Object:  StoredProcedure [Instructor].[UpdateResults]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create   Proc [Instructor].[UpdateResults] 
    @std_id int, 
    @exam_id int
as
begin
begin try
    set NoCount on;
    If Not Exists (Select 1 From [dbo].[Student] Where Std_ID = @std_id)
    begin
        Print 'Student does not exist.';
        Return;
    End

    If Not Exists (Select 1 From [dbo].[Exam],StudentExam S Where exam_ID = @exam_id and S.ExamID = exam_ID)
    begin
        Print 'Exam does not exist.';
        Return;
    End
    If Exists (
        Select 1
        From [dbo].[StudentCourse] SC
        where SC.StudentID = @std_id AND SC.CourseID IN (SELECT Crs_Id FROM [dbo].[Exam] WHERE exam_ID = @exam_id)
    )
    Begin
        Print 'Exam For This Student Already Marked.';
        Return;
    end
    Update ES
    set Result = Case When Q.correct_answer = ES.StudentAnswer Then Q.degree Else 0 End
    From StudentExam ES, ExamQuestion EQ, Question Q
    where ES.StudentID = @std_id
        and ES.ExamID = @exam_id
        and ES.ExamID = EQ.ExamID 
        and ES.QuestionID = EQ.QuestionID 
        and EQ.QuestionID = Q.ID;

    Declare @total_degree int;
    Declare @Crs_ID int;

   SELECT 
    @total_degree = ISNULL(SUM(R.Result) OVER(), 0),
    @Crs_ID = E.Crs_Id
		FROM 
			[dbo].[StudentExam] R
		INNER JOIN 
			[dbo].[Exam] E ON R.ExamID = E.exam_ID
		WHERE 
			R.StudentID = @std_id AND R.ExamID = @exam_id;


    Insert Into [dbo].[StudentCourse] ([CourseID], [StudentID], [TotalDegree])
    Values (@Crs_ID, @std_id, @total_degree);
end try
	begin Catch
	Print 'Please Add Correct Data'
	end Catch
End;
GO
/****** Object:  StoredProcedure [Student].[StoreStudentAnswers]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Student].[StoreStudentAnswers] 
    @std_id INT, 
    @exam_id INT, 
    @student_answers AnswerTableType READONLY
AS
BEGIN
SET NOCOUNT ON;

	-- Check if the @std_id and @exam_id exist in the ExamStudent table
    IF NOT EXISTS (
        SELECT 1
        FROM [dbo].[StudentExam]
        WHERE StudentID = @std_id AND ExamID = @exam_id
    )
    BEGIN
        RAISERROR('Invalid Student ID or Exam ID.', 16, 1);
		return;
    END;

	DECLARE @CurrentTime TIME = CAST(GETDATE() AS TIME)
	DECLARE @CurrentDate Date = CAST(GETDATE() AS Date)

	DECLARE @ExamStartTime TIME, @ExamEndTime TIME,@ExamDate DATE;
   SELECT @ExamStartTime = [exam_StartTime], @ExamEndTime = [exam_EndTime],@ExamDate = [Exam_Date] FROM Exam WHERE exam_ID = @exam_id ;
   
		   IF  @CurrentTime < @ExamStartTime OR @CurrentTime > @ExamEndTime OR  @CurrentDate != @ExamDate
		BEGIN
		 RAISERROR('Not allowed to answer at this time.', 16, 1);
		 return;
		END;

    -- The @Answers table variable is now directly populated by the passed parameter
    DECLARE @Answers AS AnswerTableType;
    INSERT INTO @Answers SELECT * FROM @student_answers;
		DECLARE @QuestionID CHAR(3);
   DECLARE cur CURSOR FOR SELECT QuestionID FROM @student_answers;
   OPEN cur;
   FETCH cur INTO @QuestionID;
   WHILE @@FETCH_STATUS = 0
   BEGIN
       IF NOT EXISTS (
           SELECT 1
           FROM StudentExam
           WHERE QuestionID = @QuestionID
       )
       BEGIN
           RAISERROR('Invalid Question ID.', 16, 1);
           RETURN;
       END;
       FETCH NEXT FROM cur INTO @QuestionID;
   END;
   CLOSE cur;
   DEALLOCATE cur;

    -- Use UPDATE statement to modify existing rows
    UPDATE [dbo].[StudentExam]
    SET StudentAnswer = S.StudentAnswer
    FROM @Answers AS S
    WHERE [dbo].[StudentExam].QuestionID = S.QuestionID
      AND [dbo].[StudentExam].ExamID = @exam_id
      AND [dbo].[StudentExam].StudentID = @std_id;
	  
END;
GO
/****** Object:  StoredProcedure [T_Manager].[CreateUserLogin]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [T_Manager].[CreateUserLogin]
    @Name VARCHAR(255),
    @Password VARCHAR(255),
    @UserType VARCHAR(255)
AS
BEGIN
SET NOCOUNT ON;
    IF @UserType IN ('Student', 'Training Manager', 'Admin','Instructor')
    BEGIN
        DECLARE @SQLLogin NVARCHAR(MAX);
        DECLARE @SQLUser NVARCHAR(MAX);

        IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = @Name)
        BEGIN
            SET @SQLLogin = 'USE Examination_System; CREATE LOGIN ' + QUOTENAME(@Name) + ' WITH PASSWORD = ''' + @Password + ''', CHECK_POLICY = OFF;';
            EXEC sp_executesql @SQLLogin;

            IF NOT EXISTS (SELECT name FROM sys.database_principals WHERE name = @Name)
            BEGIN
                SET @SQLUser = 'USE Examination_System; CREATE USER ' + QUOTENAME(@Name) + ' FOR LOGIN ' + QUOTENAME(@Name) + ';';
                EXEC sp_executesql @SQLUser;

                INSERT INTO User_Account (UserName, UserPassword, UserType)
                VALUES (@Name, @Password, @UserType);
            END
            ELSE
            BEGIN
                RAISERROR('User with the same name already exists.', 16, 1);
            END
        END
        ELSE
        BEGIN
            RAISERROR('Login with the same name already exists.', 16, 1);
        END
    END
    ELSE
    BEGIN
        RAISERROR('Invalid UserType. Allowed values are Student, Teacher, and Admin.', 16, 1);
    END
END;
GO
/****** Object:  StoredProcedure [T_Manager].[crs_std_inst_INFO_by_course_id]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [T_Manager].[crs_std_inst_INFO_by_course_id] 
    @CourseID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Courses WHERE ID = @CourseID)
    BEGIN
        SELECT 
            c.id AS CourseID,
            c.name AS CourseName,
            c.description AS CourseDescription,
            i.ID AS InstructorID,
            i.name AS InstructorName,
            s.Std_ID AS StudentID,
            s.std_Name AS StudentName,
            s.std_Age AS StudentAge,
            s.std_City AS StudentCity,
            s.std_Email AS StudentEmail
        FROM Courses c 
        LEFT JOIN Instructor i ON c.ID = i.ID
        LEFT JOIN Student s ON c.ID = s.[class_Id]
        WHERE c.id = @CourseID
        ORDER BY c.id;
    END
    ELSE
    BEGIN
        PRINT 'Error: Course ID does not exist.';
    END
END;
GO
/****** Object:  StoredProcedure [T_Manager].[InstructorDataOrderedBy_Proc]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [T_Manager].[InstructorDataOrderedBy_Proc] @OrderByColumn VARCHAR(max)
AS
begin
    SELECT 
        Ins.ID AS InstructorID, Ins.name AS InstructorName, Ex.exam_ID AS ExamID,
        Ex.Type_Exam AS ExamType,Ex.Exam_Date AS ExamDate, Crs.id AS CourseID,
        Crs.name AS CourseName,Crs.description AS CourseDescription
    FROM 
        Instructor Ins INNER JOIN Exam Ex ON Ins.ID = Ex.[Ins_Exam]
    INNER JOIN Courses Crs ON Ex.Crs_Id = Crs.id
    ORDER BY 
        CASE
            WHEN @OrderByColumn = 'InstructorName' THEN Ins.name
            WHEN @OrderByColumn = 'ExamDate' THEN CAST(Ex.Exam_Date AS varchar(max))
            WHEN @OrderByColumn = 'CourseName' THEN Crs.name
           WHEN @OrderByColumn = 'CourseID' THEN  CAST(Crs.id AS varchar(max))
           WHEN @OrderByColumn = 'InstructorID' THEN  CAST(Ins.ID AS varchar(max))
        END
end
GO
/****** Object:  StoredProcedure [T_Manager].[MangerDataOrderedBy_Proc]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [T_Manager].[MangerDataOrderedBy_Proc]  @Option1 VARCHAR(MAX)
AS
BEGIN
    SELECT
        S.Std_ID AS StudentID, S.std_Name AS StudentName, S.std_City AS StudentCity,
        S.std_Email AS StudentEmail,
        T.Track AS TrackName, B.Name AS BranchName, I.Name AS IntakeName
    FROM
        Student S
    INNER JOIN
        Class C ON S.class_Id = C.ClassID
    INNER JOIN
        Tracks T ON C.TrackID = T.ID
    INNER JOIN
        Branch B ON C.BranchID = B.ID
    INNER JOIN
        Intake I ON C.IntakeID = I.ID
    ORDER BY
        CASE
            WHEN @Option1 = 'StudentName' THEN S.std_Name
            WHEN @Option1 = 'StudentEmail' THEN S.std_Email
            WHEN @Option1 = 'StudentCity' THEN S.std_City
            WHEN @Option1 = 'BrancheName' THEN B.Name
            WHEN @Option1 = 'TrackName' THEN T.Track
            WHEN @Option1 = 'IntakeName' THEN I.Name
        END;
END;
GO
/****** Object:  StoredProcedure [T_Manager].[OrderBYStd_Proc]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [T_Manager].[OrderBYStd_Proc] @option1 VARCHAR(100)
AS
BEGIN
    SELECT *
    FROM Student
    ORDER BY
        CASE
            WHEN @option1 = 'Name' THEN std_Name
            WHEN @option1 = 'Age' THEN CAST(std_Age AS varchar(100))
            WHEN @option1 = 'Email' THEN std_Email
            WHEN @option1 = 'City' THEN std_City
        END;
END
GO
/****** Object:  StoredProcedure [T_Manager].[ShowDataByYear]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [T_Manager].[ShowDataByYear]
    @inputYear INT
AS
BEGIN
    SELECT  C.id AS CourseID,C.[name] AS CourseName, C.[description] AS CourseDescription,Cl.ClassID AS ClassID,
																				B.Name AS BranchName,
																				N.Name AS IntakeName,
																				T.Track AS TrackName,
																				N.Intake_Year AS ClassYear,
																				I.ID AS InstructorID,
																				I.name AS InstructorName
    FROM Courses C , Instructor I , Class Cl,Intake N,Branch B,Tracks T, Exam E
    where N.ID = Cl.IntakeID and B.ID = Cl.BranchID and Cl.TrackID = T.id
	and N.Intake_Year = @inputYear and E.class_Id = Cl.ClassID and C.id = E.Crs_Id and I.ID = E.Ins_Exam
END;
GO
/****** Object:  StoredProcedure [T_Manager].[UpdateYearOnIntakeInsert]    Script Date: 13/1/2024 2:44:16 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [T_Manager].[UpdateYearOnIntakeInsert]
    @intake VARCHAR(50),
    @id INT -- Assuming you have an identifier for the row to update
AS
BEGIN
    SET NOCOUNT ON; -- Suppress the "X rows affected" message

    DECLARE @currentYear INT;
    DECLARE @userProvidedYear INT;

    -- Get the current year
    SET @currentYear = YEAR(GETDATE());

    -- Convert the user-provided intake to an integer (assuming it contains the year)
    SET @userProvidedYear = TRY_CAST(@intake AS INT);

    -- Check if the provided year is valid
    IF @userProvidedYear IS NOT NULL AND @userProvidedYear >= @currentYear AND @userProvidedYear <= @currentYear + 5
    BEGIN
        -- Check if the provided id exists in the Intake table
        IF EXISTS (SELECT 1 FROM Intake WHERE [id] = @id)
        BEGIN
            -- Update the Intake table with the user-provided year
            UPDATE Intake
            SET Intake_Year = @userProvidedYear
            WHERE [id] = @id; -- Update the row corresponding to the provided ID

            PRINT 'Year successfully updated.';
        END
        ELSE
        BEGIN
            PRINT 'Invalid ID provided. The specified ID does not exist in the Intake table.';
        END
    END
    ELSE
    BEGIN
        IF @userProvidedYear > @currentYear + 5
        BEGIN
            PRINT 'Invalid year provided. Please ensure the year is not more than 5 years ahead of the current year.';
        END
        ELSE
        BEGIN
            PRINT 'Invalid year provided. Please ensure the year is not less than the current year.';
        END
    END
END;
GO
USE [master]
GO
ALTER DATABASE [Examination_System] SET  READ_WRITE 
GO
