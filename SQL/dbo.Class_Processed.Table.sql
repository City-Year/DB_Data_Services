USE [Data_Services]
GO
/****** Object:  Table [dbo].[Class_Processed]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class_Processed](
	[Student_ID] [varchar](256) NULL,
	[Class_Section_ID] [varchar](256) NULL,
	[Class_Period_Name] [varchar](256) NULL,
	[Period] [varchar](256) NULL,
	[Teacher_Name] [varchar](256) NULL,
	[Section_Type] [varchar](256) NULL,
	[Teacher_First_Name] [varchar](250) NULL,
	[Teacher_Last_Name] [varchar](250) NULL,
	[District] [varchar](250) NULL
) ON [INDEX]

GO
