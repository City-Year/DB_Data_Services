USE [Data_Services]
GO
/****** Object:  Table [dbo].[SF_Assignment_MP]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF_Assignment_MP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[Assignment_Library__c] [varchar](18) NOT NULL,
	[SchoolForce__Due_Date__c] [date] NULL,
	[SchoolForce__Picklist_Value__c] [varchar](18) NOT NULL,
	[SchoolForce__Include_in_Final_Grade__c] [int] NOT NULL,
	[SchoolForce__Name_in_Gradebook__c] [varchar](250) NOT NULL,
	[SchoolForce__Possible_Points__c] [int] NOT NULL,
	[SchoolForce__Time__c] [varchar](18) NOT NULL,
	[SchoolForce__Section__c] [varchar](250) NULL,
	[SchoolForce__Weighting_Value__c] [int] NOT NULL,
	[Math_Class_Section_ID] [varchar](256) NULL,
	[Student_ID] [varchar](256) NULL,
	[Marking_Period] [varchar](256) NULL,
	[SchoolForce__External_Id__c] [varchar](256) NULL
) ON [PRIMARY]

GO
