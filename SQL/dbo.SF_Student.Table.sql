USE [Data_Services]
GO
/****** Object:  Table [dbo].[SF_Student]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF_Student](
	[SchoolForce__Student_Last_Name__c] [varchar](256) NULL,
	[SchoolForce__Student_First_Name__c] [varchar](256) NULL,
	[SchoolForce__Grade__c] [varchar](10) NULL,
	[SchoolForce__School__c] [varchar](250) NULL,
	[SchoolForce__Year__c] [varchar](256) NULL,
	[SchoolForce__Active__c] [int] NOT NULL,
	[SchoolForce__Individual__c] [varchar](18) NULL,
	[SchoolForce__External_Id__c] [varchar](250) NULL,
	[SchoolForce__Setup__c] [varchar](250) NULL,
	[Student_ID] [varchar](250) NULL,
	[LocalStudentID] [varchar](250) NULL,
	[Date_Of_Birth] [datetime] NULL,
	[Sex] [varchar](256) NULL,
	[Ethnicity] [varchar](256) NULL
) ON [PRIMARY]

GO
