USE [PostAround]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 12/16/2011 12:05:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[Name] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Message] [nvarchar](500) NULL,
	[Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 12/16/2011 12:05:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MessageID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Body] [nvarchar](500) NULL,
	[Date] [datetime] NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12/16/2011 12:05:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Status] [int] NOT NULL,
	[Sort] [int] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 12/16/2011 12:05:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Latitude] [nvarchar](50) NULL,
	[Longitude] [nvarchar](50) NULL,
	[CategoryID] [numeric](18, 0) NULL,
	[UserID] [numeric](18, 0) NULL,
	[Title] [nvarchar](50) NULL,
	[Description] [nvarchar](400) NULL,
	[ImageUrl] [nvarchar](400) NULL,
	[Type] [numeric](18, 0) NULL,
	[RegionID] [numeric](18, 0) NULL,
	[PostDate] [datetime] NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/16/2011 12:05:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[phone1] [nvarchar](50) NULL,
	[phone2] [nvarchar](50) NULL,
	[address] [nvarchar](100) NULL,
	[Longtitude] [nvarchar](50) NULL,
	[Latidute] [nvarchar](50) NULL,
	[gender] [nvarchar](10) NULL,
	[facebookID] [nvarchar](50) NULL,
	[birthday] [datetime] NULL,
	[avatarImageUrl] [nvarchar](500) NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserByID]    Script Date: 12/16/2011 12:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateUserByID]

 (
      @id int,
      @fName nvarchar(50),
      @lName nvarchar(50),
      @email nvarchar(50),
      @phone1 nvarchar(50),
      @phone2 nvarchar(50),
      @address nvarchar(100),
      @lon nvarchar(50),
      @lat nvarchar(50),
      @avatarImage nvarchar(50)
  )    
      
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE Users
	SET FirstName = @fName, LastName = @lName, email = @email, phone1 = @phone1, phone2 = @phone2,
		address = @address, Longtitude = @lon, Latidute = @lat, avatarImageUrl = @avatarImage
	WHERE ID = @id
	SELECT SCOPE_IDENTITY();	
END
GO
/****** Object:  StoredProcedure [dbo].[SetFeedback]    Script Date: 12/16/2011 12:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SetFeedback]
	(
		@date DateTime,
		@name nvarchar(50),
		@email nvarchar(50),
		@message nvarchar(500)
	)
AS
BEGIN
	
	SET NOCOUNT ON;

    
	INSERT INTO [Feedback] ( [Date], [Name], [Email], [Message], [Status])
	VALUES (@date, @name, @email, @message, 0);
	SELECT SCOPE_IDENTITY();
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[SelectCountComments]    Script Date: 12/16/2011 12:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec SelectCountComments 
CREATE PROCEDURE [dbo].[SelectCountComments] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

      SELECT MessageId, COUNT(ID) AS CommentsCounter FROM Comments
      WHERE Status = 1
      GROUP BY MessageID
      
	  
END
GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 12/16/2011 12:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertUser]
(
      
      @fName nvarchar(50),
      @lName nvarchar(50),
      @email nvarchar(50),
      @phone1 nvarchar(50),
      @phone2 nvarchar(50),
      @address nvarchar(100),
      @lon nvarchar(50),
      @lat nvarchar(50),
      @avatarImage nvarchar(50)
 
 )     
      
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO Users (FirstName, LastName, email, phone1, phone2, address, Longtitude, Latidute, avatarImageUrl)
	VALUES (@fName, @lName, @email, @phone1, @phone2,@address, @lon, @lat, @avatarImage)
	SELECT SCOPE_IDENTITY();
	
END
GO
/****** Object:  StoredProcedure [dbo].[InsertUpdateUser]    Script Date: 12/16/2011 12:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec InsertUpdateUser 'Momi', 'Lomo', 'momo@gmail.com', '123-213', '2121-21212', 'address', 'lon', 'lat', 'avatar1', 'gender', '111', '1983-01-29'
CREATE PROCEDURE [dbo].[InsertUpdateUser]
(
      
      @fName nvarchar(50),
      @lName nvarchar(50),
      @email nvarchar(50),
      @phone1 nvarchar(50),
      @phone2 nvarchar(50),
      @address nvarchar(100),
      @lon nvarchar(50),
      @lat nvarchar(50),
      @avatarImage nvarchar(500),
      @gender nvarchar(10),
      @facebookID nvarchar(50),
      @birthday datetime
 
 )     
      
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	begin tran
	if exists (select * from Users with (updlock,serializable) where facebookID = @facebookID)
	begin
		DECLARE @currID INT
	
		UPDATE Users
		SET @currID = ID,  FirstName = @fName, LastName = @lName, email = @email, phone1 = @phone1, phone2 = @phone2,
			address = @address, Longtitude = @lon, Latidute = @lat, avatarImageUrl = @avatarImage,
			gender = @gender, facebookID = @facebookID, birthday = @birthday
		WHERE facebookID = @facebookID
		SELECT @currID;
	end
	else
	begin
	   	INSERT INTO Users (FirstName, LastName, email, phone1, phone2, address, Longtitude, Latidute, avatarImageUrl, gender, facebookID, birthday)
		VALUES (@fName, @lName, @email, @phone1, @phone2,@address, @lon, @lat, @avatarImage, @gender, @facebookID, @birthday)
		SELECT SCOPE_IDENTITY();
	end


commit tran



	
END
GO
/****** Object:  StoredProcedure [dbo].[InsertMessage]    Script Date: 12/16/2011 12:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec InsertMessage "1", "2", 1, 2, "title", "desc", "img", "2011-11-11", 3, 4
CREATE PROCEDURE [dbo].[InsertMessage] 
(
	@lat nvarchar(50),
	@lon nvarchar(50),
	@categoryId INT,
	@userId INT,
	@title nvarchar(100),
	@description nvarchar(500),
	@image nvarchar(500),
	@msgDate datetime,
	@msgType INT,
	@regionId INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


INSERT INTO [Messages] ([Latitude], [Longitude], [CategoryID], [UserID], [Title], [Description], [ImageUrl], [Type], [RegionID], [PostDate])
VALUES(@lat, @lon, @categoryId, @userId, @title, @description, @image, @msgType, @regionId, @msgDate);
SELECT SCOPE_IDENTITY();


END
GO
/****** Object:  StoredProcedure [dbo].[InsertComment]    Script Date: 12/16/2011 12:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec InsertComment 91, 15, "testing2", '2011-12-13'
--select * from comments
CREATE PROCEDURE [dbo].[InsertComment]

(
	@msgId int,
	@userId int,
	@body nvarchar(500),
	@date datetime
)

AS
BEGIN
	
	SET NOCOUNT ON;

    
	INSERT INTO Comments (MessageID, UserID, Body, [Date])
	VALUES (@msgId, @userId, @body, @date)
	SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserByID]    Script Date: 12/16/2011 12:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserByID]
	
	(
	@id INT
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM Users
	WHERE ID = @id
	AND Status = 1
END
GO
/****** Object:  StoredProcedure [dbo].[GetCommentsByMessageID]    Script Date: 12/16/2011 12:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec GetCommentsByMessageID 87
CREATE PROCEDURE [dbo].[GetCommentsByMessageID]
(
	@msgId int
)
	
AS
BEGIN
	
	SET NOCOUNT ON;

    
	SELECT c.*, u.FirstName + ' ' +  u.LastName AS Name, u.avatarImageUrl
	FROM Comments c
	INNER JOIN Users u
	ON (c.UserID = u.ID)
	WHERE c.MessageID = @msgId
	AND c.Status = 1 AND u.Status = 1
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllMessages]    Script Date: 12/16/2011 12:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec GetAllMessages
CREATE PROCEDURE [dbo].[GetAllMessages]
	
AS
BEGIN
	
	SET NOCOUNT ON;


	SELECT distinct m.ID, m.Latitude, m.Longitude, c.Name AS CategoryName, c.ID AS CategoryID, m.UserID, u.FirstName + ' ' + u.LastName AS Name, 
	u.email as Email, u.phone1 as Phone1, u.phone2 as Phone2,  m.title, m.description, u.avatarImageUrl, m.PostDate, m.type, 
	(SELECT COUNT(c1.ID) AS CommentsCounter FROM Comments c1
		WHERE m.ID = c1.MessageID AND c1.Status = 1) AS CommentsCounter

        

	FROM Messages m
	INNER JOIN Users u
	ON (m.UserID = u.ID)
	INNER JOIN Categories c
	ON (m.CategoryID = c.ID)
	
	WHERE m.Status = 1
	
	ORDER BY m.PostDate DESC

	
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllCategories]    Script Date: 12/16/2011 12:05:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec GetAllCategories
CREATE PROCEDURE [dbo].[GetAllCategories]
	
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT *
    FROM Categories
    WHERE Status = 1
    ORDER BY Sort
END
GO
/****** Object:  Default [DF_Categories_Status]    Script Date: 12/16/2011 12:05:41 ******/
ALTER TABLE [dbo].[Categories] ADD  CONSTRAINT [DF_Categories_Status]  DEFAULT ((1)) FOR [Status]
GO
/****** Object:  Default [DF_Categories_Soryt1]    Script Date: 12/16/2011 12:05:41 ******/
ALTER TABLE [dbo].[Categories] ADD  CONSTRAINT [DF_Categories_Soryt1]  DEFAULT ((999)) FOR [Sort]
GO
/****** Object:  Default [DF_Comments_Status]    Script Date: 12/16/2011 12:05:41 ******/
ALTER TABLE [dbo].[Comments] ADD  CONSTRAINT [DF_Comments_Status]  DEFAULT ((1)) FOR [Status]
GO
/****** Object:  Default [DF_Messages_Status]    Script Date: 12/16/2011 12:05:41 ******/
ALTER TABLE [dbo].[Messages] ADD  CONSTRAINT [DF_Messages_Status]  DEFAULT ((1)) FOR [Status]
GO
/****** Object:  Default [DF_Users_Status]    Script Date: 12/16/2011 12:05:41 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Status]  DEFAULT ((1)) FOR [Status]
GO
