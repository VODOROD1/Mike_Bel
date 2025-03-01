USE [master]
GO
/****** Object:  Database [users_awardsDB]    Script Date: 02.10.2019 10:35:46 ******/
CREATE DATABASE [users_awardsDB]
 CONTAINMENT = NONE
ALTER DATABASE [users_awardsDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [users_awardsDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [users_awardsDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [users_awardsDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [users_awardsDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [users_awardsDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [users_awardsDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [users_awardsDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [users_awardsDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [users_awardsDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [users_awardsDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [users_awardsDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [users_awardsDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [users_awardsDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [users_awardsDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [users_awardsDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [users_awardsDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [users_awardsDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [users_awardsDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [users_awardsDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [users_awardsDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [users_awardsDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [users_awardsDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [users_awardsDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [users_awardsDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [users_awardsDB] SET  MULTI_USER 
GO
ALTER DATABASE [users_awardsDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [users_awardsDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [users_awardsDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [users_awardsDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [users_awardsDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [users_awardsDB] SET QUERY_STORE = OFF
GO
USE [users_awardsDB]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [int] NOT NULL,
	[Role] [nchar](10) NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Awards]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Awards](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Awards] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AwardsAndUsers]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AwardsAndUsers](
	[UserId] [int] NOT NULL,
	[AwardId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Date] [date] NULL,
	[Age] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AwardsAndUsers]  WITH CHECK ADD  CONSTRAINT [FK_AwardsAndUsers_Awards] FOREIGN KEY([AwardId])
REFERENCES [dbo].[Awards] ([Id])
GO
ALTER TABLE [dbo].[AwardsAndUsers] CHECK CONSTRAINT [FK_AwardsAndUsers_Awards]
GO
ALTER TABLE [dbo].[AwardsAndUsers]  WITH CHECK ADD  CONSTRAINT [FK_AwardsAndUsers_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[AwardsAndUsers] CHECK CONSTRAINT [FK_AwardsAndUsers_Users]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteAward]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteAward]
	@AwardId int
AS
    DELETE FROM Awards WHERE Id = @AwardId
	DELETE FROM AwardsAndUsers WHERE AwardId = @AwardId
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteAwardFromUser]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteAwardFromUser]
	@UserId int,
	@AwardId int
AS
	DELETE FROM AwardsAndUsers WHERE UserId = @UserId AND AwardId = @AwardId
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteAwardFromUsers]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteAwardFromUsers]
	@AwardId int
AS
	DELETE FROM AwardsAndUsers WHERE AwardId = @AwardId
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUser]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteUser]
	@UserId int
AS
    DELETE FROM Users WHERE Id = @UserId
	DELETE FROM AwardsAndUsers WHERE UserId = @UserId
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllAwards]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAllAwards]
AS
    SELECT * FROM Awards
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllAwardsUsers]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAllAwardsUsers]
AS
    SELECT * FROM AwardsAndUsers
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllUsers]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAllUsers]
AS
    SELECT * FROM Users 
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertAwardForUser]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertAwardForUser]
    @userId int,
    @awardId int
AS
    INSERT INTO AwardsAndUsers(UserId, AwardId)
    VALUES (@userId, @awardId)
  
    SELECT SCOPE_IDENTITY()
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertNewAward]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertNewAward]
    @title nvarchar(50)
	/**@image varbinary(MAX)**/
AS
    INSERT INTO Awards (Title)
    VALUES (@title)
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUser]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertUser]
    @name nvarchar(50),
	@date Date,
    @age int
AS
    INSERT INTO Users (Name, Date, Age)
    VALUES (@name, @date, @age)
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAward]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateAward]
	@Id int,
	@Title nvarchar(50)
	/**@Image varbinary(MAX)**/
AS
	UPDATE Awards 
	SET Title = @Title
	WHERE Id = @Id;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUser]    Script Date: 02.10.2019 10:35:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateUser]
	@Id int,
	@name nvarchar(50),
	@date date,
	@age int
	/**@image varbinary(MAX)**/

AS
	UPDATE Users 
	SET Name = @name, Date = @date, Age = @age
	WHERE Id = @Id;
GO
USE [master]
GO
ALTER DATABASE [users_awardsDB] SET  READ_WRITE 
GO
