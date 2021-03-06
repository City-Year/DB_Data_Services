USE [Data_Services]
GO
/****** Object:  Table [dbo].[Master_Staff]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_Staff](
	[TeacherName] [varchar](256) NULL,
	[First_Name] [varchar](256) NULL,
	[Last_Name] [varchar](256) NULL,
	[SchoolForce__Organization__c] [varchar](250) NULL,
	[SchoolForce__Individual__c] [varchar](18) NOT NULL,
	[SF_ID] [varchar](18) NOT NULL,
	[SchoolForce__External_Id__c] [varchar](8000) NULL
) ON [PRIMARY]

GO
