USE [Data_Services]
GO
/****** Object:  Table [dbo].[SF_Sections]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF_Sections](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](514) NULL,
	[Salesforce__External_ID__c] [varchar](318) NULL,
	[SchoolForce__Active__c] [varchar](1) NOT NULL,
	[SchoolForce__All_Grades__c] [varchar](250) NULL,
	[Schoolforce__Course__c] [varchar](18) NOT NULL,
	[SchoolForce__Period__c] [varchar](80) NULL,
	[SchoolForce__Daily_Attendance__c] [varchar](1) NOT NULL,
	[SchoolForce__Is_Section__c] [varchar](1) NOT NULL,
	[Schoolforce__Reporting_Period__c] [varchar](18) NOT NULL,
	[Schoolforce__School__c] [varchar](250) NULL,
	[Schoolforce__Time__c] [varchar](18) NOT NULL,
	[SchoolForce__Number_of_Reporting_Periods__c] [int] NULL,
	[SchoolForce__Record_Type__c] [varchar](18) NOT NULL,
	[SchoolForce__Color__c] [varchar](7) NOT NULL,
	[SchoolForce__Text_Color__c] [varchar](7) NOT NULL
) ON [PRIMARY]

GO
